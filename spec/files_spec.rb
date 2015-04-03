require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

$arguments = OpenStruct.new({ file: 'tests/file_with_multiple_errors.sls', file_given: true,
     check_newlines: true, check_double_quotes: true, check_whitespaces: true,
     check_line_length: true, check_single_word: true, check_quoted_booleans: true })

$debug = 0

describe 'Files operations' do

  it 'scans all the files within "tests" directory' do
    $arguments.file_given = false
    $arguments.scan_given = true
    $arguments.scan = 'tests'
    list_of_sls_files = SaltLint::Actions.scan
    expect(list_of_sls_files.grep(/well_formatted_top\.sls/).any?).to eq true
  end

  it 'checks well formatted file' do
    $arguments.file = 'tests/well_formatted_top.sls'
    $arguments.file_given = true
    $arguments.scan_given = false
    expect(SaltLint::Actions.check_rules($arguments.file)).to eq true
  end

  it 'checks file with multiple errors' do
    $arguments.scan_given = false
    $arguments.file = 'tests/file_with_multiple_errors.sls'
    expect(SaltLint::Actions.check_rules($arguments.file)).to eq false
  end
end