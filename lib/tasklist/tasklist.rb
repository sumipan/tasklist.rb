require 'contracts'
require 'tasklist/task'

module Tasklist
  class Tasklist
    include Contracts

    attr_reader :tasks, :attrs

    Contract () => nil
    def initialize
      @tasks = []
      @attrs = {}

      nil
    end

    Contract (Task) => nil
    def add(task)
      @tasks.push(task)
      nil
    end

    Contract Or[Tasklist,nil] => Tasklist
    def merge(tasklist)
      if tasklist then
        tasklist.tasks.each do |task|
          add(task)
        end
      end

      self
    end

    Contract Proc => Tasklist
    def select
      tasklist = Tasklist.new

      tasks.each do |task|
        tasklist.add(task) if yield task, self
      end

      tasklist
    end

    Contract String, Or[Object,nil] => Or[Object,nil]
    def attr(key, value=nil)
      if value then
        @attrs[key] = value
      end

      if @attrs.keys.include?(key) then
        return @attrs[key]
      else
        return nil
      end
    end
  end
end
