FactoryBot.define do
  factory :breed do
    remote_id { "adO2sdA" }
    name { "Sphynx" }
    temperament { "Total Chill" }
    origin { "Greek" }
    description { "Best house cat." }
    child_friendly { 1 }
  end
end
