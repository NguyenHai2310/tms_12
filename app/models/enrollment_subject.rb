class EnrollmentSubject < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  belongs_to :subject
end
