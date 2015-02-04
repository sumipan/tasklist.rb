require 'contracts'
require 'github_api'

module Hashie
  class Mash

    define_method "tasklist" do |client|
      # nothing to do.
      return nil if !number || !title

      tasklist = Tasklist::Tasklist.new
      tasklists(client).each do |new_tasklist|
        tasklist.merge(new_tasklist)
      end

      tasklist
    end

    define_method "tasklists" do |client|
      # nothing to do.
      return nil if !number || !title

      tasklists = []
      per_page  = 100
      page      = 0

      while true
        page += 1

        comments = client.issues.comments.list({
          :user   => client.user,
          :repo   => client.repo,
          :number => number,
          :per_page => per_page,
          :page   => page
        }).body

        comments.each do |comment|
          tasklist = Tasklist.parse(comment.body)
          if tasklist then
            tasklist.attr('issue', self)
            tasklist.attr('comment', comment)
            i = 1
            tasklist.tasks.each do |task|
              task.set_id("#{comment.id}.#{i}")
              task.set_title(task.title)
              task.set_assignee("@#{comment.user.login}") unless task.assignee

              i += 1
            end

            tasklists.push(tasklist)
          end
        end

        break if comments.size < per_page
      end

      tasklists
    end
  end
end
