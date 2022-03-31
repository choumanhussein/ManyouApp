FactoryBot.define do
  factory :task do
    title { 'test1' }
    content { 'content test 1' }
    duedate { '2022-03-30 11:00:00' }
  end
  factory :second_task, class: Task do
    title { 'test2' }
    content { 'content test 2' }
    duedate{ '2022-03-30 20:00:00' }
  end
  factory :third_task, class: Task do
    title { 'sample3' }
    content { 'sample 3' }
    duedate{ '2022-03-31 19:00:00' }
  end
end
