FROM ruby:2.6-alpine

ARG PUID=1000
ARG PGID=1000

RUN apk --update add build-base git file less postgresql-dev nodejs tzdata curl rust cargo && \
	addgroup -g ${PGID} srv && \
    adduser -D -u ${PUID} -G srv srv && \
    # mkdir -p /tmp/ && \ # Uncomment these if you want rbspy
    # cd /tmp/ && \
    # export PATH=/root/.cargo/bin:$PATH && \
    # git clone https://github.com/rbspy/rbspy && \
    # cd rbspy && \
    # cargo install && \
    mkdir -p /srv/tmp && \
    chown -R srv /srv

ADD Gemfile Gemfile.lock Rakefile package.json .rspec .rubocop.yml .rubocop_todo.yml config.ru /srv/

WORKDIR /srv

RUN bundle

ADD --chown=srv:srv log /srv/log
ADD --chown=srv:srv public /srv/public
ADD --chown=srv:srv vendor /srv/vendor
ADD --chown=srv:srv bin /srv/bin
ADD --chown=srv:srv lib /srv/lib
ADD --chown=srv:srv db /srv/db
ADD --chown=srv:srv config /srv/config
ADD --chown=srv:srv spec /srv/spec
ADD --chown=srv:srv app /srv/app

USER srv

EXPOSE 3000

ENV RAILS_ENV=development

HEALTHCHECK --interval=1m \
            --timeout=3s \
            --start-period=20s \
  CMD curl -f http://localhost:3000/api/v1/health || exit 1

CMD ["sh", "-c", "rails s -b 0.0.0.0 -p 3000"]
