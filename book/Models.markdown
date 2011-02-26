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

    # need install dm-sqlite-adapter
    DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/blog.db")

    class Post
        include DataMapper::Resource
        property :id, Serial
        property :title, String
        property :body, Text
        property :created_at, DateTime
    end

    # automatically create the post table
    Post.auto_migrate! unless Post.storage_exists?

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

