require 'rubygems'
require 'sinatra'
require 'data_mapp'

# "postgres://olpc:olpc@hostname/database"
# need install dm-sqlite-adapter
DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite3://olpc-task.db')

class Task
    include DataMapper::Resource
    property :id, Serial
	  property :title, String
    property :url, String
    property :status, Integer
    property :worker, String
end

# automatically create the post table
Score.auto_migrate! unless Score.storage_exists?

configure :development do 
  use Rack::Reloader 
end

get '/show/:id' do 
  @items = Task.find :id => params[:id]
  erb :index
end

get '/new' do 
  erb :new
end

post '/create' do 
  request.body.rewind  # in case someone already read it
  puts request.body.read
  item = Task.new
  item.title = params[:title]
  item.url = params[:url]
  item.status = params[:status].to_i
  item.worker = params[:worker]
  item.save
  redirect "/show/#{item.id}"
end
