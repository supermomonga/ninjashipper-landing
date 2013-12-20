# coding: utf-8

require 'bundler'
Bundler.require

set :public_folder, "#{ File.dirname(__FILE__) }/public"

get '/css/*.css' do |name|
  less name.to_sym
end

get '/js/*.js' do |name|
  coffee name.to_sym
end

get '/' do
  slim :index
end

get '/*.html' do |name|
  slim name.to_sym
end

# hi5
