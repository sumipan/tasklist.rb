require 'contracts'

module Tasklist
  class Task
    include Contracts

    attr_accessor :title,  :assignee, :remaining_time, :is_done

    Contract ({ :title => String, :assignee => String, :remaining_time => Fixnum, :is_done => Bool }) => nil
    def initialize(params)
      [:title, :assignee, :remaining_time, :is_done].each do |key|
        if params.include?(key) then
          send("#{key.to_s}=", params[:key])
        end
      end

      nil
    end

    def is_done?
      is_done
    end
  end
end
