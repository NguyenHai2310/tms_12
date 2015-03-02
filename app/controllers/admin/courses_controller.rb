class Admin::CoursesController < ApplicationController
  before_action :logged_in_user
  before_action :require_admin

  def new
    @course = Course.new
  end

  def show
    @course = Course.find params[:id]
    @subjects  = @course.subjects
    @users = @course.users
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:success] = "Added new course!"
      redirect_to admin_courses_path
    else
      render :new
    end
  end

  def edit
    @course = Course.find params[:id]
  end

  def update
    @course = Course.find params[:id]
    
    if @course.update_attributes course_params
      flash[:success] = "Updated course."
      redirect_to admin_course_path @course
    else
      render :edit
    end
  end

  def index
    @courses = Course.paginate page: params[:page]
  end

  def destroy
    Course.find(params[:id]).destroy
    flash[:success] = "Deleted course!"
    redirect_to admin_courses_url
  end

  private
  def course_params
    params.require(:course).permit :name, :content, :start_at, :finish_at,
     user_ids:[], course_subjects_attributes: [:id, :subject_id, :_destroy]
  end
end