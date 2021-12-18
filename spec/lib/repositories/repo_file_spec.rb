# frozen_string_literal: true

require 'json'

RSpec.describe Repositories::RepoFile do
  subject(:repo_file) { described_class.new(file) }
  let(:file) { 'topics.json' }
  let(:fullpath) { repo_file.filepath }

  describe '.topics' do
    subject(:topics) { repo_file.topics }

    it { is_expected.to eq JSON.parse(File.read(fullpath), symbolize_key: true) }
  end
end
