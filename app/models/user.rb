# frozen_string_literal: true

class User < ApplicationRecord
  EMAIL_REGX = '\A^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w+([\.-]?\w+))+$\z'

  validates :first_name, :last_name, :email, :address, presence: true
  validates :email, format: { with: Regexp.new(EMAIL_REGX) }, uniqueness: true
end
