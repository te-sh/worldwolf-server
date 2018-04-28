FROM ruby:2.5.1-alpine3.7

ENV APP=/app

RUN mkdir $APP $APP/tmp
WORKDIR $APP

COPY Gemfile Gemfile.lock ./

RUN apk add --update --no-cache build-base libxml2-dev libxslt-dev postgresql-dev tzdata \
 && bundle install \
 && apk del build-base

ENTRYPOINT ["./bin/rails", "server"]
