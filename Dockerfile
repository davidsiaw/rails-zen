FROM ruby:3.3-alpine

ARG PUID=1000
ARG PGID=1000

RUN apk --update add build-base git file less postgresql-dev nodejs tzdata curl rust cargo yaml-dev linux-headers && \
	addgroup -g ${PGID} srv && \
    adduser -D -u ${PUID} -G srv srv && \
    # mkdir -p /tmp/ && \ # Uncomment these if you want rbspy
    # cd /tmp/ && \
    # export PATH=/root/.cargo/bin:$PATH && \
    # git clone https://github.com/rbspy/rbspy && \
    # cd rbspy && \
    # cargo install && \
    mkdir -p /srv/tmp

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

RUN chown -R srv /srv && \
    chgrp -R srv /srv

USER srv

EXPOSE 3000

ENV RAILS_ENV=development

CMD ["sh", "-c", "rails s -u falcon -b 0.0.0.0 -p 3000"]
