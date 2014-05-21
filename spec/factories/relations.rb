# Read about factories at https://github.com/thoughtbot/factory_girl

include FactoryGirl::Syntax::Methods
FactoryGirl.define do
  factory :relation do
    rel_type 'brother'
    person create :person
    relative :person
  end
end
