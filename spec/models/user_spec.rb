require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {FactoryBot.create :user}
  describe ".validates" do
    context "when register user correct" do
      it {expect(user).to be_valid}
    end

    context "with name" do
      it "name blank" do
        user.name=""
        user.save
        is_expected.to_not be_valid :name
        expect(user.errors.messages[:name])
          .to eq [I18n.t("spec.model.name_blank")]
      end
    end

    context "with email" do
      it "is not valid with too long" do
        user.email= "tri"*20
        user.save
        expect(user).to_not be_valid
        expect(user.errors.messages[:email])
          .to eq [I18n.t("spec.model.is_invalid")]
      end

      it "is not valid with email uniquness" do
        user
        orther_user = FactoryBot.build :user
        orther_user.save
        expect(orther_user).to_not be_valid
        expect(orther_user.errors.messages[:email])
          .to eq [I18n.t("spec.model.email_already")]
      end
    end
  end

  describe "Associations" do
    it "has_many orders" do
      association = User.reflect_on_association(:orders)
      expect(association.macro).to eq :has_many
    end

   it "has_many comments" do
     association = User.reflect_on_association(:comments)
     expect(association.macro).to eq :has_many
   end
  end

  describe "Scope" do
    it "asc name" do
      expect(User.all.asc_name.to_sql).to eq User.all.order(name: :asc).to_sql
    end
  end
end
