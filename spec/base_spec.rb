describe TurksatkabloCli::OnlineOperations::Base do

 subject { described_class }

 context '#initialize' do
  it 'will derive from Thor class' do
    expect(subject.superclass).to eq(Thor)
  end

  it 'will include Helpers module' do
    expect(subject.include?(TurksatkabloCli::OnlineOperations::Helpers)).to be_truthy
  end
 end
end
