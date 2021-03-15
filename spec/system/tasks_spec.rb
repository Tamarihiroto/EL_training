require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  describe 'ソート' do
    let(:tasks) { create_list(:task, 3) }

    before do 
      tasks
    end
    
    context 'created_at' do
      it '降順になること' do
        tasks_expect = tasks.reverse
        visit tasks_path
        task_list = all('.task_id')
        task_list.each_with_index do |task, i|
          expect(task).to have_content tasks_expect[i].id
        end
      end
    end

    context 'deadline' do
      it '昇順になること' do
        visit tasks_path
        select '終了期限が近い', from: '並び替え'
        click_on '並び替え'
        task_list = all('.task_deadline')
        task_list.each_with_index do |task, i|
          expect(task).to have_content I18n.l(tasks[i].deadline, format: :short)
        end
      end

      it '降順になること' do
        tasks_expect = tasks.reverse
        visit tasks_path
        select '終了期限が遅い', from: '並び替え'
        click_on '並び替え'
        task_list = all('.task_deadline')
        task_list.each_with_index do |task, i|
          expect(task).to have_content I18n.l(tasks_expect[i].deadline, format: :short)
        end
      end
    end
    
    context 'priority' do
      it '優先度が高い順にソートされること' do
        visit tasks_path
        select '優先度が高い', from: '並び替え'
        click_on '並び替え'
        task_list = all('.task_priority')
        task_list.each_with_index do |task, i|
          expect(task).to have_content I18n.t("enums.task.priority.#{tasks[i].priority}")
        end
      end

      it '優先度が低い順にソートされること' do
        tasks_expect = tasks.reverse
        visit tasks_path
        select '優先度が低い', from: '並び替え'
        click_on '並び替え'
        task_list = all('.task_priority')
        task_list.each_with_index do |task, i|
          expect(task).to have_content I18n.t("enums.task.priority.#{tasks_expect[i].priority}")
        end
      end
    end
  end
  
  describe '検索機能' do
    let(:task_1) { create(:task, title: 'sample1', status: 'default') }
    let(:task_2) { create(:task, title: 'sample2', status: 'untouched') }
    let(:task_3) { create(:task, title: 'sample3', status: 'untouched') }
    let(:task_4) { create(:task, title: 'sample4', status: 'in_progress') }
    before { visit tasks_path }

    before do 
      task_1
      task_2
      task_3
      task_4
    end
 
    context 'タイトルとステータスを入力する場合' do
      context '正常系' do
        it 'statusで検索されること' do
          select '--', from: 'ステータス'
          click_on 'search'
          expect(page).to have_content 'sample1'
        end

        it 'titleで検索されること' do
          fill_in 'タイトル', with: 'sample1'
          click_on 'search'
          expect(page).to have_content 'sample1'
        end

        it 'タスクが見つからないこと' do
          fill_in 'タイトル', with: ''
          click_on 'search'
          expect(page).to have_content 'タスクを見つけられませんでした'
        end

        it 'titleがない場合検索できないこと' do
          fill_in 'タイトル', with: 'sample5'
          click_on 'search'
          expect(page).to have_content 'タスクを見つけられませんでした'
        end

        it 'titleがない場合検索できないこと' do
          select '完了', from: 'ステータス'
          click_on 'search'
          expect(page).to have_content 'タスクを見つけられませんでした'
        end

        it 'titleとstatusがない場合検索できないこと' do
          fill_in 'タイトル', with: 'sample5'
          select '完了', from: 'ステータス'
          click_on 'search'
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
