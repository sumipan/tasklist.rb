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

    Contract String, Or[String,nil] => Or[String,nil]
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
