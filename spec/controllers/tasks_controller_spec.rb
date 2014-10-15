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
    it "edits task assigned to @task"
    it "renders edit page"
  end

  describe 'PUT update' do 
    context "valid attributes" do 
      it "locates requested @task"  
      it "changes @task's attributes" 
      it "re-directs to :show" 
    end

    context "invalid attributes" do
      it "locates requested @task"
      it "does not change @task's attributes"
      it "re-renders :edit"
    end
  end

  describe "GET index" do   
    it "populates an array of tasks"
    it "renders :index"
  end

  describe 'DELETE destroy' do
    context "delete one task" do
      it "deletes the task"
      it "re-directs to :show"
    end

    context "delete the entire task list" do
      it "deletes the entire list of tasks"
      it "re-directs to :show"
    end
  end
end



