require 'date'

class DateHandler
  
  def self.convert(from_date, to_date)
    (Date.parse(from_date)...Date.parse(to_date)).to_a.map { |date| date.to_s }
  end
end