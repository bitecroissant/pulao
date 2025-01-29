FROM ruby:3.0.0

ENV RAILS_ENV production
RUN mkdir /pulao

WORKDIR /pulao
ADD Gemfile /pulao
ADD Gemfile.lock /pulao
ADD vendor/cache /pulao/vendor/cache
RUN bundle config set --local without 'development test'
RUN bundle install --local

ADD pulao-*.tar.gz ./
ENTRYPOINT bundle exec puma