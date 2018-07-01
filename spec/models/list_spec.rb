require 'rails_helper'

RSpec.describe List, type: :model do
  describe '#complete_all_tasks!' do
    it 'should mark all tasks from the list as complete' do 
      list = List.create(name: "Chores")
      task_1 = Task.create(complete: false, list_id: list.id, name: "Take out Trash")
      task_2 = Task.create(complete: false, list_id: list.id, name: "Feed the fish")
      list.complete_all_tasks!

      list.tasks.each do |task|
        expect(task.complete).to eq(true)
      end
    end
  end

  describe '#snooze_all_tasks!' do 
    it 'should add an hour to the deadline of each task' do 
      task_datas = [
                     {name: "Shubert Theatre", time: Time.now},
                     {name: "Central Park", time: 3.hours.from_now},
                     {name: "Rockafeller Center", time: 5.days.ago}
                    ]

      list = List.create(name: "Places to Visit on Broadway")

      task_datas.each do |task_data|
        Task.create(name: task_data[:name], deadline: task_data[:time], list_id: list.id)
      end

      list.snooze_all_tasks!

      list.tasks.order(:id).each_with_index do |task, index|
        expect(task.deadline).to eq(task_datas[index][:time] + 1.hour)
      end
    end
  end

  describe '#total_duration' do 
    it "should return the sum of all this list's task durations" do 
      list = List.create(name: "Bucket")
      Task.create(duration: 50, list_id: list.id)
      Task.create(duration: 100, list_id: list.id)
      Task.create(duration: 30, list_id: list.id)

      expect(list.total_duration).to eq(180)
    end
  end

  describe '#incomplete_tasks' do 
    it "should return an array of all the list's incomplete tasks" do
      list = List.create(name: "Ones")
      task_1 = Task.create(complete: true, list_id: list.id)
      task_2 = Task.create(complete: false, list_id: list.id)
      task_3 = Task.create(complete: false, list_id: list.id)
      task_4 = Task.create(complete: true, list_id: list.id)

      expect(list.incomplete_tasks).to match_array([task_3, task_2])

      list.incomplete_tasks.each do |task|
        expect(task.complete).to eq(false)
      end

      # expect(list.incomplete_tasks).to be_an Array
    end
  end

  describe '#favorite_tasks' do
    it "should return an array of all the list's favorited tasks" do
      list = List.create(name: "People to Fight")
      Task.create(list_id: list.id, favorite: true)
      Task.create(list_id: list.id, favorite: false)
      Task.create(list_id: list.id, favorite: true)
      Task.create(list_id: list.id, favorite: false)

      expect(list.favorite_tasks.count).to eq(2)

      list.favorite_tasks.each do |task|
        expect(task.favorite).to eq(true)
      end

    end
  end
end





















