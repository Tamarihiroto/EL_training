require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  describe "降順確認" do
    before do
      tasks = create_list(:task, 3)
    end
    it "テスト" do
      visit tasks_path
      task_list = all('.task_list') 
      expect(task_list[0]).to have_content '3'
      expect(task_list[1]).to have_content '2'
      expect(task_list[2]).to have_content '1'
  end
end
