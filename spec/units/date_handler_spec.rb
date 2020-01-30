require 'date_handler'

describe DateHandler do
  it "changes a from and to date into a hash of dates" do
    expect(DateHandler.convert('2020-02-01', '2020-02-21')).to be_a Array
    expect(DateHandler.convert('2020-02-01', '2020-02-21')).to include("2020-02-03")
  end
end
