class User < ApplicationRecord
  has_many :todos, dependent: :destroy
  has_many :items, through: :todos

  validates_presence_of :email
  validates_presence_of :sub

  def self.from_token_payload(payload)
    find_by(sub: payload['sub'])
  end
end
