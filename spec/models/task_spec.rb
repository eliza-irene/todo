require 'spec_helper'

describe Task do 
  before { @task = Task.new(title: "Walk the dog", completed: true, location: "the park") }
    
  subject { @task }

  it { should respond_to(:location)}
  it { should respond_to(:completed) }
  it { should respond_to(:title) }
  it { should be_valid }

  describe "validations" do
    describe "title" do
      describe "not present" do
        before { @task.title = " " }
        it { should_not be_valid}
      end

      describe "too short" do
        before { @task.title = "a" * 2}
        it { should_not be_valid}
      end

      describe "too long" do
        before { @task.title = "a" * 255 }
        it { should_not be_valid}
      end
    end

    describe "completed" do
      it "false by default" do
        new_task = Task.new(title: "Walk the dog")
        expect(new_task.completed).to eq(false)
      end
    end

    describe "location" do
      describe "not present" do
        before { @task.location = " " }
        it { should be_valid }
      end

      describe "too long" do
        before { @task.location = "a" * 255 }
        it { should_not be_valid}
      end
    end

    describe "due_at" do
      it "todays date by default" do
        new_task = Task.new(title: "Walk the dog") 
        expect(new_task.due_at).to eq(Date.today)
      end

      #location regex - users need to enter a full address if they want to be able to link to
    end


  end
end
