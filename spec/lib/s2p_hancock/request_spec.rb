require "spec_helper"

describe S2PHancock::Request do

  describe "#process" do
    it "raises an error if no license_key provided" do
      expect{subject.process!}.to raise_error(ArgumentError, "License key is required")
    end

    it "raises an error if no endpoint provided" do
      S2PHancock.license_key = "foo"
      expect{subject.process!}.to raise_error(ArgumentError, "Endpoint key is required")
    end

    it "raises an error if no signature_id provided" do
      S2PHancock.endpoint = "bar"
      S2PHancock.license_key = "foo"
      expect{subject.process!}.to raise_error(ArgumentError, "Signature ID is required")
    end
  end
end