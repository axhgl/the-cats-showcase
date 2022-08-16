require "rails_helper"

RSpec.describe Breed do

  context "validations" do
    let!(:sphynx_breed) { build(:breed) }

    context "#remote_id" do
      it "must be present" do
        sphynx_breed.remote_id = ""
        expect(sphynx_breed).not_to be_valid
      end

      it "must be unique" do
        create(:breed, remote_id: "ad02sdA")
        expect(sphynx_breed).not_to be_valid
      end
    end

    context "#name" do
      it "must be present" do
        sphynx_breed.name = ""
        expect(sphynx_breed).not_to be_valid
      end

      it "must be unique" do
        create(:breed, name: "Sphynx")
        expect(sphynx_breed).not_to be_valid
      end
    end

    context "#temperament" do
      it "must be present" do
        sphynx_breed.temperament = ""
        expect(sphynx_breed).not_to be_valid
      end
    end

    context "#origin" do
      it "must be present" do
        sphynx_breed.origin = ""
        expect(sphynx_breed).not_to be_valid
      end
    end

    context "#description" do
      it "must be present" do
        sphynx_breed.description = ""
        expect(sphynx_breed).not_to be_valid
      end
    end

    context "#child_friendly" do
      it "must be present" do
        sphynx_breed.child_friendly = nil
        expect(sphynx_breed).not_to be_valid
      end
    end
  end

  context "scopes" do
    context ".by_name_search" do
      let!(:sphynx_breed) { create(:breed) }
      let!(:sphynx_somali_breed) { create(:breed, name: "sphynx somali", remote_id: "adO2sdC") }
      let!(:somali_breed) { create(:breed, name: "somali", remote_id: "adO2sdB") }

      it "find breeds that include 'sphynx' in their name" do
        expect(Breed.by_name_search("sphynx")).to eq([sphynx_breed, sphynx_somali_breed])
      end

      it "find breeds that include 'li' in their name" do
        expect(Breed.by_name_search("li")).to eq([sphynx_somali_breed, somali_breed])
      end

      it "find breeds that include 'oma' in their name" do
        expect(Breed.by_name_search("oma")).to eq([sphynx_somali_breed, somali_breed])
      end
    end
  end
end
