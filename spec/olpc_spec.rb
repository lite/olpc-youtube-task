require_relative 'spec_helper.rb'

describe 'Home:' do
	include Rack::Test::Methods	

	it "should load the home page" do
		get '/'
		last_response.should be_ok
	end
end

describe 'Create:' do
	include Rack::Test::Methods	

	it "should load the created task" do
		post '/', params = { :title => "title", :url => 'http://www.google.com'}
		last_response.body.include?('title')
	end

end
