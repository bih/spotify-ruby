<img src="docs/assets/images/logo.png" width="400" />

[![Build Status](https://travis-ci.org/bih/spotify-ruby.svg?branch=master)][build status]
[![Coverage Status](https://coveralls.io/repos/github/bih/spotify-ruby/badge.svg)][coverage status]
[![Gem Version](https://badge.fury.io/rb/spotify-ruby.svg)][gem version]
[![Code Triagers Badge](https://www.codetriage.com/bih/spotify-ruby/badges/users.svg)][code triagers badge]

The developer-friendly, opinionated Ruby SDK for [Spotify]. Works on Ruby 2.4+

🎨 [Website] | 📖 [SDK Reference] | [Code of Conduct](#code-of-conduct) | [Contributor Covenant]

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
  - [Spotify Connect](#spotify-connect)
- [Contributing](#contributing)
  - [Community Guidelines](#community-guidelines)
  - [Code of Conduct](#code-of-conduct)
  - [Getting Started](#getting-started)
  - [Releasing a Change](#releasing-a-change)
  - [Changelog](#changelog)
- [License](#license)

## Introduction

Hey! I'm a Developer Advocate at [Spotify], and I wrote this Ruby SDK to explore how to build a SDK that is TADA:

- **🧒 Thoughtfully inclusive for beginners.** Everything we do should think about beginners from the beginning. Everything. That includes documentation, tooling, and the feedback we give. Designing for beginners is designing for longevity.

- **☁️ Agnostic to minor changes.** APIs change all the time. We should be opinionated enough that our software should break with major changes, but flexible enough to work perfectly fine with major changes. We only depend on critical data, such as IDs.

- **🌈 Delightful for developers.** Writing the SDK and using the SDK should be equally delightful. Granted, this is a challenging goal; but with solid information architecture, well-crafted opinions, clear and helpful error messages, and software that doesn't get in your way - we will create quite lovely software.

- **✨ A maintained production-level.** It doesn't take experts to write production-level code; all it takes is considerate guidance from the community. We should write software that we and others [trust to do what it is intended to do](https://hackernoon.com/im-harvesting-credit-card-numbers-and-passwords-from-your-site-here-s-how-9a8cb347c5b5). We care about [Semantic Versioning] for clear version changes.

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
@accounts.client_id = ENV["SPOTIFY_CLIENT_ID"]
@accounts.client_secret = ENV["SPOTIFY_CLIENT_SECRET"]
@accounts.redirect_uri = ENV["SPOTIFY_REDIRECT_URI"]
```

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

### Spotify Connect

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

<small><i>\* Requires specific user permissions/scopes. See [Authorization Scopes] for more information.</i></small>

## Contributing

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

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `lib/spotify/version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org].

### Changelog

```
[2018-07-21] (0.2.1) Released the first version of the Spotify Ruby website.
[2018-07-16] (0.2.0) Released first iteration of 0.2.0 with full documentation and test coverage.
[2018-07-08] (0.1.0) Wrote first version of Changelog.
```

## License

The gem is available as open source under the terms of the [MIT License].

<!-- prettier-ignore-start -->
[Spotify]: https://developer.spotify.com
[Spotify Connect]: https://www.spotify.com/connect/
[developer.spotify.com]: https://developer.spotify.com
[Accounts API]: https://developer.spotify.com/documentation/general/guides/authorization-guide/
[Authorization Scopes]: https://developer.spotify.com/documentation/general/guides/scopes/

[SDK Reference]: http://www.rubydoc.info/github/bih/spotify-ruby
[Code of Conduct]: https://github.com/bih/spotify-ruby/blob/master/CODE_OF_CONDUCT.md
[Contributor Covenant]: http://contributor-covenant.org

[Build Status]: https://travis-ci.org/bih/spotify-ruby
[Coverage Status]: https://coveralls.io/github/bih/spotify-ruby
[Gem Version]: https://badge.fury.io/rb/spotify-ruby
[Code Triagers Badge]: https://www.codetriage.com/bih/spotify-ruby
[MIT License]: http://opensource.org/licenses/MIT
[rubygems.org]: https://rubygems.org
<!-- prettier-ignore-end -->
