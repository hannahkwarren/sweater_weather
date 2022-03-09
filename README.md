# README: Sweater Weather

![languages](https://img.shields.io/github/languages/top/cuisine-odyssey/frontend_application?color=red)
![PRs](https://img.shields.io/github/issues-pr-closed/cuisine-odyssey/frontend_application)
![rspec](https://img.shields.io/gem/v/rspec?color=blue&label=rspec)
![simplecov](https://img.shields.io/gem/v/simplecov?color=blue&label=simplecov) <!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->[![All Contributors](https://img.shields.io/badge/contributors-1-orange.svg?style=flat)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->


## Background and Description

"Sweater Weather" is a solo project undertaken during Module 3 of Turing School of Software and Design's Backend Engineering program.

## Learning Goals

- Expose an API that aggregates data from multiple external APIs
- Expose an API that requires an authentication token
- Expose an API for CRUD functionality
- Determine completion criteria based on the needs of other developers
- Research, select, and consume an API based on your needs as a developer


## Requirements and Setup (for Mac):

### Ruby and Rails
- Ruby Version 2.7.2
- Rails Version 5.2.6

### Gems Utilized
- RSpec 
- Pry
- SimpleCov
- Capybara
- Shoulda-Matchers 
- Factory_Bot_Rails
- Faker
- jsonapi-serialize
- Figaro
- Webmock
- VCR
- jquery-rails
- rspec_junit_formatter
- Orderly
- Lockbox
- Blind Index

## Setup
1. Clone this repository:
On your local machine open a terminal session and clone the repositiory. Once cloned, you'll have a new local copy in the directory you ran the clone command in.

2. Change to the project directory:<br>
In terminal, use `$cd` to navigate to the Frontend Application project directory.

```shell
$ cd frontend_application
```

3. Install required Gems utilizing Bundler: <br>
In terminal, use Bundler to install any missing Gems. If Bundler is not installed, first run the following command.

```shell
$ gem install bundler
```

If Bundler is already installed or after it has been installed, run:

```shell
$ bundle install
```

There should be be verbose text diplayed of the installation process. If there are any errors, verify that bundler, Rails, and your ruby environment are correctly setup.

4. Database Migration<br>
Before using the web application you will need to setup your databases locally by running the following command

```shell
$ rails db: {:drop, :create, :migrate, :seed}
```

5. Set up environment variables

```shell
$ bundle exec figaro install
```
This will create a hidden file called application.yml. You will need to sign up for three API keys to run this project: 
- [Mapquest Geocode and Directions API](https://developer.mapquest.com/plan_purchase/steps/business_edition/business_edition_free/register)
- [OpenWeather API](https://home.openweathermap.org/users/sign_up)
- [Unsplash API](https://unsplash.com/oauth/applications)

6. Add all three keys to your application.yml to set up a local variable for your endpoints if you choose to deploy outside of localhost.<br>

```shell
mapquest_api_key: <insert_your_key_here>
weather_api_key: <insert_your_key_here>
unsplash_api_key: <insert_your_key_here>
```

8. Startup and Access<br>
Finally, in order to use the web app you will have to start the server locally and access the app through a web browser. 
- Start server
```shell
$ rails s
```

9. Go to town! 
Use Postman, curl, or another tool of your choice to make a request to http://localhost:3000/api/v1

### Supported Endpoints
 
GET `/forecast?location=NewYork,NY` provides a current forecast, daily forecast for the next 5 days, and hourly forecast for the next 8 hours at a given location.

GET `/background?location=NewYork,NY` provides a single image, via the Unsplash API, tagged or titled with the provided location.

POST `/users` adds a user to the database given a valid and unique email, and matching password and password confirmation. Params must be provided in the body of the request in JSON format. Here's an example hash:

```
{
    "user": {
        "email": "example@mail.com",
        "password": "mypassword",
        "password_confirmation": "mypassword"
    }
}
```

POST `/sessions` logs in a user given email and password, provided as JSON in the request body. 

```
{
    "email": "example@mail.com",
    "password": "mypassword"
}
```

POST `/road_trip` compiles travel time and weather forecast at projected arrival time for a roadtrip (nonstop) between origin and destination. Requires a valid api_key. Your params must again be JSON in the request body:
```
{
  "origin": "New York, NY",
  "destination": "Burlington, VT",
  "api_key": "your_key_goes_here"
}
```


## **Contributors** ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="left"><a href="https://github.com/hannahkwarren"><img src="https://avatars.githubusercontent.com/u/17674781?v=4" width="100px;" alt=""/><br /><sub><b>Hannah(she/her)</b></sub></a><br /><a href="https://github.com/sweater_weather/commits?author=hannahkwarren" title="Code">💻</a> <a href="https://github.com/sweater_weather/pulls?q=is%3Apr+author%3Ahannahkwarren" title="Reviewed Pull Requests">👀</a>
     </td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification.
<!--
