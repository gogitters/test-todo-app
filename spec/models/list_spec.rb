require 'rails_helper'

RSpec.describe List, type: :model do
  describe '#complete_all_tasks!' do
    it "should mark all tasks from the list as complete" do
      list = List.create(name: "Go Gitters")
      Task.create(complete: false, list_id: list.id, name: "Write some rspec tests")
      Task.create(complete: false, list_id: list.id, name: "Eat some donuts")
      list.complete_all_tasks!
      expect(list.tasks.count).to eq(2)
      list.tasks.each do |task|
        expect(task.complete).to eq(true)
      end
    end
  end
end
