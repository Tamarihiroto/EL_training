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
      task_list = all('.task_id')
      expect(task_list[0]).to have_content tasks_expect[0].id
      expect(task_list[1]).to have_content tasks_expect[1].id
      expect(task_list[2]).to have_content tasks_expect[2].id
    end

    it 'deadlineの昇順になること' do
      visit tasks_path
      select '終了期限が近い', from: '並び替え'
      click_on '並び替え'
      task_list = all('.task_deadline')
      expect(task_list[0]).to have_content I18n.l(tasks[0].deadline, format: :short)
      expect(task_list[1]).to have_content I18n.l(tasks[1].deadline, format: :short)
      expect(task_list[2]).to have_content I18n.l(tasks[2].deadline, format: :short)
    end

    it 'deadlineの降順になること' do
      tasks_expect = tasks.reverse
      visit tasks_path
      select '終了期限が遅い', from: '並び替え'
      click_on '並び替え'
      task_list = all('.task_deadline')
      expect(task_list[0]).to have_content I18n.l(tasks_expect[0].deadline, format: :short)
      expect(task_list[1]).to have_content I18n.l(tasks_expect[1].deadline, format: :short)
      expect(task_list[2]).to have_content I18n.l(tasks_expect[2].deadline, format: :short)
    end
  end
  describe '検索機能' do
    let(:task_1) { create(:task, title: 'sample1', status: 'default') }
    let(:task_2) { create(:task, title: 'sample2', status: 'untouched') }
    let(:task_3) { create(:task, title: 'sample3', status: 'untouched') }
    let(:task_4) { create(:task, title: 'sample4', status: 'in_progress') }
    let(:task_5) { create(:task, title: 'sample5', status: 'done') }
    before { visit tasks_path }

    before do 
      task_1
      task_2
      task_3
      task_4
      task_5
    end
 
    context 'タイトルとステータスを入力する場合' do
      context '正常系' do
        it '--のタスクが検索されること' do
          fill_in 'タイトル', with: 'sample'
          select '--', from: 'ステータス'
          click_on 'search'
          expect(page).to have_content 'sample1'
        end
        it '未着手のタスクが検索されること' do
          fill_in 'タイトル', with: 'sample'
          select '未着手', from: 'ステータス'
          click_on 'search'
          expect(page).to have_content 'sample2'
          expect(page).to have_content 'sample3'
        end
        it '着手中のタスクが検索されること' do
          fill_in 'タイトル', with: 'sample'
          select '着手中', from: 'ステータス'
          click_on 'search'
          expect(page).to have_content 'sample4'
        end
        it '完了のタスクが検索されること' do
          fill_in 'タイトル', with: 'sample'
          select '完了', from: 'ステータス'
          click_on 'search'
          expect(page).to have_content 'sample5'
        end
      end

      context '異常系' do
        it 'タスクが見つからないこと' do
          fill_in 'タイトル', with: ''
          select '--', from: 'ステータス'
          click_on 'search'
          expect(page).to have_content 'sample1'
          expect(page).to have_content 'sample2'
          expect(page).to have_content 'sample3'
          expect(page).to have_content 'sample4'
          expect(page).to have_content 'sample5'
          expect(page).to have_content 'タスクを見つけられませんでした'
        end
      end
    end
  end
  describe 'ページネーション' do
    let(:tasks) { create_list(:task, 21) }

    before do 
      tasks
    end
    
    it '1ページで20個まで表示されること' do
      visit tasks_path
      expect(page).not_to have_content I18n.l(tasks[0].deadline, format: :short)
      expect(page).to have_content I18n.l(tasks[1].deadline, format: :short)
      expect(page).to have_content I18n.l(tasks[20].deadline, format: :short)
    end

    it '21個から次のページで表示されること' do
      visit tasks_path
      click_on '次へ'
      expect(page).not_to have_content I18n.l(tasks[1].deadline, format: :short)
      expect(page).to have_content I18n.l(tasks[0].deadline, format: :short)
    end

    it '「前へ」を押すと前のページがで表示されること' do
      visit tasks_path
      click_on '次へ'
      expect(page).not_to have_content I18n.l(tasks[1].deadline, format: :short)
      expect(page).to have_content I18n.l(tasks[0].deadline, format: :short)
      click_on '前へ'
      expect(page).not_to have_content I18n.l(tasks[0].deadline, format: :short)
      expect(page).to have_content I18n.l(tasks[1].deadline, format: :short)
      expect(page).to have_content I18n.l(tasks[20].deadline, format: :short)
    end

    it '最後のページが表示されること' do
      visit tasks_path
      click_on '最後へ'
      expect(page).not_to have_content I18n.l(tasks[1].deadline, format: :short)
      expect(page).to have_content I18n.l(tasks[0].deadline, format: :short)
    end

    it '最後のページが表示されること' do
      visit tasks_path
      click_on '最後へ'
      expect(page).not_to have_content I18n.l(tasks[1].deadline, format: :short)
      expect(page).to have_content I18n.l(tasks[0].deadline, format: :short)
      click_on '最初に戻る'
      expect(page).not_to have_content I18n.l(tasks[0].deadline, format: :short)
      expect(page).to have_content I18n.l(tasks[1].deadline, format: :short)
      expect(page).to have_content I18n.l(tasks[20].deadline, format: :short)
    end
  end
end
