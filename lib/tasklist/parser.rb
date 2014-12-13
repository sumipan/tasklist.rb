# encoding: utf-8

require 'contracts'

module Tasklist
  class Parser
    include Contracts

    TASK_START_PHRASE = "タスク"

    Contract String, Tasklist => Or[nil,Tasklist]
    def parse(text, tasklist)
      # tasklist must start with "タスク" phrase.
      return nil unless text.each_line.first.match(/^#{TASK_START_PHRASE}/)

      plain_attrs = text.each_line.first.sub(TASK_START_PHRASE,'').chomp.strip
      plain_attrs.split(',').each do |attr|
        key, value = attr.split('=>').map{|e| e.strip }
        tasklist.attr(key, value)
      end

      text.each_line do |line|
        input = line.chomp.strip

        next unless input.match(/^- \[[ x]\] /)

        params = {}
        if input.match(/^- \[x\] /) then
          params[:is_done] = true
        else
          params[:is_done] = false
        end

        plain_task = input.match(/^- \[[ x]\] (.+)$/)[1]
        match = plain_task.match(/ ([0-9\.]+)+h$/)
        if match then
          if match[1].include?('.') then
            params[:remaining_time] = match[1].to_f
          else
            params[:remaining_time] = match[1].to_i
          end
          plain_task = plain_task.sub(match[0], '').strip
        end

        match = plain_task.match(/ (@[a-zA-Z0-9_]+)$/)
        if match then
          params[:assignee] = match[1]
          plain_task = plain_task.sub(match[0], '').strip
        end

        params[:title] = plain_task

        tasklist.add(Task.new({
          :title          => params[:title],
          :assignee       => params[:assignee],
          :remaining_time => params[:remaining_time],
          :is_done        => params[:is_done],
        }))
      end

      tasklist
    end
  end
end
