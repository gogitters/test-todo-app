require 'rails_helper'

RSpec.describe Task, type: :model do
  describe '#toggle_complete!' do
    it "should switch to false if complete began as true" do
      task = Task.new(complete: true)
      task.toggle_complete!
      expect(task.complete).to eq(false)
    end

    it "should switch to true if complete began as false" do
      task = Task.new(complete: false)
      task.toggle_complete!
      expect(task.complete).to eq(true)
    end
  end
end
