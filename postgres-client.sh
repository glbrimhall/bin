#!/bin/sh


DB_HOST=${1:-dspace-dbdev}
DB_USER=postgresDBA
DB_PASSWORD=postgresD5vops-G5tt.62
export PGPASSWORD="$DB_PASSWORD"

psql -h $DB_HOST -U $DB_USER

