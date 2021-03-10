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
        (0..2).each do |i|
          expect(task_list[i]).to have_content tasks_expect[i].id
        end
      end
    end

    context 'deadline' do
      it '昇順になること' do
        visit tasks_path
        select '終了期限が近い', from: '並び替え'
        click_on '並び替え'
        task_list = all('.task_deadline')
        (0..2).each do |i|
          expect(task_list[i]).to have_content I18n.l(tasks[i].deadline, format: :short)
        end
      end

      it '降順になること' do
        tasks_expect = tasks.reverse
        visit tasks_path
        select '終了期限が遅い', from: '並び替え'
        click_on '並び替え'
        task_list = all('.task_deadline')
        (0..2).each do |i|
          expect(task_list[i]).to have_content I18n.l(tasks_expect[i].deadline, format: :short)
        end
      end
    end
    
    context 'priority' do
      it '優先度が高い順にソートされること' do
        visit tasks_path
        select '優先度が高い', from: '並び替え'
        click_on '並び替え'
        task_list = all('.task_priority')
        (0..2).each do |i|
          expect(task_list[i]).to have_content I18n.t("enums.task.priority.#{tasks[i].priority}")
        end
      end

      it '優先度が低い順にソートされること' do
        visit tasks_path
        select '優先度が低い', from: '並び替え'
        click_on '並び替え'
        task_list = all('.task_priority')
        expect(task_list[0]).to have_content I18n.t("enums.task.priority.#{tasks[2].priority}")
        expect(task_list[1]).to have_content I18n.t("enums.task.priority.#{tasks[1].priority}")
        expect(task_list[2]).to have_content I18n.t("enums.task.priority.#{tasks[0].priority}")
      end
    end
  end 
    
  describe '検索機能' do
    let(:task_1) { create(:task, title: 'sample1', status: 'default') }
    let(:task_2) { create(:task, title: 'sample2', status: 'untouched') }
    let(:task_3) { create(:task, title: 'sample3', status: 'untouched') }
    let(:task_4) { create(:task, title: 'sample4', status: 'in_progress') }
    let(:task_5) { create(:task, title: 'sample5', status: 'done') }
    before { visit tasks_path }
 
    context 'タイトルとステータスを入力する場合' do
      before do 
        task_1
        task_2
        task_3
        task_4
        task_5
      end
      context '正常系' do
        it '--のタスクが検索されること' do
          select '--', from: 'ステータス'
          click_on 'search'
          expect(page).to have_content 'sample1'
        end
        it '未着手のタスクが検索されること' do
          select '未着手', from: 'ステータス'
          click_on 'search'
          expect(page).to have_content 'sample2'
          expect(page).to have_content 'sample3'
        end
        it '着手中のタスクが検索されること' do
          select '着手中', from: 'ステータス'
          click_on 'search'
          expect(page).to have_content 'sample4'
        end
        it '完了のタスクが検索されること' do
          select '完了', from: 'ステータス'
          click_on 'search'
          expect(page).to have_content 'sample5'
        end
      end

      context '異常系' do
        it 'タスクが見つからないこと' do
          fill_in 'タイトル', with: ''
          click_on 'search'
          expect(page).to have_content 'タスクを見つけられませんでした'
        end
      end
    end
  end
end
