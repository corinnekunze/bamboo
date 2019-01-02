FactoryBot.define do
  factory(:recipe) do
    sequence :name do |number|
      "#{Faker::Food.dish} #{number}"
    end
  end
end
