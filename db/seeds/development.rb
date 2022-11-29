dean =
  User.first_or_create!(
    email: "dean@example.com",
    password: "password",
    password_confirmation: "password",
  )

john =
  User.first_or_create!(
    email: "john@example.com",
    password: "password",
    password_confirmation: "password",
  )

UserProfile.first_or_create!(
  gov_id: "1234567890C",
  is_freelance: true,
  street_address_1: "123 Main ST",
  city: "Estepona",
  region: "Malaga",
  postal_code: "29680",
  country: "España",
  first_name: "Dean",
  last_name: "DeHart"
)

UserProfile.first_or_create!(
  gov_id: "9876543210C",
  is_freelance: true,
  street_address_1: "123 Main ST",
  city: "Estepona",
  region: "Malaga",
  postal_code: "29680",
  country: "España",
  first_name: "John",
  last_name: "Smith"
)
