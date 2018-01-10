require 'json'

class GuestList
  DISTANCE_LIMIT = 100.0
  CUSTOMER_HEADER = %w(user_id name latitude longitude)

  def collect(file)
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
        potential_customer = JSON.parse(line)
        if is_valid_customer?(potential_customer)
          @customers << potential_customer
        end
      end
    end
    @customers
  end

  def is_valid_customer?(customer_line)
    CUSTOMER_HEADER & customer_line.keys == CUSTOMER_HEADER
  end

  def select_guests
    result = {}
    @distance_obj = DistanceToPoint.new
    @customers.each do |customer_data|
      if @distance_obj.calculate(customer_data['latitude'].to_f, customer_data['longitude'].to_f) <= DISTANCE_LIMIT
        result[customer_data['user_id']] = customer_data['name']
      end
    end

    result
  end
end
