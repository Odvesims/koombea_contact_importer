class Contact < ApplicationRecord
  self.per_page = 10
  validates :name, :date_of_birth, :phone, :address, :credit_card, :franchise, :email, :card_last4, :uploadedfile_id, presence: true
  validate :name_format, :date_format, :phone_format, :card_format, :email_format, on: :create
  validates_uniqueness_of :email, scope: :user_id
  def date_format
    validation = DateFormatValidationService.new(self.date_of_birth).execute
    errors.add(:date_of_birth, 'Invalid date format') unless validation
  end

  def name_format
    validation = self.name.match?(/\A[a-zA-Z- ]*\z/) ? true : false
    errors.add(:name, 'Invalid name format') unless validation
  end

  def card_format
    CardValidationService.new(self.credit_card).execute
  end

  def email_format
    validation =  self.email.match?(/^[\+A-Z0-9\._%-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i) ? true : false
    errors.add(:email, 'Invalid email format') unless validation
  end

  def phone_format
    validation = PhoneFormatValidationService.new(self.phone).execute
    errors.add(:phone, 'Invalid phone format') unless validation
  end

end
