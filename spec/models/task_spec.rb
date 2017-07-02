require 'rails_helper'

RSpec.describe Task, type: :model do
  task1 = Task.new(complete: false)
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

  describe '#toggle_favorite!' do
    it "should switch to false if favorite began as true" do
      task = Task.new(favorite: true)
      task.toggle_favorite!
      expect(task.favorite).to eq(false)
    end

    it "should switch to true if favorite began as false" do
      task = Task.new(favorite: false)
      task.toggle_favorite!
      expect(task.favorite).to eq(true)
    end
  end

  describe "#overdue?" do
    it "should return true if the current time is past the deadline" do
      task = Task.new(deadline: 10.days.ago)
      expect(task.overdue?).to eq(true)
    end

    it "should return false if the deadline hasn't passed yet" do
      task = Task.new(deadline: 10.days.from_now)
      expect(task.overdue?).to eq(false)
    end
  end

  describe '#increment_priority!' do
    it "should increase the priority by 1 if it is less than 10" do
      task = Task.new(priority: 6)
      task.increment_priority!
      expect(task.priority).to eq(7)
    end

    it "should not increase the priority if it's already 10" do
      task = Task.new(priority: 10)
      task.increment_priority!
      expect(task.priority).to eq(10)
    end
  end

  describe '#decrement_priority!' do
    it "should decrease the priority by 1 if it is greater than 1" do
      task = Task.new(priority: 10)
      task.decrement_priority!
      expect(task.priority).to eq(9)
    end

    it "should remain at 1 if priority is already 1" do
      task = Task.new(priority: 1)
      task.decrement_priority!
      expect(task.priority).to eq(1)
    end
  end

  describe '#snooze_hour!' do
    it "should increase the deadline by 1 hour" do
      current_time = Time.now
      task = Task.new(deadline: current_time)
      task.snooze_hour!
      expect(task.deadline).to eq(current_time + 1.hour)
    end
  end

end
