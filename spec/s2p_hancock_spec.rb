require 'spec_helper'

describe S2PHancock do

    before(:each) do
      subject.license_key = 'foo'
      subject.endpoint    = 'http://hancock.elasticbeanstalk.com/verify/'
    end

    it 'takes returns the license key provided' do
      expect(S2PHancock::license_key).to eq("foo")
    end

    it 'takes returns the endpoint provided' do
      expect(S2PHancock::endpoint).to eq("http://hancock.elasticbeanstalk.com/verify/")
    end


end