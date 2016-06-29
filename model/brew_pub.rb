require 'sequel'
class BrewPub < Sequel::Model
  many_to_many :beers
end