# Запуск на Mac
Файлы .bat предназначены для Windows. На Mac используйте Терминал; все команды — из корня variant20.

Переход (если папка находится в Загрузках):
```bash
cd ~/Downloads/variant20
```
Запуск при уже установленном Node-RED:
```bash
node ./tools/nodered/node_modules/node-red/red.js --userDir ./.nodered --settings ./nodered/settings.js ./nodered/flow.json
```
Редактор: http://127.0.0.1:1880. Не закрывайте этот Терминал до окончания работы.
Второй Терминал — просмотр данных:
```bash
cd ~/Downloads/variant20
sqlite3 -header -column db/variant.db ".read db/queries.sql"
```
При необходимости установка Node-RED после установки Node.js LTS:
```bash
npm install --prefix ./tools/nodered node-red
```
Каждый импорт заменяет таблицы. После FAULT нажмите «Загрузить реальный лог» и проверьте THRESHOLD. Это не событие NORMAL.
Ваши подтверждения — evidence/mac. Скриншот содержит FAULT, восстановление THRESHOLD подтверждено текстовым протоколом.
Программы и node_modules в архив не включены. При обновлении архива не удаляйте свою установленную папку tools и .nodered. Не заменяйте свой изменённый скетч или лог без резервной копии.
