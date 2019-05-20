FactoryBot.define do

  factory :user do |f|
    f.email {"vantri1998@gmail.com"}
    f.name {"le van tri"}
    f.phone {"01236580"}
    f.password {"124566"}
    f.password_confirmation {"124566"}
    f.picture {"link images"}
  end

  factory :invalid_user, parent: :user do |f|
    f.name {""}
    f.email {"fff"}
  end

  factory :Ortheruser, parent: :user do |f|
    f.email {"vantri1234@gmail.com"}
    f.name {"le van tri"}
    f.phone {"01236580"}
    f.password {"123456789"}
    f.password_confirmation {"123456789"}
  end

  factory :create_user, parent: :user do |f|
    f.email {"vantri@gmail.com"}
    f.name {"le van tri"}
    f.phone {"01236580"}
    f.password {"123456789"}
    f.password_confirmation {"123456789"}
  end
end
