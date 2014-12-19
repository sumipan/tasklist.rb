require 'minitest/autorun'
$LOAD_PATH.push('lib')

require 'tasklist'
require 'pp'

describe Tasklist do
  it "sort tasklist" do
    text1 = File.read(File.expand_path('tasklist_sort1.txt', File.dirname(__FILE__)))
    text2 = File.read(File.expand_path('tasklist_sort2.txt', File.dirname(__FILE__)))

    tasklist = Tasklist.parse(text1)
    tasklist = tasklist.merge(Tasklist.parse(text2))
    tasklist.tasks.size.must_equal 2
    tasklist.tasks[0].title.must_match(/2/)
    tasklist.tasks[1].title.must_match(/1/)

    tasks = tasklist.tasks.sort{|a,b| a.tasklist.attr('priority').to_i <=> b.tasklist.attr('priority').to_i }
    tasks[0].title.must_match(/1/)
    tasks[1].title.must_match(/2/)
  end
end
