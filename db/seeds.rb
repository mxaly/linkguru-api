require 'faker'

puts 'Creating users...'
10.times do
  @created = false
  while !@created do
    @created = User.create(name: Faker::Name.name, email: Faker::Internet.free_email).save
  end
end

puts 'Creating links...'
150.times do
  @created = false
  while !@created do
    user = User.all[rand(10)]
    tags = Faker::Lorem.words(rand(4)+1)
    @created = Link.create(
      user: user,
      description: Faker::Lorem.sentence,
      tags_array: tags,
      description: Faker::Lorem.sentence,
      url: "https://www.google.com/#q=#{Faker::Lorem.word}"
    ).save
  end
end

puts 'Creating votes...'
300.times do
  @created = false
  while !@created do
    @user = User.all[rand(10)]
    voteable_links = Link.all - @user.votes.map{ |v| v.voteable }
    @link = voteable_links[rand(voteable_links.count)]
    @created = Vote.create(user: @user, voteable: @link, value: ((rand(2) == 1) ? 1 : -1)).save
  end
end
