# api
 
    sinatra
    rspec

# shell 

    ruby olpc-tasks.rb 
    rake spec

# heroku

    heroku create olpc-tasks
    heroku addons:add shared-database:5mb
    heroku config
    git push heroku master

# database 
    sudo -u postgres createdb olpc-tasks
    sudo -u postgres psql
    sudo -u postgres psql
    postgres=# \password $USER

    heroku db:push postgres://postgres:postgres@localhost/olpc-tasks
    heroku pg:info

# debug

    heroku console
    >> ENV["DATABASE_URL"]

# ci
    travis-ci
