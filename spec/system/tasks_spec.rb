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
  describe 'ページネーション' do
    let(:tasks) { create_list(:task, 26) }

    before do 
      tasks
    end
    
    it '1ページで25個まで表示されること' do
      visit tasks_path
      expect(page).to have_content tasks[0].id
      expect(page).to have_content tasks[24].id
      expect(page).not_to have_content tasks[25].id
    end

    it '26個から次のページで表示されること' do
      visit tasks_path
      click_on '次へ'
      expect(page).not_to have_content tasks[24].id
      expect(page).to have_content tasks[25].id
    end

    it '「前に」を押すと前のページがで表示されること' do
      visit tasks_path
      click_on '次へ'
      expect(page).not_to have_content tasks[24].id
      expect(page).to have_content tasks[25].id
      click_on '前へ'
      expect(page).to have_content tasks[0].id
      expect(page).to have_content tasks[24].id
      expect(page).not_to have_content tasks[25].id
    end

    it '最後のページが表示されること' do
      visit tasks_path
      click_on '最後へ'
      expect(page).not_to have_content tasks[24].id
      expect(page).to have_content tasks[25].id
    end

    it '最後のページが表示されること' do
      visit tasks_path
      click_on '最後へ'
      expect(page).not_to have_content tasks[24].id
      expect(page).to have_content tasks[25].id
      click_on '最初に戻る'
      expect(page).to have_content tasks[0].id
      expect(page).to have_content tasks[24].id
      expect(page).not_to have_content tasks[25].id
    end
  end
end
