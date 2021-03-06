FactoryGirl.define do
  factory :user do
    username "Pekka"
    password "Secret1"
    password_confirmation "Secret1"
  end

  factory :rating do
    score 10
  end

  factory :rating2 do
    score 20
  end

  factory :brewery do
    name "anonymous"
    year 1900
  end

  factory :beer do
    name "anonymous"
    brewery
    style
  end

  factory :style do
    name "lager"
  end
end