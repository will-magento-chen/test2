#!/bin/sh
exec /usr/bin/env DOMAIN_NAME=$VIRTUAL_HOST RAILS_ENV=production bundle exec rackup
