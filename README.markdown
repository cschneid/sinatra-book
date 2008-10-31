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

Learn more about Sinatra at [http://github.com/bmizerany/sinatra](http://github.com/bmizerany/sinatra).


How to build the Book
---------------------

You need following gems to build the book:

    sudo gem install thor maruku

In the book directory then launch following Thor task:

    thor book:build

How to contribute
-----------------

Fork this repository, be sure to read the [styleguide](http://github.com/cschneid/sinatra-book/wikis/how-to-contribute) and post pull requests.