Sinatra Book
============

A cookbook full of excellent tutorials and recipes for developing Sinatra web applications.

How to build the Book
---------------------

Before you can translate the book into various formats you need to install the dependencies.

    gem install bundler
    bundle install

In the root directory, launch the following Rake task:

    bundle exec rake book:build

This will build a PDF version of the book in the output folder

You can run the built-in book sinatra app to view it in your browser too:

    rackup

Then visit: http://localhost:9292/

How to contribute
-----------------

Want to help contribute recipes or tutorials into the [Sinatra
Book][sinatra-book]?

Check out the [Sinatra Recipes][sinatra-recipes] project for all of
the recent additions from the community.

If you're looking for something to work on be sure to check the [issue
tracker][issues] first, then read up on the [styling
guidelines][styling-guidelines].

Once you have [forked the project][forking], feel free to send us a [pull
request][pull-requests].

Join us on IRC (#sinatra at irc.freenode.org) if you need help with anything.


[sinatra-book]: http://github.com/sinatra/sinatra-book
[sinatra-recipes]: http://recipes.sinatrarb.com/
[issues]: http://github.com/sinatra/sinatra-book/issues
[styling-guidelines]: http://github.com/sinatra/sinatra-book-contrib/wiki/Style-Guidelines
[forking]: http://help.github.com/forking/
[pull-requests]: http://help.github.com/pull-requests/

