#!/bin/bash

set -e

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

if psql "$DATABASE_URL" -lqt | cut -d \| -f 1 | grep -qw task_manager_development; then
  echo "MIGRATING DATABASE"

  bundle exec rails db:migrate
else
  echo "CREATING, MIGRATING AND SEEDING DATABASES"
  bundle exec rails db:create db:schema:load db:seed
fi

exec "$@"
