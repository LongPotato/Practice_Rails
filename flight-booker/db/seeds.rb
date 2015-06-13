# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Airport.delete_all
Flight.delete_all

lax = Airport.create(code: "LAX")
nyc = Airport.create(code: "NYC")
sfo = Airport.create(code: "SFO")
han = Airport.create(code: "HAN")
tpe = Airport.create(code: "TPE")

duration = {}

Airport.all.each do |airport1|
  Airport.all.each do |airport2|
    unless airport1 == airport2
      flight = "#{airport1.code}_#{airport2.code}"
      duration[flight] = rand(2..13).hours
    end
  end
end


Airport.all.each do |airport1|
  Airport.all.each do |airport2|
    unless airport1 == airport2
      dur = "#{airport1.code}_#{airport2.code}"
      Flight.create(from_airport_id: airport1.id, to_airport_id: airport2.id, date: Time.now, duration: duration[dur])
      Flight.create(from_airport_id: airport1.id, to_airport_id: airport2.id, date: 3.hours.from_now, duration: duration[dur])
      Flight.create(from_airport_id: airport1.id, to_airport_id: airport2.id, date: 6.hours.from_now, duration: duration[dur])
      Flight.create(from_airport_id: airport1.id, to_airport_id: airport2.id, date: 1.day.from_now, duration: duration[dur])
      Flight.create(from_airport_id: airport1.id, to_airport_id: airport2.id, date: (1.day + 6.hours).from_now, duration: duration[dur])
      Flight.create(from_airport_id: airport1.id, to_airport_id: airport2.id, date: 2.days.from_now, duration: duration[dur])
      Flight.create(from_airport_id: airport1.id, to_airport_id: airport2.id, date: (2.days + 3.hours).from_now, duration: duration[dur])
    end
  end
end
