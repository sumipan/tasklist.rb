gem 'minitest'

require 'minitest/autorun'
$LOAD_PATH.push('lib')

require 'tasklist'

describe Tasklist do
  it "should defined" do
    Tasklist.class.must_equal Module

    Tasklist::Tasklist.class.must_equal Class
    Tasklist::Task.class.must_equal Class

    Tasklist.respond_to?('parse').must_equal true
  end

  it "should parse github flaver markdown task list format" do
    skip
    tasklist = Tasklist.parse(text)
    tasklist.must_be_instance_of Tasklist::Tasklist
  end
end

describe Tasklist::Tasklist do
  before do
    @task = Tasklist::Task.new({
      :title          => 'task title',
      :assignee       => 'assignee name',
      :remaining_time => 2,
      :is_done        => false,
    })
  end

  it "ok" do
    tasklist = Tasklist::Tasklist.new
    tasklist.must_be_instance_of Tasklist::Tasklist
  end

  it "checked arguments" do
    proc {
      tasklist = Tasklist::Tasklist.new("invalid argument")
    }.must_raise NameError
  end

  it "additional tasks are pushed to the array" do
    tasklist = Tasklist::Tasklist.new
    tasklist.add(@task)

    tasklist.tasks.size.must_equal 1
  end
end
