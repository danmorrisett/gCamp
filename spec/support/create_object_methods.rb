def create_project(options= {})
  Project.create!({
    name: 'Test Project',
  }.merge(options))
end

def create_membership(project, user, options = {})
  Membership.create!({
    user_id: user.id,
    project_id: project.id,
    role: 'member'
  }.merge(options))
end

def create_task(options= {})
  Task.create!({
    description: 'New Task',
    due_date: '01/01/2001',
    complete: false,
  }.merge(options))
end

def create_user(options = {})
  User.create!({
    first_name: 'Bill',
    last_name: 'Clinton',
    email: "Bill#{rand(10000)+1}@Cigars.com",
    password: 'Cigars',
    password_confirmation: 'Cigars',
    admin: true
  }.merge(options))
end
