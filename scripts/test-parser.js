const fs=require('fs'), assert=require('assert');
const R=require('path').resolve(__dirname,'..');
const code=fs.readFileSync(R+'/nodered/parser.js','utf8');
const fn=new Function('msg','node',code);
const run=p=>fn({payload:p},{error:()=>{}});
let checks=[];
for (const [name,p] of [
 ['missing sensor','DATA n=1 s1=10 s2=2'],
 ['non-numeric','DATA n=1 s1=NaN s2=2 s3=0'],
 ['invalid event','DATA n=1 s1=10 s2=2 s3=0\nEVENT n=1 type=FAKE'],
 ['duplicate DATA','DATA n=1 s1=10 s2=2 s3=0\nDATA n=1 s1=10 s2=2 s3=0'],
 ['empty log',''],['event without DATA','EVENT n=1 type=NORMAL']
]) {assert.equal(run(p)[1],null);checks.push(name+': PASS');}
for(const [name,p] of [['PIR must be binary','DATA n=1 s1=10 s2=2 s3=0.5'],['pressure out of range','DATA n=1 s1=10 s2=6 s3=0']]) {
 assert(run(p)[1].payload.includes("'FAULT'"));checks.push(name+': PASS');
}
assert(run('\ufeffDATA  n=1  s1=10 s2=2 s3=0\r\n')[1]);checks.push('BOM / whitespace: PASS');
fs.writeFileSync(R+'/docs/parser_checks.txt',checks.join('\n')+'\n');
console.log(checks.join('\n'));
