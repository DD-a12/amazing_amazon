FactoryBot.define do
  factory :news_article do
      title { Faker::Job.title }
      description { Faker::Job.field}
      published_at { rand(100_001..200_000)}
      user
  end
end
