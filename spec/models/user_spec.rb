require 'rails_helper'

RSpec.describe User, type: :model do

	context "validations" do 
   		it { should validate_presence_of(:name) }
  		it { should have_secure_password }
  		it { validate_acceptance_of(:email)}
  		it { should_not allow_value("test.example.com").for(:email) }
  		it { should_not allow_value("123").for(:password) }
 	end
 
	context "associations" do 
		it { should have_many(:activities).through(:participants) }
		it { should have_many(:participants).dependent(:destroy) }
	end 

end 