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

    tasklist.attr("属性名").must_equal "テスト"
    tasklist.attr("属性名2").must_equal "テスト"
    tasklist.attr("属性名3").must_equal nil

    tasklist.tasks.each do |task|
      task.title.must_match(/テストのタスク/)
    end

    text = File.read(File.expand_path('no_tasklist.txt', File.dirname(__FILE__)))
    tasklist = Tasklist.parse(text)
    tasklist.must_equal nil
  end
end
