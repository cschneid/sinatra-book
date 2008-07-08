Routes
======
**NOTE: Routes are looked up in order of declaration**

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

### iPhone

