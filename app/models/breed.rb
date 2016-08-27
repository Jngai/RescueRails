# == Schema Information
#
# Table name: breeds
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Breed < ApplicationRecord

  has_many :primary_breed_dogs, class_name: 'Dog', foreign_key: 'primary_breed_id'
  has_many :secondary_breed_dogs, class_name: 'Dog', foreign_key: 'secondary_breed_id'
end
