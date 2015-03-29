namespace :cleanup do

  desc "Removes all memberships where their users have already been deleted"
  task members: :environment do
    orphaned_user_memberships = Membership.where.not(user_id: User.pluck(:id)).delete_all
    puts "#{orphaned_user_memberships} removed memberships where users had been deleted"
  end
