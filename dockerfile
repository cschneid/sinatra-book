FROM ruby:2.2.4

WORKDIR /app

COPY . .

RUN bundle install

CMD rackup

EXPOSE 9292
