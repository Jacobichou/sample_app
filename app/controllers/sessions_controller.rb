class SessionsController < ApplicationController

	def new
	end

	def create
		# user = User.find_by_email(params[:session][:email].downcase)
		# if user && user.authenticate(params[:session][:password])
		# 	# sign user in
		# 	sign_in user
		# 	redirect_to user
		# else
		# 	# create error msg
		# 	flash.now[:error] = 'Invalid email/password combination'
		# 	render 'new'
		# end

		user = User.find_by_email(params[:email].downcase)
		if user && user.authenticate(params[:password])
			sign_in user
			redirect_back_or root_url
			# flash.now.alert = "Welcome, #{user.name}." 
		else
			flash.now[:error] = "Invalid email or password"
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_url, notice: "Successfully logged out. Good bye!"
	end

end
