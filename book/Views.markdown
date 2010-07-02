Views
=====
All file-based view files should be located in the directory views/:

    root
      | - views/

You access these views by calling various view helpers.  These are methods that
lookup the template, render it, and return a string containing the rendered
output.  These view methods do not return anything to the browser by
themselves.  The only output to the browser will be the return value of the
handler block.


Template Languages
------------------

### Erb
    get '/' do
      erb :index
    end

This will render ./views/index.erb

### Haml
    get '/' do
      haml :index
    end

This will render ./views/index.haml

### Sass
    get '/' do
      sass :styles
    end

This will render ./views/styles.sass

### Builder
    get '/' do
      builder :index
    end

This will render ./views/index.builder

    get '/' do
      builder do |xml|
        xml.node do
          xml.subnode "Inner text"
        end
      end
    end

This will render the xml inline, directly from the handler.

#### Atom Feed

#### RSS Feed
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

Subdirectories in views
-----------------------

In order to create subdirectories in views/, first you need to just create the
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
appropriate layout will be grabbed (of the same filetype), and used.

The layout itself should call `yield` at the point you want the content to be
included.

An example haml layout file could look something like this:

    %html
      %head
        %title SINATRA BOOK
      %body
        #container
          = yield

### Avoiding a layout
Sometimes you don't want the layout rendered.  In your render method just
pass :layout => false, and you're good.

    get '/' do
      haml :index, :layout => false
    end

### Specifiying a custom layout

If you want to use a layout not named "layout", you can override the name
that's used by passing :layout => :custom_layout

    get '/' do
      haml :index, :layout => :custom_layout
    end

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
    X
    = yield
    X

    @@ index
    %div.title Hello world!!!!!

Partials
--------

Partials are not built into the default installation of Sinatra.

The minimalist implementation of partials takes zero helper code.  Just call
your view method from your view code.

    <%= erb :_my_partial_file, :layout => nil %>

You can even pass local variables via this approach.

    <%= erb :_my_partial_file, :layout => nil, :locals => {:a => 1} %>

If you find that you need a more advanced partials implementation that handles
collections and other features, you will need to implement a helper that does
that work.

    helpers do
      def partial(template, options={})
        erb template, options.merge(:layout => false)
        #TODO: Implementation
      end
    end
