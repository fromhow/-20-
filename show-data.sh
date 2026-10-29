#!/bin/bash
# Три контрольных запроса к базе (macOS/Linux).
cd "$(dirname "$0")" || exit 1
sqlite3 -header -column db/variant.db ".read db/queries.sql"
