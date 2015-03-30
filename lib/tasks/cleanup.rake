namespace :cleanup do

  desc "Removes all memberships where their users have already been deleted"
  task members: :environment do
    Membership.where.not(user_id: User.pluck(:id)).destroy_all
  end

  desc "Removes all memberships where their projects have already been deleted"
  task member: :environment do
    Membership.where.not(project_id: Project.pluck(:id)).destroy_all
  end

  desc "Removes all tasks where their projects have been deleted"
  task task: :environment do
    Task.where.not(project_id: Project.pluck(:id)).destroy_all
  end

  desc "Removes all comments where their tasks have been deleted"
  task comments: :environment do
    Comment.where.not(task_id: Task.pluck(:id)).destroy_all
  end

  desc "Sets the user_id of the comments to nil if their users have been deleted"
  task user_id: :environment do
    Comment.where.not(user_id: User.pluck(:id)).update_all(user_id: nil)
  end

  desc "Removes any tasks with null project_id"
  task task: :environment do
    Task.where(project_id: nil).destroy_all
  end

  desc "Removes any comments with a null task_id"
  task comment: :environment do
    Comment.where(task_id: nil).destroy_all
  end

  desc "Removes any memberships with a null project_id or user_id"
  task membership: :environment do
    Membership.where(project_id = nil && user_id = nil).destroy_all
  end

end
