require 'spec_helper'
require 'centurion/dogestry'

describe Centurion::Dogestry do
  let(:dogestry_options) {
    {
      aws_access_key_id: "abc",
      aws_secret_key: "xyz",
      s3_bucket: "s3-registry-test"
    }
  }
  let(:registry) { Centurion::Dogestry.new(dogestry_options) }
  let(:repo) { 'google/golang' }
  let(:pull_hosts) {
    [
      'tcp://host-1:2375',
      'tcp://host-2:2375'
    ]
  }
  let(:flags) { "-pullhosts #{pull_hosts.join(',')}"}

  describe '#aws_access_key_id' do
    it 'returns correct value' do
      expect(registry.aws_access_key_id).to eq(dogestry_options[:aws_access_key_id])
    end
  end

  describe '#aws_secret_key' do
    it 'returns correct value' do
      expect(registry.aws_secret_key).to eq(dogestry_options[:aws_secret_key])
    end
  end

  describe '#s3_bucket' do
    it 'returns correct value' do
      expect(registry.s3_bucket).to eq(dogestry_options[:s3_bucket])
    end
  end

  describe '#s3_region' do
    it 'returns correct default value' do
      expect(registry.s3_region).to eq("us-east-1")
    end
  end

  describe '#s3_url' do
    it 'returns correct value' do
      expect(registry.s3_url).to eq("s3://#{registry.s3_bucket}/?region=#{registry.s3_region}")
    end
  end

  describe '#exec_command' do
    it 'returns correct value' do
      expect(registry.exec_command('pull', repo)).to start_with('dogestry')
    end
  end

  describe '#which' do
    it 'finds dogestry command line' do
      allow(File).to receive(:executable?).and_return(true)
      expect(registry.which('dogestry')).to_not be_nil
    end
  end
end
