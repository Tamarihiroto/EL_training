require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  describe 'ソート' do
    let(:tasks) { create_list(:task, 3) }

    before do 
      tasks
    end
    
    it 'created_atの降順になること' do
      tasks_expect = tasks.reverse
      visit tasks_path
      # 2回でcreated_atで降順化
      click_on 'タイトル'
      click_on 'タイトル'
      task_list = all('.task_id')
      expect(task_list[0]).to have_content tasks_expect[0].id
      expect(task_list[1]).to have_content tasks_expect[1].id
      expect(task_list[2]).to have_content tasks_expect[2].id
    end

    it 'deadlineの昇順になること' do
      visit tasks_path
      # deadlineで昇順化
      click_on '終了期限'
      task_list = all('.task_deadline')
      expect(task_list[0]).to have_content I18n.l(tasks[0].deadline, format: :short)
      expect(task_list[1]).to have_content I18n.l(tasks[1].deadline, format: :short)
      expect(task_list[2]).to have_content I18n.l(tasks[2].deadline, format: :short)
    end
  end
end
