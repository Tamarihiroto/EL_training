require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  describe "タスクのテスト" do
    let(:tasks) { create_list(:task, 3) }

    before do 
      tasks
    end
    
    it "created_atの降順になること" do
      tasks_expect = tasks.reverse
      visit tasks_path
      task_list = all('.task_id')
      expect(task_list[0]).to have_content tasks_expect[0].id
      expect(task_list[1]).to have_content tasks_expect[1].id
      expect(task_list[2]).to have_content tasks_expect[2].id
    end
  end
end
