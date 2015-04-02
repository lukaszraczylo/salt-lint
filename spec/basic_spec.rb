require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'Basic commands' do
  # Running the same with -h argument should display help
  it 'arg -h displays help' do
    expect(`salt-lint -h`).to include 'Usage:'
  end
end