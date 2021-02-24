require 'rails_helper'

RSpec.describe 'Tasks', type: :model do
  describe "バリデーション確認" do
    it "タイトルがあり、内容が280字未満の場合" do
      task = build(:task)
      expect(task).to be_valid
    end

    it "タイトルがない場合、無効である" do
      task = build(:task, title: nil)
      task.valid?
      expect(task.errors.messages[:title]).to include('を入力してください')
    end
    
    it "内容が240字以上の場合、無効である" do
      task = build(:task, content:
       "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
       aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
       aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
       aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
       aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
       aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
       aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
       aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
       aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
       aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
       aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
       aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
       aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
      task.valid?
      expect(task.errors.messages[:content]).to include('は280文字以内で入力してください')
    end
  end
end
