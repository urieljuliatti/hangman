# frozen_string_literal: true

FactoryBot.define do
  factory :topic, class: 'Entities::Topic' do
    subject { 'animals' }
    keyword { 'cheetah' }
    kind { 'big cats' }
    word { 'Cheetah' }
  end
end
