Development Techniques
======================

Automatic Code Reloading
------------------------

Restarting an application manually after every code change is both slow and
painful. It can easily be avoided by using a tool for automatic code reloading.

### Shotgun

Shotgun will actually restart your application on every request. This has the
advantage over other reloading techniques of always producing correct results.
However, since it actually restarts your application, it is rather slow
compared to the alternatives. Moreover, since it relies on `fork`, it is not
available on Windows and JRuby.

Usage is rather simple:

    gem install shotgun # run only once, to install shotgun
    shotgun my_app.rb

If you want to run a modular application, create a file named `config.ru` with
similar content:

    require 'my_app'
    run MyApp

And run it by calling `shotgun` without arguments.

The `shotgun` executable takes arguments similar to those of the `rackup`
command, run `shotgun --help` for more information.

### Sinatra::Reloader

The `sinatra-reloader` gem offers a faster alternative, that also works on
Windows and JRuby. It only reloads files that actually have been changed and
automatically detects orphaned routes that have to be removed. Most other
implementations delete all routes and reload all code if one file changed,
which takes way more time than reloading only one file, especially in larger
projects.

Install it by running

    gem install sinatra-reloader

If you use the top level DSL, you just have to require it in development mode:

    require "sinatra"
    require "sinatra/reloader" if development?
    
    get('/') { 'change me!' }

When using a modular style application, you have to register the
`Sinatra::Reloader` extension:

    require "sinatra/base"
    require "sinatra/reloader"
    
    class MyApp < Sinatra::Base
      configure :development do
        register Sinatra::Reloader
      end
    end

For safety and performance reason, Sinatra::Reloader will per default only reload files defining routes. You can, however, add files to the list of reloadable files by using `also_reload`:

    require "sinatra"

    configure :development do |config|
      require "sinatra/reloader"
      config.also_reload "models/*.rb"
    end

### Other Tools and Resources

* [Magical Reloading Sparkles](http://namelessjon.posterous.com/magical-reloading-sparkles) -
  similar to Shotgun, but relies on Unicorn and only restarts on file changes.
* [Reloading Ruby Code](http://rkh.im/2010/08/code-reloading) - a blog post
  explaining how different code reloading techniques work and which one to
  use.
