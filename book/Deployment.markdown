Deployment
==========

Lighttpd Proxied to Thin        {#deployment_lighttpd}
------------------------

This will cover how to deploy Sinatra to a load balanced reverse
proxy setup using Lighttpd and Thin.

1. Install Lighttpd and Thin

        # Figure out lighttpd yourself, it should be handled by your 
        # linux distro's package manager
         
        # For thin:
        gem install thin

2. Create your rackup file - the "require 'app'" line should require the actual 
   Sinatra app you have written.

        require 'sinatra'
         
        Sinatra::Application.default\_options.merge!(
          :run => false,
          :env => :production
        )
        
        require 'app'
        run Sinatra.application

3. Setup a config.yml - change the /path/to/my/app path to reflect reality.

        ---
            environment: production
            chdir: /path/to/my/app
            address: 127.0.0.1
            user: root
            group: root
            port: 4567
            pid: /path/to/my/app/thin.pid
            rackup: /path/to/my/app/config.ru
            log: /path/to/my/app/thin.log
            max_conns: 1024
            timeout: 30
            max_persistent_conns: 512
            daemonize: true

4. Setup lighttpd.conf - change mydomain to reflect reality. Also make 
   sure the first port here matches up with the port setting in config.yml.

         $HTTP["host"] =~ "(www\.)?mydomain\.com"  {
                 proxy.balance = "fair"
                 proxy.server =  ("/" =>
                                         (
                                                 ( "host" => "127.0.0.1", "port" => 4567 ),
                                                 ( "host" => "127.0.0.1", "port" => 4568 )
                                         )
                                 )
         }

5. Start thin and your application. I have a rake script so I can just 
   call "rake start" rather than typing this in. 

         thin -s 2 -C config.yml -R config.ru start

You're done! Go to mydomain.com/ and see the result! Everything should be setup
now, check it out at the domain you setup in your lighttpd.conf file.

*Variation* - nginx via proxy - The same approach to proxying can be applied to
the nginx web server

	upstream www_mydomain_com {
		server 127.0.0.1:5000;
		server 127.0.0.1:5001;
	}

	server {
		listen		www.mydomain.com:80
		server_name	www.mydomain.com live;
		access_log /path/to/logfile.log
		
		location / {
			proxy_pass http://www_mydomain_com;
		}
		
	}

*Variation* - More Thin instances - To add more thin instances, change the 
`-s 2` parameter on the thin start command to be how ever many servers you want. 
Then be sure lighttpd proxies to all of them by adding more lines to the proxy 
statements. Then restart lighttpd and everything should come up as expected.


Passenger (mod rails)           {#deployment_passenger}
------------------------
Hate deployment via FastCGI? You're not alone.  But guess what, Passenger supports Rack;
and this book tells you how to get it all going.

You can find additional documentation at the Passenger Github repository.


1. Setting up the account in the Dreamhost interface

        Domains -> Manage Domains -> Edit (web hosting column)
        Enable 'Ruby on Rails Passenger (mod_rails)'
        Add the public directory to the web directory box. So if you were using 'rails.com', it would change to 'rails.com/public'
        Save your changes

2. Creating the directory structure

        domain.com/
        domain.com/tmp
        domain.com/public
        # a vendored version of sinatra - not necessary if you use the gem
        domain.com/sinatra

3. Creating a rackup file

        # This file goes in domain.com/config.ru
        require 'sinatra/lib/sinatra.rb'
        require 'rubygems'
         
        Sinatra::Application.default_options.merge!(
          :run => false,
          :env => :production
        )
         
        require 'test.rb'
        run Sinatra.application


4. A very simple Sinatra application

        # this is test.rb referred to above
        get '/' do
                "Worked on dreamhost"
        end
         
        get '/foo/:bar' do
                "You asked for foo/#{params[:bar]}"
        end
And that's all there is to it! Once it's all setup, point your browser at your 
domain, and you should see a 'Worked on Dreamhost' page. To restart the 
application after making changes, you need to run `touch tmp/restart.txt`.



FastCGI                         {#deployment_fastcgi}
-------

The standard method for deployment is to use Thin or Mongrel, and have a 
reverse proxy (lighttpd, nginx, or even Apache) point to your
bundle of servers.

But that isn't always possible.  Cheaper shared hosting (like Dreamhost) won't
let you run Thin or Mongrel, or setup reverse proxies (at least on the default
shared plan).

Luckily, Rack supports various connectors, including CGI and FastCGI.  Unluckily
for us, FastCGI doesn't quite work with the current Sinatra release.

To get a simple 'hello world' Sinatra application up and running on Dreamhost
involves pulling down the current Sinatra code, and hacking at it a bit.  Don't
worry though, it only requires commenting out a few lines, and tweaking
another.

Steps to deploy via FastCGI:

* .htaccess
* dispatch.fcgi
* Tweaked sinatra.rb


1. .htaccess
        RewriteEngine on
         
        AddHandler fastcgi-script .fcgi
        Options +FollowSymLinks +ExecCGI
         
        RewriteRule ^(.*)$ dispatch.fcgi [QSA,L]

2. dispatch.fcgi
        #!/usr/bin/ruby
         
        require 'sinatra/lib/sinatra.rb'
        require 'rubygems'
         
        fastcgi_log = File.open("fastcgi.log", "a")
        STDOUT.reopen fastcgi_log
        STDERR.reopen fastcgi_log
        STDOUT.sync = true
         
        set :logging, false
        set :server, "FastCGI"
         
        module Rack
          class Request
            def path_info
              @env["SCRIPT_URL"].to_s
            end
            def path_info=(s)
              @env["SCRIPT_URL"] = s.to_s
            end
          end
        end
         
        load 'test.rb'

3. sinatra.rb - Replace this function with the new version here (commenting out the `puts` lines)

        def run
          begin
            #puts "== Sinatra has taken the stage on port #{port} for #{env} with backup by #{server.name}"
            require 'pp'
            server.run(application) do |server|
              trap(:INT) do
                server.stop
                #puts "\n== Sinatra has ended his set (crowd applauds)"
              end
            end
          rescue Errno::EADDRINUSE => e
            #puts "== Someone is already performing on port #{port}!"
          end
        end

Fuzed and Amazon 
----------------
// TODO: Talk with Blake about this.

Poolparty and Amazon EC2
------------------------


// TODO: What other deployment strategies are there?

