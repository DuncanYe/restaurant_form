# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.destroy_all

category_list = [
  {name: "中華料理"},
  {name: "日本料理"},
  {name: "航道料理"},
  {name: "印度料理"},
  {name: "泰國料理"},
  {name: "義式料理"},
  {name: "科技料理"},
]

category_list.each do |category|
  Category.create( name: category[:name])
end
puts "Category created!"

#Default admin
User.create(email: "example@root.com", password: "12345678", role: "admin")
puts "Default admin create!"