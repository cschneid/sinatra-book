Error Handling
==============

Overview
--------

These are run inside the Sinatra::EventContext which means you get all the
helpers is has to offer, including template rendering via `haml`, `erb`,
calling halt, and using send\_file.

not\_found
---------

Whenever NotFound is raised this will be called.  Using the `not_found` helper
in a route *does not* trigger this block.

    not_found do
      'This is nowhere to be found'
    end

error
-----
By default error will catch Sinatra::ServerError, but you can customize your
error conditions to match your specific application.  For example, this can be
useful to implement rate limiting in an API.

Sinatra will pass you the specific exception that was raised via the
‘sinatra.error’ in request.env

    error do
      'Sorry there was a nasty error - ' + request.env['sinatra.error'].name
    end
  
A quick example of a custom error class:

    # Define an error class
    class RateLimitError < Exception
    end

    # Define a handler for the error class
    error RateLimitError do
      'You are over your limit: ' + request.env['sinatra.error'].message
    end

    get '/' do
      raise RateLimitError, '100 API calls allowed per hour'
    end

You will see this as the output:

    You are over your limit: 100 API calls allowed per hour

Additional Information
----------------------
Sinatra gives you default not\_found and error handlers in the production
environment that are secure (hides application specific error information). If
you want to customize the error handlers for the production environment, but
leave the friendly Sinatra error pages in Development, then put your error
handlers in a configure block.

    configure :production do
      not_found do
        haml :'404'
      end
  
      error do
        haml :'500'
      end
    end

