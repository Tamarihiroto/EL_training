FactoryBot.define do
  factory :task do
    title { "title" }
    content { 'content' }
    status { 'untouched' }
    priority { 'undefine' }
  end
end
