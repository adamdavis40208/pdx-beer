Sequel.migration do
  change do
    create_table :beers do
      primary_key :id
      String :name, :unique => true, :length => 32, :null => false
      String :brewery, :unique => true, :length => 32, :null => false
      String :style, :length => 32
      Double :abv, :length => 32
      DateTime :created_on
    end
  end
end