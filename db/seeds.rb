# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


if ['development', 'test'].include?(Rails.env)

  Project.create!({name: 'Test', start: Time.new(2015, 9, 2, 12), end: Time.new(2015, 9, 2, 21), sensor1_name: '1', sensor2_name: '2'})

  t = Time.new(2015, 9, 2, 12)
  end_t = Time.new(2015, 9, 2, 21)
  v1 = 70.0
  v2 = 32.0

  Reading.transaction do
    while t < end_t

      Reading.create!({timestamp: t, value1: v1, value2: v2})

      t += 2
      v1 += 0.75
      v2 += 0.25
    end
  end

end