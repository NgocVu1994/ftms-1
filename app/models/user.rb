class User < ActiveRecord::Base

  QUERY = "id NOT IN (SELECT user_id
    FROM user_courses WHERE user_courses.course_id = :course_id AND
    user_courses.user_id IS NOT NULL)"
  belongs_to :programming_language
  belongs_to :progress
  belongs_to :status
  belongs_to :trainer, class_name: User.name, foreign_key: :trainer_id
  belongs_to :type
  belongs_to :university
  belongs_to :role

  has_many :user_courses, dependent: :destroy
  has_many :user_subjects, dependent: :destroy
  has_many :user_tasks, dependent: :destroy
  has_many :courses, through: :user_courses
  has_many :course_subjects, through: :user_subjects
  has_many :tasks, through: :user_tasks
  has_one :profile
  has_one :evaluations
  has_many :trainees, class_name: User.name
  has_many :course_leaders, class_name: UserCourse.name,
                            dependent: :destroy,
                            foreign_key: :leader_id,
                            inverse_of: :leader
  has_many :leading_courses, through: :course_leaders
  has_many :course_supervisors, class_name: UserCourse.name,
                                dependent: :destroy,
                                foreign_key: :supervisor_id,
                                inverse_of: :supervisor
  has_many :supervising_courses, through: :course_supervisors

  validates :name, presence: true, uniqueness: true
  validates_confirmation_of :password

  devise :database_authenticatable, :rememberable, :trackable, :validatable

  scope :free_trainees, ->(course_id){where QUERY, course_id: course_id}

  def total_done_tasks user, course
    done_tasks = UserSubject.load_user_subject(user.id, course.id).map(&:user_tasks).flatten.count
  end

  def owner_course course
    return course.user_courses.find_by(supervisor_id: self.id) ? true :false
  end

  def leader_course course
    return course.user_courses.find_by(leader_id: self.id) ? true :false
  end

  private
  def password_required?
    new_record? ? super : false
  end
end
