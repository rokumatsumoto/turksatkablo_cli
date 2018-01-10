describe TurksatkabloCli do
 subject { described_class }

  context '#initialize' do
    before { require "init/poltergeist" }
    it 'will register poltergeist as default capybara driver' do
      expect(Capybara.current_session.driver).to be_instance_of(Capybara::Poltergeist::Driver)
    end
 end
end
