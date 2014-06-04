require "spec_helper"

describe S2PHancock::Response do

  let(:subject){S2PHancock::Response}

  before(:each){
    S2PHancock.endpoint = "http://hancock.elasticbeanstalk.com/verify"
    S2PHancock.license_key = "foo"

    VCR.use_cassette 'api/success' do
      request = S2PHancock::Request.new(:signature_id=> "534d568369702d3f640a0000")
      @successful_response = request.process
    end

    VCR.use_cassette 'api/failed' do
      request = S2PHancock::Request.new(:signature_id=> "bad_id")
      @failed_response = request.process
    end
  }

  it "must be defined" do
    expect(subject).to_not be_nil
  end

  describe "#initialize" do

    it "raises an error if no object passed " do
      expect{S2PHancock::Response.new}.to raise_error(ArgumentError, "Missing response string")
    end

    context 'with a successful request' do

      it "sets a response code on response" do
        expect(@successful_response.http_code).to eq(200)
      end

      it "sets a body on response" do
        expect(@successful_response.body).to_not be_nil
      end

    end

    context 'with a failed request' do

      it "sets a response code on response" do
        expect(@failed_response.http_code).to eq(500)
      end

      it "sets a body on response" do
        expect(@failed_response.body).to_not be_nil
      end

      it "sets the server message" do
        expect(@failed_response.message).to include("failed")
      end

    end

  end

  describe "#parse" do

    context 'with a successful request' do

      it "sets a success method on response" do
        expect(@successful_response.success?).to be(true)
      end

      it "sets a confidence score" do
        expect(@successful_response.confidence).to be_kind_of(Float)
      end

      it "sets a verification status" do
        expect(@successful_response.verification_OK).to eq(true)
      end

      it "sets the response headers" do
        expect(@successful_response.headers).to be_kind_of(Hash)
      end

      # apparently a bug in Typhoeus Webmock inetgration prevents time being sent
      # https://github.com/bblimke/webmock/blob/master/lib/webmock/http_lib_adapters/typhoeus_hydra_adapter.rb#L82..L101

      # it "sets a the response time" do
      #   expect(@successful_response.total_time).to be_an_instance_of(Float)
      # end


    end

  end

end