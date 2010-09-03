Routes
======

HTTP methods
------------
Sinatra's routes are designed to respond to the HTTP request methods.  

* GET
* POST
* PUT
* DELETE

Basic
-----

Simple

    get '/hi' do
      ...
    end
    
With params

    # /name/Chris will return "You said your name was Chris" to the browser
    # /name/Blake will return "You said your name was Blake" to the browser
    get '/name/:name' do
      "You said your name was #{params[:name]}"
    end

Parameters can be accessed via a string, or symbol
    
    # These are the same
    params[:name]
    params["name"]

Options
-------

User agent
----------

    get '/foo', :agent => /Songbird (\d\.\d)[\d\/]*?/ do
      "You're using Songbird version #{params[:agent][0]}"
    end
    
    get '/foo' do
      # matches non-songbird browsers
    end

Splats
------

Sometimes you want to match more than a single parameter, and instead want to
match an entire set of URL components.  You can use the splat operator to do
this.

    get '/say/*/to/*' do
      # matches /say/hello/to/world
      params["splat"] # => ["hello", "world"]
    end
    
    get '/download/*.*' do
      # matches /download/path/to/file.xml
      params["splat"] # => ["path/to/file", "xml"]
    end

HTTP Methods
------------

The other HTTP methods are requested exactly the same as "get" routes.  You
simply use the `post`, `put`, or `delete` functions to define the route, rather
then the `get` one. 

    get '/foo' do
    end

    post '/foo' do
    end

    put '/foo' do
    end

    delete '/foo' do
    end


The PUT and DELETE methods
--------------------------

Since browsers don't natively support the PUT and DELETE methods, a hacky
workaround has been adopted by the web community. There are two steps to
using this workaround with Sinatra:

First, you must add a hidden element in your form with the name "\_method" and
the value equal to the HTTP method you want to use. The form itself is sent as
a POST, but Sinatra will interpret it as the desired method. For example:

    <form method="post" action="/destroy_it">
      <input type="hidden" name="_method" value="delete" />
      <div><button type="submit">Destroy it</button></div>
    </form>

Then, include the Rack::MethodOverride middleware into your app:

    require 'sinatra'
    
    use Rack::MethodOverride
    
    delete '/destroy_it' do
      # destroy it
    end

Or, if you are subclassing Sinatra::Base, do it like this:

    require 'sinatra/base'
    
    class MyApp < Sinatra::Base
      use Rack::MethodOverride
      
      delete '/destroy_it' do
        # destroy it
      end
    end

When you want to use PUT or DELETE from a client that does support them
(like Curl, or ActiveResource), just go ahead and use them as you normally
would, and ignore the `_method` advice above. That is only for hacking in
support for browsers.


How routes are looked up
------------------------

Each time you add a new route to your application, the URL definition is
compiled down into a regular expression.  The regex is stored in an array along
with the Ruby block attached to that route.

When a new request comes in, each regex is checked in turn, until one matches.
Then the code block attached to that route gets executed.

