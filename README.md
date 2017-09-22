# Fidor API Demo

This [Rails](http://rubyonrails.org) application demonstrates the capabilities of Fidor Bank API powered by the [fidor_api](https://github.com/fidor/fidor_api) ruby library.

## Production Setup & Deployment

### Preview

You can always access the latest version of this appliation at [fidor-api-demo.herokuapp.com](https://fidor-api-demo.herokuapp.com) to see it action. This deployment is connected to the Fidor Sandbox (`aps.fidor.de`). Use the following credentials to login:

```
Username: api_tester@example.com
Password: password
```

If you want to deploy your own version of this application just follow this instructions:

> **Requirement**: You need to have registered a Application in the Fidor App Manager.<br>
See "Register a new Application in the Fidor App-Manager" section.

### To Heroku

You can deploy this application to Heroku with just a click on the following button:

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https%3A%2F%2Fgithub.com%2Ffidor%2Ffidor_api_demo)

This will create a new application at Heroku (requiring an account there of course) and ask for all the needed configuration. This allows to run this application in production-like environment for free (using the Free-Tier at Heroku: [heroku.com/pricing](https://www.heroku.com/pricing)) without deeper knowledge of how to host ruby/rails applications.

### Using Docker

The [Dockerfile](Dockerfile) in this repository's master branch is the source for the public [fidor/fidor_api_demo](https://hub.docker.com/r/fidor/fidor_api_demo/) image.

On a machine having docker installed you can:

#### Create and start a new container

**Note**: The following command requires a file called `.env` in your current work-directory.<br>See "Configuration" section for details.

```
$ docker run -it --rm --env-file .env -p 4000:8080 -d fidor/fidor_api_demo
```

#### Build your own image using the Dockerfile

```shell
# Change to the directory where the source-code has been checked out to
$ cd ~/code/fidor_api_demo

# Build the image
$ docker build -t fidor_api_demo .
```

## Development Setup

> **Requirement**: You need to have registered a Application in the Fidor App Manager.<br>
See "Register a new Application in the Fidor App-Manager" section.

In order to run this application locally on your computer you need a working ruby environment.<br />
See [rvm.io](http://rvm.io) or [github.com/rbenv/rbenv](https://github.com/rbenv/rbenv) for two examples how you could get one.

How to get started:

```shell
# Change to the directory where the source-code has been checked out to
cd ~/code/fidor-api-demo

# Make sure the package manager "bundler" is installed
$ gem install bundler

# Install all dependencies for this project using bundler
$ bundle install

# Start the application server on port 4000
$ bundle exec rails s -p 4000
```

You can then access the application on your local machine: [http://127.0.0.1:4000](http://127.0.0.1:4000) and will see the required configuration. To complete your setup you have to add a file called `.env` to the root directory of this application and restart the application server. See "Configuration" section for details.

## Configuration

The application is reading it's configuration from environment variables in order to be [12factor](https://12factor.net/) compliant.<br>
Those variables can be passed in different ways: In development mode the application is checking for a `.env` file located inside the main-directory which contains one environment variable per line.

Example format of `.env` file:

```shell
FIDOR_API_CALLBACK=http://localhost:4000/auth/callback
FIDOR_API_CLIENT_ID=1234567890
FIDOR_API_CLIENT_SECRET=xxxxxxxxxxxxxxxxxxxxxxx
FIDOR_API_LOGGING=true
FIDOR_API_URL=https://aps.fidor.de
FIDOR_OAUTH_URL=https://aps.fidor.de
```

The same file can be used when executing a docker-container with the option `--env-file` but it's also possible to pass the variables inline of the `docker run` command:

```shell
$ docker run -it --rm \
    -e FIDOR_API_CALLBACK=http://localhost:4000/auth/callback \
    -e FIDOR_API_CLIENT_ID=1234567890 \
    -e FIDOR_API_CLIENT_SECRET=xxxxxxxxxxxxxxxxxxxxxxx \
    -e FIDOR_API_LOGGING=true \
    -e FIDOR_API_URL=https://aps.fidor.de \
    -e FIDOR_OAUTH_URL=https://aps.fidor.de \
    -p 4000:8080 \
    -d fidor_api_demo
```

When you use the "Deploy to Heroku" button in this README all variables will already be passed to heroku - you'll just need to fill in the values.

## Register a new Application in the Fidor App-Manager

To access the Fidor API you need to register for an account at [apm.fidor.de](https://apm.fidor.de) and create a new application in order to get the following information:

* Client ID
* Client Secret
* Fidor OAuth URL
* Fidor API URL

For the **Callback URLs** it's required to add a list of two values like this:

```
http://localhost:4000/auth/callback,https://<production-domain>/auth/callback
```
So you can use the same application for development (localhost) and production (replace `<production-domain>` with the domain name you're planning to use).
