require_relative '../olpc-task.rb'
require 'rack/test'

set :environment, :test

def app
	Sinatra::Application
end

