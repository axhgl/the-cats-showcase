require "rails_helper"

RSpec.describe Cat do
  let(:sphynx_breed) { create(:breed) }

  context "validations" do
    let!(:cat) { build(:cat, breed: sphynx_breed) }

    context "#remote_id" do
      it "must be present" do
        cat.remote_id = ""
        expect(cat).not_to be_valid
      end

      it "must be unique" do
        create(:cat, remote_id: "ad02sdA", breed: sphynx_breed)
        expect(cat).not_to be_valid
      end
    end

    context "#url" do
      it "must be present" do
        cat.url = ""
        expect(cat).not_to be_valid
      end

      it "must be unique" do
        create(:cat, url: "https://cdn2.thecatapi.com/images/hV2A_LW2n.jpg", breed: sphynx_breed)
        expect(cat).not_to be_valid
      end
    end

    context "#width" do
      it "must be present" do
        cat.width = nil
        expect(cat).not_to be_valid
      end
    end

    context "#height" do
      it "must be present" do
        cat.height = nil
        expect(cat).not_to be_valid
      end
    end
  end

  context "scopes" do
    let(:somali_breed) { create(:breed, name: "Somali", remote_id: "adO2sdB") }
    let!(:somali_cat) { create(:cat, remote_id: "adO2sdB", url: "some url", breed: somali_breed) }
    let!(:sphynx_cat) { create(:cat, breed: sphynx_breed) }

    context ".by_breed_name" do
      it "returns cats of the specified breed" do
        expect(Cat.by_breed_name("Somali")).to eq([somali_cat])
      end
    end

    context ".by_newest" do
      it "returns cats ordered in a descending order by when created" do
        expect(Cat.by_newest(1)).to eq([sphynx_cat, somali_cat])
      end
    end
  end
end
