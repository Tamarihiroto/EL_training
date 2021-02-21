FactoryBot.define do
  sequence :task_id do |i|
    "500#{i}"
  end
    
  factory :task do
    id { generate :task_id }
    title { "title" }
    content { 'content' }
  end
end
