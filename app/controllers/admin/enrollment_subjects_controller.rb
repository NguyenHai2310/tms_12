class Admin::EnrollmentSubjectsController < ApplicationController
  before_action :logged_in_user
  before_action :require_admin
end