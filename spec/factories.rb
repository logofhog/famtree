FactoryGirl.define do
  factory :person do
    first_name 'factfred'
    middle_name 'walter'
    last_name 'rooms'
    email 'example@example.com'
    birthday '01/01/1992'
    wedding_day '01/01/2013'
    family_id '1'
  end
end


FactoryGirl.define do
  factory :user do
    email 'example@example.com'
    password 'password'
    family_id '4'
  end
end




