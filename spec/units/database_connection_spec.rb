require 'database_connection'

describe DatabaseConnection do

  it "executes a query via PG" do
    connection = DatabaseConnection.setup('bnb_app_test')
    expect(connection).to receive(:exec).with("SELECT * FROM listings;")
    DatabaseConnection.query("SELECT * FROM listings;")
  end

  it "sets up a connection to a database through PG" do
    expect(PG).to receive(:connect).with(dbname: 'bnb_app_test') 
    DatabaseConnection.setup('bnb_app_test')
  end

end