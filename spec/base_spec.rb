describe TurksatkabloCli::Base do

 subject { described_class }

 context 'call' do

  before {expect(defined?(Thor)).not_to be_nil}

  it 'will derive from Thor class' do
    expect(subject.superclass).to eq(Thor)
  end

  it 'will include Helpers module' do
    expect(subject.include?(TurksatkabloCli::OnlineOperations::Helpers)).to be_truthy
  end

  it 'will include Thor Actions module' do
    expect(subject.include?(Thor::Actions)).to be_truthy
  end
 end
end
