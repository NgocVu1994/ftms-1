module SessionsHelper
  def current_user? user
    user == current_user
  end

  def is_trainer? user
    user.role.name == "trainer"
  end

  def user_course
    current_user.user_courses.actived.last.course
  end
end