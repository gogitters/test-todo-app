require 'rails_helper'

RSpec.describe List, type: :model do
  let(:list) { List.create(name: "Go Gitters")}
  describe '#complete_all_tasks!' do
    it "should mark all tasks from the list as complete" do
      # list = List.create(name: "Go Gitters")
      Task.create(complete: false, list_id: list.id, name: "Write some rspec tests")
      Task.create(complete: false, list_id: list.id, name: "Eat some donuts")
      list.complete_all_tasks!
      expect(list.tasks.count).to eq(2)
      list.tasks.each do |task|
        expect(task.complete).to eq(true)
      end
    end
  end

  describe '#snooze_all_tasks!' do
    it "should snooze each task by 1 hour" do
      current_time = Time.now
      Task.create(deadline: current_time, list_id: list.id)
      Task.create(deadline: current_time, list_id: list.id)
      list.snooze_all_tasks!
      expect(list.tasks.count).to eq 2
      list.tasks.each do |task|
        expect(task.deadline).to eq (current_time + 1.hour)
      end
    end
  end

  describe '#total_duration' do
    it "should add up the duration of all my tasks" do
      Task.create(duration: 42, list_id: list.id)
      Task.create(duration: 100, list_id: list.id)
      expect(list.total_duration).to eq(142)
    end
  end

  describe '#incomplete_tasks' do
    it "should return an array of all incomplete tasks" do
      task1 = Task.create(list_id: list.id, complete: true)
      task2 = Task.create(list_id: list.id, complete: false)
      task3 = Task.create(list_id: list.id, complete: false)
      expect(list.incomplete_tasks.count).to eq 2
      expect(list.incomplete_tasks).to eq [task2, task3]
    end
  end

  describe '#favorite_tasks' do
    it "should return an array of all favorite tasks" do
      task1 = Task.create(list_id: list.id, favorite: false)
      task2 = Task.create(list_id: list.id, favorite: true)
      task3 = Task.create(list_id: list.id, favorite: true)
      expect(list.favorite_tasks.count).to eq 2
      expect(list.favorite_tasks).to eq [task2, task3]
    end
  end
end
