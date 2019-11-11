Category.create!(name: "news")
Category.create!(name: "food")
Category.create!(name: "place")
16.times do |n|
  title = Faker::WorldCup.team
  description = Faker::Lorem.sentence(word_count: 3)
  content = Faker::Quote.matz
  price = Faker::Number.within(range: 1..1000)
  Tour.create!(title: title,
               description: description,
               content: content,
               image: File.open(File.join(Rails.root, "app/assets/images/halong.jpg")),
               price: price,
               date_in: Date.new(2019,10,31),
               date_out: Date.new(2019,11,01))
end
