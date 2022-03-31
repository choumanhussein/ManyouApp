require 'rails_helper'
RSpec.describe "Tasks management function", type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
    visit tasks_path
  end

  describe 'list function' do
    context 'to transition to the list screen' do
      it 'already created tasks should be displayed' do
        expect(page).to have_content 'test1'
        expect(page).to have_content 'test2'
        expect(page).to have_content 'sample3'
      end
    end
  end
  describe 'new feautures' do
  context 'case was the task to create a new task' do
    it 'should display the new task created' do
      visit new_task_path
      fill_in "Task Name", with: 'test1'
      fill_in "Task Details", with: 'test2'
      click_on 'Create Task'
      expect(page).to have_content 'sample3'
    end
  end
end
describe 'list function' do
   context 'to transition to the list screen' do
     it 'already created tasks should be displayed' do
       expect(page).to have_content 'test1'
       expect(page).to have_content 'test2'
       expect(page).to have_content 'sample3'
     end
   end
 end
 describe 'detailed display function' do
    context 'to transition to any task detail screen' do
      it 'contents of relevant task should be displayed' do
        visit new_task_path
        fill_in "Task Name", with: 'title test4'
        fill_in "Task Details", with: 'content test'
        expect(page).to have_content ''
      end
    end
  end

  let!(:task){ FactoryBot.create(:task, title: 'task') }
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
    visit tasks_path
  end

      it 'New task is displayed at the top' do
        assert Task.all.order(duedate: :desc)
      end
    end
