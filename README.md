# Welcome to the Succotash API

* Ruby Version
Succotash is built with Ruby 2.6.1 and Rails 6.0.3. If you wish to run the
application on your local machine, we recommend securing the correct version
of Ruby using a utility such as RVM[https://rvm.io/].

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

The API has some, though certainly not extensive, unit testing in place to
ensure update to the API do not break working features. Testing is built with
RSpec. Running tests from the command line can be done with `rspec`.

Some tests specifically require a Spoonacular API key to pass. If you have not
provided a Spoonacular API key, you may skip those tests by running `rspec --tag
~spoonacular`.

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions
