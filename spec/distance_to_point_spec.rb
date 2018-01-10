describe DistanceToPoint do
  describe 'initialize' do
    it 'should return argument error if point latitude was not float' do
      expect { described_class.new(56, -6.23) }.to raise_error(
        ArgumentError, "Coordinate `56` must be a float value"
      )
    end

    it 'should return argument error if point longitude was not float' do
      expect { described_class.new(56.1, -3) }.to raise_error(
        ArgumentError, "Coordinate `-3` must be a float value"
      )
    end

    it 'should return argument error with latitude if both point coordinates was not float values' do
      expect { described_class.new("58.1", 2) }.to raise_error(
        ArgumentError, "Coordinate `58.1` must be a float value"
      )
    end

    it 'should return correct object with float point coordinates' do
      expect(described_class.new(56.11, -6.23)).to be_a(described_class)
    end

    it 'should return correct object with no arguments' do
      expect(described_class.new).to be_a(described_class)
    end
  end

  describe 'calculate' do
    let (:start_point) { [51.928932, -10.27699] }
    let (:end_point) { [52.986375, -6.043701] }

    it 'should return correct distance between default start point and end point' do
      expect( described_class.new.calculate(*end_point) ).to eq(42)
    end

    it 'should return correct distance between custom start point and end point' do
      expect( described_class.new(*start_point).calculate(*end_point) ).to eq(310)
    end
  end
end
