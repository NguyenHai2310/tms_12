class Admin::SubjectsController < ApplicationController
  before_action :logged_in_user
  before_action :require_admin

  def index
    @subjects = Subject.paginate page: params[:page]
  end

  def new
    @subject = Subject.new
    @subject.tasks.build
  end

  def show
    @subject = Subject.find params[:id]
  end

  def destroy
    @subject = Subject.find params[:id]
    @subject.destroy
    flash[:success] = "Deleted"
    redirect_to admin_subjects_url
  end

  def edit
    @subject = Subject.find params[:id]
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash[:success] = "Added new subject"
      redirect_to admin_subject_path(@subject)
    else
      flash[:danger] = "Fail!"
      render :new
    end
  end

  def update
    @subject = Subject.find params[:id]
    if @subject.update_attributes subject_params
      flash[:success] = "Done!"
      redirect_to admin_subject_path(@subject)
    else
      flash[:danger] = "Fail!"
      render :edit  
    end
  end

  private
  def subject_params
    params.require(:subject).permit :name, :content, tasks_attributes: [:name, :id, :_destroy]
  end
end