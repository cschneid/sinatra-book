Handlers (controllers?)
=======================

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

The flow of requests is:
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

### alternate session stores

cookies
-------

authentication
--------------

