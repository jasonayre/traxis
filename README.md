# Traxis
Bridging the gap between Rails and Praxis (mainly Active Record), and sprinkling some inherited resources
inspired conventions for some 1-800-94-Jenny, controllers.

### Quick example

**Just include ::Traxis::Controller into your ::Praxis::Controller,**
(please have mercy on my soul and forgive the awful library name,
and corny sounding rhymes you may encounter and cringe at, while reading these docs) --

**define "handles" method to link your controller with your resource,
and you'll be off to the races.**

``` ruby
includes ::Traxis::Controller

handles ::Post,
        :collection => {
          :serializer => ::V1::MediaTypes::Users,
          :json_root => "users"
        },
        :resource => {
          :serializer => ::V1::MediaTypes::User,
          :json_root => "user"
        }
```

Ill prob make ^ auto config by default and overrideable, but works for now.

``` ruby
module V1
  class PostsController < ::V1::BaseController
    include ::Traxis::Controller
    implements ::V1::ApiResources::Post

    handles ::Post,
            :collection => {
              :serializer => ::V1::MediaTypes::Users,
              :json_root => "users"
            },
            :resource => {
              :serializer => ::V1::MediaTypes::User,
              :json_root => "user"
            }
  end
end
```

### Will likely change the dsl "handle" method name as I think I hate that name.

# Purpose / Rant / Why I only build apis using IR (previously, in rails)

**IT HAS NOTHING TO DO WITH WRITING LESS LINES OF CODE**

&

**EVERYTHING TO DO WITH:**
1. Convention over configuration
2. Open closed principle
3. Making controllers super composable (via lots of resource centric helpers)
4. Skinny Controllers in general
5. Encouraging SRP, via the concept of 1 resource, being controller by a single controller
(or in the case of the actual Inherited Resources library, shortcuts were used for
things like polymorphism, I probably wont try to emulate any of that. And one of the big
draws to Praxis in general is it seems like it will be cleaner to handle routes and
context of controllers in a cleaner manner, with the routing being part of the endpoint
definition and what not).

IMO, the golden rule is:

When you cant keep the controller interface the same, you probably are talking about
overlapping behavior of resources, which likely warrants a new controller. Youll be amazed how much
cleaner your code can be.

### Why bring ActiveRecord to Praxis

1. Its the best orm around for the sake of usability and discoverability.
2. Scopes and relations are incredibly composable (if used right)

Sure it may be heavy handed in some instances, but I'll take a library that
makes me happy to be programming in it over one Im fighting with any day.

### Note, I only became aware of praxis, like 3 days before building this:
And I think it was only released to public like 3 days ago. So needless to say,
Im still trying to figure it all out, and the library is brand new.
Things will likely break, and things will likely change. I have however built
a small mostly working API completely using praxis and this gem, and I can tell you
I was suprised overall at the ease of working with the library, which is why I
started breaking my code out into this gem.

## Installation

Add this line to your application's Gemfile:

    gem 'traxis'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install traxis

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/traxis/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
