source :gemcutter
#source "http://ruby.taobao.com"

gem 'rake'
gem 'sinatra'
gem 'datamapper'
gem 'heroku'

group :production do
  gem "pg"
  gem "dm-postgres-adapter"
end

group :development, :test do
  gem "sqlite3"
  gem 'dm-sqlite-adapter'
end

group :test do
  gem 'rack-test'
  gem 'rspec'
  gem 'autotest'
end


