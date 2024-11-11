FROM ruby:3.0.0-slim

WORKDIR /srv/slate

EXPOSE 4567

COPY Gemfile .
COPY Gemfile.lock .

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        git \
        nodejs \
    && gem install bundler \
    && bundle install \
    && apt-get remove -y build-essential git \
    && apt-get autoremove -y \
    && apt-get install -y zip unzip \
    && apt-get install -y curl \
    && rm -rf /var/lib/apt/lists/*

COPY . /srv/slate

RUN chmod +x /srv/slate/slate.sh

ENTRYPOINT ["/srv/slate/slate.sh"]
CMD ["build"]
CMD ["serve"]