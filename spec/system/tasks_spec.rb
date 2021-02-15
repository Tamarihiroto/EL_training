require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  it "降順確認" do
    visit "/tasks"
    task = Task.all.order(created_at: :desc)
    expect(task.ids).to eq  [49, 50, 48, 47, 46, 45, 44, 43, 42, 41, 40, 39, 38, 37, 36, 35, 34, 33, 32, 31, 29, 28, 27, 24, 23, 22, 21, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 4, 3, 2, 1]
  end
end
