require "rails_helper"

RSpec.feature "Logging-in" do
  context "visitor navigates to /login" do
    specify "username and password input fields are displayed" do
      visit "/login"

      expect(page).to have_field("email")
      expect(page).to have_field("password")
    end

    specify "successful login redirects to cats page" do
      admin = double(id: "random-id")

      allow(Admin).to receive(:find_by).and_return(admin)
      allow(Admin).to receive(:find).and_return(admin)
      allow(admin).to receive(:authenticate).and_return(true)

      visit "/login"

      fill_in("email", with: "admin@oddcamp.com")
      fill_in("password", with: "password")

      click_button("Login")

      expect(page).to have_current_path("/cats")
    end

    specify "unsuccessful login re-renders the login page" do
      admin = double(id: "random-id")

      allow(Admin).to receive(:find_by).and_return(admin)
      allow(admin).to receive(:authenticate).and_return(false)

      visit "/login"

      fill_in("email", with: "admin@oddcamp.com")
      fill_in("password", with: "wrong-password")

      click_button("Login")

      expect(page).to have_current_path("/login")
    end
  end

  context "an admin navigates to /login" do
    specify "they're redirected to cats path" do
      allow_any_instance_of(ApplicationController).to receive(:logged_in?).and_return(true)

      visit "/login"

      expect(page).to have_current_path("/cats")
    end
  end
end
