Jobs
----

This is where you put your job classes. All workers must be named `something_job.rb`.

To make a new kind of job just run the generator:

`rails generate job Something`

This will create

```
class SomethingJob < ApplicationJob
  queue_as :default

  def perform(*args)
  end
end
```

To run any job just run `SomethingJob.perform_later(params)`.

More info:

https://github.com/sidekiq/sidekiq/wiki/Active-Job
