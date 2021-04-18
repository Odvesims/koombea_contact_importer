class CardValidationService

  attr_reader :card_number, :franchise

  def initialize(card_number)
    @card_number = card_number.tr('^0-9', '') .to_s
    @franchise = nil
  end

  def execute()
    validate_card_details ? "#{@franchise.name}" : nil
  end

  private

    def validate_card_details
      cards_iins = CreditCardFranchiseDetail.all
      cards_iins.each do |card_info|
        return false if @card_number.length < card_info.characters_count
        card_substring = (@card_number[0..(card_info.characters_count - 1)]).to_i
        card_iin_range = card_info.iin_range.split("-")
        if card_substring.between?(card_iin_range[0].to_i, card_iin_range[1].to_i)
          card_length_range = card_info.length_range.split("-")
          if @card_number.length.between?(card_length_range[0].to_i, card_length_range[1].to_i)
            @franchise = CreditCardFranchise.find(card_info.creditcardfranchise_id)
            return true
          end
        end
      end
      false
    end

end