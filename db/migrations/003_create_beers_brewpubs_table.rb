Sequel.migration do
  change do
    create_table :beers_brewpubs do
      primary_key :id
      foreign_key :beer_id, :beers
      foreign_key :brewpub_id, :brewpubs
      DateTime :created_on
      DateTime :updated_on
    end
  end
end