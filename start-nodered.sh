#!/bin/bash
# Запуск Node-RED на macOS/Linux. Запускать из папки проекта (пути в потоке относительные).
cd "$(dirname "$0")" || exit 1
if command -v node-red >/dev/null 2>&1; then
  node-red --userDir ./.nodered --settings ./nodered/settings.js ./nodered/flow.json
elif [ -f ./tools/nodered/node_modules/node-red/red.js ]; then
  node ./tools/nodered/node_modules/node-red/red.js --userDir ./.nodered --settings ./nodered/settings.js ./nodered/flow.json
else
  echo "Node-RED не найден. Установка: npm install -g node-red"; exit 1
fi
