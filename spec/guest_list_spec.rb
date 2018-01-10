require_relative '../lib/guest_list'

describe GuestList do
  let(:wrong_formatted_file) { 'spec/fixtures/non_json_customers.json' }
  let(:correct_file) { 'spec/fixtures/customers.json' }

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
          { "latitude"=>"52.3191841", "user_id"=>3, "name"=>"Jack", "longitude"=>"-8.5072391" },
          { "latitude"=>"53.807778", "user_id"=>28, "name"=>"Charlie", "longitude"=>"-7.714444"},
        ])
    end
  end

  describe 'select_guests' do
    it 'should select guests which are within distance limit'
    it 'should not select guests which are too far'
  end

  describe 'sort asc' do
    it 'should sort guest list ascending by id'
  end

  describe 'collect' do
    it 'should collect all matched guests'
  end
end
