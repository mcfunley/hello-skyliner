# Hello Skyliner

This is an example application for Skyliner. It's a simple Rails app, packaged
with Docker.

## How To Deploy

1. Install and configure Docker and the AWS CLI tools.
2. Fork this repo on GitHub.
3. Create an application in Skyliner named `hello-skyliner`.
4. Add a configuration parameter named `SECRET_KEY_BASE`. Generate two different
   values for it using `rake secret`. Use one for QA, the other for Production.
5. Go to the settings for the application and copy the application token.
6. Run `./upload.sh <app token>` to build and upload the image to Skyliner.
7. Go to Skyliner and deploy!
8. For additional deploys, just repeat steps 6-9.

If you want Puma to run more Rails processes, add a configuration parameter
named `WEB_CONCURRENCY`. It defaults to `2`. If you want Rails to run more Ruby
threads, add a configuration parameter named `MAX_THREADS`. It defaults to `2`.

## Differences from a stock Rails application

* Depends on the `lograge` gem, which converts Rails's weirdly verbose logging
  into production-ready logging using Logstash JSON formatting.
* Depends on Heroku's `rails_12factor` gem, which directs the logs to stdout and
  allows Rails to serve up static assets. (If static asset serving becomes a
  performance hotspot, we recommend setting up CloudFront.)
* Adds quotes to the use of `SECRET_KEY_BASE` in `secrets.yaml`, which prevents
  a secret with all digits from being interpreted as a number.
* Depends on `puma-heroku`, which borrows Heroku's recommended Puma
  configuration.

## Docker tips

* Use Alpine Linux as a base image. It's tiny.
* Include OS updates along with each image build. This slows down images builds,
  but ensures you have all security updates included in each deploy.
* Separate out build dependencies (i.e. only required for compiling gems and
  assets) and runtime dependencies (i.e. required for the app to run). Remove
  build dependencies after the app is built to save space.
* Build the application in a single `RUN` command. It looks gross, but reduces
  the number of layers in your Docker image and saves space.
 
 
