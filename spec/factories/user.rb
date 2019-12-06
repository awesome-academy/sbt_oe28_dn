FactoryBot.define do
  factory :user do
    full_name {Faker::Name.name}
    email {Faker::Internet.free_email}
    password {"123456"}
    password_confirmation {"123456"}
    role {User.roles[:user]}
  end
end
