class SessionsController < ApplicationController
  def new
  end

	def create
		user = User.find_by_username(params[:session][:username])
		if user && user.authenticate(params[:session][:password])
			# Sign the user in and redirect to the user's show page.
      sign_in user # sign_in defined in app/helpers/sessions_helper.rb
      redirect_back_or user #redirect_back_or defined in app/helpers/sessions_helper.rb	
		else
			# Create an error message and re-render the signin form.
      flash.now[:error] = 'Invalid username/password combination'
      render 'new'			
		end
	end

  def destroy
    sign_out
    redirect_to root_url
  end
end
