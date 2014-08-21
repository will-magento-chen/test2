20.times do
  Contact.create({
                   first_name: Faker::Name.first_name,
                   last_name: Faker::Name.last_name,
                   email: Faker::Internet.email,
                   company: Faker::Company.name,
                   address1: Faker::Address.street_address,
                   country: Faker::Address.country,
                   state: Faker::Address.state_abbr,
                   city: Faker::Address.city,
                   zipcode: Faker::Address.zip_code,
                   mobile_phone: Faker::PhoneNumber.cell_phone

                })
end
