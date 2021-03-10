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
  describe '検索確認' do
    context '正常系' do
      let(:task) { create(:task) }
      let(:search_params_1) { {title: 'title', status: 1} }
      let(:search_params_2) { {title: 'title', status: ''} }
      let(:search_params_3) { {title: '', status: 1} }
      let(:search_params_4) { {title: nil, status: nil} }

      before do
        task
      end

      context 'titleとstatusのAND検索できること' do
        subject { Task.search(search_params_1) } 
        it { is_expected.to include(task) }
      end

      context 'titleで検索できること' do
        subject { Task.search(search_params_2) } 
        it { is_expected.to include(task) }
      end

      context 'statusで検索できること' do
        subject { Task.search(search_params_3) } 
        it { is_expected.to include(task) }
      end

      context '空白で検索するとtaskが返ってくること' do
        subject { Task.search(search_params_4) } 
        it { is_expected.to include(task) }
      end
    end
    context '異常系' do
      let(:task) { create(:task) }
      let(:search_params_1) { {title: 'title', status: 2} }
      let(:search_params_2) { {title: 'title1', status: ''} }
      let(:search_params_3) { {title: 'title1', status: 3} }

      before do
        task
      end

      context 'statusがない場合検索できないこと' do
        subject { Task.search(search_params_1) } 
        it { is_expected.not_to include(task) }
      end

      context 'titleがない場合検索できないこと' do
        subject { Task.search(search_params_2) } 
        it { is_expected.not_to include(task) }
      end

      context 'titleとstatusがない場合検索できないこと' do
        subject { Task.search(search_params_2) } 
        it { is_expected.not_to include(task) }
      end
    end
  end
end
