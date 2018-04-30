require 'rails_helper'

RSpec.feature "Users can only see the appropriate links" do
  let(:user) { FactoryGirl.create(:user)}
  let(:admin) { FactoryGirl.create(:user, :admin)}
  let(:project) { FactoryGirl.create(:project)}
  context "anonymous user" do
    scenario "Cannot see the New Project link" do
      visit "/"
      expect(page).not_to have_link "New Project"
    end

    # This test is not necessary anymore
    # scenario "Cannot see the Delete Project link" do
    #   visit project_path(project)
    #   expect(page).not_to have_link "Delete Project"
    # end
  end

  context "regular user" do
    before do
      assign_role!(user, :viewer, project)
      login_as(user)
    end

    scenario "cannot see the New Project link" do
      visit "/"
      expect(page).not_to have_link "New Project"
    end

    scenario "cannot see the Delete Project link" do
      visit project_path(project)
      expect(page).not_to have_link "Delete Project"
    end

    scenario "cannot see the Edit Project link" do
      visit project_path(project)
      expect(page).not_to have_link "Edit Project"
    end
  end

  context "admin user" do
    before { login_as(admin) }

    scenario "can see the New Project link" do
      visit "/"
      expect(page).to have_link "New Project"
    end

    scenario "can see the Delete Project link" do
      visit project_path(project)
      expect(page).to have_link "Delete Project"
    end

    scenario "can see the Edit Project Link" do
      visit project_path(project)
      expect(page).to have_link "Edit Project"
    end
  end

end