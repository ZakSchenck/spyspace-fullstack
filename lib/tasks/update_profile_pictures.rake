namespace :db do
    desc 'Update empty or null profile pictures to default value'
    task update_profile_pictures: :environment do
      users_without_profile_picture = User.where(profile_picture: [nil, 'default_profile.jpg'])
      users_without_profile_picture.update_all(profile_picture: 'pfp-funny.jpeg')
  
      puts "#{users_without_profile_picture.count} user(s) updated."
    end
  end