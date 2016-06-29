Sequel.migration do
  change do
    create_table :brewpubs do
      primary_key :id
      String :name, :unique => true, :length => 32, :null => false
      DateTime :created_on
      DateTime :updated_on
    end
  end
end