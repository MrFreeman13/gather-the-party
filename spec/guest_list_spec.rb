describe GuestList do
  let(:wrong_formatted_file) { 'spec/fixtures/non_json_customers.json' }
  let(:correct_file) { 'spec/fixtures/customers.json' }
  let(:not_valid_customers) { 'spec/fixtures/not_valid_customers.json' }

  describe 'load_customers' do
    it 'should return argument error if file was not provided' do
      expect { described_class.new.send(:load_customers, nil) }.to raise_error(
        ArgumentError, "Please provide customers file"
      )
    end

    it 'should return argument error if file was not exist' do
      expect { described_class.new.send(:load_customers, 'no_file.json') }.to raise_error(
        ArgumentError, "Please provide customers file"
      )
    end

    it 'should raise parsing error if file was not json formatted' do
      expect { described_class.new.send(:load_customers, wrong_formatted_file) }.to raise_error(JSON::ParserError)
    end

    it 'should load customers from correct file' do
      expect( described_class.new.send(:load_customers, correct_file) ).to eq(
        [
          { "latitude"=>"52.986375", "user_id"=>3, "name"=>"Jack", "longitude"=>"-6.043701" },
          { "latitude"=>"53.807778", "user_id"=>28, "name"=>"Charlie", "longitude"=>"-7.714444" },
          { "latitude"=>"53.1229599", "user_id"=>6, "name"=>"Theresa", "longitude"=>"-6.2705202" }
        ])
    end

    it 'should load only the customers with correct headers' do
      expect( described_class.new.send(:load_customers, not_valid_customers) ).to eq(
        [
          { "latitude"=>"52.986375", "user_id"=>3, "name"=>"Jack", "longitude"=>"-6.043701" }
        ])
    end
  end

  describe 'select_guests' do
    it 'should select only the guests which are within distance limit' do
      guest_list_obj = described_class.new
      guest_list_obj.send(:load_customers, correct_file)

      expect(guest_list_obj.send(:select_guests)).to eq({ 3=>"Jack", 6=>"Theresa" })
    end
  end

  describe 'sort_asc' do
    it 'should sort guest list ascending by id' do
      unsorted_guest_list = { 10 => "Nick", 2 => "Kate", 3 => "Jack" }

      expect(described_class.new.send(:sort_asc, unsorted_guest_list)).to eq(
        [[2, "Kate"], [3, "Jack"], [10, "Nick"]]
      )
    end
  end

  describe 'collect' do
    it 'should collect all matched guests' do
      expect(described_class.new.collect(correct_file)).to eq(
        [[3, "Jack"], [6, "Theresa"]]
      )
    end
  end
end
