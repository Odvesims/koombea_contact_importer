class Contact < ApplicationRecord
  validates :name, :date_of_birth, :phone, :address, :credit_card, :franchise, :email, :card_last4, presence: true
  validate :name_format, :date_format, :phone_format, :card_format, :email_format

  def date_format
    DateFormatValidationService.new(self.date_of_birth).execute
  end

  def name_format
    return self.name.match?(/\A[a-zA-Z- ]*\z/) ? true : false
  end

  def card_format
    CardValidationService.new(self.credit_card).execute
  end

  def email_format
    return self.email.match?(/^[\+A-Z0-9\._%-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i) ? true : false
  end

  def phone_format
    PhoneFormatValidationService.new(self.phone).execute
  end

end
