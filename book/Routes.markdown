Routes
======

http methods
------------
Sinatra's routes are designed to respond to the HTTP request methods.  

* get
* post
* put
* delete



basic
-----
Simple

	get '/hi' do
	  ...
	end

With params

	get '/:name' do
	  # matches /sinatra and the like and sets params[:name]
	end

options
-------

splats
------
	get '/say/*/to/*' do
	  # matches /say/hello/to/world
	  params["splat"] # => ["hello", "world"]
	end

	get '/download/*.*' do
	  # matches /download/path/to/file.xml
	  params["splat"] # => ["path/to/file", "xml"]
	end


user agent
----------
	get '/foo', :agent => /Songbird (\d\.\d)[\d\/]*?/ do
	  "You're using Songbird version #{params[:agent][0]}"
	end

	get '/foo' do
	  # matches non-songbird browsers
	end

other methods
-------------
Other methods are requested exactly the same as "get" routes.  You simply use
the "post", "put", or "delete" functions to define the route, rather then the
"get" one.  To access POSTed parameters, use params\[:xxx\] where xxx is the name
of the form element that was posted.

    post '/foo' do
      "You just asked for foo, with post param bar equal to #{params[:bar]}"
    end


the PUT and DELETE methods
--------------------------
Since browsers don't natively support the PUT and DELETE methods, a hacky
workaround has been adopted by the web community.  Simply add a hidden element
with the name "\_method" and the value equal to the HTTP method you want to use.
The form itself is sent as a POST, but Sinatra will interpret it as the desired
method.  

When you want to use PUT or DELETE form a client that does support them (like
Curl, or ActiveResource), just go ahead and use them as you normally would, and
ignore the \_method advice above.  That is only for hacking in support for
browsers.

how routes are looked up
------------------------
Each time you add a new route to your application, it gets compiled down into a
regular expression that will match it.  That is stored in an array along with
the handler block attached to that route.

When a new request comes in, each regex is run in turn, until one matches.  Then
the the handler (the code block) attached to that route gets executed.

splitting into multiple files
-----------------------------
Because Sinatra clears out your routes and reloads your application on every 
request in development mode, you can't use require to load files containing 
your routes because these will only be loaded when the application starts 
(and reloaded even on the first request!)  Instead, use [load](http://www.ruby-doc.org/core/classes/Kernel.html#M005966 "Ruby RDoc: load"):

    # application.rb
    require 'rubygems'
    require 'sinatra'
    
    get '/' do
        "Hello world!"
    end
    
    load 'more_routes.rb'

and

    # more_routes.rb
    
    get '/foo' do
        "Bar?  How unimaginitive."
    end