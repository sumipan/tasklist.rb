require 'contracts'
require 'tasklist/task'

module Tasklist
  class Tasklist
    include Contracts

    attr_reader :tasks

    Contract () => nil
    def initialize
      @tasks = []

      nil
    end

    Contract (Task) => nil
    def add(task)
      @tasks.push(task)
      nil
    end
  end
end
