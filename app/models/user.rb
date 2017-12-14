class User < ActiveRecord::Base

	after_initialize :set_uuid , if: :new_record?


	private 

	def set_uuid
		self.uuid = SecureRandom.uuid
	end


end
