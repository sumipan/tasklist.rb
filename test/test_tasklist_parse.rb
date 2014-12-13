require 'minitest/autorun'
$LOAD_PATH.push('lib')

require 'tasklist'

describe Tasklist do
  it "parse tasklist" do
    text = File.read(File.expand_path('tasklist.txt', File.dirname(__FILE__)))

    tasklist = Tasklist.parse("no task given")
    tasklist.must_equal nil

    tasklist = Tasklist.parse(text)
    tasklist.must_be_instance_of Tasklist::Tasklist

    tasklist.tasks.each do |task|
      task.title.must_match(/テストのタスク/)
      task.assignee.must_equal "@sumipan"
    end
  end
end
