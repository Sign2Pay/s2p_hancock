require "spec_helper"

describe "S2PHancock::VERSION" do
  let(:subject){S2PHancock::VERSION}

  it "must be defined" do
    expect(subject).to_not be_nil
  end

  it "returns a string" do
    expect(subject).to be_an_instance_of(String)
  end

end