# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :thing do
    sequence(:name) { |n| "Thing of Interest - #{n}" }
    description "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n\nLorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    image_url "thing.jpg"
  end
end

# WDI: If this is the first time you are seeing factory_girl, it essentially makes it easy for us
#   to create dummy data for our tests.  In the above example, description and image_url will
#   always be generated as the "Lorem ipsum..." string and "thing.jpg" respectively.  The
#   "sequence :name" syntax allows us to guarantee unique names for each record factoried up,
#   since we will be demanding that each name be unique.
#
#   This factory will replace our @valid_attributes that we talked about before in model specs!