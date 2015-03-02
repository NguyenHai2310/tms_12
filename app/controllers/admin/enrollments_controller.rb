class Admin::EnrollmentsController < ApplicationController
  before_action :logged_in_user
  before_action :require_admin
  
  def new
    @course = Course.find params[:course_id]
    @enrollment = @course.enrollments.new
    @users = User.all
  end
end