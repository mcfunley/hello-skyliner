# Hello Skyliner

This is an example application for Skyliner. It's a simple Rails app, packaged
with Docker.

## How To Deploy

1. Install and configure Docker and the AWS CLI tools.
2. Fork this repo on GitHub.
3. Create an application in Skyliner named `hello-skyliner`.
4. Add a configuration parameter named `SECRET_KEY_BASE`. Generate two different
   values for it using `rake secret`. Use one for QA, the other for Production.
5. Run `./push.sh` to build and push the image to your private AWS Docker
   registry.
6. Go to Skyliner and deploy!

## Differences from a stock Rails application

* Depends on Heroku's `rails_12factor` gem, which directs the logs to stdout and
  allows Rails to serve up static assets.
* Adds quotes to the use of `SECRET_KEY_BASE` in `secrets.yaml`, which prevents
  a secret with all digits from being interpreted as a number.
* Depends on `puma-heroku`, which borrows Heroku's recommended Puma
  configuration.
