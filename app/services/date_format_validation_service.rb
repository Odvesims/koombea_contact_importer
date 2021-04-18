class DateFormatValidationService

  MONTH_DAYS = {
    1=> {days: 31 }, 
    2=> {days: 28},
    3=> {days: 31},
    4=> {days: 30},
    5=> {days: 31},
    6=> {days: 30},
    7=> {days: 31},
    8=> {days: 30},
    9=> {days: 31},
    10=> {days: 30},
    11=> {days: 31},
    12=> {days: 30}
  }
  attr_reader :date, :year, :month, :day

  def initialize(date)
    @date = date
  end

  def execute()
    @date = @date.gsub(/[^\d]+/, '')
    return false if date.length != 8
    @year = date[0..3].to_i
    @month = date[4..5].to_i
    @day = date[6..7].to_i
    return false if year == 0 or (not month.between?(1, 12)) or day < 1
    if month == 2 and day >= 29
      return false if not Date.leap?(year) 
      @day -= 1
    end
    return false if day > MONTH_DAYS[month][:days] 
    true
  end

end