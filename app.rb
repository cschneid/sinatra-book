require File.join(File.dirname(__FILE__), "book.rb")
require 'erb'
require 'sinatra'
include Book

get('/'){ erb build }

get('/download'){ build(true); send_file "#{OUTPUT_DIR}/sinatra-book.pdf", :type => 'application/pdf'; }

get('/book.css') { send_file "#{ASSETS_DIR}/book.css", :type => 'text/css' }
get('/print.css') { send_file "#{ASSETS_DIR}/print.css", :type => 'text/css' }

get('/images/download.png') { send_file "#{ASSETS_DIR}/images/download.png", :type => :png }
get('/images/book-logo.png') { send_file "#{ASSETS_DIR}/images/book-logo.png", :type => :png }
__END__
@@layout
<!DOCTYPE html>
<html>
  <head>
    <meta charset='utf-8'>
    <meta http-equiv="X-UA-Compatible" content="chrome=1">
    <title>Sinatra Book</title>
    <link rel="stylesheet" type="text/css" href="/book.css" media="screen, projection" />
    <link rel="stylesheet" type="text/css" href="/print.css" media="print" />
    <link rel="shortcut icon" href="/images/favicon.ico">
  </head>
  <body>
    <div id="download">
      <a href="/download">
        <img src="/images/download.png" alt="Download the Sinatra Book" />
      </a>
    </div>
    <div id="header">
      <p>
        <img src="/images/book-logo.png" />
      </p>
    </div>
    <%= yield %>
  </body>
</html>
