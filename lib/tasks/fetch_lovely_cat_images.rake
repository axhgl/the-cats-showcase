namespace :fetch_lovely_cat_images do
  desc "fetches cat images and inserts them and their breeds in the database"

  task populate_db: :environment do
    begin
      puts "Fetching the cat images next ..."

      response = RestClient.get 'https://api.thecatapi.com/v1/images/search?limit=20&has_breeds=1',
        {
          'Content-Type': 'application\json',
          'x-api-key': Rails.application.credentials.cat_api_key
        }
    rescue RestClient::Exceptions::OpenTimeout
      puts "Fetching of the cat images request timed out!! Please retry!"
    end

    if response
      puts "Populating the database ..."

      json_data = JSON.parse(response.body)
      json_data.each do |data_point|
        remote_breed_attrs = data_point["breeds"][0].slice(
          "id", "name", "temperament", "description", "origin", "child_friendly"
        )

        breed = Breed.find_or_create_by!(remote_id: remote_breed_attrs["id"]) do |breed|
          breed.name = remote_breed_attrs["name"]
          breed.temperament = remote_breed_attrs["temperament"]
          breed.description = remote_breed_attrs["description"]
          breed.origin = remote_breed_attrs["origin"]
          breed.child_friendly = remote_breed_attrs["child_friendly"]
        end

        remote_cat_attrs = data_point.slice("id", "url", "width", "height")

        cat = Cat.find_or_create_by!(remote_id: remote_cat_attrs["id"]) do |cat|
          cat.breed = breed
          cat.url = remote_cat_attrs["url"]
          cat.width = remote_cat_attrs["width"]
          cat.height = remote_cat_attrs["height"]
        end
      end
    end
  end
end
