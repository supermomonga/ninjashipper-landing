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
  case name.to_sym
  when :index
  when :index_tmp
    @page_title = "The easiest way to get Japanese items."
  else
    @page_title = name.gsub('_', ' ').capitalize
  end
  if name == 'index'
    @page = name.to_sym
    slim :comming_soon, layout: false
  else
    name = :index if name == 'index_tmp'
    @page = name.to_sym
    slim name.to_sym
  end
end

