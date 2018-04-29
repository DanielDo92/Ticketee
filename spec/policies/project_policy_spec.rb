require 'rails_helper'

describe ProjectPolicy do

  let(:user) { User.new }

  subject { ProjectPolicy }

  permissions ".scope" do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  context "policy scope" do
    subject { Pundit.policy_scope(user, Project) }

    let!(:project) { FactoryGirl.create :project }
    let(:user) { FactoryGirl.create :user }

    it "is empty for anonymous user" do
      expect(Pundit.policy_scope(nil, Project)).to be_empty
    end

    it "includes projects a user is allowed to view" do
      assign_role!(user, :viewer, project)
      expect(subject).to include(project)
    end

    it "doesn't include projects a user is now allowed to view" do
      expect(subject).to be_empty
    end

    it "returns all projects for admins" do
      user.admin = true
      expect(subject).to include(project)
    end
  end

  permissions :create? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :show? do
    let(:user) { FactoryGirl.create :user }
    let(:project) { FactoryGirl.create :project }

    it "blocks anonymous users" do
      expect(subject).not_to permit(nil, project)
    end

    it "allows viewers of project" do
      assign_role!(user,:viewer, project)
      expect(subject).to permit(user, project)
    end

    it "allows editor of project" do
      assign_role!(user,:editor, project)
      expect(subject).to permit(user, project)
    end

    it "allows manager of project" do
      assign_role!(user,:manager, project)
      expect(subject).to permit(user, project)
      end

    it "allows administrator of project" do
      assign_role!(user,:administrator, project)
      expect(subject).to permit(user, project)
    end

    it "doesn't allow users assigned to other projects" do
      other_project = FactoryGirl.create(:project)
      assign_role!(user, :manager, other_project)
      expect(subject).not_to permit(user, project)
    end
  end

  permissions :update? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :destroy? do
    pending "add some examples to (or delete) #{__FILE__}"
  end
end
