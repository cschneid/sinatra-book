Introduction
=============

What is Sinatra?
----------------
Sinatra is a Domain Specific Language (DSL) for quickly creating
web-applications in Ruby.

It keeps a minimal feature set, leaving the developer to use the
tools that best suit them and their application.

It doesn't assume much about your application, apart from that:

* it will be written in Ruby programming language
* it will have URLs

In Sinatra, you can write short _ad hoc_ applications or mature, larger
application with the same easiness.

You can use the power of various Rubygems and other libraries available for
Ruby.

Sinatra really shines when used for experiments and application mock-ups or for
creating a quick interface for your code.

It isn't a _typical_ Model-View-Controller framework, but ties specific URL
directly to relevant Ruby code and returns its output in response. It does
enable you, however, to write clean, properly organized applications:
separating _views_ from application code, for instance.

Installation
------------
The simplest way to install Sinatra is through Rubygems:

```
$ gem install sinatra
```

### Dependencies

Sinatra depends on the _Rack_ gem (<https://rubygems.org/rack>).

Sinatra supports many different template engines (it uses the Tilt library
internally to support practically every template engine in Ruby)
For optimal experience, you should install the template engines you want to
work with.  The Sinatra dev team suggests using either ERB, which is included
with Ruby, or installing HAML as your first template language.

```
$ gem install haml
```

### Living on the Edge

The _edge_ version of Sinatra lives in its Git repository, available at
**<https://github.com/sinatra/sinatra/>**.

You can use the _edge_ version to try new functionality or to contribute to the
framework. You need to have [Git version control
software](https://www.git-scm.com/) and [Bundler](https://bundler.io/).

```
$ gem install bundler
```

To use Sinatra _edge_ with Bundler, you'll have to create a `Gemfile` listing
Sinatra's and any other dependencies you're going to need.

```ruby
gem 'sinatra', :git => 'git://github.com/sinatra/sinatra.git'
```

Now we can install our dependencies:

```
$ bundle install
```

Hello World Application
-----------------------

Sinatra is installed, how about making your first application?

```ruby
# If you're using bundler, you will need to add this
require 'bundler/setup'

require 'sinatra'

get '/' do
  "Hello world, it's #{Time.now} at the server!"
end
```

Run this application by `$ ruby hello_world.rb` and load
`http://localhost:4567` in your browser.

As you can see, Sinatra doesn't force you to set up much infrastructure: a
request to a URL evaluates some Ruby code and returns some text in response.
Whatever the block returns is sent back to the browser.


Real World Applications in Sinatra
----------------------------------

### Github Services

Git hosting provider Github used Sinatra for Git post-receive hooks, calling user-specified
services/URLs, whenever someone pushed to their repository:

* <https://github.blog/2008-04-29-github-services-ipo/> explains how it was introduced
* <https://github.com/github/github-services> is a deprecated repository
* <https://docs.github.com/en/rest/webhooks> is the documentation for the current non-Sinatra solution

Check out a full list of Sinatra apps [in the wild][in-the-wild].

[in-the-wild]: https://sinatrarb.com/wild.html

About this book
---------------
This book will assume you have a basic knowledge of the Ruby scripting language
and a working Ruby interpreter.

For more information about the Ruby language visit the following links:

* [ruby-lang](https://www.ruby-lang.org)
* [ruby-lang / documentation](https://www.ruby-lang.org/en/documentation/)

Need Help?
----------

The Sinatra club is small, but super-friendly.  Join us on IRC at
irc.freenode.org in #sinatra if you have any questions.  It's a bit
slow at times, so give us a bit to get back to your questions.
