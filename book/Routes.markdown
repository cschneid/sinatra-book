Routes
======

http methods
------------
Sinatra's routes are designed to respond to the HTTP request methods.  

* GET
* POST
* PUT
* DELETE



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

how routes are looked up
------------------------

Each time you add a new route to your application, it gets compiled down into a
regular expression that will match it.  That is stored in an array along with
the handler block attached to that route.

When a new request comes in, each regex is run in turn, until one matches.  Then
the the handler (the code block) attached to that route gets executed.


