require 'rails_helper'
RSpec.describe "Labels function", type: :system do
  before do
    @adminuser = User.create(name: "husseim", email: "hussein12@hussein.com", password: "123456*", password_confirmation: "123456*", admin: true)
    @user = FactoryBot.create(:user)
    @task = FactoryBot.create(:task, user: @user)
    @second_task = FactoryBot.create(:second_task, user: @user)
    @third_task = FactoryBot.create(:third_task, user: @user)
    @label = FactoryBot.create(:label)
    @second_label = FactoryBot.create(:second_label)
    @third_label = FactoryBot.create(:third_label)
    FactoryBot.create(:user, name: 'bella',
                             email: 'bella@gmail.com',
                             password: 'password',
                             password_confirmation: 'password')
  end

  describe 'Accessing the label screen after login' do
    context 'when user visits label screen' do
      before do
        visit new_session_path
        fill_in 'session_email', with: 'hussein@hussein.com'
        fill_in 'session_password', with: '123456'
        click_button 'login'
      end
      it 'should have access to label screen' do
        visit labels_path
        expect(current_path).to eq labels_path
        expect(page).to have_content 'Labels'
      end
      it 'should create new label' do
        visit new_label_path
        fill_in 'name', with: 'new label'
        click_on 'Créer un(e) Label'
        expect(page).to have_content 'new label'
        expect(page).to have_content 'Label Was Successfuly created !'
      end
      it 'can edit label' do
        visit labels_path
        within first('tbody tr') do
          click_link 'Edit'
        end
        fill_in 'name', with: 'edit label'
        click_on 'Modifier ce(tte) Label'
        expect(page).to have_content 'Label updated !'
        expect(page).to have_content 'edit'
      end
      it 'can delete label' do
        visit labels_path
        within first('tbody tr') do
          click_on 'Destroy'
        end
      end
    end
  end

  describe 'related to task and labels' do
    before do
      visit new_session_path
      fill_in 'session_email', with: 'bella@gmail.com'
      fill_in 'session_password', with: 'password'
      click_button 'login'
    end

    context 'when new task is created' do
      it 'should be able to add a label' do
        visit new_task_path
        fill_in "Task Name", with: 'title test'
        fill_in "Task Details", with: 'content test'
        fill_in "Deadline", with: '002020-12-18 11:00 PM'
        select 'started'
        select 'low'
        check 'FirstLabel'
        check 'SecondLabel'
        check 'ThirdLabel'
        click_on 'Créer un(e) Task'
        expect(page).to have_content 'User bella has created a task !'
        expect(page).to have_content 'FirstLabel'
        expect(page).to have_content 'SecondLabel'
        expect(page).to have_content 'ThirdLabel'
      end
    end

    context 'when visiting task details screen' do
      it 'should display the label' do
        visit new_task_path
        fill_in "Task Name", with: 'title test'
        fill_in "Task Details", with: 'content test'
        fill_in "Deadline", with: '002020-12-18 11:00 PM'
        select 'started'
        select 'low'
        check 'FirstLabel'
        check 'SecondLabel'
        check 'ThirdLabel'
        click_on 'Créer un(e) Task'
        within first('tbody tr') do
        click_on 'Edit'
      end
        check 'FirstLabel'
        check 'SecondLabel'
        uncheck 'ThirdLabel'
        click_on 'Modifier ce(tte) Task'
        #visit task_path(@task.id)
        expect(page).to have_content 'FirstLabel'
        expect(page).to have_content 'SecondLabel'
      end
    end

    context 'editing labels' do
      it 'should be able to update labels' do
        visit new_task_path
        fill_in "Task Name", with: 'title test'
        fill_in "Task Details", with: 'content test'
        fill_in "Deadline", with: '002020-12-18 11:00 PM'
        select 'started'
        select 'low'
        check 'FirstLabel'
        check 'SecondLabel'
        check 'ThirdLabel'
        click_on 'Créer un(e) Task'
        within first('tbody tr') do
        click_on 'Edit'
      end
        check 'FirstLabel'
        check 'SecondLabel'
        check 'ThirdLabel'
        click_on 'Modifier ce(tte) Task'
          click_on 'Show'
        expect(page).to have_content 'FirstLabel'
        expect(page).to have_content 'SecondLabel'
        expect(page).to have_content 'ThirdLabel'
      end
    end

    context 'Using edit to delete label' do
      it 'should remove label' do
        visit new_task_path
        fill_in "Task Name", with: 'title test'
        fill_in "Task Details", with: 'content test'
        fill_in "Deadline", with: '002020-12-18 11:00 PM'
        select 'started'
        select 'low'
        check 'FirstLabel'
        check 'SecondLabel'
        check 'ThirdLabel'
        click_on 'Créer un(e) Task'
        within first('tbody tr') do
        click_on 'Edit'
      end
        uncheck 'SecondLabel'
        uncheck 'ThirdLabel'
        click_on 'Modifier ce(tte) Task'
        within first('tbody tr') do
          click_on 'Show'
         end
        expect(page).to have_no_content 'SecondLabel'
        expect(page).to have_no_content 'ThirdLabel'
      end
    end
  end
end
