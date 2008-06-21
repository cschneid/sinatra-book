Table of Contents
=================

1. Routes
    - basic
    - options
    - splats
    - user agent
        - iPhone
2. Handlers (controllers?)
    - redirect 
    - sessions
        - alternate session stores
    - cookies
    - authentication
3. Filters
    - before do...
4. Views
    - Template Languages
        - Haml
        - Erb
        - Builder
            - Atom Feed
            - RSS Feed
    - Layouts
    - In File Views
    - Partials
5. Models
    - TODO: Does sinatra have any opinion at all on models?
    - Datamapper
    - Sequel
    - AR
6. Helpers
    - TODO: How do we repeat the partials thing
7. Rack Middleware
    - "use"
    - TODO: What useful rack middleware is out there?  Is there any 3rd party stuff available?
8. Error Handling
    - not found //FIXME needs underscore
    - error
9. Configuration
    - Use Sinatra's "set" option
    - \@\@config file in a config block
    - Application module / config area
10. Deployment
    - FastCGI
    - Passenger/mod rails //FIXME needs underscore
    - Lighttpd -> Thin
    - Nginx -> Thin
    - TODO: Was Blake serious with the erlang yaws based deployment? (fuzed)
    - TODO: What other deployment strategies are there?
11. Contributing
    - How to clone the Sinatra repo?
    - How to create a patch?
    - How to get that patch into the official Sinatra?
