require 'rails_helper'
require 'spec_helper'

feature 'User Sign Up' do
 scenario 'with valid name, email and password' do
   visit(root_path)
   click_button('Sign up')
   fill_in 'user_name', :with => "John"
   fill_in 'user_email', :with => "john@gmail.com"
   fill_in 'user_password', :with => "john123"
   click_button('Submit')
   visit(root_path) 
   expect(page.has_content?("Welcome")).to eq(true)
 end
end 