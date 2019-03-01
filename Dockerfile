FROM ruby:2.3.7

RUN apt-get update \
    && apt-get install -y --no-install-recommends sqlite3 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app
COPY Gemfile* ./
RUN bundle
COPY . .
RUN rake db:migrate
RUN rake db:seed

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
