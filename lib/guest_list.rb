require 'json'

class GuestList
  DISTANCE_LIMIT = 100.0

  def collect(file)
    @distance_obj = DistanceToPoint.new
    load_customers(file)
    sort_asc(select_guests)
  end

  private

  def sort_asc(guests)
    guests.sort
  end

  def load_customers(file)
    @customers = []
    if file.nil? || !File.exists?(file)
      raise ArgumentError.new("Please provide customers file")
    else
      File.open(file).each do |line|
        @customers << JSON.parse(line)
      end
    end

  end

  def select_guests
    result = {}
    @customers.each do |customer_data|
      if @distance_obj.calculate(customer_data['latitude'].to_f, customer_data['longitude'].to_f) <= DISTANCE_LIMIT
        result[customer_data['user_id']] = customer_data['name']
      end
    end

    result
  end
end
