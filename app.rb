require File.join(File.dirname(__FILE__), "book.rb")
require 'erb'
require 'sinatra'
include Book

get('/'){ erb build }

get('/book.css') { send_file "#{ASSETS_DIR}/book.css", :type => 'text/css' }

get('/logo.png') { send_file "#{ASSETS_DIR}/images/logo.png", :type => :png }

__END__
@@layout
<html>
  <head>
    <title>Sinatra Book</title>
    <link rel="stylesheet" type="text/css" href="/book.css" />
  </head>
  <body>
    <p><img src="/logo.png" /></p>
    <%= yield %>
  </body>
</html>
