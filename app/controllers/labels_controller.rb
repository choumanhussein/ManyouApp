class LabelsController < ApplicationController
  before_action :set_label, only: [:edit, :update, :destroy]
  def new
    @label = Label.new
  end

  def index
    @labels = Label.all
  end

  def create
    @label = Label.new(label_params)
    if @label.save
      redirect_to labels_path
      flash[:success] =  "Label Was Successfuly created !"
    else
      flash.now[:danger] = 'Label is not created!'
      render :new
    end
  end

  def update
    if @label.update(label_params)
      flash[:success] = 'Label updated !'
      redirect_to labels_path
    else
        flash.now[:danger] = 'Label not updated !'
      render :edit
    end
  end

  def destroy
    @label.destroy
    flash[:success] = 'Label deleted !'
    redirect_to labels_path
  end

  def edit
  end

  def show
  end
  private

   def set_label
     @label = Label.find(params[:id])
   end


   def label_params
     params.require(:label).permit(:name)
   end

end
