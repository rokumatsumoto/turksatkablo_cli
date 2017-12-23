RSpec.describe "environment" do

  it "ruby version is >= 2.2.0" do
    expect(TurksatkabloCli::OnlineOperations::Helpers.check_ruby_version("2.4.2")).to be >= "2.1.0"
  end

  it "ruby version is < 2.2.0" do
    expect { TurksatkabloCli::OnlineOperations::Helpers.check_ruby_version("2.1.0") }.to raise_error(SystemExit)
  end

  it "phantomjs needs to be in path" do
    expect(TurksatkabloCli::OnlineOperations::Helpers.check_is_installed?("phantomjs", TurksatkabloCli::OnlineOperations::Enums::PHANTOM_JS_REQUIRED)).to be_truthy
  end

  it "ruby is in path" do
    expect(TurksatkabloCli::OnlineOperations::Helpers.which("ruby")).to be_instance_of(String)
  end

  it "phantom_jsx is not in path" do
    expect { TurksatkabloCli::OnlineOperations::Helpers.check_is_installed?("phantom_jsx", "phantom_jsx is not in path") }.to raise_error(SystemExit)
  end

end
