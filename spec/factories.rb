FactoryGirl.define do
  factory :person do
    first_name 'fred'
    middle_name 'walter'
    last_name 'rooms'
    email 'example@example.com'
    birthday '01/01/1992'
    wedding_day '01/01/2013'
    family_id '1'
  end
end


FactoryGirl.define do
  factory :family do
    family_name "smiths"
    description "this is the smith family"
  end
end


