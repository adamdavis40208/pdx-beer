require 'sinatra'
require 'sequel'
require 'dotenv'
require './lib/site_parsers/baileys_parser'

class Todo < Sinatra::Application
  configure do
    Dotenv.load
    DB = Sequel.connect(ENV["DATABASE_URL"])
    Sequel::Model.plugin :timestamps, :create => :created_on, :update => :updated_on, :update_on_create => true
    Dir[File.join(File.dirname(__FILE__),'model','*.rb')].each { |model| require model }
  end
end

get '/' do
  all_beers =  Beer.all
  all_beers.to_s
end

get '/search/:name/' do
  #user = User.find(name: params[:name])
  #if !user.nil?
  #  "user: " + user.values[:name] +" password: " + user.values[:password]
 # else
    "Search not implemented yet due to lazy dev"
  #end
end

get '/baileys' do
  BaileysParser.new(nil).get_beers
end