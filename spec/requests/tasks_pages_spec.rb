require 'spec_helper'

describe "tasks_pages" do
  
  subject { page }

  describe "show page GET /tasks/:id" do
    let(:my_task) { Task.create(title: "Do the dishes")}
    before { visit task_path(my_task.id) }
    it { should have_title("Todo | Show Task") }

    it { should have_selector('h1', "I need to...") }
    it { should have_selector('p', text: my_task.title)}
  end

  describe "new page GET /tasks/new" do
    before { visit new_task_path }
  
    it { should have_title("Todo | New Task") }
    it { should have_selector('h1', text: "New Task") }

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
          it { should have_selector('p', text: "Walk the dog")}
        end
      end

      context "invalid information" do
        it "does not create a task" do
          expect { click_button submit }.not_to change(Task, :count)
        end

        describe "after submission" do
          before { click_button submit}

          it {should have_title('Todo | New Task')}
          # it {should have_content('error')}
        end
      end
    end
  end

  describe "index page GET /tasks" do
    before { visit tasks_path }
    let(:task) { Task.create(title: "Walk the dog") }

    it {should have_title( 'Todo | My Tasks')}
    it { should have_selector('h1', text: "All Tasks" )}

    describe "destroy DELETE /tasks/:id" do
    
      it { should have_link('Delete', href: task_path(Task.first)) }

      it "destroys the task" do
        expect {
          click_link('Delete', match: :first)
        }.to change(Task, :count).by(-1)
      end
    end
  end

  describe "edit page GET /tasks/:id/edit" do
    let(:task) { Task.create(title: "Walk the dog") }

    before { visit edit_task_path(task.id) }

    it { should have_title( 'Todo | Edit Task')}
    it { should have_selector('h1', 'Edit Task')}

    describe "update PUT /tasks/:id" do
      let (:submit) { "Save" }

      context "valid information" do
        before do
          fill_in "Title", with: "Walk the dog"
          click_button submit
        end

        it { should have_title( 'Todo | Show Task')}
        it { should have_selector('p'), text: "Walk the dog"}
        specify { expect(task.reload.title).to eq("Walk the dog") }
      end

      context "invalid information" do
        before do 
          fill_in "Title", with: " "
          click_button submit
        end

        it {should have_title('Todo | Edit Task') }
        # it { should have_content('error') }
      end
    end
  end
end
