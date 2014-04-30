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

p "created 5 wikis"