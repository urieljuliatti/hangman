# frozen_string_literal: true

require 'json'
require 'spec_helper'

RSpec.describe Repositories::RepoFile do
  subject(:repo_file) { described_class.new(file) }
  let(:file) { 'topics.json' }
  let(:fullpath) { repo_file.filepath }
  let(:filepath) { './lib/files' }

  describe '.topics' do
    subject(:topics) { repo_file.topics }

    it { is_expected.to eq JSON.parse(File.read(fullpath), symbolize_key: true) }
  end

  before do
    stub_const("#{described_class}::DEFAULT_FILE", file)
    stub_const("#{described_class}::DEFAULT_FILE_PATH", filepath)
  end

  describe '#all' do
    subject(:all) { described_class.all }

    it {
      is_expected.to eq JSON.parse(File.read("#{described_class::DEFAULT_FILE_PATH}/#{described_class::DEFAULT_FILE}"),
                                   symbolize_key: true)
    }
  end
end
