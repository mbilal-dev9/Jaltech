class Person < ApplicationRecord
  belongs_to :profile, polymorphic: true, foreign_type: :user_type

  validates :first_name, presence: true
  validates :last_name, presence: true

  enum residential_status: {
    sa_resident: "sa_resident",
    non_resident: "non_resident",
    foreign_national: "foreign_national"
  }
  
end
