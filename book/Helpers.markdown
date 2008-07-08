Helpers
=======
It is ill-advised to create helpers on (main). Use the handy helpers to install helper methods on Sinatra::EventContext for use inside events and templates.

Example:

	helpers do

	  def bar(name)
	    "#{name}bar"
	  end

	end

	get '/:name' do
	  bar(params[:name])
	end

// TODO: How do we repeat the partials thing (formatting issue, it belongs in two places)

