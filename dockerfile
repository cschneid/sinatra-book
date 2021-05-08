FROM ruby:2.7.2

WORKDIR /app

COPY . .

RUN bundle install

CMD bundle exec rackup

EXPOSE 9292
