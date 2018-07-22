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

# Expectations

First and foremost, we'd like to set clear what is expected from you, us, and others:

- **💖 Encourage perspectives.** &mdash; It's not about the loudest person in the room. It's not always about the majority. It's about surfacing the right thing to do and doing it - so we welcome all genuine voices with open arms.
- **👋 Help guide each other.** &mdash; Everything should consider empathy for each other, their time, and their programming experience. Contributing should be a fun, learning experience!
- **❗️ Enforce our Code of Conduct.** &mdash; Expect us to make no compromises in enforcing our [Code of Conduct] fast when called upon. A healthy community means a living community.

# Getting Started

There's multiple ways you can contribute, and we'll cover all of them:

- [Website](#website)
  - [Setting up Jekyll](#setting-up-jekyll)
  - [Folder Structure](#folder-structure)
- [SDK](#sdk)
  - [Versioning](#versioning)
  - [Configuration](#configuration)
  - [Conventions](#conventions)
  - [Adding a Component](#adding-a-component)
  - [Adding a Method](#adding-a-component)
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

### Conventions

### Adding a Component

### Adding a Method

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
[yard]: https://yardoc.org
[rspec]: http://rspec.info
[rubocop]: https://github.com/rubocop-hq/rubocop
[travis ci]: https://travis-ci.org
[bih/spotify-ruby]: https://github.com/bih/spotify-ruby
[spotify]: https://developer.spotify.com
[markdown]: https://daringfireball.net/projects/markdown/syntax
[ruby]: https://ruby-lang.org
[jekyll]: https://jekyllrb.com
[github pages]: https://pages.github.com
[code of conduct]: https://github.com/bih/spotify-ruby#code-of-conduct
