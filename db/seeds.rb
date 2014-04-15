User.create(email: 'kevin@gmail.com', screen_name: "pandasan", hometown: "San Francisco, California", password: "123456", password_confirmation: "123456")

trips = []

trips << Trip.create(name: 'SF Galore', destination: "San Francisco, California", description:"moving to SF!!",)
trips << Trip.create(name: 'New York Fun!', destination: "Manhattan, New York", description:"Visiting Sasha!")

User.first.trips << trips[0]
User.first.trips << trips[1]