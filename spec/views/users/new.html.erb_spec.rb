require "rails_helper"

RSpec.describe "users/new", type: :view do
   let(:user){User.new}
   subject {rendered}
   before do
    assign :user, user
    render
   end
   describe "users/view/new" do
    it "form sign up" do
      visit("/login")
      is_expected.to have_field "user_name"
      is_expected.to have_field "user_email"
      is_expected.to have_field "user_password"
      is_expected.to have_field "user_password_confirmation"
      have_submit_button("Sign up")
    end
  end
end
