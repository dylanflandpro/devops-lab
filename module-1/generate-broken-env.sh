#!/bin/bash
mkdir -p check-challenge
cd check-challenge

# Structure d'une app web typique
mkdir -p webapp/{bin,config,data,logs,public,tmp}

# Fichiers de config
echo "DB_HOST=localhost" > webapp/config/app.conf
echo "DB_PASSWORD=super_secret_123" > webapp/config/.env
echo "API_KEY=ak_live_xxxxx" > webapp/config/credentials.json

# Scripts
echo '#!/bin/bash' > webapp/bin/start.sh
echo '#!/bin/bash' > webapp/bin/backup.sh
echo '#!/bin/bash' > webapp/bin/cleanup.sh

# Données et logs
touch webapp/data/users.db
touch webapp/logs/access.log
touch webapp/logs/error.log

# Fichiers publics
touch webapp/public/index.html
touch webapp/public/style.css

# Applique des permissions chaotiques (simule le bricolage)
chmod 777 webapp/config/.env
chmod 777 webapp/config/credentials.json
chmod 666 webapp/bin/start.sh
chmod 644 webapp/bin/backup.sh
chmod 777 webapp/tmp
chmod 777 webapp/data
chmod 666 webapp/data/users.db
chmod 755 webapp/logs
chmod 666 webapp/logs/access.log
chmod 000 webapp/logs/error.log
chmod 604 webapp/config/app.conf
