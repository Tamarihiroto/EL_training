require 'rails_helper'

RSpec.describe 'Tasks', type: :model do
  describe 'バリデーション確認' do
    context '正常系' do
      context 'タイトルがあり、内容が280字未満の場合' do
        let(:task) { build(:task, title: 'a', content: 'a' * 280) }
        it do
          expect(task).to be_valid
        end
      end
    end

    context '異常系' do
      let(:task) { build(:task, title: title, content: content) }
      context 'タイトルがない場合' do
        let(:title) { nil }
        let(:content) { 'a' }
        it '無効であること' do
          task.valid?
          expect(task).to be_invalid
          expect(task.errors.messages[:title]).to include('を入力してください')
        end
      end

      context '内容が280字以上の場合' do
        let(:title) { 'a' }
        let(:content) { 'a' * 281 }
        it '無効であること' do
          task.valid?
          expect(task).to be_invalid
          expect(task.errors.messages[:content]).to include('は280文字以内で入力してください')
        end
      end
    end
  end
end
