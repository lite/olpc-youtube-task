require_relative '../olpc-tasks.rb'
require 'rack/test'

set :environment, :test

def app
	Sinatra::Application
end

