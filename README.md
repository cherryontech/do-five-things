# Do Five Things

## Description

Do Five Things is a web application built with Ruby on Rails that helps users manage their daily tasks by limiting their focus to five tasks at a time. It is a daily to-do list so small it might actually be achievable.

## Table of Contents

- [Ruby and Rails Versions](#ruby-and-rails-versions)
- [Bundler Version](#bundler-version)
- [Prerequisites](#prerequisites)
- [Development Setup](#development-setup)
- [Usage](#usage)
- [Contributing](#contributing)
- [Docs](#docs)

## Ruby and Rails Versions

- **Ruby version:** 3.1.2
- **Rails version:** 7.1.3.4
- **PostgreSQL version** 15.7

## Bundler Version

- **Bundler version:** 2.5.4

## Prerequisites

- postgresql
- ruby
- rails

## Development Setup

1. Clone the repository:

  ```bash
  git clone git@github.com:cherryontech/do-five-things.git
  ```

1. Navigate to directory:

  ```bash
  cd do-five-things
  ```

1. Install postgresql

1. Install dependencies:

  ```bash
  bundle install
  ```

  ```bash
  yarn
  ```
  
## Usage

1. Start the server:

  ```bash
  web: env RUBY_DEBUG_OPEN=true bin/rails server
  vite: bin/vite build --clear --mode=development
  ```

1. Alternatively `./bin/dev` will start `Procfile.dev` which will run all the commands together.
Running the commands separately might be useful for debugging 😅
To use the application, open your web browser and navigate to <http://localhost:3000>.

## Contributing

Please follow the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) style for commits.
For branch names, please use the conventional commits prefix, and be sure to include the name of the issue, if applicable (e.g. `chore/19-reorder-settings-sections`).
Please ensure units are present and passing for any work involves logic or goes beyond simple templating.

## Docs

- [inertia-rails_contrib gem](https://inertia-rails.netlify.app/guide/)
- [Inertia.js Rails Adapter](https://github.com/inertiajs/inertia-rails)
- [Ruby](https://www.ruby-lang.org/en/documentation/)
- [Ruby on Rails API](https://api.rubyonrails.org/)
- [Ruby On Rails guides](https://guides.rubyonrails.org/)
- [vite-ruby](https://vite-ruby.netlify.app/)
- [Vue.js](https://vuejs.org/)
