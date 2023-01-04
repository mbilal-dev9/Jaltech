# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

AdminUser.create!(email: "admin@example.com", password: "Password1")

investor_user = User.create!(
  email: "investor@example.com",
  password: "Password1",
  user_type: "Investor",
  profile_attributes: {
    person_attributes: {
      first_name: "First name",
      last_name: "Last name"
    }
  }
)

company_user = User.create!(
  email: "company@example.com",
  password: "Password1",
  user_type: "Company",
  profile_attributes: {
    company_name: "Company name",
    person_attributes: {
      first_name: "First name",
      last_name: "Last name"
    }
  }
)

User.create!(
  email: "advisor@example.com",
  password: "Password1",
  user_type: "Advisor",
  profile_attributes: {
    company_name: "Company name",
    person_attributes: {
      first_name: "First name",
      last_name: "Last name"
    }
  }
)

btc = Cryptocurrency.create!(name: "Bitcoin", code: "BTC", category: :digital_currency)
ltc = Cryptocurrency.create!(name: "Litecoin", code: "LTC", category: :digital_currency)

eth = Cryptocurrency.create!(name: "Ether", code: "ETH", category: :blockchain_technology)
sol = Cryptocurrency.create!(name: "Solana", code: "SOL", category: :blockchain_technology)
link = Cryptocurrency.create!(name: "Chainlink", code: "LINK", category: :blockchain_technology)
matic = Cryptocurrency.create!(name: "Polygon", code: "Matic", category: :blockchain_technology)
dot = Cryptocurrency.create!(name: "Polkadot", code: "DOT", category: :blockchain_technology)

uni = Cryptocurrency.create!(name: "Uniswap", code: "UNI", category: :decentralized_finance)
aave = Cryptocurrency.create!(name: "Aave", code: "AAVE", category: :decentralized_finance)

cryptocurrency_basket = Product.create!(name: "Cryptocurrency Basket",
  description: "Long description",
  category: :cryptocurrency,
  cryptocurrencies: [btc, ltc, eth, sol, link, matic, dot, uni, aave])

bitcoin_debenture = Product.create!(name: "Bitcoin Debenture",
  description: "Long description",
  category: :cryptocurrency,
  cryptocurrencies: [btc])

Investment.create!(product: cryptocurrency_basket, profile: investor_user.profile, amount: Random.rand(10..1000000))
Investment.create!(product: bitcoin_debenture, profile: investor_user.profile, amount: Random.rand(10..1000000))
Investment.create!(product: cryptocurrency_basket, profile: company_user.profile, amount: Random.rand(10..1000000))
Investment.create!(product: bitcoin_debenture, profile: company_user.profile, amount: Random.rand(10..1000000))
