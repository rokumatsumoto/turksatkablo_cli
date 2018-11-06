shared_examples 'agent' do
  context 'call' do
    before(:all) do
      require 'init/poltergeist'
    end

    it 'returns instance of Agent' do
      expect(agent).to be_instance_of(TurksatkabloCli::OnlineOperations::Agent)
    end

    it 'initializes capybara session w/ poltergeist' do
      expect(agent.session).to be_instance_of(Capybara::Session)
    end
  end
end
