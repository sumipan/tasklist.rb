require 'minitest/autorun'
$LOAD_PATH.push('lib')

require 'tasklist'
require 'tasklist/github'
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
      puts task.to_s
    end
  end
end
