module UsersHelper
  def tasks_count(user_id)
    Task.eager_load(:user).where(users: { id: user_id }).count  
  end
end
