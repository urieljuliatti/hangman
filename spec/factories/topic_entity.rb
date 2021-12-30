# frozen_string_literal: true

FactoryBot.define do
  factory :topic_entity, class: 'Entities::Topic' do
    subject { 'animals' }
    keyword { 'cheetah' }
    kind { 'big cats' }
    name { 'Cheetah' }

    trait :with_whitespace do
      subject { 'cities' }
      keyword { 'new_york' }
      kind { 'big cities' }
      name { 'New York' }
    end
  end
end
