# Welcome to the Succotash API

The Succotash application utilizes Ruby-on-Rails as an API. This Readme provides
details on how you can startup the API and contribute to it.

## Setup
### Ruby Version
Succotash is built with Ruby 2.6.1 and Rails 6.0.3. If you wish to run the
application on your local machine, we recommend securing the correct version
of Ruby using a utility such as [RVM](https://rvm.io/).

### Database
The Succotash API requires [PostgreSQL](https://www.postgresql.org/) as the 
database for Active Record. In order to effectively work on the API in any 
environment, you will need Postgres installed on your machine and start the 
service. Please follow your system's instructions for installing and starting 
the database.

### Configuration
In order to work on the Succotash API, you will need to provide environment
variables to Figaro. In the home directory run `touch config/application.yml`
and insert the following into the file:
```
secret_key: abc
spoonacular_api_key: 
test:
    allowed_origin: http://localhost:3000

development:
    allowed_origin: http://localhost:3000
    PORT: 2020
```

If you have an API key from [Spoonacular](https://spoonacular.com/food-api), you
may add it to application.yml. A Spoonacular API key is required if you wish to 
have photos associated with crops. The API will still function without the
key, but letters will display instead of photos.

The application.yml file is not checked into the git repository.

## Create the Database
Once the configuration is set and Postgres is running on your machine, the
database can be created by running `rails db:create db:migrate`. Some seed
values are available for uses and can be seeded into your database with 
`rails db:seed`.

## Start the Server
The API server can be started on port 2020 by running the command `rails s`. If
you successfully seeded or added items to the crops table of the database, you
can check the server by visiting [localhost:2020/crops](localhost:2020/crops).

## Run the Test Suite
The API has some, though certainly not extensive, unit testing in place to
ensure update to the API do not break working features. Testing is built with
RSpec. Running tests from the command line can be done with `rspec`.

Some tests specifically require a Spoonacular API key to pass. If you have not
provided a Spoonacular API key, you may skip those tests by running 
`rspec --tag ~spoonacular`.

## Integrate with the Succotash Frontend
Information on how to run the Succotash frontend concurrently with the Succotash
API can be found in the frontend's 
[Github repository](https://github.com/mattbechtel1/succotash-frontend).