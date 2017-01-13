class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  def verify_jwt_token
    if user_jwt_present?
      user = get_jwt_user()
      if user.present?
        return user
      else
        head :not_found
      end
    else
      head :unauthorized
    end
  end
  def get_jwt_user
    return nil if !user_jwt_present?
    
    data = AuthToken.get_data(request.headers['Authorization'].split(' ').last)
    return User.find_by(uuid: data["uuid"])
  end
  def user_jwt_present?
    return request.headers['Authorization'].present? &&
      AuthToken.valid?(request.headers['Authorization'].split(' ').last)
  end

  def not_found
		raise ActionController::RoutingError.new('Not Found')
	end
  def unauthorized_page
    render file: "public/401.html", status: :unauthorized
  end
end
