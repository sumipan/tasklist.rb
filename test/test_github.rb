require 'minitest/autorun'
$LOAD_PATH.push('lib')

require 'tasklist'
require 'tasklist/github'
require 'hashie'
require 'pp'

describe Tasklist do
  it "should" do
    options = {
      :user => ENV['GITHUB_USER'],
      :repo => ENV['GITHUB_REPO'],
    }

    github = Github::Client.new
    github.setup(options.merge({
      :oauth_token => ENV['GITHUB_TOKEN'],
    }))

    tasklist = github.issues.get(options.merge({:number => ENV['GITHUB_NUMBER']})).body.tasklist(github)
    tasklist.tasks.each do |task|
      task.id.must_be_instance_of String
      p task.id
      task.tasklist.attr('comment').must_be_instance_of Hashie::Mash
      task.tasklist.attr('issue').must_be_instance_of Hashie::Mash
      task.tasklist.attr('issue').number.to_s.must_equal ENV['GITHUB_NUMBER']
    end
  end
end
