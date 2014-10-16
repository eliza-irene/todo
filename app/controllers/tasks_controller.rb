class TasksController  < ApplicationController

def show
  @task = Task.find(params[:id])
end

def new
  @task = Task.new
end

def create
  @task = Task.new(task_params)
  if @task.save
    redirect_to task_path(@task.id), notice: "You have created a new task!"
  else
    render 'new'
  end
end

def index
  @tasks = Task.all
end

def edit
  @task = Task.find(params[:id])
end

def update
  @task = Task.find(params[:id])
  if @task.update_attributes(task_params)
    redirect_to task_path(@task.id), notice: "You have updated your task!"
  else
    render 'edit'
  end
end

def destroy
  @task = Task.find(params[:id])
  @task.destroy
  redirect_to tasks_path, notice: "You have deleted your task!"  
end

  private
    def task_params
      params.require(:task).permit(:title, :completed, :due_at)
    end

end