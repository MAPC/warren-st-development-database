#!/bin/bash
set -e
LOGFILE=/var/www/log/warrenstreet-gunicorn.log
NUM_WORKERS=1
# user/group to run as
USER=www-data
GROUP=www-data
cd /var/www/warrenstreet
#source /usr/local/bin/virtualenvwrapper.sh
source /var/www/venvs/warrenstreet/bin/activate
#toggleglobalsitepackages
exec /var/www/venvs/warrenstreet/bin/gunicorn developmentdatabase.wsgi:application \
  --workers=$NUM_WORKERS \
  --bind=127.0.0.1:8008 \
  --user=$USER --group=$GROUP --log-level=error \
  --env ENV_TYPE_FULL=$ENV_TYPE_FULL \
  --env SECRET_KEY=$SECRET_KEY \
  --env DATABASE_URL=$DATABASE_URL \
  --env BING_API_KEY=$BING_API_KEY \
  --env WSAPIKEY=$WSAPIKEY \
  --log-file=$LOGFILE 2>>$LOGFILE

