def generate_chars(num_chars)
  charset = Array('A'..'Z')
  Array.new(num_chars) { charset.sample }.join
end

def rand_int(from, to)
  rand_in_range(from, to).to_i
end

def rand_in_range(from, to)
  rand * (to - from) + from
end

99.times do |n|
  TaxCertificate.create!(
    gf: "#{Faker::Number.number(8)} #{generate_chars(2)}",
    title_company: Faker::Bank.name.titlecase,
    certificate: "#{rand_int(1997, 2019)}-",
    order: "#{rand_int(100000, 543210)}",
    buyer: Faker::Name.name,
    property_address: Faker::Address.street_address
  )
end