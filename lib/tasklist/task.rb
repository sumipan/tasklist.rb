require 'contracts'
require 'tasklist/tasklist'

module Tasklist
  class Task
    include Contracts

    attr_reader :title,  :assignee, :remaining_time, :is_done, :tasklist

    Contract ({ :title => String, :assignee => Or[String,nil], :remaining_time => Or[Fixnum,Float,nil], :is_done => Bool }) => nil
    def initialize(params)
      [:title, :assignee, :remaining_time, :is_done].each do |key|
        if params.include?(key) then
          instance_eval "@#{key.to_s}=params[key]"
        end
      end

      nil
    end

    Contract () => Bool
    def is_done?
      is_done
    end

    Contract Tasklist => nil
    def set_tasklist(tasklist)
      @tasklist = tasklist
      nil
    end

    Contract String => nil
    def set_assignee(assignee)
      @assignee = assignee
      nil
    end

    Contract String => String
    def to_s
      sprintf(" - [%s] %s %s %sh", (is_done?) ? 'x' : ' ', title, assignee, remaining_time)
    end
  end
end
