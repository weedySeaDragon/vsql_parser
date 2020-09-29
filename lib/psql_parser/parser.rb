require 'treetop'
require_relative './psql_node_extensions'


class PsqlParser::Parser

  PSQLPARSER_BASE_PATH ||= File.expand_path(__dir__)
  PSQL_GRAMMER_FN = 'psql_parser.treetop'

  # Load the Treetop grammar from the 'sexp_parser' file, and
  # create a new instance of that parser as a class variable
  # so we don't have to re-create it every time we need to
  # parse a string

  # This call to Treetop will create a Parser class based on the root name in the grammar file.
  Treetop.load(File.join(PSQLPARSER_BASE_PATH, PSQL_GRAMMER_FN))
  @@parser = PSqlParser.new


  def self.parse(sql)
    d_sql = sql.downcase  # REQUIRED!

    # parser.parse(d_sql).tap do
    #   d_sql.replace(sql)
    # end

    tree = parser.parse(d_sql).tap do
      d_sql.replace(sql)
    end

    # If the AST is nil then there was an error during parsing
    # we need to report a simple error message to help the user
    raise Exception, "Parse error at offset: #{parser.index}" if tree.nil?

    tree
  end


  def self.parser
    @@parser ||= PSqlParser.new
  end


  #
  # def self.parser
  #   @parser ||= VSqlParser.new
  # end
  #
  #   def parse(sql)
  #     d_sql = sql.downcase
  #     parser.parse(d_sql).tap do
  #       d_sql.replace(sql)
  #     end
  #   end
  # Treetop.load(File.join(__dir__, 'vsql_parser.treetop'))


end

