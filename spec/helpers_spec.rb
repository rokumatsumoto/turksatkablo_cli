
describe TurksatkabloCli::OnlineOperations::Helpers do
 subject { described_class }

 context '#check_ruby_version' do
  it 'returns ruby version when correct version >= 2.2.0 installed' do
    expect(subject.check_ruby_version("2.4.2")).to be >= "2.2.0"
  end

  it 'abort with error message when unsupported ruby version (< 2.2.0) installed' do
    expect { subject.check_ruby_version("2.1.0") }.to raise_error(SystemExit)
  end
end

context '#check_is_installed?' do
  it 'returns true when phantomjs is in path' do
    expect(subject.check_is_installed?("phantomjs", TurksatkabloCli::OnlineOperations::Enums::PHANTOM_JS_REQUIRED)).to be_truthy
  end

  it 'abort with error message because phantom_jsx can not be in path' do
    expect { subject.check_is_installed?("phantom_jsx", "phantom_jsx can not be in path") }.to raise_error(SystemExit)
  end
end

context '#which' do
  it 'returns ruby\'s path when ruby is in path' do
    expect(subject.which("ruby")).to be_instance_of(String)
  end
end

context '#require_all' do
  before {subject.require_all("./spec/support/required_all")}

  it 'needed files' do
    notifier = class_double("ConsoleNotifier").as_stubbed_const
    expect(notifier).to receive(:notify).with("suspended as")
    user = User.new
    user.suspend!

  end
end

context '#add_line' do
  it 'returns new line' do
    expect do
      subject.add_line
    end.to output("\n").to_stdout
  end
end

context '#internet_connection?' do
  it 'returns false when blank address specified' do
    expect(subject.internet_connection?('')).to be_falsey
  end
  it 'returns nil when nil address specified' do
    expect(subject.internet_connection?(nil)).to be_nil
  end
end

end
