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

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

This will create a new application at Heroku (requiring an account there of course) and ask for all the needed configuration. This allows to run this application in production-like environment for free (using the Free-Tier at Heroku: [heroku.com/pricing](https://www.heroku.com/pricing)) without deeper knowledge of how to host ruby/rails applications.

### Using Docker

To be added soon ;)

## Development Setup

> **Requirement**: You need to have registered a Application in the Fidor App Manager.<br>
See "Register a new Application in the Fidor App-Manager" section.

In order to run this application locally on your computer you need a working ruby environment.<br />
See [rvm.io](http://rvm.io) or [github.com/rbenv/rbenv](https://github.com/rbenv/rbenv) for two examples how you could get one.

How to get started:

```shell
# Make sure the package manager "bundler" is installed
user@host:code/fidor-api-demo$ gem install bundler

# Install all dependencies for this project using bundler
user@host:code/fidor-api-demo$ bundle install

# Start the application server on port 4000
user@host:code/fidor-api-demo$ bundle exec rails -p 4000
```

You can then access the application on your local machine: [http://127.0.0.1:4000](http://127.0.0.1:3000) and will see the required configuration. To complete your setup you have to add a file called `.env` to the root directory of this application and restart the application server.

Example format of `.env` file:

```shell
export FIDOR_API_CALLBACK=http://localhost:4000/auth/callback
export FIDOR_API_CLIENT_ID=1234567890
export FIDOR_API_CLIENT_SECRET=xxxxxxxxxxxxxxxxxxxxxxx
export FIDOR_API_LOGGING=true
export FIDOR_API_URL=https://aps.fidor.de
export FIDOR_OAUTH_URL=https://aps.fidor.de
```

After adding the file you'll need to restart the application-server (in case it's already running).
To do that simply hit `CTRL` + `C` in your terminal window and execute the `bundle exec rails s ...` commadn again.

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
