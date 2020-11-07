FROM ruby:2.6.3-stretch

MAINTAINER vinay@codecrux.com

RUN apt-get update && apt-get install -qq -y --no-install-recommends build-essential nodejs libpq-dev

ENV RAILS_ENV=production RACK_ENV=production SECRET_KEY_BASE=xpto APP_HOME=/app/

ADD Gemfile* $APP_HOME
RUN cd $APP_HOME && bundle install --without development test --jobs 2

ADD ./ $APP_HOME
WORKDIR $APP_HOME

RUN RAILS_GROUPS=assets bundle exec rake assets:precompile


CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]