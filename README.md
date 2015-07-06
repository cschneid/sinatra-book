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

License
-----------------

The MIT License (MIT)

Copyright (c) 2015 Sinatra

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
