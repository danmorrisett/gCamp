require 'rails_helper'

feature 'Existing user can CRUD a Task' do

  before :each do
    user = create_user
    sign_in_user(user)
  end

  scenario 'signs in, goes to project index page, and clicks through to task showpage' do

    project = create_project

    expect(page).to have_content 'Tasks'

  end

  scenario 'can create a new task and see a success message' do

    project = create_project

    visit project_tasks_path(project)

    click_link 'New Task'

    expect(current_path).to eq new_project_task_path(project)

    fill_in :task_description, with: 'Learn Ruby'
    fill_in :task_due_date, with: '01/01/2001'
    click_button 'Create Task'

    expect(page).to have_content 'Task was successfully created'
    expect(page).to have_content 'Learn Ruby'
  end

  scenario 'can read an existing Task' do
    project = create_project
    task = create_task(description: "Catch a raccoon", project_id: project.id)

    visit project_tasks_path(project)

    expect(page).to have_content 'Catch a raccoon'
  end

  scenario 'can update an existing task and see a success message' do
    project = create_project

    task = create_task(description: "Catch a raccoon", project_id: project.id)

    visit project_tasks_path(project)

    click_link 'Edit'

    expect(current_path).to eq edit_project_task_path(project, task)

    fill_in :task_description, with: 'Learn Ruby'

    click_button 'Update Task'

    expect(current_path).to eq (project_task_path(project, task))
    expect(page).to have_content 'Task was successfully updated'
    expect(page).to have_content 'Learn Ruby'
  end

  scenario 'delete an existing task' do
    project = create_project
    task = create_task(description: 'Mohammad Ali', project_id: project.id)

    visit project_tasks_path(project)

    expect(page).to have_content 'Mohammad Ali'

    page.find(".glyphicon-remove").click

    expect(current_path).to eq project_tasks_path(project)
    expect(page).to_not have_content 'Mohammad Ali'
  end

  scenario 'can see validations without a description' do
    project = create_project

    visit project_tasks_path(project)

    click_link 'New Task'

    click_button 'Create Task'

    expect(page).to have_content '1 error prohibited this form from being saved Description can\'t be blank'
  end

end
