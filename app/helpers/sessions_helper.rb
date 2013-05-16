module SessionsHelper
	def sign_in(user)
		# Under the hood, using permanent causes Rails to set the expiration to 20.years.from_now automatically.
		cookies.permanent[:remember_token] = user.remember_token
		# The purpose of this line is to create current_user, accessible in both controllers and views, 
		# which will allow constructions such as
		# <%= current_user.name %>
		# redirect_to current_user
		self.current_user = user 
	end

  def sign_out
    # Setting the current user to nil isn’t currently necessary because of the immediate redirect in the destroy action, 
    # but it’s a good idea in case we ever want to use sign_out without a redirect.
    self.current_user = nil
    cookies.delete(:remember_token)
  end

	# self.current_user = ...
	# is automatically converted to 
	# current_user=(...)
  def current_user=(user)
    @current_user = user
  end	

  # sets the @current_user instance variable to 
  # the user corresponding to the remember token, 
  # but only if @current_user is undefined.

  # calls the find_by_remember_token method the first time current_user is called, 
  # but on subsequent invocations returns @current_user without hitting the database.
  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def signed_in?
    !current_user.nil?
  end  
end
