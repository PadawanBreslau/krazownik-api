class PhoneNumber < ApplicationRecord
  validates :number, telephone_number: { country: :pl, types: [:mobile] }
end
