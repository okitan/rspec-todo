# Rspec::Todo [![Build Status](https://travis-ci.org/okitan/rspec-todo.png?branch=master)](https://travis-ci.org/okitan/rspec-todo)

* todo
 * pending if failed
* not_todo
 * result errors if passed

## Installation

Add this line to your application's Gemfile:

    gem 'rspec-todo'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec-todo

## Usage

```ruby
require "rspec/todo"

describe "rspec-todo" do
  include ::RSpec::Todo

  it "todo results pending if failed" do
    todo {
      # your test code which may fail and will fix later
    }
  end

  it "not_todo report error when test passed" do
    not_todo {
      # your test code which is not correct but cannot fix for some reason
      #  (e.g. released with the bug and user have already integrated system using the bug)
    }
  end
end
```

### if: and unless:

switch use to_do and not to_do with options.


```ruby
it "todo results pending if failed and if: is true" do
  todo(if: true) {
    # your code which may fail and will fix later
  }
end

it "todo ignored if if: is true" do
  todo(if: false) { # todo is ignored and expectation is evaled directly
  }
end
```

## Comparison

| methods  | no errors (passed) | raise error (failed) |
|----------|-------------|-------------|
| pending  | failure | pending |
| todo     | success | pending |
| not_todo | failure | success |

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
