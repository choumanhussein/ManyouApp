class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :current_user
  before_action :authenticate_user
  before_action :logged_in?
   PER = 8
  def show
  end

  def edit
  end

  def index
      if params[:title].blank? && params[:status].blank?
        @tasks = Task.page(params[:page]).per(PER)
        if params[:duedate].blank? && params[:sort_priority].blank?
          @tasks = @tasks.order(created_at: :desc)
        elsif params[:duedate].blank?
          @tasks = @tasks.order(priority: :asc)
        else
          @tasks = @tasks.order(expired_at: :desc)
        end
      elsif params[:title].blank?
        @tasks = Task.page(params[:page]).per(PER).where('title LIKE ? AND status LIKE ?', "%#{params[:title]}%", "%#{params[:status]}%" )
        flash[:notice] = " search result for '#{params[:status] }' "
      elsif params[:status].blank?
         @tasks = Task.page(params[:page]).per(PER).where('title LIKE ?', "%#{params[:title]}%")
        flash[:notice] = "search result for '#{params[:title]}' "
      else
        @tasks = Task.page(params[:page]).per(PER).where('title LIKE ? AND status LIKE ?', "%#{params[:title]}%", "%#{params[:status]}%" )
        flash[:notice] = "search result for '#{params[:status]}' and '#{params[:title]}' "
      end
    end

  def new
     if params[:back]
       @task = Task.new(task_params)
       @task.duedate = Date.today
     else
       @task = Task.new
     end
   end

  def create
    @task = current_user.tasks.build(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        flash[:success] = 'Task created'
        redirect_to tasks_path
      else
        flash.now[:danger] = 'Task cannot be created'
        render :new
      end
    end
  end

  def update
      if @task.update(task_params)
        flash[:success] = 'Task updated'
        redirect_to tasks_path
      else
        flash.now[:danger] = 'Task not updated'
        render :edit
      end
    end

  def destroy
    @task.destroy
    flash[:success] = 'Task deleted'
    redirect_to tasks_path
  end


  private
  def set_task
    @task = current_user.tasks.find(params[:id])
  end
  def task_search_params
     params.fetch(:search, {}).permit(:title, :status )
   end
  def task_params
    params.require(:task).permit(:title, :content, :duedate, :priority, :status, :id)
  end
end
