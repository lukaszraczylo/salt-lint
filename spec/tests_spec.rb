require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

test_file_good      = 'tests/well_formatted_top.sls'
test_file_bad_yaml  = 'tests/non_yaml_file.sls'
test_file_bad       = 'tests/file_with_multiple_errors.sls'

describe 'Tests suite checks if' do
  it 'file is in YAML format (incorrect)' do
    expect(SaltLint::Tests.check_if_proper_yaml(0, 0, test_file_bad_yaml)).to eq false
  end

  it 'file is in YAML format (correct)' do
    expect(SaltLint::Tests.check_if_proper_yaml(0, 0, test_file_good)).to eq true
  end

  it 'won\'t allow lines longer than 80 characters' do
    expect(SaltLint::Tests.check_line_length(0, 'xG9H2z8dOK0n3fTX1g4bWS5a6lRI7t6jCsY58mLJ2pqU9N3k4rBD0woA17iMyP90eEZ2u3cFbQ47uYD5lmM16' , test_file_good)).to eq false
  end

  it 'won\'t allow double quotes' do
    expect(SaltLint::Tests.check_double_quotes(0, 'There\'s one "potato"', test_file_good)).to eq false
  end

  it 'won\'t allow trailing whitespace' do
    expect(SaltLint::Tests.check_trailing_whitespace(0, 'This text looks okay ', test_file_good)).to eq false
    expect(SaltLint::Tests.check_trailing_whitespace(0, "This text looks okay\t", test_file_good)).to eq false
  end

  it 'won\'t allow to forget about newline at the end of the file' do
    expect(SaltLint::Tests.check_for_no_newline(0, 0, test_file_bad)).to eq false
  end
end