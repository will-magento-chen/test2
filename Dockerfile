FROM synctree/base-ubuntu14.04-deploy-ruby
MAINTAINER Synctree App Force <appforce@synctree.com>

RUN apt-get install -y libmysqlclient-dev

RUN apt-get install -y software-properties-common
RUN apt-add-repository ppa:chris-lea/node.js -y
RUN apt-get update -y
RUN apt-get install -y nodejs

ADD Gemfile       /home/deploy/app/Gemfile
ADD Gemfile.lock  /home/deploy/app/Gemfile.lock
ADD .ruby-version /home/deploy/app/.ruby-version
ADD .ruby-gemset  /home/deploy/app/.ruby-gemset
ADD package.json  /home/deploy/app/package.json


USER deploy
ENV USER deploy
ENV HOME /home/deploy
WORKDIR /home/deploy/app
RUN bash -l -c bundle install --without development test
RUN bash -l -c npm install --save-dev browserify watchify
RUN bash -l -c npm install


USER root
ADD . /home/deploy/app
RUN chown -R deploy:deploy /home/deploy/app


USER deploy
RUN bash -l -c RAILS_ENV=production bundle exec rake assets:precompile
RUN bash -l -c npm run bundle

ENTRYPOINT ["./bin/entrypoint.sh"]
CMD ["./bin/run.sh"]

EXPOSE 9292
