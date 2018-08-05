<!-- prettier-ignore-start -->
<img src="docs/theme/assets/images/logo.png" width="400" />

[![Build Status](https://travis-ci.org/bih/spotify-ruby.svg?branch=master)][Build Status]
[![Maintainability](https://api.codeclimate.com/v1/badges/89410e6302b5562c658a/maintainability)][Maintainability]
[![Test Coverage](https://api.codeclimate.com/v1/badges/89410e6302b5562c658a/test_coverage)][Test Coverage]
[![Gem Version](https://badge.fury.io/rb/spotify-ruby.svg)][Gem Version]
[![Code Triagers Badge](https://www.codetriage.com/bih/spotify-ruby/badges/users.svg)][Code Triagers Badge]

The developer-friendly, opinionated Ruby SDK for [Spotify]. Works on Ruby 2.4+

🎨 [Website] | 💖 [Contributing] | 📖 [SDK Reference] | 🔒 [Code of Conduct](#code-of-conduct)

## Contents

- [Introduction](#introduction)
- [Install](#install)
  - [With Bundler](#with-bundler)
  - [Manual Install](#manual-install)
- [Configuration](#configuration)
  - [Your App Credentials](#your-app-credentials)
  - [Authorization](#authorization)
  - [Creating a Session](#creating-a-session)
  - [Recreating a Session](#recreating-a-session)
- [Using the SDK](#using-the-sdk)
  - [Spotify Connect API](#spotify-connect-api)
  - [Me API](#me-api)
  - [Listening History API](#listening-history-api)
  - [Following API](#following-api)
- [Contributing](#contributing)
  - [Community Guidelines](#community-guidelines)
  - [Code of Conduct](#code-of-conduct)
  - [Getting Started](#getting-started)
  - [Releasing a Change](#releasing-a-change)
- [License](#license)

## Introduction

Hey! I'm a Developer Advocate at [Spotify], and I wrote this Ruby SDK to explore how to build a SDK that is TADA:

1. **🧒 Thoughtfully inclusive for beginners.** Everything we do should think about beginners from the start. From having an enforced [Code of Conduct] policy to building great documentation, tooling, and an empathetic feedback process. Designing for beginners is designing for longevity.

1. **☁️ Agnostic to minor changes.** APIs change all the time. We should be opinionated enough that our software should break with major changes, but flexible enough to work perfectly fine with minor changes. Our code should only depend on critical data, such as IDs.

1. **🌈 Delightful for developers.** Writing the SDK and using the SDK should be equally delightful. Granted, this is a challenging goal; but with solid information architecture, well-crafted opinions, clear and helpful error messages, and software that doesn't get in your way - we will create quite lovely software.

1. **✨ A maintained production-level.** It doesn't take experts to write production-level code; all it takes is considerate guidance from the community. We should write software that we and others [trust to do what it is intended to do](https://hackernoon.com/im-harvesting-credit-card-numbers-and-passwords-from-your-site-here-s-how-9a8cb347c5b5). We care about [Semantic Versioning] for clear version changes.

_Disclaimer: This SDK is NOT owned or supported by Spotify. It remains a personal project of mine. If you are a commercial partner of Spotify and wish to use this SDK, be aware you are using it at your own risk._

## Install

### With Bundler

Add this line to your application's `Gemfile`:

```ruby
gem "spotify-ruby"
```

And then execute in your Terminal:

```bash
$ bundle install
```

Finally you can include the SDK via `Bundler.require`:

```ruby
require "bundler"
Bundler.require
```

### Manual Install

Or, you can install manually by executing this in your Terminal:

```bash
$ gem install spotify-ruby
```

Then you can include the SDK in your Ruby project:

```ruby
require "spotify-ruby"
```

## Configuration

You'll firstly need to register your client ID on [developer.spotify.com]. You should receive a Client ID and Client Secret which we'll need to continue.

### Your App Credentials

As mentioned above, you'll need to register your client ID. We recommend you that you use a different set of client IDs for development and production. We'll need to use those credentials in order to use any of Spotify's APIs.

To define your app credentials, you'll need to create an instance of `Spotify::Accounts`:

```ruby
@accounts = Spotify::Accounts.new
@accounts.client_id = "spotify client ID"
@accounts.client_secret = "spotify client secret"
@accounts.redirect_uri = "redirect URI"
```

Alternatively, these credentials can be supplied as environment variables when running your application:

```ruby
@accounts = Spotify::Accounts.new # fetches configuration from ENV
```

The respective environment variables you'll need to set are:

| Environment Variable     | Description                               | Required?     |
| ------------------------ | ----------------------------------------- | ------------- |
| `SPOTIFY_CLIENT_ID`      | Your Spotify Client ID                    | **Yes**       |
| `SPOTIFY_CLIENT_SECRET`  | Your Spotify Client Secret                | **Yes**       |
| `SPOTIFY_REDIRECT_URI`   | Your Spotify Redirect URI (must be exact) | **Yes**       |

### Authorization

In order to use Spotify's APIs on a user's behalf, you'll need to use the Spotify [Accounts API] to redirect them to `https://accounts.spotify.com`. They will then need to explicitly approve your application and what data you're asking for (technically referred to as authorization scopes).

**Recommended for production:** To request specific data, read our [Authorization Scopes] reference, and then execute:

```ruby
@accounts.authorize_url({
  scope: "user-read-private user-read-email user-top-read"
}) # => "https://accounts.spotify.com/oauth/authorize?..."
```

**Recommended for exploration / local development:** Or, to request all data, you can execute:

```ruby
@accounts.authorize_url # => "https://accounts.spotify.com/oauth/authorize?..."
```

### Creating a Session

Each session lasts 60 minutes. New sessions can be generated when you have a valid `refresh_token` (they become invalid [if a user revokes your application](https://support.spotify.com/uk/account_payment_help/privacy/revoke-access-from-3rd-party-app/)).

After a user has authorized your application, they'll be sent to your `redirect_uri` defined in [Your App Credentials](#your-app-credentials) with a `code` parameter. We can use this to create a `Spotify::Session`:

```ruby
@session = @accounts.exchange_for_session(params[:code])
```

We can check when the session expires, and when we should refresh:

```ruby
@session.expires_at # => 2018-07-08 22:40:15 +0200

if @session.expired?
  @session.refresh!
end
```

You'll then be able to use `@session` in the `Spotify::SDK` object. See the [Using the SDK](#using-the-sdk) section below.

### Recreating a Session

We don't want to send the user to `https://accounts.spotify.com/...` every time they want to use your application. For this case, we'll need to export the `refresh_token` and persist it somewhere:

```ruby
@session.refresh_token # => "BQASNDMelPsTdJMNMZfWdbxsuuM1FiBxvVzasqWkwYtgpjXJO60Gm51R0LO_-3Q5MfzCU0xIrbIFs7ZlMQrVJeRwN1_Ffa3sIJn_KW6LO8vA44fYc85oz48TuBuZsT2gzr4L"
```

Then you can repeatedly create a session with just a refresh token and running `refresh!`:

```ruby
@session = Spotify::Session.from_refresh_token(@accounts, "refresh_token here")
@session.expired? # => true
@session.refresh!
@session.expired? # => false
```

## Using the SDK

To create an instance of the Spotify SDK, you'll need the `@session` from above and pass it to `Spotify::SDK` as follows:

```ruby
@session = Spotify::Session.from_refresh_token(@accounts, "refresh_token here")
@session.refresh!

@sdk = Spotify::SDK.new(@session)
```

### Spotify Connect API

With [Spotify Connect], you can take your music experience anywhere on over 300 devices. And you can read and control most devices programmatically through the SDK:

#### Read your devices\*

```ruby
@sdk.connect.devices # => [#<Spotify::SDK::Connect::Device:...>, ...]

@sdk.connect.devices[0].active?
@sdk.connect.devices[0].private_session?
@sdk.connect.devices[0].volume
@sdk.connect.devices[0].restricted?
```

#### Read current playback\*

```ruby
@sdk.connect.playback
@sdk.connect.playback.playing? # => true
@sdk.connect.playback.device.private_session? # => false
@sdk.connect.playback.shuffling? # => false
@sdk.connect.playback.repeat_mode # => :context
@sdk.connect.playback.position_percentage # => 4.53
@sdk.connect.playback.artist.name # => "Ed Sheeran"
@sdk.connect.playback.item.album.name # => "÷"
```

#### Control playback\*

```ruby
@sdk.connect.devices[0].play!({
  uri: "spotify:track:0tgVpDi06FyKpA1z0VMD4v"
})

@sdk.connect.devices[0].pause!
@sdk.connect.devices[0].resume!
@sdk.connect.devices[0].volume = 80
@sdk.connect.devices[0].previous!
@sdk.connect.devices[0].next!
@sdk.connect.devices[0].position_ms = 3_000
@sdk.connect.devices[0].shuffle = false
@sdk.connect.devices[0].repeat_mode = :context
```

#### Transfer playback\*

This will transfer state, and start playback.

```ruby
@sdk.connect.devices[0].transfer_playback!
```

#### Transfer state\*

This will transfer state, and pause playback.

```ruby
@sdk.connect.devices[0].transfer_state!
```

### Me API

This allows you to perform specific actions on behalf of a user.

#### My information\*

```ruby
@sdk.me.info
@sdk.me.info.free? # => false
@sdk.me.info.premium? # => true
@sdk.me.info.birthdate # => 1980-01-01
@sdk.me.info.display_name? # => true
@sdk.me.info.display_name # => "ABC Smith"
@sdk.me.info.images[0].url # => "https://profile-images.scdn.co/userprofile/default/..."
@sdk.me.info.followers # => 4913313
@sdk.me.info.spotify_uri # => "spotify:user:abcsmith"
@sdk.me.info.spotify_url # => "https://open.spotify.com/user/abcsmith"
```

### Listening History API

#### My recently played tracks (up to last 50)\*

```ruby
@sdk.me.history(10) # => [#<Spotify::SDK::Item...>, ...]
@sdk.me.history(10).size # => 10
@sdk.me.history(50) # => [#<Spotify::SDK::Item...>, ...]
@sdk.me.history(50).size # => 50
```

### Following API

#### Follow an artist\*

```ruby
@sdk.playback.item.artist.follow!
```

#### Unfollow an artist\*

```ruby
@sdk.playback.item.artist.unfollow!
```

#### Check if following Spotify artists?\*

```ruby
@sdk.me.following_artists?(%w(3TVXtAsR1Inumwj472S9r4 6LuN9FCkKOj5PcnpouEgny 69GGBxA162lTqCwzJG5jLp))
# => {
#   "3TVXtAsR1Inumwj472S9r4" => false,
#   "6LuN9FCkKOj5PcnpouEgny" => true,
#   "69GGBxA162lTqCwzJG5jLp" => false
# }
```

#### Check if following Spotify users?\*

```ruby
@sdk.me.following_users?(%w(3TVXtAsR1Inumwj472S9r4 6LuN9FCkKOj5PcnpouEgny 69GGBxA162lTqCwzJG5jLp))
# => {
#   "3TVXtAsR1Inumwj472S9r4" => false,
#   "6LuN9FCkKOj5PcnpouEgny" => true,
#   "69GGBxA162lTqCwzJG5jLp" => false
# }
```

#### See all followed artists\*

```ruby
@sdk.me.following(5) # => [#<Spotify::SDK::Artist...>, ...]
@sdk.me.following(5).size # => 5
@sdk.me.following(50) # => [#<Spotify::SDK::Artist...>, ...]
@sdk.me.following(50).size # => 50
```


<small><i>\* Requires specific user permissions/scopes. See [Authorization Scopes] for more information.</i></small>

## Contributing

On the website, we have [a full guide on contributing][contributing] for beginners.

### Community Guidelines

Bug reports and pull requests are welcome on GitHub at https://github.com/bih/spotify-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant] code of conduct.

### Code of Conduct

Everyone interacting with this project's codebases, issue trackers, discussions, chat rooms, and mailing lists is required to follow the [Code of Conduct].

Whilst we try to always assume good intentions, any clear violations or bad actors will be warned and subsequently banned from this project indefinitely.

### Getting Started

Firstly, you'll need Git and Ruby installed. You can then install the dependencies as following:

```bash
$ git clone ssh://git@github.com/bih/spotify-ruby.git
$ bin/setup
```

You can run `rake ci` to validate your Ruby syntax, our RSpec tests, and code coverage.

For local development, you can run `bin/console` for an interactive prompt for experimentation.

### Releasing a Change

- To install this gem onto your local machine, run `bundle exec rake install`.
- Ensure versions are in line with the [Semantic Versioning] convention.
- To release a new version:
  - Update the version number in `lib/spotify/version.rb`
  - Run `bundle exec rake release` (which will create a git tag for the version)
  - Push git commits and tags
  - Push the `.gem` file to [rubygems.org].

## License

The gem is available as open source under the terms of the [MIT License].

[Spotify]: https://developer.spotify.com
[Spotify Connect]: https://www.spotify.com/connect/
[developer.spotify.com]: https://developer.spotify.com
[Accounts API]: https://developer.spotify.com/documentation/general/guides/authorization-guide/
[Authorization Scopes]: https://developer.spotify.com/documentation/general/guides/scopes/

[Website]: https://bih.github.io/spotify-ruby
[Contributing]: https://bih.github.io/spotify-ruby/documentation/contributing/
[SDK Reference]: http://www.rubydoc.info/github/bih/spotify-ruby
[Code of Conduct]: https://github.com/bih/spotify-ruby/blob/master/CODE_OF_CONDUCT.md
[Contributor Covenant]: http://contributor-covenant.org
[Semantic Versioning]: https://semver.org/spec/v2.0.0.html

[Build Status]: https://travis-ci.org/bih/spotify-ruby
[Maintainability]: https://codeclimate.com/github/bih/spotify-ruby/maintainability
[Test Coverage]: https://codeclimate.com/github/bih/spotify-ruby/test_coverage
[Gem Version]: https://badge.fury.io/rb/spotify-ruby
[Code Triagers Badge]: https://www.codetriage.com/bih/spotify-ruby
[MIT License]: http://opensource.org/licenses/MIT
[rubygems.org]: https://rubygems.org
<!-- prettier-ignore-end -->
