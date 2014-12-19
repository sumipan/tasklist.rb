# Tasklist

Tasklist parse Github Flavor Markdown format task list into taslist.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tasklist', :git => 'https://github.com/sumipan/tasklist.rb.git', :branch => 'master'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tasklist

## Usage

```ruby
require 'tasklist/github'

github = Github::Client.new
github.setup(options)

github.issues.get(:number => number).body.tasklists.each do |tasklist|
  tasklist.attr('attribute name')

  tasklist.tasks.each do |task|
    task.is_done?
    task.title
    task.assignee
    task.remaining_time
  end
end
```

Or

```ruby
require 'tasklist'

tasklist = Tasklist.parse(text)
tasklist.attr('attribute name')

tasklist.tasks.each do |task|
  task.is_done?
  task.title
  task.assignee
  task.remaining_time
end
```

### Filter

```ruby
tasklist.tasks.select{|t|
  !t.is_done?
}.each do|task|
  # do something
end
```

### Sort

```ruby
tasklist.tasks.sort{|a,b|
  a.tasklist.attr('priority').to_i <=> b.tasklist.attr('priority').to_i
}.each do |task|
  # do something
end
```

### Merge

```ruby
tasklist.merge(tasklist2)
```

Tasks are sorted in the order in which they are added.

## Writing rule

Only issue of comment is subject.
Comments must begin with the word "タスク".
Describe the task at Github Flavor Markdown format.

"=>" And "," can not contain attribute key and value. These will be used as a delimiter.

```
タスク attribute 1 => value, attribute 2 => value

- [ ] Task title @sumipan 1h
```


## Contributing

1. Fork it ( https://github.com/sumipan/tasklist.rb/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
