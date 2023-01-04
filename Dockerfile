FROM ruby:3.1.2-alpine3.16 AS rails-toolbox

# Install dependencies
RUN apk --update add build-base git postgresql-dev postgresql-client tzdata libxml2-dev libxslt-dev

# Use a directory called /app in which to store this application's files.
WORKDIR /app
