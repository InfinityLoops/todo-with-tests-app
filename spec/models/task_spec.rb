require 'rails_helper' 

RSpec.describe Task, type: :model do
  describe '#toggle_complete!' do 
    it 'should change complete to false if complete is true' do 
      task = Task.create(name: "Mow the lawn", complete: true)
      task.toggle_complete!
      expect(task.complete).to eq(false)
    end

    it 'should change complete to true if complete is false' do 
      task = Task.create(name: "Mow the lawn", complete: false)
      task.toggle_complete!
      expect(task.complete).to eq(true)
    end
  end

  describe '#toggle_favorite!' do 
    it 'should switch favorite to true if it began as false' do 
      task = Task.create(favorite: false)
      task.toggle_favorite!
      expect(task.favorite).to eq(true)
    end

    it 'should switch favorite to false if it began as true' do 
      task = Task.create(favorite: true)
      task.toggle_favorite!
      expect(task.favorite).to eq(false)
    end
  end

  describe '#overdue?' do 
    it 'should return false if deadline is later than now' do 
      task = Task.create(deadline: 1.hour.from_now)
      expect(task.overdue?).to eq(false)
    end

    it 'should return true if deadline is earlier than now' do 
      task = Task.create(deadline: 1.hour.ago)
      expect(task.overdue?).to eq(true)
    end
  end

  describe '#increment_priority!' do 
    it 'should increase priority by 1' do 
      task = Task.create(priority: 5)
      task.increment_priority!
      expect(task.priority).to eq(6)
    end

    it 'should not increase priority beyond 10' do 
      task = Task.create(priority: 10)
      task.increment_priority!
      expect(task.priority).to eq(10)
    end
  end

  describe '#decrement_priority!' do 
    it 'should decrease priority by 1' do 
      task = Task.create(priority: 5)
      task.decrement_priority!
      expect(task.priority).to eq(4)
    end

    it 'should not decrease priority beyond 1' do 
      task = Task.create(priority: 1)
      task.decrement_priority!
      expect(task.priority).to eq(1)
    end
  end

  describe '#snooze_hour!' do 
    it 'should push deadline off by 1 hour' do 
      right_now = Time.now
      task = Task.create(deadline: right_now)
      task.snooze_hour!
      expect(task.deadline).to eq(right_now + 1.hour)
    end
  end
end


















