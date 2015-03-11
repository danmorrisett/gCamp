require 'rails_helper'

feature 'Existing user can CRUD a Task' do
  scenario 'signs in, goes to project index page, and clicks through to task showpage' do

    sign_in_user

    project = create_project

    expect(page).to have_content 'Tasks'

  end

  scenario 'can create a new task and see a success message' do

    sign_in_user

    click_link 'Tasks'

    click_link 'New Task'

    expect(current_path).to eq new_task_path

    fill_in :task_description, with: 'Learn Ruby'
    fill_in :task_due_date, with: '01/01/2001'
    click_button 'Create Task'

    expect(page).to have_content 'Task was successfully created'
    expect(page).to have_content 'Learn Ruby'
  end

  scenario 'can read an existing Task' do

    task = create_task(description: "Catch a raccoon")

    sign_in_user

    visit tasks_path

    expect(page).to have_content 'Catch a raccoon'
  end

  scenario 'can update an existing task and see a success message' do
    task = create_task(description: "Catch a raccoon")

    sign_in_user

    visit tasks_path

    click_link 'Edit'

    expect(current_path).to eq edit_task_path(task)

    fill_in :task_description, with: 'Learn Ruby'

    click_button 'Update Task'

    expect(current_path).to eq (task_path(task))
    expect(page).to have_content 'Task was successfully updated'
    expect(page).to have_content 'Learn Ruby'
  end

  scenario 'delete an existing task' do
    task = create_task(description: 'Mohammad Ali')

    sign_in_user

    visit tasks_path

    expect(page).to have_content 'Mohammad Ali'

    click_link 'Delete'

    expect(current_path).to eq tasks_path
    expect(page).to_not have_content 'Mohammad Ali'
  end

  scenario 'can see validations without a description' do
    sign_in_user

    visit tasks_path

    click_link 'New Task'

    click_button 'Create Task'

    expect(page).to have_content '1 error prohibited this form from being saved Description can\'t be blank'
  end

end
