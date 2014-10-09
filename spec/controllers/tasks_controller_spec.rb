# 1. Create a GET tasks / show page when the user visits /tasks/:id (aka visits /tasks/3)

require 'spec_helper'

describe TasksController, type: :controller do 
  describe "GET show" do
    before { @task = Task.create(title: "Walk Milo", location: "Piedmont Park", due_at: "2014-10-10")}

    it "renders show page" do
      get :show, id: @task.id
      expect(response).to render_template(:show)
    end

    it "assigns requested task to @task" do
      get :show, id: @task.id
      assigns(:task).should eq(@task)
    end
  end

  describe "GET index" do   
    it "populates an array of tasks"
    it "renders index page"
  end

  describe "GET new" do
    it "assigns new task to @task" 
    it "renders new task page" 
  end 

  describe "GET edit" do
    it "edits task assigned to @task"
    it "renders edit page"
  end

  describe 'PUT update' do 
    context "valid attributes" do 
      it "locates requested @task"  
      it "changes @task's attributes" 
      it "redirects to the updated task" 
    end

    context "invalid attributes" do
      it "locates requested @task"
      it "does not change @task's attributes"
      it "re-renders edit page"
    end
  end

  describe "POST create" do 
    context "with valid attributes" do 
      it "creates new task" 
      it "redirects to new task"
    end

    context "with invalid attributes" do 
      it "doesn't create new task" 
      it "re-renders new page"
    end
  end

  describe 'DELETE destroy' do
    context "delete one task" do
      it "deletes the task"
      it "re-directs to index page"
    end

    context "delete the entire task list" do
      it "deletes the entire list of tasks"
      it "re-directs to index page"
    end
  end
end




