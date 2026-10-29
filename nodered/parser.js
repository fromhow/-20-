// T must match T_MS/1000 in firmware/sketch.ino.
const T = 5;
const RANGES = {s1:[0,100],s2:[0,5],s3:[0,1]};
const quote = s => "'" + String(s).replace(/'/g,"''") + "'";
const text = String(msg.payload).replace(/^\uFEFF/, '');
const sql = [];
let rows = 0;
try {
 const seen = new Set();
 text.split(/\r?\n/).forEach((raw,index) => {
  const line = raw.trim();
  if (!line) return;
  const parts = line.split(/\s+/);
  const kind = parts.shift();
  if (!['DATA','EVENT'].includes(kind)) throw Error(`line ${index+1}: expected DATA or EVENT`);
  const f = {};
  parts.forEach(p => {
   const m = /^([a-z][a-z0-9]*)=(\S+)$/i.exec(p);
   if (!m || Object.prototype.hasOwnProperty.call(f,m[1])) throw Error(`line ${index+1}: bad or repeated field`);
   f[m[1]]=m[2];
  });
  if (!/^\d+$/.test(f.n || '')) throw Error(`line ${index+1}: invalid n`);
  const n=Number(f.n), t=n*T;
  if (!Number.isSafeInteger(n) || n<1 || !Number.isSafeInteger(t)) throw Error(`line ${index+1}: n out of bounds`);
  if (kind==='DATA') {
   if (seen.has(n)) throw Error(`line ${index+1}: duplicate DATA n=${n}`);
   seen.add(n);
   ['s1','s2','s3'].forEach(s => {
    if (!/^[+-]?(?:\d+(?:\.\d*)?|\.\d+)$/.test(f[s] || '')) throw Error(`line ${index+1}: invalid ${s}`);
    const v=Number(f[s]);
    if (!Number.isFinite(v)) throw Error(`line ${index+1}: non-finite ${s}`);
    sql.push(`INSERT INTO readings(n,t_s,sensor,value) VALUES(${n},${t},${quote(s)},${v});`);
    rows++;
    const bad=v<RANGES[s][0] || v>RANGES[s][1] || (s==='s3' && ![0,1].includes(v));
    if (bad) sql.push(`INSERT INTO events(n,t_s,type,message) VALUES(${n},${t},'FAULT',${quote(`датчик ${s} вне диапазона`)});`);
   });
  } else {
   if (!seen.has(n)) throw Error(`line ${index+1}: EVENT must follow its DATA`);
   if (!['THRESHOLD','NORMAL'].includes(f.type)) throw Error(`line ${index+1}: invalid event type`);
   sql.push(`INSERT INTO events(n,t_s,type,message) VALUES(${n},${t},${quote(f.type)},'');`);
  }
 });
 if (!rows) throw Error('no DATA records');
} catch(e) {
 node.error(e.message,msg);
 return [{payload:'IMPORT REJECTED: '+e.message},null];
}
const head="BEGIN;\nDELETE FROM readings;\nDELETE FROM events;\nDELETE FROM sqlite_sequence WHERE name IN ('readings','events');\n";
return [null,{payload:head+sql.join('\n')+'\nCOMMIT;\n'}];
