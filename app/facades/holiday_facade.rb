class HolidayFacade

  def self.holidays_dates
    holidays = HolidayService.get_holiday_data
    holidays.map {|holiday| Holiday.new(holiday) if holiday['date'] >= Time.now.strftime("%Y-%m-%d")}
  end

  
end