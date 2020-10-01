require 'spec_helper'

RSpec.describe PsqlParser::Parser do

  def assert_parse_file(sql, show_tree: true)
    expect { described_class.parse_file sql, show_tree: show_tree }.not_to raise_error
  end


  def assert_not_parse_file(sql)
    expect { described_class.parse_file sql }.to raise_error
  end

  # ----------------------------------------------------
  FIXTURES = File.join(__dir__, '..', 'fixtures')

  ENTIRE_RASVAL_SCHEMA = 'rasval_production_20200402_2155.sql'
  RASVAL_AND_BPROFILES = 'rasval_production_20200402_2155-ONLY-answers-breedprofiles.sql'

  CREATE_TABLES_ONLY = 'rasval_production_20200402_2155-createTables-only.sql'
  SMALL_START_SHORT_TABLE = 'start_create_1_table.sql'

  describe 'parse files' do

    it 'all blank lines' do
      assert_parse_file <<-TESTFILE




      TESTFILE
    end

    it '1 content 1 blank line' do
      sql = "\n -- describe the file\n\n-- again with the comment\nline of content\n   --comment\n content\n  --comment \n \n  \nline of content\n \n \n"
      assert_parse_file sql
    end

    describe 'comments and blank lines' do

      it 'comment line and blank line' do
        sql = "-- line of content\n     \n"
        assert_parse_file sql
      end

      it 'comment lines and blank lines' do
        sql = "\n \n\n-- line of content\n -- line of content\n    -- comment    tstufft\n\n\n    \n"
        assert_parse_file sql
      end

      it '2 comment lines and blank line' do
        sql = "-- line of content\n -- line of content\n    \n"
        assert_parse_file sql
      end
    end

    it 'EOF 1 content 1 blank line' do
      assert_parse_file <<-TESTFILE
line of content

      TESTFILE
    end

    it 'ENTIRE_RASVAL_SCHEMA' do
      sql = ''
      File.open(File.join(FIXTURES, ENTIRE_RASVAL_SCHEMA), 'r:bom|utf-8') { |sql_file| sql = sql_file.read }
      assert_parse_file(sql, show_tree: false)
    end

  end

end
