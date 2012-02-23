require 'rubygems'
require 'sinatra'
require 'data_mapper'

# need install dm-sqlite-adapter
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/olpc-tasks.db")

class Task
    include DataMapper::Resource
    property :id, Serial
	  property :title, Text, :required => true
    property :url, Text, :required => true
    property :complete, Boolean, :required => true, :default => false 
    property :volunteer, String, :default => ""
end

# automatically create the post table
Task.auto_migrate! unless Task.storage_exists?

configure :development do 
  use Rack::Reloader 
end

get '/' do 
  @tasks = Task.all :order => :id.desc  
  @title = 'All tasks'
  erb :home
end

post '/create' do
  t = Task.new
  t.title = params[:title]
  t.url = params[:url]
  t.save
  redirect '/'
end

get '/:id' do
  @task = Task.get params[:id]
  @title = "Edit task ##{params[:id]}"
  erb :edit
end

post '/:id/update' do
  t = Task.get params[:id]
  t.title = params[:title]
  t.url = params[:url]
  t.volunteer = params[:volunteer] 
  t.save
  redirect "/"
end

get '/:id/delete' do
  @task = Task.get params[:id]
  @title = "Confirm deletion of task ##{params[:id]}"
  erb :delete
end

post '/:id/destroy' do
  t = Task.get params[:id]  
  t.destroy  
  redirect '/'  
end

get '/:id/complete' do
  t = Task.get params[:id]
  t.complete = t.complete ? 0 : 1 # flip it
  t.save
  redirect '/'
end
