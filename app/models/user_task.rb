class UserTask < ActiveRecord::Base
  include PublicActivity::Model
  
  tracked only: [:create],
    owner: ->(controller, model) {controller.current_user},
    recipient: ->(controller, model) {model.user_subject.course_subject}
  has_many :activities, as: :trackable, class_name: "PublicActivity::Activity", dependent: :destroy

  belongs_to :task
  belongs_to :user_subject
  belongs_to :user

  before_create :init_relation_user

  private
  def init_relation_user
    self.user_id = self.user_subject.user_id
  end
end
