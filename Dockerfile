FROM ruby:2.7.1

WORKDIR /var/www/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 3000

ENTRYPOINT exec bundle exec puma -b tcp://0.0.0.0:3000