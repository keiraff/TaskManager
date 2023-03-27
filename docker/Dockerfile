FROM ruby:3.1.3-alpine3.17

RUN apk add --no-cache --update \
    build-base \
    bash \
    bash-completion \
    libffi-dev \
    tzdata \
    postgresql15-client \
    postgresql15-dev \
    nodejs \
    npm \
    yarn

WORKDIR /task-manager

COPY Gemfile* .

RUN gem update --system \
    && gem install bundler:2.4.7 --no-document \
    && bundle config set without 'production' \
    && MAKE="make --jobs 8" bundle install --retry 5

COPY . ./
