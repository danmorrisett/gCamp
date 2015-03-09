require "rails_helper"

  feature 'Existing user can CRUD a Project' do
    scenario 'visits root_path, signs in, and goes to a Project index page' do
      project = Project.new(name: 'Project Mayhem')
      project.save!

      sign_in_user

      click_link 'Projects'
      expect(page).to have_content 'Project Mayhem'

    end

    scenario 'can create a new project and see success message' do

      sign_in_user
      click_link 'Projects'
      expect(current_path).to eq projects_path
      click_link 'New project'

      expect(current_path).to eq new_project_path

      fill_in :project_name, with: 'Cool Project'
      click_button 'Create Project'

      expect(page).to have_content 'Project was successfully created'
      expect(page).to have_content 'Cool Project'

    end

    scenario 'can read an existing Project' do
      project = Project.new(name: 'Project Mayhem')
      project.save!

      sign_in_user
      click_link 'Projects'
      expect(current_path).to eq projects_path

      click_link 'Project Mayhem'
      expect(current_path).to eq project_path(project)
      expect(page).to have_content 'Project Mayhem'
      expect(page).to have_link 'Edit'
    end

    scenario "Can update an existing project with success message" do
      project = Project.new(name: "The woods!")
      project.save!

      sign_in_user

      click_link 'Projects'
      expect(current_path).to eq projects_path
      click_link 'The woods!'

      click_link 'Edit'

      expect(current_path).to eq(edit_project_path(project))
      expect(page).to have_content 'Project was successfully updated'
    end

    scenario 'delete an existing project with success massage' do
      project = Project.new(name: 'Project Mayhem')
      project.save!
      sign_in_user

      click_link 'Projects'
      expect(curent_path).to eq projects_path
      click_link 'Project Mayhem'

      expect(current_path).to eq project_path(project)
      click_link 'Delete'

      expect(current_path).to eq projects_path
      expect(page).to have_content 'Project was successfully deleted'
      expect { project.reload }.to raise_error ActiveRecord::RecordNotFound
    end

    scenario 'can see validations without a name' do

      sign_in_user
      click_link 'Projects'
      expect(current_path).to eq projects_path
      click_link 'New Project'

      expect(current_path).to eq new_project_path

      click_button 'Create Project'

      expect(page).to have_content '1 error prohibited this form from being saved:
      Name can\'t be blank'

    end

  end
