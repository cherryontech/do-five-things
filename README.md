# Do Five Things

## Description
Do Five Things is a web application built with Ruby on Rails that helps users manage their daily tasks by limiting their focus to five tasks at a time. It is a daily to-do list so small it might actually be achievable.

## Table of Contents
- [Ruby and Rails Versions](#ruby-and-rails-versions)
- [Bundler Version](#bundler-version)
- [Development Setup](#development-setup)
- [Usage](#usage)

## Ruby and Rails Versions
- **Ruby version:** 3.1.2
- **Rails version:** 7.1.3.4

## Bundler Version
- **Bundler version:** 2.5.4

## Development Setup
1. Clone the repository:
  ```bash
  git clone git@github.com:cherryontech/do-five-things.git
  ```
2. Navigate to directory:
  ```bash
  cd do-five-things
  ```
3. Install dependencies:
  ```bash
  bundle install
  ```
4. Start the server:
  ```bash
  web: env RUBY_DEBUG_OPEN=true bin/rails server
  vite: bin/vite dev
  ```
5. Alternatively `./bin/dev` will start `Procfile.dev` which will run all the commands together. 
Running the commands separately might be useful for debugging 😅


## Usage
To use the application, open your web browser and navigate to http://localhost:3000.

