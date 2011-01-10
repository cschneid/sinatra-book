Sinatra Book
============

Documentation in "book" form for the Sinatra Web Framework.

About
-----

It'll probably be cookbook style recipes, along with a more linear tutorial to get you started.

Join us on IRC (#sinatra at irc.freenode.org) if you need help with anything.

File Layout:

* _book_   - Text of the book.  In maruku's markdown format.
* _images_ - Images, Diagrams, Funny Pictures
* _source_ - Any source examples to be included into the book

Learn more about Sinatra at 
[http://github.com/sinatra/sinatra](http://github.com/sinatra/sinatra).


How to build the Book
---------------------

Before you can translate the book into various formats you need to 
have the Thor and Maruku gem installed:

    gem install maruku
    gem install thor

Or you install the Bundler gem and let it check all the required dependencies to build the book:

    gem install bundler
    bundle check

In the root directory, launch the following Thor task:

    thor book:build

This will install an HTML version of the book in the output folder

To build a LaTeX or PDF version you have to use this task:

    thor book:build latex
    # or
    thor book:build pdf

How to contribute
-----------------

Fork this repository, be sure to read the [styleguide](http://github.com/sinatra/sinatra-book/wiki/How-to-contribute) and post pull requests.
