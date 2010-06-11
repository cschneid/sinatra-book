Filters
=======

before do...
------------
These are run in Sinatra::EventContext

    before do
      # .. this code will run before each event ..
    end

Handling of Rails like nested params (Sinatra <= 0.3.0) {#nested_params_as_filter}
------------------------------------
If you want to use a form with parameters like this (aka. Rails' nested params):

    <form>
      <input ... name="post[title]" />
      <input ... name="post[body]" />
      <input ... name="post[author]" />
    </form>

You have to convert parameters to a hash. You can easily do this with a before filter:

    before do
      new_params = {}
      params.each_pair do |full_key, value|
        this_param = new_params
        split_keys = full_key.split(/\]\[|\]|\[/)
        split_keys.each_index do |index|
          break if split_keys.length == index + 1
          this_param[split_keys[index]] ||= {}
          this_param = this_param[split_keys[index]]
       end
       this_param[split_keys.last] = value
      end
      request.params.replace new_params
    end

Then parameters become:

    {"post"=>{ "title"=>"", "body"=>"", "author"=>"" }}