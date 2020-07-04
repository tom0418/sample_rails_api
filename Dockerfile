FROM ruby:2.7.1-alpine3.12

RUN apk update
RUN gem update bundler

#Using japanese on Rails console
ENV LANG ja_JP.UTF-8

# SETUP middleware required for build
# build-base  : native extension build
# mariadb-dev : gem mysql2
RUN apk --update add --virtual build-deps \
        build-base \
        mariadb-dev \
        tzdata \
        git \
    && rm -rf /usr/lib/libmysqld* \
    && rm -rf /usr/bin/mysql*

RUN mkdir /sample_api
ENV API_ROOT /sample_api
WORKDIR $API_ROOT

# Copy Gemfile of host to gest
COPY ./Gemfile $API_ROOT/Gemfile
COPY ./Gemfile.lock $API_ROOT/Gemfile.lock

# Run bundle install
RUN bundle install --jobs=4

# Copy from source files
COPY . $API_ROOT
