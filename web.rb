# coding: utf-8

require 'bundler'
Bundler.require
require 'sinatra/reloader' if development?
require 'csv'
require 'erb'
require 'cgi'


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

get '/shops.html' do
  @page_title = "Our recommended shops"
  @cat_id = params[:cat] || ERB::Util.url_encode('Our shops')
  @cat_name = CGI::unescape @cat_id

  data = CSV.table('./data/shops.csv')
  @categories = data[:category].inject({}){|acc,e|
    acc[e] ||= {
      name: e,
      id: ERB::Util.url_encode(e),
      count: 0
    }
    acc[e][:count] += 1
    acc
  }.values
  @shops = data.select{|d| d[:category] == @cat_name }
  p @shops.first

  slim :shops
end

get '/lithium-ion-battery-installation.html' do
  @page_title = "Notification of costs to be charged for lithium ion battery installation work."
  slim :lithium
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

