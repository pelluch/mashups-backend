class User < ActiveRecord::Base
	before_save      :generate
	has_secure_password

	validates_uniqueness_of :name, :mail
	validates 	:name, :password, :mail, presence: true
	validates 	:name, length: { minimum: 4, maximum: 20 }
	validates 	:password, length: { minimum: 8, maximum: 20 }
	validates 	:mail, format: { with: /\A[\w__.+-]+@[\w]+\.[\w]{2,4}+\Z/}
	validates 	:name, format: { with: /\A[-a-z]+\Z/ }
	
	has_many	:mashups

	def generate
		self.token = SecureRandom.hex
	end

	def destroy
		self.token = ''
	end

	def validate(token)
		puts "#{token} sd #{self.token} "
		if token != self.token || self.token == ''
			return false
		else
			return true
		end
	end

	def self.create_with_omniauth(auth)
	  create! do |user|
	    user.provider = auth['provider']
	    user.uid = auth['uid']
	    if auth['info']
	      user.name = auth['info']['name'] || ""
	      user.email = auth['info']['email'] || ""
	    end
	  end
	end

end
