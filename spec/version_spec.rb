describe TurksatkabloCli::OnlineOperations do

  it 'returns turksatkablo_cli version' do
    stub_const("VERSION", "0.2.0")
    expect(VERSION).to eq(subject::VERSION)
  end
end
