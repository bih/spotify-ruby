# bih/spotify-ruby

A modern, opinionated and *unofficial* Ruby SDK for the [Spotify Web API][spotify-web-api] to help developers all over the world build amazing music things with Spotify. [Check out the full docs here][rubyinfo-docs].

This is a work in progress. **Currently in pre-alpha.**

[![Build Status](https://travis-ci.org/bih/spotify-ruby.svg?branch=master)](https://travis-ci.org/bih/spotify-ruby)
[![Coverage Status](https://coveralls.io/repos/github/bih/spotify-ruby/badge.svg)](https://coveralls.io/github/bih/spotify-ruby)
[![Gem Version](https://badge.fury.io/rb/spotify-ruby.svg)](https://badge.fury.io/rb/spotify-ruby)
[![Code Triagers Badge](https://www.codetriage.com/bih/spotify-ruby/badges/users.svg)](https://www.codetriage.com/bih/spotify-ruby)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'spotify-ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install spotify-ruby

## Setup

Configure with your client credentials and redirect URL. Get it [for free here][spotify-developer-dashboard].

```ruby
require "spotify"

@accounts = Spotify::Accounts.new
@accounts.client_id = ENV["SPOTIFY_CLIENT_ID"]
@accounts.client_secret = ENV["SPOTIFY_CLIENT_SECRET"]
@accounts.redirect_uri = ENV["SPOTIFY_REDIRECT_URI"]
```

## Authentication

### Authorization URL

You'll need to generate an authorization URL to send your users to.

```ruby
@accounts.authorize_url
```

Once they return back to your application with a `code`:

```ruby
@session = @accounts.exchange_for_session(params[:code])
```

All you'll need to save to your database will be the `refresh_token` as follows.

You can save their information in the database under `access_token`, `expires_in` and `refresh_token`
```ruby
refresh_token = @session.refresh_token
```

And you can also start a session from a saved `refresh_token`:
```ruby
@session = Spotify::Accounts::Session.from_refresh_token(refresh_token)
@session.refresh!
```

And when their access token expires, you can just run `refresh!`:

```ruby
if @session.expired?
  @session.refresh!
end
```

## Usage

TODO: Write more detailed usage instructions here. [Spotify API endpoint coverage can be found in COVERAGE.md](COVERAGE.md)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bih/spotify-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the `spotify-ruby` project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/bih/spotify-ruby/blob/master/CODE_OF_CONDUCT.md).

[spotify]: https://spotify.com
[spotify-authorization-guide]: https://developer.spotify.com/web-api/authorization-guide/
[spotify-web-api]: https://developer.spotify.com/documentation/web-api/reference/
[spotify-developer-dashboard]: https://developer.spotify.com/my-applications/
[rubyinfo-docs]: http://www.rubydoc.info/github/bih/spotify-ruby
