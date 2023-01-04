class PersonProfile < ApplicationRecord
  belongs_to :person
  belongs_to :profile, polymorphic: true, foreign_type: :user_type
end
