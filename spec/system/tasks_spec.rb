require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  describe "降順確認" do
    let(:tasks) { create_list(:task, 3) }

    before do 
      tasks
    end
    
    it do
      tasks_expect = tasks.reverse
      visit tasks_path
      task_list = all('.task_id')
      expect(task_list[0]).to have_content tasks_expect[0].id
      expect(task_list[1]).to have_content tasks_expect[1].id
      expect(task_list[2]).to have_content tasks_expect[2].id
    end
  end
  describe "ソート" do
    let(:task_1) { create(:task, priority: 'high') }
    let(:task_2) { create(:task, priority: 'low') }
    let(:task_3) { create(:task, priority: 'middle') }
    let(:task_4) { create(:task, priority: 'undefine') }

    before do 
      task_1
      task_2
      task_3
      task_4
    end
    
    it '優先順位が高い順にソートされること' do
      visit tasks_path
      # 優先順位が高い順にソート
      click_on '優先順位'
      task_list = all('.task_priority')
      expect(task_list[0]).to have_content I18n.t("enums.task.priority.#{task_1.priority}")
      expect(task_list[1]).to have_content I18n.t("enums.task.priority.#{task_3.priority}")
      expect(task_list[2]).to have_content I18n.t("enums.task.priority.#{task_2.priority}")
      expect(task_list[3]).to have_content I18n.t("enums.task.priority.#{task_4.priority}")
    end

    it '優先順位が低い順にソートされること' do
      visit tasks_path
      # 優先順位が低い順にソート
      click_on '優先順位'
      click_on '優先順位'
      task_list = all('.task_priority')
      expect(task_list[0]).to have_content I18n.t("enums.task.priority.#{task_4.priority}")
      expect(task_list[1]).to have_content I18n.t("enums.task.priority.#{task_2.priority}")
      expect(task_list[2]).to have_content I18n.t("enums.task.priority.#{task_3.priority}")
      expect(task_list[3]).to have_content I18n.t("enums.task.priority.#{task_1.priority}")
    end
  end
end
