<!--
# @title jaltech backend
-->
# Jaltech backend

## Requirements
- ruby 3.1.2
- rails 7.0.3
- postgresql 14
- docker
- redis

## How to run development environment

Below you can find instructions on how to run the application in a particular environment.

Please follow the instructions in the `For all environments` then:

- the `Docker` instructions if you want to run the application using the docker
- the `Native` instructions if you want to run the application natively on your machine

### For all environments

1. Copy the file with environment variables
   ```
    cp .env.template .env
   ```
2. Copy environment variables from 1Pass vault (`Project / Jaltech`) to your `.env` file.

### Docker 

1. Install dependencies and prepare the database
   ```
   docker-compose run setup
   ```
2. Start docker containers
   ```
    docker-compose up app
   ```

### Native

1. Install dependencies and prepare the database
   ```
   bin/setup
   ```
2. Run rails server
   ```
   rails server
   ```
3. Run sidekiq
   ```
   bundle exec sidekiq -C config/sidekiq.yml
   ```


## Documentation

* [Tutorials](docs/tutorials/README.md) take you by the hand through a series of steps to run the app locally. Start here if you’re new to the project.
* [Topic guides](docs/topics/README.md) discuss key topics and concepts at a fairly high level and provide useful background information and explanation.
* [Reference guides](docs/references/README.md) contain technical reference for APIs, project glossary and other aspects of app machinery.
* [How-to guides](docs/guides/README.md) are recipes. They guide you through the steps involved in addressing key problems and use-cases.
