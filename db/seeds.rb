require 'faker'

u = User.new
u.update_attributes(:name => "Christine", :password => "Iceboxx88", :email => "christine.stauffer@gmail.com")
# u.skip_confirmation!
u.save

wikis = []
5.times do
  wikis << Wiki.create(
    title: Faker::Lorem.sentence, 
    body: Faker::Lorem.paragraph,
    user: u
  )
end

plan = Plan.create!(:name => "Premium", :price => 10)
plan.save 

p "#{plan} is the plan name"
p "created 5 wikis"