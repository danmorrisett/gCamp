def create_project(options= {})
  Project.create!({
    name: 'Test Project',
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
  email: 'Bill@Cigars.com',
  password: 'Cigars',
  password_confirmation: 'Cigars'
  })
end

# before :each do
  # user = User.create(first_name: 'Bill',
  # last_name: 'Clinton',
  # email: 'Innocent@gmail.com',
  # password: 'bornagain')
  # visit root_path
  # click_link 'Sign In'
  # fill_in 'Email', with: user.email
  # fill_in 'Password', with: user.password
  # click_button 'Sign In'
# end
# def create_task (project, options = {})
#   Task.create!({
#     description: 'Test task for a project',
#     :project_id => project.id,
#     complete: true,
#   }.merge(options))

#end
