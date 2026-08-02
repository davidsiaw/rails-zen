# rails-zen

Rails 8 skeleton using Falcon, Sidekiq, and Grape.

## Getting started

Run this first in a new container:

```
bin/setuplocal
```

Installs PostgreSQL and Redis, starts them, bundles gems, creates and migrates both dev and test databases, and seeds. Optionally pass a Ruby version: `bin/setuplocal 3.4.0`.

After setup:

```
bin/rails server -u falcon -p 3000
```
