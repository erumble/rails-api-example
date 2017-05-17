FROM ruby:2.3-alpine

RUN apk --update --no-cache add \
    mariadb-client \
    mariadb-dev

RUN apk --update --no-cache add --virtual .gem-builddeps alpine-sdk

RUN mkdir /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./

RUN bundle install --jobs=20 --retry=5
RUN apk del .gem-builddeps

COPY . .