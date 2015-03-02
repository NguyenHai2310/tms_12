class SubjectsController < ApplicationController
  def index
    @subjects = Subject.paginate page: params[:page]
  end

  def show
    @subject = Subject.find params[:id]
  end

  private
  def subject_params
    params.require(:subject).permit :name, :content, tasks_attributes: [:name]
  end
end