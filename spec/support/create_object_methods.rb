def create_project(options= {})
  Project.create!({
    name: 'Test Project',
  }.merge(options))
end

def create_membership(options = {})
  Membership.create!({
    user_id: create_user.id,
    project_id: create_project.id,
    role: 'Member'
  }.merge(options))
end

def create_task(options= {})
  Task.create!({
    description: 'New Task',
    due_date: '01/01/2001',
    complete: false,
    project_id: create_project.id
  }.merge(options))
end

def create_user(option= {})
  User.create!({
  first_name: 'Bill',
  last_name: 'Clinton',
  email: "Bill#{rand(10000)+1}@Cigars.com",
  password: 'Cigars',
  password_confirmation: 'Cigars',
  admin: true
  })
end
