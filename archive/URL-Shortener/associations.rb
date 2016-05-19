#id | user_id | course_id

class Enrollment < ActiveRecord::Base
  belongs_to(
    :course,
    :class_name => "Course",
    :foreign_key => :course_id,
    :primary_key => :id
  )

  belongs_to(
    :user,
    :class_name => "User",
    :foreign_key => :user_id,
    :primary_key => :id
  )
end

class Course < ActiveRecord::Base
  has_many(
    :enrollments,
    :class_name => "Enrollment",
    :foreign_key => :course_id,
    :primary_key => :id
  )

  has_one(
    :prerequisite,
    :class_name => "Course",
    :foreign_key => :prerequisite_id,
    :primary_key => :id
  )

  has_one(
    :instructor,
    :class_name => "User",
    :foreign_key => :instructor,
    :primary_key => :id
  )

  has_many :enrolled_students, :through => :enrollments, :source => :user
end

class User < ActiveRecord::Base
  has_many(
  :enrollments,
  :class_name => "Enrollment",
  :foreign_key => :user_id,
  :primary_key => :id
  )

  has_many :enrolled_courses, :through => :enrollments, :source => :course
end