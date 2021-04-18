class PhoneFormatValidationService
  PHONE_BLOCKS_LENGTH = {
    0=> 5, 
    1=> 3,
    2=> 3,
    3=> 2,
    4=> 2
  }

  attr_accessor :phone

  def initialize(phone)
    @phone = phone
  end

  def execute
    return false if @phone.length != 19
    @phone.gsub!("-", " ")
    phone_arr = @phone.split(" ")
    return false if phone_arr.count != 5
    return false if phone_arr[0].count("0-9") != 2
    return false if phone_arr[0][0] != "(" or phone_arr[0][1] != "+" or phone_arr[0][4] != ")"
    for i in 1..4 do
      block = phone_arr[i]
      return false if block.count("0-9").zero?
      return false if block.length != PHONE_BLOCKS_LENGTH[i]
    end
    true
  end
end