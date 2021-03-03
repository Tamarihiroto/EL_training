FactoryBot.define do
  sequence :task_deadline do |i|
    "#{i} Feb 2021 11:38:00 JST +09:00"
  end

  factory :task do
    title { "title" }
    content { "content" }
    deadline { generate :task_deadline }
  end
end
