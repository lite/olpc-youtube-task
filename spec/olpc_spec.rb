require_relative 'spec_helper.rb'

describe 'Home' do
	include Rack::Test::Methods	

	it "should load the home page" do
		get '/'
		last_response.should be_ok
    last_response.body.should include('All tasks')
	end

	it "should return to home with the created task" do
    title = "title-#{Time.now}"
    url = "http://www.google.com/#{Time.now}"
		post '/create', params = { :title => title, :url => url}
    last_response.should be_redirect; follow_redirect!
    last_request.url.should include("/")
    last_response.body.should include(title) 
	end

end

describe 'Edit task' do
	include Rack::Test::Methods	

  before do
    @task = Task.first
  end

	it "should load task to edit" do
		get "/#{@task.id}"
    last_response.should be_ok
    last_response.body.should include('Edit task')
	end

  it "should return to home with the updated task" do
		title = "title-#{Time.now}"
    url = "http://www.google.com/#{Time.now}"
    volunteer = "volunteer-#{Time.now}"
		post "/#{@task.id}/update", params = { :title => title, :url => url, :volunteer  => volunteer}
    last_response.should be_redirect; follow_redirect!
    last_request.url.should include("/")
    last_response.body.should include(volunteer) 
	end

end

describe 'Delete task' do
	include Rack::Test::Methods	

  before do
    @task = Task.first
  end

	it "should let user confirm the delete operation" do
		get "/#{@task.id}/delete"
    last_response.should be_ok
    last_response.body.should include('Confirm deletion of task')
	end

  it "should return to home without the deleted task" do
		post "/#{@task.id}/destroy"
    last_response.should be_redirect; follow_redirect!
    last_request.url.should include("/") 
	end

end

describe 'Complete task' do
	include Rack::Test::Methods	

  before do
    @task = Task.first
  end

	it "should return to home with the completed task" do
		get "/#{@task.id}/complete"
    last_response.should be_redirect; follow_redirect!
    last_request.url.should include("/")     
    last_response.should be_ok
	end

end
