# Rails Zen

This is a skeleton app for writing APIs.

This skeleton allows you to achieve zen with Rails.

## Features

|   | Feature           |
|---|-------------------|
| [![Gitlab pipeline status](https://gitlab.com/astrobunny/rails-zen/badges/master/pipeline.svg)](https://gitlab.com/astrobunny/rails-zen/pipelines)  | Comes with default Gitlab CI Configuration  |
| [![CircleCI build status](https://img.shields.io/circleci/project/github/davidsiaw/rails-zen/master.svg?label=circleci)](https://circleci.com/gh/davidsiaw/rails-zen/tree/master)  | Comes with default Circle CI Configuration   |
| [![Github Actions status](https://github.com/davidsiaw/rails-zen/workflows/test/badge.svg)](https://github.com/davidsiaw/rails-zen/actions)  | Comes with default Github Actions Configuration   |
| ![Dependabot](https://img.shields.io/badge/dependabot-active-brightgreen.svg)  | Constantly updates dependencies  |

- Uses Grape API
- Provides Swagger UI for viewing your API
- Has Papertrail
- IDs default to ULIDs
- Comes with Redis
- Comes with Sidekiq
- Comes with a nice docker compose that sets up a dev environment that you can use immediately
- Devise for swagger and sidekiq dashboards (and everything else you want)
- Pre-prepared browser test suite
- Scans gems and docker images for vulnerabilities on every push
- No more sprockets!

## Getting Started

Rails Zen comes with a set of useful bash scripts for happy debugging

```
bin/start              # Start the dev stack
```

```
bin/stop               # Shutdown the dev stack
```

```
bin/close              # Stop the devstack and delete everything
```

```
bin/test               # Run tests
```

```
bin/watch              # Watch the logs
```

```
bin/attach             # Attach to rails for debugging with binding.pry
```

```
bin/shell              # Shell into the rails container
```

## Important ENV Vars

These are ENV vars you can pass to your server when you start up the server that set up its behavior.

### FRONTEND_HOST

Sets up the allowed origin of the frontend, such as `'example.com'`

## Where's my API at

View your API at http://localhost:3000/swagger

```
user: admin@example.com
pass: asdasd
```

## How to edit database

Comes with PGAdmin at http://localhost:5050.

```
user: admin@example.com
pass: admin
```

## Unit container

Rails Zen also runs inside a single container where redis and postgres also run.

```
docker-compose -f docker-compose.unit.yml up -d # Start
```

## Vulnerability scanning

Circle CI scans for known vulnerabilities on every push. None of these need an account.

|   | Scans |
|---|---|
| bundler-audit | `Gemfile.lock` |
| [osv-scanner](https://github.com/google/osv-scanner) | `Gemfile.lock` |
| [grype](https://github.com/anchore/grype) | `Dockerfile` and `docker/unit/Dockerfile` images |
| [trivy](https://github.com/aquasecurity/trivy) | `Dockerfile` and `docker/unit/Dockerfile` images, plus secrets left in them |

The image scanners fail on HIGH or CRITICAL issues that have a fix available.

Scanner versions are pinned in `.circleci/config.yml` with a SHA-256 checksum. When bumping, pick a release that has been out for at least a week and update the checksum too.

If trivy flags something that does not apply, add it to `.trivyignore.yaml` with a comment saying why.

## My project is not called Rails Zen

There is a script that renames your application and database classes called `bin/rename`

Simply use that script to rename your project to whatever you like!

```
bin/rename hello_trains
```
