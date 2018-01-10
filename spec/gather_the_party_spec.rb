describe GatherTheParty do
  describe 'run' do
    let(:file) { 'spec/fixtures/customers.json' }

    it 'should return correct response for customer file' do
      gather_the_party_obj = described_class.new

      expect(gather_the_party_obj.run(file)).to eq([[3, "Jack"], [6, "Theresa"]])

      expect { gather_the_party_obj.run(file) }.to output(
        "Here's your guest list: \n[[3, \"Jack\"], [6, \"Theresa\"]]\n").to_stdout
    end

    it 'should return ArgumentError if file was not provided' do
      expect { described_class.new.run('no_file.json') }.to raise_error(
        ArgumentError, "Please provide customers file"
      )
    end
  end
end
