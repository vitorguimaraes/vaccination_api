FROM elixir:1.14-alpine

RUN apk add --no-cache openssl && \
    apk add --no-cache inotify-tools && \
    mix local.hex --force && \
    mix local.rebar --force && \
    mix archive.install hex phx_new --force && \
    apk add git && \
    apk add bash && \
    apk add --no-cache make && \
    apk --no-cache --update add build-base 

ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

EXPOSE 5001
