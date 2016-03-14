class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.is_trainee?
      cannot :manage, Course
      cannot :manage, Subject
      can :update, UserTask, user_id: user.id
      can :manage, UserCourse
      can :manage, UserSubject
    else
      can :manage, :all 
    end
  end
end
