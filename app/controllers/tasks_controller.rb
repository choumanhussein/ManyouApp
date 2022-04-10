class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :current_user
  before_action :authenticate_user
  before_action :logged_in?
  before_action :set_labels, only: [:new, :create, :edit, :update]
   PER = 8
  def show
  end

  def edit
  end

  def index
    if logged_in?
   @tasks = Task.where(user_id: current_user.id)
   @tasks = @tasks.joins(:labels).where(labels: { id: params[:label_id] }) if params[:label_id].present?
   if params[:title].blank? && params[:status].blank?
     @tasks = @tasks.page(params[:page]).per(PER)
     @tasks = @tasks.where(user_id: current_user.id)
     if params[:sort_expired].blank? && params[:sort_priority].blank?
       @tasks = @tasks.order(created_at: :desc)
       @tasks = @tasks.where(user_id: current_user.id)
     elsif params[:sort_expired].blank?
       @tasks = @tasks.order(priority: :asc)
       @tasks = @tasks.where(user_id: current_user.id)
     else
       @tasks = @tasks.order(expired_at: :desc)
       @tasks = @tasks.where(user_id: current_user.id)
     end
   elsif params[:title].blank?
     @tasks = Task.page(params[:page]).per(PER).where('status LIKE ?', "%#{params[:status]}%" )
     @tasks = @tasks.where(user_id: current_user.id)
     flash[:notice] = " search result for '#{params[:status] }' "
      elsif params[:status].blank?
         @tasks = Task.page(params[:page]).per(PER).where('title LIKE ?', "%#{params[:title]}%")
         @tasks = @tasks.where(user_id: current_user.id)
        flash[:notice] = "search result for '#{params[:title]}' "
      else
        @tasks = Task.page(params[:page]).per(PER).where('title LIKE ? AND status LIKE ?', "%#{params[:title]}%", "%#{params[:status]}%" )
        @tasks = @tasks.where(user_id: current_user.id)
        flash[:notice] = "search result for '#{params[:title]}' and '#{params[:status]}' "
      end
    else
   redirect_to sessions_new_path
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
       redirect_to tasks_path
       flash[:success] =  "User " + current_user.name + " has created a task !"
     else
       flash.now[:danger] = 'Task cannot be created !'
       render :new
     end
   end
 end

  def update
    task.tasklabels.delete_all unless params[:task][:label_ids]
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
    flash[:success] = 'Task deleted !'
    redirect_to tasks_path
  end


  private

  def set_labels
     @labels = Label.all
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
  def task_search_params
     params.fetch(:search, {}).permit(:title, :status, :label_id )
   end
  def task_params
    params.require(:task).permit(:title, :content, :duedate, :priority, :status, :id, label_ids:[])
  end
end
