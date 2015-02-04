gem 'minitest'

require 'minitest/autorun'
$LOAD_PATH.push('lib')

require 'tasklist'

describe Tasklist::Task do
  it "argument is checked type" do
    task = Tasklist::Task.new({
      :title          => 'task title',
      :assignee       => 'sumipan',
      :remaining_time => 2,
      :is_done        => false,
    })

    task.must_be_instance_of Tasklist::Task

    task.title.must_equal 'task title'
    task.assignee.must_equal 'sumipan'
    task.remaining_time.must_equal 2
    task.is_done?.must_equal false

    proc {
      Tasklist::Task.new({
        :title          => 'task title',
        :assignee       => 'assignee name',
        :remaining_time => 2,
      })
    }.must_raise NameError

    proc {
      Tasklist::Task.new({
        :title          => 'task title',
        :assignee       => 'assignee name',
        :remaining_time => "2",
        :is_done        => false,
      })
    }.must_raise NameError

    tasklist = Tasklist::Tasklist.new
    task.set_tasklist(tasklist)
  end
end
