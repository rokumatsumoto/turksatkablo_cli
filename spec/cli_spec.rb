require_relative "support/agent_shared_examples"
require 'turksatkablo_cli/online_operations/cli'
describe TurksatkabloCli::OnlineOperations::Cli do
 subject { described_class }

 context 'call' do
  it 'will derive from Base class' do
    expect(subject.superclass).to eq(TurksatkabloCli::Base)
  end
end

context '#initialize' do
  before(:context) do
    @cli = described_class.new
  end

  it 'will fill @session instance variable' do
   expect(@cli.instance_variable_get(:@session)).to eq(agent.session)
 end

 it_behaves_like 'agent'
end



end
