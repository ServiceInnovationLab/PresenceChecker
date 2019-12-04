# README

[![Build Status](https://travis-ci.org/ServiceInnovationLab/PresenceChecker.svg?branch=master)](https://travis-ci.org/ServiceInnovationLab/PresenceChecker)
[![Total alerts](https://img.shields.io/lgtm/alerts/g/ServiceInnovationLab/PresenceChecker.svg?logo=lgtm&logoWidth=18)](https://lgtm.com/projects/g/ServiceInnovationLab/PresenceChecker/alerts/)
[![Maintainability](https://api.codeclimate.com/v1/badges/33f8f206d6c46ef84d9d/maintainability)](https://codeclimate.com/github/ServiceInnovationLab/PresenceChecker/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/33f8f206d6c46ef84d9d/test_coverage)](https://codeclimate.com/github/ServiceInnovationLab/PresenceChecker/test_coverage)

# Presence Checker

New Zealand legislation contains a somewhat complicated requirement to obtain citizenship by grant. The applicants needs to be present in New Zealand, on an indefinite stay visa, for a total number of days over a time. For a person who has travelled outside NZ this can result in being eligible for a small window of time, and then ineligible again.

This software is a tool to calculate and predict days where a person is eligible, helping people decipher the result of these rules in legislation, and plan.

The rules are implemented on an [OpenFisca](https://openfisca.org/en/) server.

## How to run
This app is built to run on Linux, but also runs nicely on MacOS. Windows is not supported, so YMMV.

This is a ruby on rails app. You will need to:
* Git clone this repo
* Install the correct version of Ruby. We recommend installing `rbenv` to manage multiple versions of ruby, and then using that to install the version of ruby specified in our file `.ruby-version`
```
# Install rbenv from https://github.com/rbenv/rbenv then
rbenv install < .ruby-version
```
* Install PostgreSQL (in a mac)
```
brew install postgresql
```
* Start PostgreSQL on startup
```
brew services start postgresql
```
* Bundler. Install this from gem
```
gem install bundler
```

* Install the gems needs by this app:
```
bundle install
```
* Install the javascript dependencies
```
yarn install
```
* setup config environment variables from the example
```
cp env-example .env
```
* Create the databases
```
bundle exec rake db:create db:migrate
```
* Create the first user
```
bundle exec rake db:seed
```
* Run the app
```
bundle exec rails server
```

## Deployment

Deployments happen automatically (performed by TravisCI) when code is merged into the `master` branch.

## Testing

RSpec
```
bundle exec rspec
```

## Quality Assurance tools

Rubocop
```
bundle exec rubocop
```

## Database structure

Generate a PDF diagram of the database structure (`rails-erd` gem) in the root folder of the application (requires [Graphviz](https://www.graphviz.org/)):
```
bundle exec rake erd
```

## Related Projects

[OpenFisca Aotearoa](https://github.com/ServiceInnovationLab/openfisca-aotearoa)
