Configuration
=============

Use Sinatra's "set" option
--------------------------

Configure blocks are not executed in the event context, and don't have access
to the same instance variables. To store a piece of information that you want
to access in your routes, use `set`.

    configure :development do
      set :dbname, 'devdb'
    end

    configure :production do
      set :dbname, 'productiondb'
    end

...

    get '/whatdb' do
      'We are using the database named ' + options.dbname
    end


External config file via the configure block
--------------------------------------------


Application module / config area
--------------------------------

