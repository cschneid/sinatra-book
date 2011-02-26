Getting to know Sinatra
=======================

## It's Witchcraft

You saw in the introduction how to install Sinatra, its dependencies, and
write a small "hello world" application. In this chapter you will get a
whirlwind tour of the framework and familiarize yourself with its features.

## Routing

Sinatra is super flexible when it comes to routing, which is essentially an
HTTP method and a regular expression to match the requested URL. The four basic
HTTP request methods will get you a long ways:

*   GET
*   POST
*   PUT
*   DELETE

Routes are the backbone of your application, they're like a guide-map to how
users will navigate the actions you define for your application.

They also enable to you create [RESTful web services][restful-web-services], in
a very obvious manner. Here's an example of how one-such service might look:

    get '/dogs' do
      # get a listing of all the dogs
    end

    get '/dog/:id' do
      # just get one dog, you might find him like this:
      @dog = Dog.find(params[:id])
      # using the params convention, you specified in your route
    end

    post '/dog' do
      # create a new dog listing
    end

    put '/dog/:id' do
      # HTTP PUT request method to update an existing dog
    end

    delete '/dog/:id' do
      # HTTP DELETE request method to remove a dog who's been sold!
    end

As you can see from this contrived example, Sinatra's routing is very easy to get
along with. Don't be fooled, though, Sinatra can do some pretty amazing things
with Routes.

Take a more indepth look at [Sinatra's routes][routes], and see for yourself. 

[routes]: http://www.sinatrarb.com/intro#Routes
[restful-web-services]: http://en.wikipedia.org/wiki/Representational_State_Transfer#RESTful_web_services

## Filters

## Handlers

## Templates

Sinatra is built upon an incredibly powerful templating engine, [Tilt][tilt].
Which, is designed to be a "thin interface" for frameworks that want to support
multiple template engines.

Some of Tilt's other all-star features include:

*   Custom template evaluation scopes / bindings
*   Ability to pass locals to template evaluation
*   Support for passing a block to template evaluation for "yield"
*   Backtraces with correct filenames and line numbers
*   Template file caching and reloading

And includes support for some of the best engines available, such as
[HAML][haml], [Less CSS][less], and [coffee-script][cs].

All you need to get started is `erb`, which is included in Ruby. Views by
default look in the `views` directory in your application root.

So in your route you would have:

    get '/' do
      erb :index
      # renders views/index.erb
     
      # OR look in a sub-directory

      erb :"dogs/index"
      # would instead render views/dogs/index.erb
    end

Another default convention of Sinatra, is the layout, which automatically looks
for a `views/layout` template file to render before loading any other views. In
the case of using `erb`, your `views/layout.erb` would look something like
this:

    <html>
      <head>..</head>
      <body>
        <%= yield %>
      </body>
    </html>

The possibilities are pretty much endless, here's a quick list of some of the most common use-cases covered in the README:

*   [Inline Templates][inline]
*   [Embedded Templates][embedded]
*   [Named Templates][named]

For more specific details on how Sinatra handles templates, check the [README][templates].

[tilt]: http://github.com/rtomayko/tilt 
[haml]: http://haml-lang.com/
[less]: http://lesscss.org/
[cs]: http://jashkenas.github.com/coffee-script/
[inline]: http://www.sinatrarb.com/intro#Inline%20Templates
[embedded]: http://www.sinatrarb.com/intro#Embedded%20Templates
[named]: http://www.sinatrarb.com/intro#Named%20Templates
[templates]: http://www.sinatrarb.com/intro#Views%20/%20Templates

## Helpers

