FROM ruby:3.2

LABEL maintainer=ivankhoda@ya.ru
RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends nodejs

COPY Gemfile* /usr/src/app/
WORKDIR /usr/src/app
RUN bundle install

COPY . /usr/src/app


#ENV BUNDLE_PATH /gems
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD bin/rails s -b 0.0.0.0