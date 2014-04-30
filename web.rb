# coding: utf-8

require 'bundler'
Bundler.require
require 'sinatra/reloader' if development?


get '/css/*.css' do |name|
  less name.to_sym
end

get '/js/*.js' do |name|
  coffee name.to_sym
end

get '/' do
  @page = :index
  # slim :index, layout: false
  slim :comming_soon, layout: false
end

get '/*.html' do |name|
  if name == 'index'
    @page = name.to_sym
    slim :comming_soon, layout: false
  else
    name = :index if name == 'index_tmp'
    @page = name.to_sym
    slim name.to_sym
  end
end

# hi5
