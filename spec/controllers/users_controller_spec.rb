require "rails_helper"
require './app/helpers/sessions_helper'

RSpec.configure do |c|
  c.include SessionsHelper
end
RSpec.describe UsersController, type: :controller do
  let(:user) {FactoryBot.create :user}
  let(:orther_user) {FactoryBot.create :Ortheruser}

  describe "GET #show" do
    it "requests user to @user" do
      get :show, params: {id: user.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    it "create a new user valid" do
      post :create, params: {user: FactoryBot.attributes_for(:create_user)}
      user.send_activation_email
      expect(assigns(:user)).to be_a User
      expect(response).to redirect_to root_path
    end

    context "when email invalid name blank " do
      it "create a new user invalid" do
        post :create, params:{user: FactoryBot.attributes_for(:invalid_user)}
        expect{assigns(:user)}.to_not change(User,:count)
        expect(response).to render_template :new
      end
    end
  end

  describe "GET #edit" do
    before{log_in user}
    it "requests user to edit" do
      get :edit, params: {id: user.to_param}
      expect(response).to render_template :edit
    end

    context "when not loggin" do
      it "requests user to edit" do
        log_out
        get :edit, params: {id: user.to_param}
        expect(response).to redirect_to login_path
      end
    end

    context "when not correct user" do
      it "requests user to edit" do
        log_out
        log_in orther_user
        get :edit, params: {id: user.to_param}
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "PUT #update" do
    context "when member" do
      before{log_in user}
      it " requests to update" do
        put :update, params: {user: FactoryBot.attributes_for(:Ortheruser), id: user.to_param}
        expect(response).to redirect_to root_path
      end
    end

    context "when admin" do
      before{log_in user}
      it " requests to update" do
        log_out
        user.role = 1
        user.save
        log_in user
        put :update, params: {user: FactoryBot.attributes_for(:Ortheruser), id: user.to_param}
        expect(response).to redirect_to admin_users_path
      end
    end
  end
end
