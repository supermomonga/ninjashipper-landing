# coding: utf-8

require 'bundler'
Bundler.require

set :port, 12345

get '/css/*.css' do |name|
  scss name.to_sym
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
