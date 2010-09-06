Testing
=======

Using Rack::Test
----------------

Testing is an integral part of software development. In this section we will
look into testing the Sinatra application itself. For unit testing your models
or other classes, please consult the documentation of frameworks used
(including your test framework itself). Sinatra itself uses [Contest][ct] for
testing, but feel free to use any framework you like.

Bryan Helmkamp's [Rack::Test][rt] offers tools for mocking Rack request,
sending those to your application and inspecting the response all wrapped in a
small DSL.

### Firing Requests

You import the DSL by including `Rack::Test::Methods` into your test
framework. It is even usable without a framework and for other tasks besides
testing.

Imagine you have an application like this:

    # myapp.rb
    require 'sinatra'
    
    get '/' do
      "Welcome to my page!"
    end
    
    post '/' do
      "Hello #{params[:name]}!"
    end

You have to define an `app` method pointing to your application class (which is `Sinatra::Application` per default):

    require 'rack/test'
    require 'myapp'
    include Rack::Test
    
    def app
      Sinatra::Application
    end
    
    get '/'
    last_response.ok?     # => true
    last_response.status  # => 200
    last_response.body    # => "Welcome to my page!"
    last_response.headers # Hash with headers
    
    get '/foo'
    last_response.ok?     # => false
    last_response.status  # => 404
    
    post '/', :name => 'Simon'
    last_response.body.include? 'Hello Simon' # => true

### Modifying `env`

While parameters can be send via the second argument of a get/post/put/delete
call (see the post example above), the env hash (and thereby the HTTP headers)
can be modified with a third argument:

    get '/foo', {}, 'HTTP_USER_AGENT' => 'Songbird 1.0'

This also allows passing internal `env` settings:

    get '/foo', {}, 'rack.session' => { 'user_id' => 20 }

### Cookies

You can access cookies via a response:

    get '/'
    last_response.cookies['foo']

Use `set_cookie` for setting and removing cookies:

    set_cookie 'foo=bar'
    get '/'

### Usage with Test::Unit, Test::Spec or Contest

Set up rack-test by including `Rack::Test::Methods` into your test class and
defining `app`:

    ENV['RACK_ENV'] = 'test'
    require 'test/unit'
    require 'rack-test'
    require 'myapp'
    
    class HomepageTest < Test::Unit::TestCase
      include Rack::Test:Methods
      def app() Sinatra::Application end
      
      def test_homepage
        get '/'
        assert last_response.ok?
      end
    end

If you have multiple test files, you could create a test helper file and do
all the setup in there:

    # test/test_helper.rb
    ENV['RACK_ENV'] = 'test'
    require 'test/unit'
    require 'rack-test'
    require 'my-app'
    
    module TestMixin
      include Rack::Test::Methods
      Test::Unit::TestCase.send(:include, self)
      def app() Sinatra::Application end
    end

In your test files you only have to require that helper:

    # test/homepage_test.rb
    # if you only target Ruby >= 1.9, you could use require_relative
    require File.expand_path('../test_helper', __FILE__)
    
    class HomepageTest < Test::Unit::TestCase
      def test_homepage
        get '/'
        assert last_response.ok?
      end
    end

Since Contest and Test::Spec are both extensions for Test::Unit, all you have
to do is install them and add a `require 'contest'` or `require 'test/spec'`
to your test helper.

### Usage with RSpec

In your spec file or your spec helper, you can setup `Rack::Test` like this:

    # spec/spec_helper.rb
    ENV['RACK_ENV'] = 'test'
    require 'test/unit'
    require 'rack-test'
    require 'my-app'
    
    module TestMixin
      include Rack::Test::Methods
      def app() Sinatra::Application end
    end
    
    Spec::Runner.configure { |c| c.include TestMixin }

And use it in your specs:

    require File.expand_path('../spec_helper', __FILE__)
    
    describe "My Sinatra Application" do
      it "should allow accessing the home page" do
        get '/'
        last_response.should be_ok
      end
    end

### Usage with Bacon

This works similar to `Test::Unit`:

    ENV['RACK_ENV'] = 'test'
    require 'bacon'
    require 'rack-test'
    require 'my-app'

    module TestMixin
      include Rack::Test::Methods
      Bacon::Context.send(:include, self)
      def app() Sinatra::Application end
    end

### Usage with Minitest

### Usage with MSpec

### Usage with Protest

Using Capybara
--------------

### Test::Unit

### Cucumber

Using Sinatra::TestHelper
-------------------------

### Making sure you don't break Sinatra

[ct]: http://github.com/citrusbyte/contest#readme "Contest"
[rt]: http://github.com/brynary/rack-test/#readme "Rack::Test"
