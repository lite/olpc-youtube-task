require_relative 'spec_helper.rb'

describe 'Reverse Service' do
	include Rack::Test::Methods	

	it "should load the home page" do
		get '/'
		last_response.should be_ok
	end

  """
	it "should reverse posted values as well" do
		post '/create', params = { :str => 'Jeff'}
		last_response.body.should be_ok
	end
  """
end
