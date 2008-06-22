Deployment
==========

Lighttpd Proxied to Thin        {#deployment_lighttpd}
------------------------

I've previously written about deploying Sinatra to Dreamhost, both with FastCGI, 
and also Passenger (mod\_rails). This howto will cover how to deploy Sinatra to 
a load balanced reverse proxy setup using Lighttpd and Thin.

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

*Variation* - nginx - I haven't looked into the config file syntax, but there 
isn't any reason that this exact same approach wouldn't work with nginx. Thin 
and the rackup file stay the same, while the nginx layer has to be configured 
to reverse proxy to the thin install.

*Variation* - More Thin instances - To add more thin instances, change the 
-s 2 parameter on the thin start command to be how ever many servers you want. 
Then be sure lighttpd proxies to all of them by adding more lines to the proxy 
statements. Then restart lighttpd and everything should come up as expected.


Passenger (mod rails)           {#deployment_passenger}
------------------------
// TODO: Copy and format blog post


FastCGI                         {#deployment_fastcgi}
-------
// TODO: Copy and format blog post

