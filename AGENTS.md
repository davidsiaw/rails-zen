# rails-zen

Rails 8 skeleton using Falcon, Sidekiq, and Grape.

## Getting started

Run this first in a new container:

```
bin/setuplocal
```

Installs PostgreSQL and Redis, starts them, bundles gems, creates and migrates both dev and test databases, and seeds. Optionally pass a Ruby version: `bin/setuplocal 3.4.10`. Released versions are required (dev builds with negative RUBY_PATCHLEVEL are rejected).

## Ruby version

Minimum **Ruby 3.4**, enforced by `ruby '>= 3.4'` in the Gemfile and by `bin/setuplocal`.

Ruby < 3.3.7 carries a Mutex/ConditionVariable bug ([ruby-lang #20907](https://bugs.ruby-lang.org/issues/20907)) that makes Async raise `Attempt to unlock a mutex which is not locked` when the fiber scheduler cancels a task, producing alarming but harmless errors on Falcon/Capybara teardown. Fixed in Ruby 3.2.7+, 3.3.7+ and 3.4+. Do not work around this in application or gem code -- use a supported Ruby.

After setup:

```
source tmp/localenv.sh
bin/rails server -u falcon -p 3000
```
