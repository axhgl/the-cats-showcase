require "rails_helper"

RSpec.feature "Displaying cat images" do
  context "a visitor navigates to /cats" do
    let(:breed_sphynx) { build_stubbed(:breed) }
    let(:breed_somali) { build_stubbed(:breed, name: "Somali") }
    let!(:one_sphynx_cat) { build_stubbed(:cat, breed: breed_sphynx) }
    let!(:two_sphynx_cat) { build_stubbed(:cat, breed: breed_sphynx) }
    let(:somali_cat) { build_stubbed(:cat, breed: breed_somali) }

    specify "a list of cat images is displayed" do
      allow(Cat).to receive(:by_newest).and_return([one_sphynx_cat, two_sphynx_cat])
      visit "/cats"

      expect(page).to have_selector('img', id: one_sphynx_cat.id)
      expect(page).to have_selector('img', id: two_sphynx_cat.id)
    end

    specify "a list of cats and their breed is displayed" do
      allow(Cat).to receive(:by_newest).and_return([one_sphynx_cat, two_sphynx_cat])
      visit "/cats"

      expect(page).to have_selector('a', text: breed_sphynx.name).twice
    end

    specify "clicking a breed name displays only cats of that breed", js: true do
      allow(Cat).to receive(:by_newest).and_return([one_sphynx_cat, two_sphynx_cat, somali_cat])
      allow(Cat).to receive(:by_breed_name).and_return([somali_cat])

      visit "/cats"

      click_link("Somali")

      expect(page).to have_selector('img', id: somali_cat.id)
      expect(page).not_to have_selector('img', id: one_sphynx_cat.id)
    end
  end

  context "an admin navigates to /cats" do
    let(:breed_somali) { build_stubbed(:breed, name: "Somali") }
    let!(:somali_cat) { build_stubbed(:cat, breed: breed_somali) }

    specify "a delete button is displayed next to each cat" do
      allow(Cat).to receive(:by_newest).and_return([somali_cat])
      allow_any_instance_of(ApplicationController).to receive(:logged_in?).and_return(true)

      visit "/cats"

      expect(page).to have_selector("form", class: "button_to")
    end
  end
end
