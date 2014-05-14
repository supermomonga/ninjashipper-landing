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
  @page_title = "Japan Address, Mail Forwarding & Assisted purchasing."
  if @debug
    slim :comming_soon, layout: false
  else
    slim :index
  end
end

before do
  @debug = false
end

get '/*.html' do |name|
  case name.to_sym
  when :index, :index_tmp
    @page_title = "Japan Address, Mail Forwarding & Assisted purchasing."
  else
    @page_title = name.gsub('_', ' ').capitalize
  end

  if @debug == true && name == 'index'
    @page = name.to_sym
    slim :comming_soon, layout: false
  else
    name = :index if name == 'index_tmp'
    @page = name.to_sym
    slim name.to_sym
  end
end

