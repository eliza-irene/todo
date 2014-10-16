# 1. Create a GET tasks / show page when the user visits /tasks/:id (aka visits /tasks/3)

require 'spec_helper'

describe TasksController, type: :controller do 
  describe "GET show" do
    let(:task) { Task.create(title: "Walk Milo", location: "Piedmont Park", due_at: "2014-10-10")}

    it "renders :show" do
      get :show, id: task.id
      expect(response).to render_template(:show)
    end

    it "assigns requested task to @task" do
      get :show, id: task.id
      #assigns @task to eq task that we defined on line 5
      assigns(:task).should eq(task)
    end
  end

  describe "GET new" do
    it "renders :new" do
      get :new
      expect(response).to render_template(:new)
    end

    it "assigns new Task to @task" do
      get :new
      assigns(:task).should be_a_new(Task)
    end
  end 

describe "POST create" do
  context "with valid attributes" do
    it "saves the new Task to @task" do
      #when I post to the create action, change Task.count by 1, aka add 1 to the tasks db
      expect{
        post :create, task: { title: "Walk the dog" }
      }.to change(Task, :count).by(1)
    end
    
    it "redirects to :show" do
      post :create, task: { title: "Walk the dog" }
      last_task = Task.last
      expect(response).to redirect_to(task_path(last_task.id))
    end
  end
    
  context "with invalid attributes" do
    it "does not save the new Task to @task" do
      expect{
        post :create, task: { title: "" }
      }.to_not change(Task, :count)
    end

    it "re-renders :new" do
      post :create, task: { title: "" }
      expect(response).to render_template(:new)
    end
  end
end

  describe "GET edit" do
    let(:task) { Task.create(title: "Walk the dog") }

    it "renders :edit" do
    get :edit, id: task.id 
    expect(response).to render_template(:edit)
    end

    it "assigns requested task to @task" do
      get :edit, id: task.id
      assigns(:task).should eq(task)
    end
  end

  describe 'PUT update' do 
    let(:task) { Task.create(title: "Do the dishes") }

    context "valid attributes" do

      it "changes @task's attributes" do
        put :update, id: task.id, task: { title: "Walk the dog" }
        task.reload
        expect(task.title).to eq("Walk the dog")
      end

      it "re-directs to :show" do
        post :update, id: task.id, task: { title: "Walk the dog" }
        last_task = Task.last
        expect(response).to redirect_to(task_path(last_task.id))
      end
    end

    context "invalid attributes" do

      it "does not change @task's attributes" do
        put :update, id: task.id, task: { title: " " }
        task.reload
        expect(task.title).to eq("Do the dishes")
      end

      it "re-renders :edit" do
        put :update, id: task.id, task: { title: " " }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "GET index" do   
    before { Task.destroy_all } 
    let(:first_task) { Task.create(title: "Walk the dog")}
    let(:second_task) { Task.create(title: "Buy groceries")}

    it "renders :index" do
      get :index
      expect(response).to render_template(:index)
    end

    it "assigns all tasks to @tasks as an array" do
      get :index
      assigns(:tasks).should eq( [first_task, second_task] ) #may be reversed order
    end
  end

  describe 'DELETE destroy' do
    let!(:task) { Task.create(title: "Walk the dog") }

    it "deletes the requested task" do
      expect {
        delete :destroy, id: task.id
      }.to change(Task, :count).by(-1)
    end

    it "re-directs to :index" do
      delete :destroy, id: task.id
      expect(response).to redirect_to(tasks_path)
    end
  end
end




