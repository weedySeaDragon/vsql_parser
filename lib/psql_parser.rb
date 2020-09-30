# This is a very helpful post about getting started with Treetop:
#   http://thingsaaronmade.com/blog/a-quick-intro-to-writing-a-parser-using-treetop.html

Dir[File.join(__dir__, 'psql_parser',  '**/*.rb')].each { |f| require f }
