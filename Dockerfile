FROM ruby:2.6-alpine

RUN apk --update add build-base git file less postgresql-dev nodejs tzdata curl && \
    mkdir -p /srv/

ADD Gemfile Gemfile.lock Rakefile package.json .rspec .rubocop.yml .rubocop_todo.yml config.ru /srv/

WORKDIR /srv

ARG PUID=1000
ARG PGID=1000

RUN bundle && \
    addgroup -g ${PGID} srv && \
    adduser -D -u ${PUID} -G srv srv

ADD --chown=srv:srv app /srv/app
ADD --chown=srv:srv bin /srv/bin
ADD --chown=srv:srv config /srv/config
ADD --chown=srv:srv db /srv/db
ADD --chown=srv:srv lib /srv/lib
ADD --chown=srv:srv log /srv/log
ADD --chown=srv:srv public /srv/public
ADD --chown=srv:srv spec /srv/spec
ADD --chown=srv:srv storage /srv/storage
ADD --chown=srv:srv tmp /srv/tmp
ADD --chown=srv:srv vendor /srv/vendor

USER srv

EXPOSE 3000

ENV RAILS_ENV=development

HEALTHCHECK --interval=1m \
            --timeout=3s \
            --start-period=20s \
  CMD curl -f http://localhost:3000/api/v1/health || exit 1

CMD ["sh", "-c", "rails s -b 0.0.0.0 -p 3000"]
