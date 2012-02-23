require 'rubygems'
require 'sinatra'
require 'data_mapper'

# need install dm-sqlite-adapter
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/olpc-task.db")

class Task
    include DataMapper::Resource
    property :id, Serial
	  property :title, String
    property :url, String
    property :complete, Boolean, :required => true, :default => false 
    property :worker, String
end

# automatically create the post table
Task.auto_migrate! unless Task.storage_exists?

configure :development do 
  use Rack::Reloader 
end

get '/' do 
  @tasks = Task.all :order => :id.desc  
  @title = 'All Tasks'
  erb :home
end

post '/' do
  t = Task.new
  t.title = params[:title]
  t.url = params[:url]
  t.save
  redirect '/'
end

"""
get '/delete/:id' do
  item = Task.find :id=> params[:id]
  item.delete
  redirect '/'
end

get '/edit/:id' do 
  @items = Task.find :id => params[:id]
  @title = 'Edit Task'
  erb :edit
end

post '/update/:id' do 
  request.body.rewind
  puts request.body.read
  item = Task.find :id=> params[:id]
  item.title = params[:title]
  item.url = params[:url]
  item.status = params[:status].to_i
  item.worker = params[:worker]
  item.save
  redirect '/'
end

get '/new' do 
  @title = 'New Task'
  erb :new
end

post '/create' do 
  request.body.rewind  # in case someone already read it
  puts request.body.read
  item = Task.new
  item.title = params[:title]
  item.url = params[:url]
  item.status = 0
  item.worker = params[:worker]
  item.save
  redirect '/'
end
"""
