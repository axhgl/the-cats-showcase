FactoryBot.define do
  factory :cat do
    id { SecureRandom.uuid }
    remote_id { "adO2sdA" }
    url { "https://cdn2.thecatapi.com/images/hV2A_LW2n.jpg" }
    width { 120 }
    height { 60 }
  end
end
