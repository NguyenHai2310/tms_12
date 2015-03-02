class Enrollment < ActiveRecord::Base
  belongs_to :user, class_name: 'User', foreign_key: :user_id
  belongs_to :course, class_name: 'Course', foreign_key: :course_id

  validates :user, presence: true
  #validates :course_id, presence: true
end