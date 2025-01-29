FROM ruby:3.0.0

ENV RAILS_ENV production
RUN mkdir /pulao
RUN bundle config mirror.https://rubygems.org https://gems.ruby-china.com
WORKDIR /pulao
ADD Gemfile /pulao
ADD Gemfile.lock /pulao
RUN bundle config set --local without 'development test'
RUN bundle install
ENTRYPOINT bundle exec puma