FactoryBot.define do
  sequence :task_deadline do |i|
    Time.zone.now + i.day
  end

  sequence :task_priority do |i|
    (i - 1) % 3
  end

  factory :task do
    title { "title" }
    content { 'content' }
    deadline { generate :task_deadline }
    status { 'untouched' }
    priority { generate :task_priority }
  end
end
