require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Etherscan" do
  it "has a version" do
    expect(Etherscan::VERSION).not_to be_nil
  end
end
