Handlers
========

Structure
---------
Handler is the generic term that Sinatra uses for the "controllers".  A
handler is the initial point of entry for new http requests into your
application.

To find more about the routes, head to the Routes section (right above
this one)


redirect
--------
The redirect helper is a shortcut to a common http response code (302).

Basic usage is easy:

    redirect '/'
    
    redirect '/posts/1'

    redirect 'http://www.google.com'

The redirect actually sends back a Location header to the browser, and the
browser makes a followup request to the location indicated.  Since the browser
makes that followup request, you can redirect to any page, in your application,
or another site entirely.

The flow of requests during a redirect is:
Browser --> Server (redirect to '/') --> Browser (request '/') --> Server (result for '/')

Sinatra sends a 302 response code as a redirect by default. According to the
spec, 302 shouldn't change the request method, but you can see a note saying
that most clients do change it. Apparently the mobile browser that person was
using did things correctly (instead of the mainstream misinterpretation).

The fix for this in the spec is 2 different response codes: 303 
and 307. 303 resets to GET, 307 keeps the same method.

To force Sinatra to send a different response code, it's very simple:

    redirect '/', 303 # forces the 303 return code
     
    redirect '/', 307 # forces the 307 return code

sessions
--------

### Default Cookie Based Sessions

Sinatra ships with basic support for cookie based sessions.  To enable it, in a configure block, or at the top of your application, you just need to enable to option.

    enable :sessions

The downside to this session approach is that all the data is stored in the
cookie.  Since cookies have a fairly hard limit of 4 kilobytes, you can't store
much data.  The other issue is that the cookie is not tamper proof.  The user
can change any data in their session.  But... it is easy, and it doesn't have
the scaling problems that memory or database backed sessions run into.

### Memory Based Sessions

### Memcached Based Sessions

### File Based Sessions

### Database Based Sessions


cookies
-------

Cookies are a fairly simple thing to use in Sinatra, but they have a few quirks.

Lets first look at the simple use case:

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

Setting a path, expiration date, or domain gets a little more complicated - see the source code for set\_cookie if you want to dig deeper.

    set_cookie("thing", { :domain => myDomain,
                          :path => myPath,
                          :expires => Date.new } )

That's the easy stuff with cookies - It can also serialize Array objects,
separating them with ampersands (&), but when they come back, it doesn't
deserialize or split them in any way, it hands you the raw, encoded string
for your parsing pleasure.


status
------

If you want to set your own status response instead of the normal 200 (Success), you can use the `status`-helper to set the
code, and then still render normally:

    get '/' do
      status 404
      "Not found"
    end

Alternatively you can use `throw :halt, [404, "Not found"]` to immediately stop any further actions and return the
specified status code and string to the client. `throw` supports more options in this regard, see the appropriate section
for more info.


authentication
--------------

