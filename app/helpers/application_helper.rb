module ApplicationHelper
  def is_admin?
    not session[:user_id].nil?
  end
end
