require './autohash'

describe HashTagsManager do
  DUMMY_FILEPATH = 'sample_autohash'

  let(:h) { HashTagsManager.new }

  before :each do
    h.stub(:filepath).and_return(DUMMY_FILEPATH)
  end

  it 'should get no hash tags defaultly' do
    expect(h.get).to eq('')
  end

  it 'should save hashtags' do
    h.save ['a', 'b', 'c']
    expect(h.get).to eq(' #a #b #c')
  end

  it 'should reset hashtags' do
    h.save ['a', 'b', 'c']
    h.reset
    expect(h.get).to eq('')
  end

  after :each do
    File.delete DUMMY_FILEPATH if File.exists? DUMMY_FILEPATH
  end
end
