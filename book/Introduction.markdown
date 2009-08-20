Introduction
=============

What is Sinatra?
----------------
Sinatra is a Domain Specific Language (DSL) for quickly creating web-applications
in Ruby.

It keeps a minimal feature set, leaving the developer to use the
tools that best suit them and their application.

It doesn't assume much about your application, apart from that:

* it will be written in Ruby programming language
* it will have URLs

In Sinatra, you can write short _ad hoc_ applications or mature, larger application with the same easiness. 
(See section "Real World Applications" later in this book.)

You can use the power of various Rubygems and other libraries available for Ruby.

Sinatra really shines when used for experiments and application mock-ups or for creating a quick interface for your code.

It isn't a _typical_ Model-View-Controller framework, but ties specific URL directly to relevant Ruby code and returns its output in response. It does enable you, however, to write clean, properly organized applications: separating _views_ from application code, for instance.

Installation
------------
The simplest way to obtain Sinatra is through Rubygems

    $ sudo gem install sinatra

### Dependencies

Sinatra depends on the _Rack_ gem (<http://rack.rubyforge.org>).

For optimal experience, you should also install the _Haml_ (<http://haml.hamptoncatlin.com>) and 
_Builder_ gem (<http://builder.rubyforge.org>), which simplifies working with views.

    $ sudo gem install builder haml

### Living on the Edge

The _edge_ version of Sinatra lives in its Git repository, available at 
**<http://github.com/sinatra/sinatra/tree/master>**.

You can use the _edge_ version to try new functionality or to contribute to the framework. 
You need to have Git version control software installed (<http://www.git-scm.com>). 
Then follow these steps:

1. cd where/you/keep/your/projects
2. git clone git://github.com/sinatra/sinatra.git
3. cd sinatra
4. cd your\_project
5. ln -s ../sinatra

Then add this to your application:

    $:.unshift File.dirname(__FILE__) + '/sinatra/lib'
    require 'sinatra'

You can check the version you are running by adding this route

    get '/about' do
      "I'm running on Version " + Sinatra::VERSION
    end

and loading `http://localhost:4567/about` in your browser.


Hello World Application
-----------------------
Sinatra is installed and you're done eating cake, how about making your
first application?

    # hello_world.rb
    require 'rubygems'
    require 'sinatra'
    
    get '/' do
      "Hello world, it's #{Time.now} at the server!"
    end

Run this application by `$ ruby hello_world.rb` and load `http://localhost:4567` in your browser.

As you can see, Sinatra doesn't force you to setup much infrastructure: 
a request to some URL (_root_ URL in this case) evaluates some Ruby code 
and returns some text in response.


Real World Applications in Sinatra
----------------------------------

### Github Services

Git hosting provider Github uses Sinatra for post-receive hooks, calling user specified services/URLs, whenever someone pushes to their repository:

* <http://github.com/blog/53-github-services-ipo>
* <http://github.com/guides/post-receive-hooks>
* <http://github.com/pjhyett/github-services>

### Git Wiki

Git Wiki is minimal Wiki engine powered by Sinatra and Git. See also various forks with additional functionality.

* <http://github.com/sr/git-wiki>
* <http://github.com/sr/git-wiki/network>

### Integrity

Integrity is small and clean _continuous integration_ service using Sinatra, watching for failing builds of your codebase and notifying you by various channels.

* <http://www.integrityapp.com/>
* <http://github.com/foca/integrity>

### Seinfeld Calendar

Seinfeld Calendar is a fun application tracking your contributions to open-source projects, displaying your "streaks", ie. continuous commits to Github repositories.

* <http://www.calendaraboutnothing.com>
* <http://github.com/entp/seinfeld>


About this book
---------------
This book will assume you have a basic knowledge of the Ruby scripting language
and a working Ruby interpreter.

For more information about the Ruby language visit the following links:

* <http://www.ruby-lang.org>
* <http://www.ruby-lang.org/en/documentation/ruby-from-other-languages/>
* <http://www.ruby-doc.org>
* <http://www.ruby-doc.org/core-1.8.7/index.html>
* <http://www.ruby-doc.org/docs/ProgrammingRuby/>
