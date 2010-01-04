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
    
    DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/blog.db")
    
    class Post
        include DataMapper::Resource
        property :id, Serial
        property :title, String
        property :body, Text
        property :created_at, DateTime
    end
    
    # automatically create the post table
    Post.auto_migrate! unless Post.table_exists?

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
Require the Sequel gem in your app:

    require 'rubygems'
    require 'sinatra'
    require 'sequel'

Use a simple in-memory DB:

    DB = Sequel.sqlite

Create a table:

    DB.create_table :links do
     primary_key :id
     varchar :title
     varchar :link
    end

Create the Model class:

    class Link < Sequel::Model
    end

Create the route:
   
    get '/' do
     @links = Link.all
     haml :links
    end

ActiveRecord
------------
First require ActiveRecord gem in your application, then give your database
connection settings:

    require 'rubygems'
    require 'sinatra'
    require 'activerecord'

    ActiveRecord::Base.establish_connection(
      :adapter => 'sqlite3',
      :database =>  'sinatra_application.sqlite3.db'
    )

Now you can create and use ActiveRecord models just like in Rails (the example
assumes you already have a 'posts' table in your database):

    class Post < ActiveRecord::Base
    end
    
    get '/' do
      @posts = Post.all()
      erb :index 
    end
    
This will render ./views/index.erb:

    <% for post in @posts %>
      <h1><%= post.title %></h1>
    <% end %>
