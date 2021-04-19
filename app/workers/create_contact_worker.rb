class CreateContactWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  sidekiq_options retry: 0
  require 'digest'

  def perform(name, date_of_birth, phone, address, credit_card, email, file_id, line, user_id)
    card_franchise = CardValidationService.new(credit_card).execute
    if card_franchise.nil?
      failed_contact(user_id, file_id, line, name, "Validation Failed: Invalid/Unsupported Credit Card").save
      return;
    end
    new_contact = succesful_contact(name, date_of_birth, phone, address, credit_card, email, card_franchise, user_id, file_id)
    begin
      new_contact.save!
    rescue Exception => e
      failed_contact(user_id, file_id, line, name, e.message).save
    end
  end

  def succesful_contact(name, date_of_birth, phone, address, credit_card, email, card_franchise, user_id, file_id)
    new_contact = Contact.new
    new_contact.name = name
    new_contact.date_of_birth = date_of_birth
    new_contact.phone = phone
    new_contact.address = address
    new_contact.card_last4 = credit_card.split(//).last(4).join
    new_contact.credit_card = (Digest::SHA256.hexdigest credit_card.to_s)
    new_contact.email = email
    new_contact.franchise = card_franchise
    new_contact.user_id = user_id
    new_contact.uploadedfile_id = file_id
    new_contact
  end

  def failed_contact(user_id, file_id, line, name, error_message)
    new_failed_contact = FailedContact.new
    new_failed_contact.user_id = user_id
    new_failed_contact.uploadedfile_id = file_id
    new_failed_contact.file_line = line
    new_failed_contact.contact_name = name 
    new_failed_contact.error_message = error_message
    new_failed_contact
  end
  
end
