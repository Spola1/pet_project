module ControllerHelpers
  def login(user)
    session[:user_id] = user.id
  end
end
