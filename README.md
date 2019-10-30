# Rails Zen

This is a skeleton app for writing APIs.

This skeleton allows you to achieve zen

## Features

|   | Feature           |
|---|-------------------|
| [![Gitlab pipeline status](https://img.shields.io/gitlab/pipeline/davidsiaw/rails-zen.svg?label=gitlab)](https://gitlab.com/davidsiaw/rails-zen/pipelines)  | Comes with default Gitlab CI Configuration  |
| [![CircleCI branch](https://img.shields.io/circleci/project/github/davidsiaw/rails-zen/master.svg?label=circleci)](https://circleci.com/gh/davidsiaw/rails-zen/tree/master)  | Comes with default Circle CI Configuration   |
|   | Uses Grape API    |
|   | Provides Swagger UI for viewing your API  |
|   | Has Papertrail  |
|   | IDs default to ULIDs  |
|   | Comes with Redis  |
|   | Comes with Sidekiq  |
|   | Comes with a nice docker compose that sets up a dev environment that you can use immediately  |
|   | Devise for swagger and sidekiq dashboards (and everything else you want)  |
|   | Pre-prepared browser test suite  |
| ![Dependabot](https://img.shields.io/badge/dependabot-active-brightgreen.svg)  | Constantly updates dependencies  |

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
