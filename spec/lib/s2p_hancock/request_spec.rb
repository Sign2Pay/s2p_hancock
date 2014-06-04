require "spec_helper"

describe S2PHancock::Request do

  describe "#initialize" do
    it "sets all arguments passed as instance attributes" do
      request = S2PHancock::Request.new(:signature_id => "bar")
      expect(request.signature_id).to eq("bar")
    end
  end

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

    it "calls get to create a request" do
      S2PHancock.endpoint = "http://hancock.elasticbeanstalk.com/verify"
      S2PHancock.license_key = "foo"
      VCR.use_cassette 'api/success' do
        subject.signature_id = "534d568369702d3f640a0000"
        expect_any_instance_of(S2PHancock::Request).to receive(:get)
        subject.process
      end
    end

    it "validates request before sending" do
      S2PHancock.endpoint = "http://hancock.elasticbeanstalk.com/verify"
      S2PHancock.license_key = "foo"
      VCR.use_cassette 'api/success' do
        subject.signature_id = "534d568369702d3f640a0000"
        expect_any_instance_of(S2PHancock::Request).to receive(:validate)
        subject.process
      end
    end

    it "returns a response" do
      S2PHancock.endpoint = "http://hancock.elasticbeanstalk.com/verify"
      S2PHancock.license_key = "foo"
      VCR.use_cassette 'api/success' do
        subject.signature_id = "534d568369702d3f640a0000"
        response = subject.process
        expect(response).to be_an_instance_of(S2PHancock::Response)
      end
    end

  end
end