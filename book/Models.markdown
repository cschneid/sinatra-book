Models
======

Datamapper
----------

Start out by getting the DataMapper gem if you don't already have it, and then
making sure it's in your applicaton. A call to `setup` as usual will get the
show started, and this example will include a 'Post' model.

    require 'rubygems'
    require 'sinatra'
    require 'datamapper'
    
    DataMapper::setup(:default, "sqlite://#{Dir.pwd}/blog.db")
    
    class Post
        include DataMapper::Resource
        property :id, Serial
        property :title, String
        property :body, Text
        property :created_at, DateTime
    end

To automatically create the table for the 'Post' model if you haven't already,
add a task to your rakefile to migrate your database:

    task :migrate do
        DataMapper.auto_migrate!
    end

Once that is all well and good, you can actually start developing your
application!

    get '/' do
        # get the latest 20 posts
        @posts = Post.get(:order => [ :id.desc ], :limit => 20)
        erb :index
    end

Finally, the view at `./view/index.html`:

    <% for post in @posts %>
        <h3><%= post.title %></h3>
        <p><%= post.body %></p>
    <% end %>


Sequel
------

ActiveRecord
------------
First require ActiveRecord gem in your application, then give your database
connection settings:

    require 'rubygems'
    require 'sinatra'
    require 'activerecord'

    ActiveRecord::Base.establish_connection(
      :adapter => 'sqlite3',
      :dbfile =>  'sinatra_application.sqlite3.db'
    )

Now you can create and use ActiveRecord models just like in Rails (the example
assumes you already have a 'posts' table in your database):

    class Post < ActiveRecord::Base
    end
    
    get '/' do
      @posts = Post.all()
      erb :index 
    end
    
This will render ./views/index.html:

    <% for post in @posts %>
      <h1><% post.title %></h1>
    <% end %>
