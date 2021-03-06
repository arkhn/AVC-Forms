#!/bin/bash

# Collect static files
echo "Collect static files"
python manage.py collectstatic --noinput

# Wait for db
echo "Waiting for postgres..."
while ! nc -z "$POSTGRES_HOST" "$POSTGRES_PORT"; do
  sleep 1
done

# Apply database migrations
echo "Apply database migrations"
python manage.py migrate

# Create superuser
echo "Create superuser"
python manage.py createsuperuser --noinput

exec "$@"
