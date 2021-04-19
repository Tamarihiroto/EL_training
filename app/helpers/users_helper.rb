module UsersHelper
  def tasks_count(user_id)
    Task.where(user_id: user_id).count
  end
end
