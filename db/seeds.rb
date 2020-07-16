# todos

100.times do |n|
  title = Faker::Lorem.word
  created_by = Faker::Number.number(10)

  Todo.create!(title: title,
               created_by: created_by)
end

20.times do |n|
  Item.create!(name: "Test User",
               done: false,
               todo_id: 1)
end
