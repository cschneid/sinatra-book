Handlers
========

Structure
---------

Handler is the generic term that Sinatra uses for the "controllers". A
handler is the initial point of entry for new HTTP requests into your
application.

To find more about the routes, head to the [Routes section](#routes)

Form parameters
---------------
In handlers you can access submitted form parameters directly via the params hash:

    get '/' do
      params['post']
    end

Parameters can be accessed by either a string, or symbol key:
    
    params[:name]
    params["name"]
    
### Nested form parameters

The support for Rails-like nested parameters has been built-in since Sinatra
version 0.9.0. 

    <form>
      <input ... name="post[title]" />
      <input ... name="post[body]" />
      <input ... name="post[author]" />
    </form>
    

The parameters in this case became as a hash:
    
    {"post"=>{ "title"=>"", "body"=>"", "author"=>"" }}

Therefore in handlers you can use nested parameters like a regular hash:

    params['post']['title']

Redirect
--------

The redirect helper is a shortcut to a common http response code (302).

Basic usage is easy:

    redirect '/'

    redirect '/posts/1'

    redirect 'http://www.google.com'

The redirect actually sends back a Location header to the browser, and the
browser makes a followup request to the location indicated. Since the browser
makes that followup request, you can redirect to any page, in your application,
or another site entirely.

The flow of requests during a redirect is:
Browser → Server (redirect to '/') → Browser (request '/') → Server (result for '/')

To force Sinatra to send a different response code, it's very simple:

    redirect '/', 303 # forces the 303 return code

    redirect '/', 307 # forces the 307 return code

Sessions
--------

### Default Cookie Based Sessions

Sinatra ships with basic support for cookie-based sessions. To enable it in a
configure block, or at the top of your application, you just need to enable
the option.

    enable :sessions

    get '/' do
      session["counter"] ||= 0
      session["counter"] += 1

      "You've hit this page #{session["counter"]} time(s)"
    end

The downside to this session approach is that all the data is stored in the
cookie. Since cookies have a fairly hard limit of 4 kilobytes, you can't store
much data. The other issue is that cookies are not tamper proof - the user
can change any data in their session. But... it is easy, and it doesn't have
the scaling problems that memory or database backed sessions run into.

### Memory Based Sessions

### Memcached Based Sessions

### File Based Sessions

### Database Based Sessions


Cookies
-------

Cookies are a fairly simple thing to use in Sinatra, but they have a few quirks.

Lets first look at the simple use case:

    require 'rubygems'
    require 'sinatra'

    get '/' do
        # Get the string representation
        cookie = request.cookies["thing"]

        # Set a default
        cookie ||= 0

        # Convert to an integer
        cookie = cookie.to_i

        # Do something with the value
        cookie += 1

        # Reset the cookie
        set_cookie("thing", cookie)

        # Render something
        "Thing is now: #{cookie}"
    end

Setting a path, expiration date, or domain gets a little more complicated - see
the source code for set\_cookie if you want to dig deeper.

    set_cookie("thing", :domain => myDomain,
                        :path => myPath,
                        :expires => Date.new)

That's the easy stuff with cookies - It can also serialize Array objects,
separating them with ampersands (&), but when they come back, it doesn't
deserialize or split them in any way, it hands you the raw, encoded string
for your parsing pleasure.


Status
------

If you want to set your own status response instead of the normal 200
(Success), you can use the `status` helper to set the code, and then still
render normally:

    get '/' do
      status 404
      "Not found"
    end

Because this is common, there's a `not_found` helper to do this.  In this
example, no response body will be sent, and the browser will display it's
default content.

    get '/' do
      not_found
    end

The `not_found` helper takes an optional argument of the body to send.  Use a
template to have a complicated 404 page.

    get '/' do
      not_found(haml :404) # renders views/404.haml
    end

And another way, a bit more flexible because you can easily setup other
statuses than 404 is to raise a special exception subclass.

    get '/' do
      raise NotFound
    end

Sinatra defines the `NotFound` exception.  To define your own, subclass 
exception and define a code method returning the HTTP status code you
want.  For example, to return a 401 simply in your app you can use this code:

    class Unauthorized < Exception
      def code
        401
      end
    end

    get '/' do
      raise Unauthorized
    end


