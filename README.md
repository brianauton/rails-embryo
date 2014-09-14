# rails-embryo
[![Gem Version](https://badge.fury.io/rb/rails-embryo.png)](http://badge.fury.io/rb/rails-embryo)
[![Build Status](https://travis-ci.org/brianauton/rails-embryo.png?branch=master)](https://travis-ci.org/brianauton/rails-embryo)
[![Code Climate](https://codeclimate.com/github/brianauton/rails-embryo.png)](https://codeclimate.com/github/brianauton/rails-embryo)

Rails-embryo is a Ruby gem that helps get a new Rails application up and
running quickly. In just one step, it adds many of the the tweaks and
best practices that I typically spend time tediously adding to any new
Rails project.

The features it adds are based on my personal
preferences and development habits, and will probably be made more
configurable in the future.

### Requirements

* Ruby 1.9.3 or newer
* Rails 4.1.6 or newer

### Getting Started

The rails-embryo gem provides an `embryo` generator that is designed to enhance a
newly-generated Rails application. This guide assumes you've created a new Rails application
using the `rails new` command, and that you've changed into the application directory.

Add "rails-embryo" to the new application's Gemfile and install it via Bundler:

    echo "gem 'rails-embryo'" >> Gemfile
    bundle install

Now you're ready to generate the rails-embryo enhancements. It's recommended to provide the
`--force` option to the generator, since some of the files from your newly-generated Rails
application will need to be overwritten.

    rails generate embryo --force

To verify that the rails-embryo enhancements have been installed, you'll need to update your
installed Gems again, and then initialize the database. You may want to look at the generated
`config/database.yml`, which assumes a local Postgres server is available, and make any
necessary changes to that file first.

    bundle install
    rake db:create

Now you can run the generated RSpec suite by invoking RSpec (or Rake, but RSpec is faster).

    rspec

You can also see your application's new Bootstrap-enhanced landing page by running a
development server and visiting `http://localhost:3000/`.

    rails server

### Other Generators

Once Rails Embryo has has been initialized in an application, more
generators are available to add features to the app.

#### Models

To generate a new model, run the `embryo:model` generator with the
same arguments you would pass to Rails' basic `model` generator.

    rails generate embryo:model user name email age:integer

A class, migration, spec and factory will all be generated for the
model. All options available for the [basic model
generator](http://railsguides.net/advanced-rails-model-generators/)
are accepted.

#### Authenticated Models

To generate a model that can be authenticated with
[Devise](https://github.com/plataformatec/devise), use
`embryo:model:authenticated`:

    rails generate embryo:model:authenticated first_name last_name

Authenticated models will automatically have an `email` field added and configured as the
authentication key. To customize this or any other Devise behavior, edit the generated
`config/initializers/devise.rb` along with the class and migration files for the new model.

### Enhancements Added

All of the following enhancements are added to new applications by
rails-embryo, and are used whenever possible by the other "embryo"
generators.

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
is configured and ready for JavaScript-enabled testing; just add a `:js`
metadata tag to any RSpec `feature` or `scenario` blocks that require
JavaScript:

```ruby
feature "Customer searches for widgets" do
  scenario "using the auto-suggest search box", :js do
    # ...
```

#### Other Enhancements

Some files that normally have lots of documentation comments added
when they are first generated (e.g. Gemfile, routes.rb, and others)
will have all comments removed by rails-futurizer. These comments may
be helpful for new users, but they may be more of a distraction for
experienced developers, and they tend to get out of date as Rails and
other gems are updated.

#### For Existing Rails Applications

You can attempt to run the `embryo` generator on an existing application that has been
modified since it was first generated, but rails-embryo makes little attempt to coexist with
those modifications, so you may get undesirable results.

#### Using With Ruby Version Managers (rvm, rbenv, etc.)

The `embryo` generator does not create configuration for any Ruby version manager you might be
using. If you're using a Ruby version manager, configure your Ruby version and gemset as
desired for your application as a part of generating the application before running the
`embryo` generator.
