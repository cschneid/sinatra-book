Introduction
=============

What is Sinatra?
--------------------------
Sinatra is a Domain Specific Language (DSL) for quickly creating web-applications
in ruby.  It keeps a minimal feature set, leaving the developer to use the
tools that best suit them and their application.

Installation
---------------------------------
The simplest way to obtain Sinatra is through rubygems

    $ sudo gem install sinatra

Sample App
-----------
Sinatra is installed and you're done eating cake, how about making your
first application?

    # myapp.rb
    require 'rubygems'
    require 'sinatra'
    
    get '/' do
      'Hello world!'
    end

Run this by doing `$ ruby myapp.rb` and view it at http://localhost:4567

Living on the Edge
--------------------------------
Looking to live life (or Sinatra I should say) on the edge, huh?  Well, it's rather simple.
The latest greatest Sinatra is on Github; so using the power of git and the power of
our minds--we can do the following

1. cd where/you/keep/your/projects
2. git clone git://github.com/bmizerany/sinatra.git
3. cd sinatra
4. git submodule init && git submodule update
5. cd your\_project
6. ln -s ../sinatra

To use this unholy power, simply add this line to your sinatra.rb file

    $:.unshift File.dirname(__FILE__) + '/sinatra/lib'
    require 'sinatra'

That is certainly life on the edge.

About this book
---------------
This book will assume you have a basic knowledge of the Ruby scripting language
and a working ruby interpreter.

For more information about the Ruby language visit the following links:

- http://www.ruby-lang.org
