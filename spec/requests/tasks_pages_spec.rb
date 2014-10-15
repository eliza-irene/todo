require 'spec_helper'

describe "tasks_pages" do
  
  subject { page }

  describe "show page GET /tasks/:id" do
    let(:my_task) { Task.create(title: "Do the dishes")}
    before { visit task_path(my_task.id) }
    it { should have_title("Todo | Show Task") }

    it { should have_selector('h1', "I need to...") }
    it { should have_selector('p', my_task.title)}
  end

  describe "new page GET /tasks/new" do
    before { visit new_task_path }
  
    it { should have_title("Todo | New Task") }
    it { should have_selector('h1', "New Task") }

    describe "create POST /tasks" do
      let(:submit) { "Save" }
    
      context "valid information" do
        before do
          visit new_task_path
          fill_in "Title",     with: "Walk the dog"
          check "task_completed"
          fill_in "Due at",    with: 2.weeks.from_now.to_date
        end

        it "creates task" do
          expect { click_button submit }.to change(Task, :count).by(1)
        end

        describe "after submission" do
          before { click_button submit }

          #redirect to :show
          it { should have_title("Todo | Show Task")}
          it { should have_selector('p', "Walk the dog")}
        end
      end

      context "invalid information" do
        it "does not create a task" do
          expect { click_button submit }.not_to change(Task, :count)
        end

        describe "after submission" do
          before { click_button submit}

          it {should have_title('Todo | New Task')}
          it {should have_content('error')}
        end
      end
    end
  end
end