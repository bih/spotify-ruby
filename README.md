# bih/spotify-ruby

A modern, opinionated and *unofficial* Ruby SDK for the [Spotify Web API][spotify-web-api] to help developers all over the world build amazing music things with Spotify.

This is a work in progress. **Currently in pre-alpha.**

[![Build Status](https://travis-ci.org/bih/spotify-ruby.svg?branch=master)](https://travis-ci.org/bih/spotify-ruby)

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

You'll need to create a `Spotify::Auth` instance with your credentials.

```ruby
@auth = Spotify::Auth.new({
  client_id: ENV["SPOTIFY_CLIENT_ID"],
  client_secret: ENV["SPOTIFY_CLIENT_SECRET"],
  redirect_uri: ENV["SPOTIFY_REDIRECT_URI"]
})
```

## Authentication

With our `@auth` instance, we can initiate an authentication URL for `https://accounts.spotify.com`. By default, this will have all the values needed to get a user setup.

```
@auth.authorize_url # => https://accounts.spotify.com/oauth/authorize?client_id=...&redirect_uri=...
```

## Usage

Configure with your client credentials and redirect URL. Get it [for free here][spotify-developer-dashboard].

```ruby
@auth = Spotify::Auth.new({
  client_id: ENV["SPOTIFY_CLIENT_ID"],
  client_secret: ENV["SPOTIFY_CLIENT_SECRET"],
  redirect_uri: ENV["SPOTIFY_REDIRECT_URI"]
})
```

You'll need to redirect your users to Spotify for authentication. This might help:
```ruby
puts @auth.authorize_url # => https://accounts.spotify.com/oauth/authorize?client_id=...
```

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
[spotify-web-api]: https://developer.spotify.com/documentation/web-api/reference/
[spotify-developer-dashboard]: https://developer.spotify.com/my-applications/
