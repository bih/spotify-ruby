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

# Contributors
contributors:
  - https://github.com/bih
---

# Introduction

We're building a SDK to programmatically interact with [Spotify] using Ruby. It focuses on being as familiar and native to Ruby developers, from hobbyists to experts, and allowing them to be creative with music technology.

Even more importantly, we're focusing on building software that isn't just expected to be abandoned; but rather help to experiment and define better standards for community software.

[Read more about the standards we're aiming to achieve on GitHub](https://github.com/bih/spotify-ruby#introduction).

# Expectations

First and foremost, we'd like to set clear what is expected from you, us, and others:

- **💖 Care and fight for opinions.** &mdash; It's not about the loudest person in the room. It's not even always about the majority. It's about doing the right thing; _all genuine voices are welcome with open arms_.
- **👋 Help guide each other.** &mdash; Everything should consider empathy for each other, their time, and their programming experience. Contributing should be a fun, learning experience - and helping each other helps!
- **❗️ Enforce our Code of Conduct.** From the maintainers side, we will make no compromises in enforcing our [Code of Conduct] and are committed to acting fast when necessary. A healthy community means our shared work lives longer.

# Getting Started

There's multiple ways you can contribute, and we'll cover all of them:

- [Website](#website)
  - [Folder Structure](#folder-structure)
- [Website Documentation](#website-documentation)
- [Source Documentation](#source-documentation)
- [SDK](#sdk)
  - [Configuration](#configuration)
  - [Conventions](#conventions)
  - [Adding a Component](#adding-a-component)
  - [Adding a Method](#adding-a-component)
  - [Testing](#testing)

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

### CSS

All of our CSS is written in [SASS] which is automatically compiled inside of [Jekyll]. All of the SASS files seem to have understandable naming conventions, so we won't cover them in detail.

To see all of the stylesheets we have:

```bash
$ ls -l docs/**/*.scss
```

### Folder Structure

We write plain HTML in our website.

| HTML Contents   | Location                       |
| --------------- | ------------------------------ |
| HTML Components | [docs/theme/_includes]/\*.html |
| HTML Layouts    | [docs/theme/_layouts]/\*.html  |

[docs/theme/_includes]: https://github.com/bih/spotify-ruby/tree/master/docs/theme/_includes
[docs/theme/_layouts]: https://github.com/bih/spotify-ruby/tree/master/docs/theme/_layouts

## Modifying Documentation

All of the documentation we write is in [Markdown] (for the website, or our [GitHub README](https://github.com/bih/spotify-ruby/blob/master/README.md)) or [YARD] for our source documentation.

All guides have links to edit them (see image below):
![](/documentation/contributing/edit.png)

**Protip:** Don't forget to add your GitHub URL as a contributor in the YAML Front Matter (the configuration at the top of `.md` files):

```yaml
contributors:
  - https://github.com/[your github username here]
---
```

[sass]: https://sass-lang.com/
[yard]: https://yardoc.org
[bih/spotify-ruby]: https://github.com/bih/spotify-ruby
[spotify]: https://developer.spotify.com
[markdown]: https://daringfireball.net/projects/markdown/syntax
[ruby]: https://ruby-lang.org
[jekyll]: https://jekyllrb.com
[github pages]: https://pages.github.com
[code of conduct]: https://github.com/bih/spotify-ruby#code-of-conduct
