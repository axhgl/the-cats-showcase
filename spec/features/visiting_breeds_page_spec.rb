require "rails_helper"

RSpec.feature "Displaying cat images" do
  context "a visitor navigates to /breeds" do
    let(:breed_sphynx) { build_stubbed(:breed) }
    let(:breed_bengali) { build_stubbed(:breed, name: "Bengali") }

    specify "a list of breeds is displayed" do
      allow(Breed).to receive(:order).and_return([breed_bengali, breed_sphynx])

      visit "/breeds"

      expect(page).to have_selector("h3", text: "Bengali")
      expect(page).to have_selector("h3", text: "Sphynx")
    end

    specify "a breed's cats size is displayed" do
      allow(Breed).to receive(:order).and_return([breed_bengali])
      allow(breed_bengali).to receive_message_chain(:cats, :size).and_return(2)

      visit "/breeds"

      expect(page).to have_selector("p", text: "2")
    end

    specify "a search form is displayed" do
      visit "/breeds"

      expect(page).to have_selector("form", id: "search-breed")
    end

    specify "searching for a breed returns breeds that match the name pattern", js: true do
      allow(Breed).to receive(:order).and_return([breed_bengali, breed_sphynx])
      allow(Breed).to receive(:by_name_search).and_return([breed_bengali])
      allow(breed_bengali).to receive_message_chain(:cats, :size).and_return(2)

      visit "/breeds"

      fill_in(:search_term, with: "Beng")

      find('form input').native.send_keys :enter

      expect(page).to have_selector("h3", text: "Bengali")
      expect(page).to have_selector("p", text: "2")
    end
  end

  context "an admin navigates to /breeds" do
    let(:breed_bengali) { build_stubbed(:breed, name: "Bengali") }

    specify "a delete button is displayed next to each breed" do
      allow(Breed).to receive(:order).and_return([breed_bengali])
      allow_any_instance_of(ApplicationController).to receive(:logged_in?).and_return(true)

      visit "/breeds"

      expect(page).to have_selector("form", class: "button_to")
    end
  end
end
