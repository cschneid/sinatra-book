Views
=====
All file-based views are looked up in:

	root
	  | - views/

Template Languages
------------------

### Haml
	get '/' do
	  haml :index
	end

This will render ./views/index.haml

### Erb

### Builder

#### Atom Feed

#### RSS Feed

Layouts
-------

In File Views
-------------
This one is cool:

	get '/' do
	  haml :index
	end

	use_in_file_templates!

	__END__

	@@ layout
	X
	= yield
	X

	@@ index
	%div.title Hello world!!!!!

Try it!

Partials
--------

