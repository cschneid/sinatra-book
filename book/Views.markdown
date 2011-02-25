Views
=====

All file-based view files should be located in the directory `./views/`:

    root
      | - views/

You access these views by calling various view helpers. These are methods that
lookup the template, render it, and return a string containing the rendered
output. These view methods do not return anything to the browser by
themselves. The only output to the browser will be the return value of the
handler block.

To use a different view directory:

    set :views, File.dirname(__FILE__) + '/templates'

One important thing to remember is that you always have to reference templates
with symbols, even if they’re in a subdirectory, in this case use
`:subdir/template`. You must use a symbol because otherwise rendering methods
will render any strings passed to them directly.

Template Languages
------------------

### Erb

    ## You'll need to require erb in your app
    require 'erb'

    get '/' do
      erb :index
    end

This will render ./views/index.erb

#### RSS Feed

The builder gem/library is required to in this recipe

Assume that your site url is http://liftoff.msfc.nasa.gov/.

    get '/rss.xml' do
      builder do |xml|
        xml.instruct! :xml, :version => '1.0'
        xml.rss :version => "2.0" do
          xml.channel do
            xml.title "Liftoff News"
            xml.description "Liftoff to Space Exploration."
            xml.link "http://liftoff.msfc.nasa.gov/"

            @posts.each do |post|
              xml.item do
                xml.title post.title
                xml.link "http://liftoff.msfc.nasa.gov/posts/#{post.id}"
                xml.description post.body
                xml.pubDate Time.parse(post.created_at.to_s).rfc822()
                xml.guid "http://liftoff.msfc.nasa.gov/posts/#{post.id}"
              end
            end
          end
        end
      end
    end

This will render the rss inline, directly from the handler.

### CoffeeScript Templates

To render CoffeeScript templates you first need the `coffee-script` gem and
`therubyracer`, or access to the `coffee` binary.

Here's an example of using CoffeeScript with Sinatra's template rendering
engine Tilt:

    ## You'll need to require coffee-script in your app
    require 'coffee-script'

    get '/application.js' do
      coffee :application
    end

Renders `./views/application.coffee`.

This works great if you have access to [nodejs][nodejs] or `therubyracer` gem
on your platform of choice and hosting environment. If that's not the case, but
you'd still like to use CoffeeScript, you can precompile your scripts using the
`coffee` binary:

    coffee -c -o public/javascripts/ src/

Or you can use this example [rake][rake] task to compile them for you with the
`coffee-script` gem, which can use either `therubyracer` gem or the `coffee`
binary:

    require 'coffee-script'

    namespace :js do
      desc "compile coffee-scripts from ./src to ./public/javascripts"
      task :compile do
        source = "#{File.dirname(__FILE__)}/src/"
        javascripts = "#{File.dirname(__FILE__)}/public/javascripts/"
        
        Dir.foreach(source) do |cf|
          unless cf == '.' || cf == '..' 
            js = CoffeeScript.compile File.read("#{source}#{cf}") 
            open "#{javascripts}#{cf.gsub('.coffee', '.js')}", 'w' do |f|
              f.puts js
            end 
          end 
        end
      end
    end

Now, with this rake task you can compile your coffee-scripts to
`public/javascripts` by using the `rake js:compile` command.

**Resources**

If you get stuck or want to look into other ways of implementing CoffeeScript
in your application, these are a great place to start:

*   [coffee-script][coffee-script-url]
*   [therubyracer][therubyracer]
*   [ruby-coffee-script][ruby-coffee-script]

[therubyracer]: http://github.com/cowboyd/therubyracer
[coffee-script-repo]: http://github.com/jashkenas/coffee-script
[coffee-script-url]: http://coffeescript.org/
[rake]: http://rake.rubyforge.org/
[nodejs]: http://nodejs.org/
[ruby-coffee-script]: http://github.com/josh/ruby-coffee-script

### Inline Templates

    get '/' do
      haml '%div.title Hello World'
    end

Renders the inlined template string.


Subdirectories in views
-----------------------

In order to create subdirectories in `./views/`, first you need to just create the
directory structure.  As an example, it should look like:

    root
      | - views/
        | - users/
          | - index.haml
          | - edit.haml

Then you can call the haml view helper with a symbol pointing to the path of the view.
There's a syntax trick for this in ruby, to convert a string to a symbol.  

    :"users/index"
    
You can also use the more verbose version of the same thing:

    "users/index".to_sym


Layouts
-------

Layouts are simple in Sinatra.  Put a file in your views directory named
"layout.erb", "layout.haml", or "layout.builder".  When you render a page, the
appropriate layout will be grabbed, of the same filetype, and used.

The layout itself should call `yield` at the point you want the content to be
included.

An example haml layout file could look something like this:

    %html
      %head
        %title SINATRA BOOK
      %body
        #container
          = yield

In File Views
-------------

For your micro-apps, sometimes you don't even want a separate views file.  Ruby
has a way of embedding data at the end of a file, which Sinatra makes use of to
embed templates directly into its file.

    get '/' do
      haml :index
    end

    enable :inline_templates

    __END__

    @@ layout
    %html
    = yield

    @@ index
    %div.title Hello world!!!!!
    
NOTE: Inline templates defined in the source file that requires sinatra are
automatically loaded. Call `enable :inline_templates` explicitly if you
have inline templates in other source files.

### Named Templates

Templates may also be defined using the top-level `template` method:

    template :layout do
      "%html\n  =yield\n"
    end

    template :index do
      '%div.title Hello World!'
    end

    get '/' do
      haml :index
    end

If a template named "layout" exists, it will be used each time a template
is rendered. You can disable layouts by passing `:layout => false`.

    get '/' do
      haml :index, :layout => !request.xhr?
    end

Partials
--------

Partials are not built into the default installation of Sinatra.

The minimalist implementation of partials takes zero helper code.  Just call
your view method from your view code.

    <%= erb :_my_partial_file, :layout => false %>

You can even pass local variables via this approach.

    <%= erb :_my_partial_file, :layout => false, :locals => {:a => 1} %>

If you find that you need a more advanced partials implementation that handles
collections and other features, you will need to implement a helper that does
that work.

    helpers do
      def partial(template, options={})
        erb template, options.merge(:layout => false)
        #TODO: Implementation
      end
    end
    
