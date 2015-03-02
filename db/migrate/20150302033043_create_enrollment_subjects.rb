class CreateEnrollmentSubjects < ActiveRecord::Migration
  def change
    create_table :enrollment_subjects do |t|
      t.references :user, index: true
      t.references :course, index: true
      t.references :subject, index: true
      t.integer :status, default: 0

      t.timestamps null: false
    end
  end
end
