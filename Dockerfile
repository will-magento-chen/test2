FROM synctree/base-ubuntu14.04-deploy-ruby
MAINTAINER Synctree App Force <appforce@synctree.com>

RUN apt-get install -y libmysqlclient-dev

ADD Gemfile      /home/deploy/app/Gemfile
ADD Gemfile.lock /home/deploy/app/Gemfile.lock
RUN chown -R deploy:deploy /home/deploy/app
RUN su - deploy -c 'cd app && bundle install --without development test'

ADD . /home/deploy/app
RUN chown -R deploy:deploy /home/deploy/app
RUN su - deploy -c 'cd app && RAILS_ENV=production bundle exec rake assets:precompile'

WORKDIR /home/deploy/app
CMD ["./bin/run.sh"]

EXPOSE 9292
