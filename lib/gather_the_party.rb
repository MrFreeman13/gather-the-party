class GatherTheParty
  def run(file)
    guest_list = GuestList.new.collect(file)
    puts "Here's your members list #{guest_list.inspect}"
  end
end
