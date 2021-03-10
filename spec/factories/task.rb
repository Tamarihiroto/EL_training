FactoryBot.define do
  sequence :task_deadline do |i|
    Time.zone.now + i.day
  end

  factory :task do
    title { "title" }
    content { 'content' }
    deadline { generate :task_deadline }
    status { 'untouched' }
  end
end
