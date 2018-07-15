class User < ApplicationRecord
	before_save { self.email = email.downcase }
	enum role: [:customer, :admin]
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }
	validates :name, presence: true, length: { maximum: 50 }
  	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: {maximum: 255 },
			  		  format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }
end


# validation for name - should not be blank
# validation for email - should not be blank, match specific email format and no duplicate emails 
# email also test for case sensitivity e.g. foo.bar = FOO.BAR and will downcase email adds before saving 
# has_secure_password method 
# - allows saving of a securely hashed password_digest attribute to the database
# - A pair of virtual attributes18 (password and password_confirmation), 
# - including presence validations upon object creation and a validation requiring that they match
# - an authenticate method that returns the user when the password is correct (and false otherwise)
