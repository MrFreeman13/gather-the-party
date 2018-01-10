class GatherTheParty
  def run(file)
    guest_list = GuestList.new.collect(file)
    puts "Here's your guest list: \n #{guest_list}"
  end
end
