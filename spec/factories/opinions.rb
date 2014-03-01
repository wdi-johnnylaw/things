# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :opinion do
    user
    thing
    rating 3
    comment "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  end
end


# WDI: Notice that simply putting user and thing there will cause FactoryGirl to
#   generate a new user and a new thing associated with this opinion.  If I already
#   have a specific user (for example) I want to have be associated with this opinion
#   I can feed it in like so:
#
#     FactoryGirl.build :opinion, user: user
#
#   If I did exactly that line, the opinion would be associated with the user I supplied,
#     but the "thing" would be built freshly by FactoryGirl