class User < ActiveRecord::Base
	has_secure_password
	before_create	:generate

	validates_uniqueness_of :name, :mail
	validates 	:name, presence: true, :if => :name
	validates 	:password, presence: true, :if => :password 
	validates   :mail, presence: true, :if => :mail
	validates 	:name, length: { minimum: 4, maximum: 20 }
	validates 	:password, length: { minimum: 8, maximum: 20 }, :if => :password 	
	validates 	:mail, format: { with: /\A[\w__.+-]+@[\w]+\.[\w]{2,4}+\Z/}
	#validates 	:name, format: { with: /\A[-a-z]+\Z/ }
	
	has_many	:mashups
	
	def generate
		if self.token == nil
			self.token = SecureRandom.hex
		end
		a = Mashup.create! name: 'temporal'
		self.mashup_id = a.id
	end

	def reset_temporal
		temp = self.temporal
		temp.links.delete_all
		temp.keywords.delete_all
		temp.parameters = nil
		temp.save
	end

	def regenerate_temporal (mash)
		#self.temporal.destroy
		temp = self.temporal
		temp.links.delete_all
		temp.keywords.delete_all
      	self.generate
      	
      	self.temporal = Mashup.clonar mash
      	temp = self.temporal
      	temp.name = 'temporal'
      	temp.user_id = nil
      	temp.save
      	      	
	end

	def temporal=(mash)
		self.mashup_id = mash.id
	end

	def temporal
		Mashup.find(self.mashup_id)
	end

	def validate(token)
		puts "#{self.token} asd #{token}"
		if token != self.token || self.token == ''
			return false
		else
			return true
		end
	end

	#def self.create_with_omniauth(auth)
	 # create! do |user|
	  #  user.provider = auth['provider']
	   # user.uid = auth['uid']
	    #if auth['info']
	     # user.name = auth['info']['name'] || ""
	      #user.email = auth['info']['email'] || ""
	    #end
	  #end
	#end

end
