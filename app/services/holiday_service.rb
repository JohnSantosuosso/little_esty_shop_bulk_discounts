  class HolidayService

    def self.get_holiday_data
      response = HTTParty.get("https://date.nager.at/api/v3/publicholidays/2022/US")
      json = JSON.parse(response.body, symbolize_name: true)
    end
  end