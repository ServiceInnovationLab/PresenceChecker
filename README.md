# README

[![Waffle.io - Issues in progress](https://badge.waffle.io/ServiceInnovationLab/PresenceChecker.png?label=in%20progress&title=In%20Progress)](http://waffle.io/ServiceInnovationLab/PresenceChecker)
[![Build Status](https://travis-ci.org/ServiceInnovationLab/PresenceChecker.svg?branch=master)](https://travis-ci.org/ServiceInnovationLab/PresenceChecker)

# Presence Checker

New Zealand legislation contains a somewhat complicated requirement of presence in New Zealand, on an indefinite stay visa, for a total number of days over a time. For a person who has travelled outside NZ this can result in being eligible for a small window of time, and then ineligible again.

This software is a tool to calculate and predict days where a person is eligible, helping people decipher the result of these rules in legislation, and plan.

## How to run

This is a ruby on rails app. You will need:
* a dev machine to run on. This app is built to run on Linux, but also runs nicely on MacOS. Windows is not supported, so YMMV.
* Git clone this repo
* Install the correct version of Ruby. We reccomend install `rbenv`, and then uing that to install the version of ruby specified in our file `.ruby-version`
```
# Install rbenv from https://github.com/rbenv/rbenv then
rbenv install < .ruby-version
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
bundle exec rails serve
```
