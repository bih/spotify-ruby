---
# Page settings
layout: default
keywords:
comments: false

# Hero section
title: Contributing
description: >
  Make your first open source contribution with Spotify Ruby.

# Micro navigation
micro_nav: true

# Page navigation
page_nav:
  prev:
    content: Introduction
    url: https://github.com/bih/spotify-ruby#introduction
  next:
    content: API Reference
    url: https://www.rubydoc.info/github/bih/spotify-ruby/master

# Contributors
contributors:
  - https://github.com/bih
---

# Introduction

We're building a SDK to programmatically interact with [Spotify] using Ruby. It focuses on being as familiar and native to Ruby developers, from hobbyists to experts, and allowing them to be creative with music technology.

Even more importantly, we're focusing on building software that isn't just expected to be abandoned; but rather help to experiment and define better standards for consistently maintained community software.

[Read more about the standards we're aiming to achieve on GitHub](https://github.com/bih/spotify-ruby#introduction).

# Objectives

As mentioned in our `README.md`, we have four objectives with this SDK:

- **🧒 Thoughtfully inclusive for beginners.** Everything we do should think about beginners from the start. From having an enforced [Code of Conduct] policy to building great documentation, tooling, and an empathetic feedback process. Designing for beginners is designing for longevity.

- **☁️ Agnostic to minor changes.** APIs change all the time. We should be opinionated enough that our software should break with major changes, but flexible enough to work perfectly fine with minor changes. Our code should only depend on critical data, such as IDs.

- **🌈 Delightful for developers.** Writing the SDK and using the SDK should be equally delightful. Granted, this is a challenging goal; but with solid information architecture, well-crafted opinions, clear and helpful error messages, and software that doesn't get in your way - we will create quite lovely software.

- **✨ A maintained production-level.** It doesn't take experts to write production-level code; all it takes is considerate guidance from the community. We should write software that we and others [trust to do what it is intended to do](https://hackernoon.com/im-harvesting-credit-card-numbers-and-passwords-from-your-site-here-s-how-9a8cb347c5b5). We care about [Semantic Versioning] for clear version changes.

# Getting Started

There's multiple ways you can contribute, and we'll cover all of them:

- [Website](#website)
  - [Setting up Jekyll](#setting-up-jekyll)
  - [Folder Structure](#folder-structure)
- [SDK](#sdk)
  - [Versioning](#versioning)
  - [Configuration](#configuration)
  - [SDK Folder Structure](#sdk-folder-structure)
  - [Adding a Component](#adding-a-component)
  - [Adding a Model](#adding-a-model)
  - [Testing](#testing)
  - [Documentation](#documentation)

## Website

This refers to the website you are currently viewing. It is bundled in the `master` branch of [bih/spotify-ruby] in the `docs/` folder, even though it is not part of the source code itself. It is not compiled inside of the gem itself.

The source code is compiled using [Ruby] and [Jekyll]. It is kindly hosted for free through [GitHub Pages].

### Setting up Jekyll

You'll want to run these commands in your Terminal:

```sh
$ git clone ssh://git@github.com/bih/spotify-ruby.git
$ cd spotify-ruby/docs/
$ gem install bundler
$ bundle install
$ bundle exec jekyll serve --watch --open-url
```

The last command creates a local server and reloads whenever you make changes. Don't forget that if you edit the `_config.yml` you will need to restart the server by pressing <kbd>Ctrl</kbd> + <kbd>C</kbd> and then re-running the last command.

More information and troubleshooting can be found in Jekyll's [Installation](https://jekyllrb.com/docs/installation/) guide.

### Folder Structure

In the `docs/` folder, see all the respective content:

| Type       | Description           | Location                       |
| ---------- | --------------------- | ------------------------------ |
| [Markdown] | Website Documentation | [docs/assets]/\*\*/\*          |
| Images     | Content Assets        | [docs/assets]/\*\*/\*          |
| Images     | Layout Assets         | [docs/theme/assets]/\*\*/\*    |
| CSS        | [SASS] Stylesheets    | [docs/theme/_sass]/\*.scss     |
| HTML       | HTML Components       | [docs/theme/_includes]/\*.html |
| HTML       | HTML Layouts          | [docs/theme/_layouts]/\*.html  |

[docs/assets]: https://github.com/bih/spotify-ruby/tree/master/docs/assets
[docs/theme/assets]: https://github.com/bih/spotify-ruby/tree/master/docs/theme/assets
[docs/theme/_sass]: https://github.com/bih/spotify-ruby/tree/master/docs/theme/_sass
[docs/theme/_includes]: https://github.com/bih/spotify-ruby/tree/master/docs/theme/_includes
[docs/theme/_layouts]: https://github.com/bih/spotify-ruby/tree/master/docs/theme/_layouts

## SDK

This covers all of the code in `spotify-ruby`, excluding the `docs/` folder (which was covered in [Website](#website) above).

### Versioning

We follow the [Semantic Versioning] convention in our versioning. Here's a excerpt that will explain the convention better:

```md
Given a version number MAJOR.MINOR.PATCH, increment the:

MAJOR version when you make incompatible API changes,
MINOR version when you add functionality in a backwards-compatible manner, and
PATCH version when you make backwards-compatible bug fixes.
Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.
```

As a general rule of thumb, we always preference backwards compatibility as much as possible. It helps us achieve our [🌈 Delightful for Developers](https://github.com/bih/spotify-ruby#introduction) objective for this SDK.

### Configuration

In our project, we have the core files in the root folder `/`:

| Type            | File                   | Description                                                          |
| --------------- | ---------------------- | -------------------------------------------------------------------- |
| Local Config    | [.rspec]               | Our config for running our testing framework, [RSpec].               |
| Local Config    | [.rubocop.yml]         | Our config for our Ruby static code analyzer tool, [Rubocop].        |
| Local Config    | [.ruby-version]        | The [Ruby] version we're using to build `spotify-ruby`.              |
| Local Config    | [.rvm-version]         | Our RVM-specific [Ruby] version we're using to build `spotify-ruby`. |
| Local Config    | [Gemfile]              | Used for running `bundler install` during installation.              |
| External Config | [.travis.yml]          | Our config for our continuous integration provider, [Travis CI].     |
| External Config | [spotify-ruby.gemspec] | Used for configuring the `spotify-ruby` gem.                         |
| Tooling         | [Rakefile]             | Used for running `rake` helper commands.                             |
| Documentation   | [LICENSE]              | A distributed excerpt of our source code license.                    |
| Documentation   | [CODE_OF_CONDUCT.md]   | Our official Code of Conduct policy.                                 |
| Documentation   | [COVERAGE.md]          | Our SDK coverage status of all [Spotify] Developer APIs.             |

[.travis.yml]: https://github.com/bih/spotify-ruby/blob/master/.travis.yml
[.rspec]: https://github.com/bih/spotify-ruby/blob/master/.rspec
[.rubocop.yml]: https://github.com/bih/spotify-ruby/blob/master/.rubocop.yml
[.ruby-version]: https://github.com/bih/spotify-ruby/blob/master/.ruby-version
[.rvm-version]: https://github.com/bih/spotify-ruby/blob/master/.rvm-version
[spotify-ruby.gemspec]: https://github.com/bih/spotify-ruby/blob/master/spotify-ruby.gemspec
[gemfile]: https://github.com/bih/spotify-ruby/blob/master/Gemfile
[rakefile]: https://github.com/bih/spotify-ruby/blob/master/Rakefile
[license]: https://github.com/bih/spotify-ruby/blob/master/LICENSE
[code_of_conduct.md]: https://github.com/bih/spotify-ruby/blob/master/CODE_OF_CONDUCT.md
[coverage.md]: https://github.com/bih/spotify-ruby/blob/master/coverage.md

### SDK Folder Structure

In the `lib/spotify/` and `spec/` folders, we have a specific folder structure that we'll explain:

#### lib/spotify/

| Type   | File                  | Description                                                                             |
| ------ | --------------------- | --------------------------------------------------------------------------------------- |
| [Ruby] | [version.rb]          | Stores the `Spotify::VERSION` constant. See [Versioning](#versioning) for more details. |
| [Ruby] | [accounts.rb]         | The source file for `Spotify::Accounts` and authenticating with the SDK.                |
| [Ruby] | [accounts/session.rb] | &#x21B3; A subclass of `Spotify::Accounts` that deals with session management.          |
| [Ruby] | [sdk.rb]              | The source file for `Spotify::SDK` and interfacing with the Spotify Platform.           |
| [Ruby] | [sdk/base.rb]         | &#x21B3; The core class for creating a [SDK Component](#adding-a-component).            |
| [Ruby] | [sdk/model.rb]        | &#x21B3; The core class for creating a [SDK Model](#adding-a-model).                    |

All other files in `lib/spotify/sdk/` are either [components](#adding-a-component) or [models](#adding-a-model). It is possible to identify what type of object they are by seeing where they inherit from.

```ruby
# frozen_string_literal: true

module Spotify
  class SDK
    class Me < Base # This is a component.
    end

    class User < Model # This is a model.
    end
  end
end
```

[version.rb]: https://github.com/bih/spotify-ruby/blob/master/lib/spotify/version.rb
[accounts.rb]: https://github.com/bih/spotify-ruby/blob/master/lib/spotify/accounts.rb
[accounts/session.rb]: https://github.com/bih/spotify-ruby/blob/master/lib/spotify/accounts/session.rb
[sdk.rb]: https://github.com/bih/spotify-ruby/blob/master/lib/spotify/sdk.rb
[sdk/base.rb]: https://github.com/bih/spotify-ruby/blob/master/lib/spotify/sdk/base.rb
[sdk/model.rb]: https://github.com/bih/spotify-ruby/blob/master/lib/spotify/sdk/model.rb

#### spec/

| Type     | File                | Description                                                                                  |
| -------- | ------------------- | -------------------------------------------------------------------------------------------- |
| [Ruby]   | [spec_helper.rb]    | The core Ruby file which configures our [RSpec], [WebMock] and testing environment.          |
| Mocks    | [factories.rb]      | The source of truth for generating "mock" Ruby objects for the SDK. Powered by [FactoryBot]. |
| Fixtures | [support/fixtures/] | The folder containing sample [Spotify] API responses to be used with [WebMock].              |

All files in the `spec/` with the `*_spec.rb` filename are [RSpec] tests. They depend on [WebMock] for mocking API responses and [FactoryBot] for mocking Ruby objects.

To see a full list of all [RSpec] tests, run this in your Terminal:

```sh
$ ls -l spec/**/*_spec.rb
```

[spec_helper.rb]: https://github.com/bih/spotify-ruby/blob/master/spec/spec_helper.rb
[factories.rb]: https://github.com/bih/spotify-ruby/blob/master/spec/factories.rb
[support/fixtures/]: https://github.com/bih/spotify-ruby/blob/master/spec/support/fixtures/

### Adding a Component

In the `bin/` folder, we have provided a Rails-like generator that will generate the relevant files for you to add a new component:

#### Generate

For example, if you'd like to generate a component called `Friends` run the following command:

```sh
$ bin/generate_component friends
```

It will then generate the following files for you:

```sh
$ cat lib/spotify/sdk/friends.rb
$ cat spec/lib/spotify/sdk/friends_spec.rb
```

#### Mounting

Then you'll need to do two manual steps in `lib/spotify/sdk.rb`:

- Include the component at the top:

  ```ruby
  # Components
  require "spotify/sdk/friends"
  ```

- Then mount the component as `friends` in `Spotify::SDK::SDK_COMPONENTS`:
  ```ruby
  SDK_COMPONENTS = {
    ...,
    friends: Spotify::SDK::Friends
  }.freeze
  ```

That's it! We have setup a component. You can go ahead and write some fun logic! 🙂

#### Writing Logic

In our component, we can create a method called `hi`:

```ruby
# frozen_string_literal: true

module Spotify
  class SDK
    class Friend < Base
      ##
      # Hello world!
      #
      # @see https://bih.github.io/spotify-ruby/documentation/contributing/
      #
      # @param [Class] param_name Description
      # @return [String] text Description
      #
      def hi
        "Hello world!"
      end
    end
  end
end
```

The comments above are used by [YARD] to generate our [SDK Reference] on <https://rubydoc.info>.

#### Debugging Logic

As we've mounted our component as `friends` already, we can use the following code to test it in our console by running `bin/console`:

```
$ bin/console
[1] pry(main)> @sdk = Spotify::SDK.new(@session)
[2] pry(main)> @sdk.friends
=> #<Spotify::SDK::Friends:0x007fd7d31784e8>
[3] pry(main)> @sdk.friends.hi
=> "Hello world"
```

#### Testing Logic

In our generated `spec/lib/spotify/sdk/friends_spec.rb` file, we can write some [RSpec] tests:

```ruby
# frozen_string_literal: true

require "spec_helper"

RSpec.describe Spotify::SDK::Friends do
  let(:session) { build(:session, access_token: "access_token") }
  subject { Spotify::SDK.new(session).friends }

  describe "#hi" do
    it "returns 'Hello world'" do
      expect(subject.hi).to eq "Hello world"
    end
  end
end
```

And then you can execute tests by running `rake ci` in the root directory.

#### Sample Implementation

For an example of a good implementation, see the following files for `Spotify::SDK::Me` component:

- Implementation: [lib/spotify/sdk/me.rb]
- RSpec Tests: [spec/lib/spotify/sdk/me_spec.rb]
- Fixture: [spec/support/fixtures/get/v1/me/object.json]

[lib/spotify/sdk/me.rb]: https://github.com/bih/spotify-ruby/blob/master/lib/spotify/sdk/me.rb
[spec/lib/spotify/sdk/me_spec.rb]: https://github.com/bih/spotify-ruby/blob/master/spec/lib/spotify/sdk/me_spec.rb
[spec/support/fixtures/get/v1/me/object.json]: https://github.com/bih/spotify-ruby/blob/master/spec/support/fixtures/get/v1/me/object.json

### Adding a Model

### Testing

### Documentation

# Creating a Pull Request

We'd love to see you suggest changes and make a pull request! In order to make a pull request, you'll need to [fork the bih/spotify-ruby repository][fork]. Then make the relevant changes and create a PR to `bih/spotify-ruby:master` on GitHub.

**Protip:** First time making a pull request? Check out [this guide from GitHub](https://help.github.com/articles/creating-a-pull-request/)!

We will then review your changes, and then approve/merge it for you.

- If the change is with `docs/`, once merged [GitHub Pages] will automatically deploy your changes to [bih.github.io/spotify-ruby]. It can sometimes take up to 15 minutes to propagate.
- If the change is with the SDK, we will publish the changes in the next MAJOR/MINOR release. Urgent changes will result in an expedited PATCH release, as per the [Semantic Versioning] convention.

If we have reviewed it, we will most likely suggest changes for you. The feedback will need to be addressed by you or another community member. We may close PRs that may be inactive, unclear, or controversial.

## Add Your Profile as a Contributor

If you're contributing changes to any file in `docs/documentation/`, it is possible to mention yourself as an official contributor!

It's possible to see at the top of this page, or in the screenshot below:
![](/documentation/contributing/edit.png)

To add yourself, in the relevant `.md` file, at the top you should see:

```yaml
contributors:
  - https://github.com/bih
```

All you need to do is to create a new line with your GitHub username:

```yaml
contributors:
  - https://github.com/bih
  - https://github.com/[your github username here]
```

That's all - we'll use your public GitHub avatar and give you some 💖!

[bih.github.io/spotify-ruby]: https://bih.github.io/spotify-ruby/
[fork]: https://github.com/bih/spotify-ruby/fork
[semantic versioning]: https://semver.org
[sass]: https://sass-lang.com/
[sdk reference]: https://www.rubydoc.info/github/bih/spotify-ruby/master
[yard]: https://yardoc.org
[factorybot]: https://github.com/thoughtbot/factory_bot
[rspec]: http://rspec.info
[webmock]: https://github.com/bblimke/webmock
[rubocop]: https://github.com/rubocop-hq/rubocop
[travis ci]: https://travis-ci.org
[bih/spotify-ruby]: https://github.com/bih/spotify-ruby
[spotify]: https://developer.spotify.com
[markdown]: https://daringfireball.net/projects/markdown/syntax
[ruby]: https://ruby-lang.org
[jekyll]: https://jekyllrb.com
[github pages]: https://pages.github.com
[code of conduct]: https://github.com/bih/spotify-ruby#code-of-conduct
