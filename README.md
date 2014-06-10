# rails-embryo

Rails-embryo is a Ruby gem that helps get a new Rails application up and
running quickly. In just one step, it adds many of the the tweaks and
best practices that I typically spend time tediously adding to any new
Rails project.

The features it adds are based on my personal
preferences and development habits, and will probably be made more
configurable in the future.

### Requirements

* Ruby 1.9.3 or newer
* Rails 4.1.1 or newer

### Getting Started

Make sure the gem is installed in your current environment (this will
also install Rails 4.1.1 if it's not already present).

    gem install rails-embryo

Once rails-embryo is installed, you can run "rails-embryo new" the
same way you would normally run "rails new".

    rails-embryo new my_project

This will create a new application called "My Project" in a directory
called my_project. It's the same skeleton Rails app you would get from
"rails new", but with additional rails-embryo-specific enhancements
(described below).

The enhancements include .ruby-version and .ruby-gemset files, so if
your system is configured with a Ruby version manager that looks for
those files, you should be able to change into the project directory
and then run Bundler to configure the gems for your new application.

    cd my_project
    bundle install

Your new application will have a working test suite, and you can run
it by invoking RSpec (or Rake, but RSpec is faster).

    rspec

It's also ready to run with the Rails server, so fire up the server
and visit localhost:3000 to see your application's
Bootstrap-enhanced landing page.

    rails server

### Running the Generators Directly

You can also install the rails-embryo enhancements by adding the gem
to an existing Rails application and running the "embryo" generator:

    rails generate embryo

### Enhancements Added

All of the following enhancements are added by rails-embryo.

#### Views and Templating

[Haml](http://haml.info/) and [Bootstrap](http://getbootstrap.com/)
are installed, along with a new application layout that replaces the
default .erb layout and adds a Bootstrap menu bar to the top of the
page.

A basic "Dashboard" controller with index action is created, so unlike
Rails' familiar "welcome aboard" page, you'll have a view that
actually uses the application layout. The "Welcome" message on this
page is served from a simple `render :text` call in the controller, so
the application still won't have any views yet.

#### Testing Tools

The latest
[RSpec](http://myronmars.to/n/dev-blog/2014/05/notable-changes-in-rspec-3)
is installed, along with a working controller test for the
`Welcome#index`
action. [FactoryGirl](https://github.com/thoughtbot/factory_girl) is
configured and ready for you to add your own factories.

For acceptance testing,
[Capybara](https://github.com/jnicklas/capybara) is installed, along
with a simple end-to-end spec that uses it to test the `Welcome#index`
action. [Poltergeist](https://github.com/teampoltergeist/poltergeist)
is configured and ready for JavaScript-enabled testing; just add `js:
true` to any RSpec `scenario` blocks that require JavaScript.

#### Other Enhancements

A .ruby-version file is created that specifies Ruby 2.1.2, and a
.ruby-gemset file is created with a gemset that has the same name as
your application directory. These can be safely ignored on systems
that aren't automatically configured to switch Ruby versions and/or
gemsets based on these files.

Some files that normally have lots of documentation comments added
when they are first generated (e.g. Gemfile, routes.rb, and others)
will have all comments removed by rails-futurizer. These comments may
be helpful for new users, but they may be more of a distraction for
experienced developers, and they tend to get out of date as Rails and
other gems are updated.
