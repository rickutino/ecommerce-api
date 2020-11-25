FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "Category #{n}" } #FactoryBot tem o sequence que gera id aleatorio para teste.
  end
end
