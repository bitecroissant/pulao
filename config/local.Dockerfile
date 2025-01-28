FROM ruby:3.0.0

ENV RAILS_ENV production
RUN mkdir /pulao
WORKDIR /pulao
ADD pulao-*.tar.gz ./
RUN bundle config set --local without 'development test'
RUN bundle install
ENTRYPOINT bundle exec puma