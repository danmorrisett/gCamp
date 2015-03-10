def create_project(options= {})
  Project.create!({
    name: 'Test Project',
  }.merge(options))
end

def create_task(options= {})
  Task.create!({
    description: 'New Task',
    due_date: '01/01/2001',
    complete: false
  }.merge(options))
end

# def create_task (project, options = {})
#   Task.create!({
#     description: 'Test task for a project',
#     :project_id => project.id,
#     complete: true,
#   }.merge(options))

#end
