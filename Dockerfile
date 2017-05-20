FROM ruby:2.3-alpine

RUN apk --update --no-cache add mariadb-dev

RUN mkdir /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./

RUN apk --update --no-cache add --virtual .gem-builddeps \
    build-base \
    ruby-dev \
 && bundle install --jobs=20 --retry=5 \
 && apk del .gem-builddeps

COPY . .
