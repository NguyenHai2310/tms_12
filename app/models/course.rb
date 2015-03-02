class Course < ActiveRecord::Base
  after_save :enrollment_subject_create
  has_many :enrollments, class_name: 'Enrollment',
                         foreign_key: 'course_id',
                         dependent: :destroy
  has_many :users, through: :enrollments
  has_many :course_subjects, class_name: 'CourseSubject',
                             foreign_key: 'course_id',
                             dependent: :destroy
  has_many :subjects, through: :course_subjects
  has_many :enrollment_subjects, dependent: :destroy

  accepts_nested_attributes_for :enrollments, allow_destroy: true
  accepts_nested_attributes_for :course_subjects, allow_destroy: true

  validates :content, presence: true, length: {maximum: 140}
  validates :name, presence: true, length: {maximum: 50}

  scope :attending_courses, ->{includes(:enrollments).where(enrollments: {status: [0, 1]})}
  scope :finished_courses, ->{includes(:enrollments).where(enrollments: {status: 2})}

  def user_course_id user
    Enrollment.where(course: self, user: user).first.try :id
  end

  def subject_course_id subject
    CourseSubject.where(course: self, subject: subject).first.try :id
  end

  def enrollment_subject_create
    if !self.start_at.nil? && self.finish_at.nil?
      self.enrollments.update_all status: 1
      self.course_subjects.each do |course_subject|
        self.users.each do |user|
          self.enrollment_subjects.create! subject: course_subject.subject,
                                           user: user,
                                           status: 0
        end
      end
    elsif !self.finish_at.nil? && !self.start_at.nil?
      self.enrollments.update_all status: 2
      self.enrollment_subjects.update_all status: 2
    end
  end
end