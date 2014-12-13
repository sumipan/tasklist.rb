require "tasklist/version"

module Tasklist
  def parse(text)
    tasklist = Tasklist.new

    parser = Parser.new
    parser.parse(text, tasklist)
  end

  module_function :parse

  # quick hack for error on Tasklist::Tasklist not defined at Tasklist::Task evaled
  class Tasklist; end

  require 'tasklist/parser'
  require 'tasklist/tasklist'
  require 'tasklist/task'
end
