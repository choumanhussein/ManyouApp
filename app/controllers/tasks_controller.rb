class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def _form
  end

  def edit
  end

  def index
    @tasks = Task.all.order(title: :desc)
  end

  def new
    if params[:back]
     @task = Task.new(task_params)
   else
     @task = Task.new
   end
  end

  def show
  end
end
private

 def set_task
   @task = Task.find(params[:id])
 end

 def task_params
     params.require(:task).permit(:title, :content)
   end
