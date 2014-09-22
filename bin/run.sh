#!/bin/sh
export DOMAIN_NAME=$VIRTUAL_HOST
export RAILS_ENV=production 
exec bundle exec rackup
