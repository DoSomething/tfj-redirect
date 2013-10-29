set :application, "TFJ Laravel"
set :repository, "." 
set :scm, :none 
set :deploy_via, :copy

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

server '209.61.132.44', :app, :web, :db

set :use_sudo, false
set :user, 'dosomething'

set :deploy_to, '/tmp/tfj'
