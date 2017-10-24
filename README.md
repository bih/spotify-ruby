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

@auth = Spotify::Auth.new({
  client_id: ENV["SPOTIFY_CLIENT_ID"],
  client_secret: ENV["SPOTIFY_CLIENT_SECRET"],
  redirect_uri: ENV["SPOTIFY_REDIRECT_URI"]
})
```

## Authentication

With our `@auth` instance, we have access to multiple forms of authentication. Below are our ones that we make available through the Spotify Platform: Authorization Code, Implicit Grant and Client Credentials. [Learn more here][spotify-authorization-guide].

### Authorization Code

**Recommended.** Generate the URL for the user to grant permissions for your application:

```ruby
@auth.authorize_url(response_type: "code")
```

Once they return back to your application with a `code`:

```ruby
@access_token = @auth.auth_code.get_token(params[:code])
```

You can save their information in the database under `access_token`, `expires_in` and `refresh_token`
```ruby
@sdk = Spotify::SDK.new(@access_token)
@sdk.to_hash # => { access_token: "...", expires_in: 1234567890, refresh_token: "..." }
```

And you can also re-instantiate a SDK instance again later:
```ruby
@sdk = Spotify::SDK.new({
  access_token: "[insert access_token]",
  expires_in: "[insert expires_in]",
  refresh_token: "[insert refresh_token]"
})
```

And hen their access token expires, you can just run `refresh!`:

```ruby
@access_token = @access_token.refresh!
```

### Implicit Grant

```ruby
@auth.authorize_url(response_type: "token")
```

Once they return back to your application with a `token`:

```ruby
@sdk = Spotify::SDK.new(params[:token])
```

### Client Credentials

Generate an access token based from your client credentials. Note this has limited access.

```ruby
@access_token = @auth.client_credentials.get_token
```

## Usage

TODO: Write more detailed usage instructions here

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
