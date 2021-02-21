require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  describe "降順確認" do
    before do
      Task.all.destroy_all
    end
    let(:task_1) { create(:task, id: 5000) }
    let(:task_2) { create(:task, id: 5001) }
    let(:task_3) { create(:task, id: 5002) }
    it "テスト" do
      task_1
      task_2
      task_3
      visit "/tasks"
      task_id_fact = Task.all.order(created_at: :desc)
      expect(task_id_fact.ids).to eq [5002, 5001, 5000]
    end
  end
end
