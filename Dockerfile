FROM ruby:2.7

WORKDIR /app/autify_test

COPY autify_test/Gemfile autify_test/Gemfile.lock ./

RUN gem install bundler
RUN bundle install

COPY . ./

CMD []
