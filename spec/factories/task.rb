FactoryBot.define do
  sequence :task_title do |i|
    "title#{i}"
  end

  factory :task do
    title { "title" }
    content { 'content' }
  end
end
