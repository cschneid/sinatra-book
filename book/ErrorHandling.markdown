Error Handling
==============

not\_found
---------
Remember: These are run inside the Sinatra::EventContext which means you get all the goodies is has to offer (i.e. haml, erb, :halt, etc.)

Whenever NotFound is raised this will be called

    not_found do
      'This is nowhere to be found'
    end

error
-----
By default error will catch Sinatra::ServerError

Sinatra will pass you the error via the ‘sinatra.error’ in request.env

    error do
      'Sorry there was a nasty error - ' + request.env['sinatra.error'].name
    end
  
Custom error mapping:

    error MyCustomError do
      'So what happened was...' + request.env['sinatra.error'].message
    end

then if this happens:

    get '/' do
      raise MyCustomError, 'something bad'
    end

you gets this:

    So what happened was... something bad

Additional Information
----------------------
Because Sinatra gives you a default not\_found and error do :production that are secure. If you want to customize only for :production but want to keep the friendly helper screens for :development then do this:

    configure :production do
      not_found do
        "We're so sorry, but we don't what this is"
      end
  
      error do
        "Something really nasty happened.  We're on it!"
      end
    end