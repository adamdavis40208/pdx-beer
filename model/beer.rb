require 'sequel'
class Beer < Sequel::Model
  many_to_many :brewpubs
end