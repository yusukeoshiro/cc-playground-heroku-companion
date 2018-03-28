class ApiController < ApplicationController
	skip_before_filter :verify_authenticity_token

	# try to find the user name and password match and return the user information if  there is match
	# otherwise return null
	def login
		payload = JSON.parse request.raw_post
		user_name = payload["user_name"]
		password = payload["password"]
		user = User.where("user_name = ? AND password = ?", user_name, password)
		render :json => user || {}
	end


	# try to create a new user
	# and return the user object in json
	def user_new
		payload = JSON.parse request.raw_post
		user_name = payload["user_name"]
		password = payload["password"]
		user = User.find_by_user_name user_name
		if user
			render :json => {"error" => "user already exists"}, :status => :bad_request
		else
			user = User.new
			user.user_name = user_name
			user.password = password
			user.save
			render :json => user || {}
		end
	end


	def user_get
		user_id = params[:user_id]
		user = User.find_by_id user_id

		if user.count.present?
			user.count += 1
		else
			user.count = 1
		end
		user.save

		render :json => user || {}
	end



end
