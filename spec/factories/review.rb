FactoryBot.define do
  factory :review do
    title  {Faker::FunnyName.name}
    description {"this is description"}
    content {Faker::Food.description}
    image {File.open(File.join(Rails.root, "app/assets/images/halong.jpg"))}
    category_id {Faker::Number.between(1,3)}
    association :user, factory: :user
  end
end
