# namespace :dev - 讓指令出現前綴，例如 rails dev:fake。
# task fake: :environment 加入 :environment 可以讓你的 Rake 
# 與專案的 Model 和資料庫互動，否則你只能在 Rake 寫 Ruby 程式。


namespace :dev do
  task fake: :environment do

    # 產生500家餐廳
    Restaurant.destroy_all

    500.times do |i|
      Restaurant.create!(name: FFaker::Name.first_name,
        opening_hours: FFaker::Time.datetime,
        tel: FFaker::PhoneNumber.short_phone_number,
        address: FFaker::Address.street_address,
        description: FFaker::Lorem.paragraph,
        category: Category.all.sample
      )
    end
    puts "have created fake restaurants"
    puts "now you have #{Restaurant.count} restaurants data"


  
    # 產生20個帳號
    User.all.each do | user |
      user.destroy unless user.admin?
    end

    20.times do |i|
      user_name = FFaker::Name.first_name
      User.create!(
        email: "#{user_name}@example.com",
        password: "12345678"
        )
    end
    puts "Have createed fake users."
    puts "Now you have #{User.count} users data."


  # 每家餐廳產生3筆留言
    Comment.destroy_all

    Restaurant.all.each do |restaurant|
      3.times do |i|
        restaurant.comments.create!(
          content: FFaker::Lorem.sentence,
          user: User.all.sample
          )
      end
    end
    puts "Have created fake comments."
    puts "Now you have #{Comment.count} comment data."

    
  end
end
