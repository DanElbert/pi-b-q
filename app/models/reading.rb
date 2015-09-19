class Reading < ActiveRecord::Base

  def in_fahrenheit
    (self.value * 1.8) + 32
  end

  def in_celsius
    self.value
  end

end
