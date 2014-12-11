require 'minitest/autorun'
$LOAD_PATH.push('lib')

require 'tasklist'

describe Tasklist::Task do
  it "ok" do
    task = Tasklist::Task.new({
      :title          => 'task title',
      :assignee       => 'assignee name',
      :remaining_time => 2,
      :is_done        => false,
    })

    task.must_be_instance_of Tasklist::Task

    proc {
      Tasklist::Task.new({
        :title          => 'task title',
        :assignee       => 'assignee name',
        :remaining_time => 2,
      })
    }.must_raise ContractError

    proc {
      Tasklist::Task.new({
        :title          => 'task title',
        :assignee       => 'assignee name',
        :remaining_time => "2",
        :is_done        => false,
      })
    }.must_raise ContractError
    end
end
