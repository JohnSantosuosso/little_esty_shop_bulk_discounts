class Holiday
  attr_reader :name, :date

  def initialize(attributes)
    @name = attributes['name']
    @date = attributes['date']
  end

end