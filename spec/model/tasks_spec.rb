require 'rails_helper'

RSpec.describe 'Tasks', type: :model do
  describe "バリデーション確認" do
    it do
      task = Task.new()
      task.valid?
      expect(task.errors.messages[:title]).to include('を入力してください')
    end
  end
end
