Deployment
==========

Heroku
------

This is the easiest configuration + deployment option.  [Heroku] has full
support for Sinatra applications.   Deploying to Heroku is simply a matter of
pushing to a remote git repository.

Steps to deploy to Heroku:

* Create an [account](http://heroku.com/signup) if you don't have one
* Download and install [Heroku toolbelt](https://toolbelt.heroku.com/)
* Make sure you have a `Gemfile`. Otherwise, you can create one and install the `sinatra` gem using `bundler`.
* Make a config.ru in the root-directory
* Create the app on heroku
* Push to it

1. Install `bundler` if you haven't yet (`gem install bundler`). Create a `Gemfile` using `bundle init`. Modify your `Gemfile` to look like:

    ```ruby
    source 'http://rubygems.org'

    gem 'sinatra'
    ```

    Run `bundle` to install the gem.

    It is possible to specify a specific Ruby version on your Gemfile.
    For more information, check [this](https://devcenter.heroku.com/articles/ruby-versions).

2. Here is an example config.ru file that does two things.  First, it requires
   your main app file, whatever it's called. In the example, it will look for
   `myapp.rb`. Second, run your application. If you're subclassing, use the
   subclass's name, otherwise use Sinatra::Application.

    ```ruby
    require "myapp"

    run Sinatra::Application
    ```

3. Create the app and push to it

   From the root directory of the application, run these commands:
   
    ```bash
    $ heroku create <app-name>  # This will add heroku as a remote
    $ git push heroku master
    ```

   For more details see [this](http://github.com/sinatra/heroku-sinatra-app).

   [Heroku]: http://www.heroku.com
