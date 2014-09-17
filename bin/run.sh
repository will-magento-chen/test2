#!/bin/sh
exec su - deploy -c "cd app && RAILS_ENV=production bundle exec rackup"
