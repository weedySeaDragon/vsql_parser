require 'spec_helper'

RSpec.shared_examples 'it can parse sql file' do |sql_fn|

  it "#{sql_fn}" do
    sql = ''
    File.open(File.join(FIXTURES, sql_fn), "r:bom|utf-8") { |sql_file| sql = sql_file.read }
    # puts "sql:"
    # puts sql
    assert_parse_schema(sql, show_tree: false, cleanup_tree: false, make_dot_file: false)
  end
end

RSpec.describe PsqlParser::Parser do

  def assert_parse_schema(sql, show_tree: false, cleanup_tree: false, make_dot_file: false)
    expect { described_class.parse_schema(sql, show_tree: show_tree, cleanup_tree: cleanup_tree, dot_file: make_dot_file) }.not_to raise_error
  end


  def assert_not_parse_schema(sql)
    expect { described_class.parse_schema sql }.to raise_error
  end


  def select_expressions(sql)
    described_class.parse(sql)&.select_statement&.expressions.map(&:text_value)
  end


  # ----------------------------------------------------

  describe 'DDL (schema) statements' do

    describe 'CREATE table' do

      it 'table name' do
        assert_parse_schema "CREATE TABLE answers_table"
        assert_parse_schema "CREATE TABLE public.answers_table"
        assert_parse_schema "CREATE TABLE answers_table;"
        assert_parse_schema "CREATE TABLE public.answers_table;"
      end


      context 'with columns' do

        it '1 simple column' do
          assert_parse_schema "CREATE TABLE answers (id integer)"
        end

        it 'many columns' do
          assert_parse_schema "CREATE TABLE answers (id integer, some_text text, is_valid boolean   )"
        end

        describe 'column types with options' do

          describe 'column with ::' do
            # expression::type is shorthand for CAST(expression AS type)

            it 'this::integer' do
              assert_parse_schema "CREATE TABLE questions (this::integer)"
            end

            it "something::integer NOT NULL" do
              assert_parse_schema "CREATE TABLE questions (something::integer NOT NULL)"
            end

            it "locale::character varying NOT NULL" do
              assert_parse_schema "CREATE TABLE questions (locale::character varying NOT NULL)"
            end

            it "locale character varying DEFAULT 'sv'::character varying NOT NULL" do
              assert_parse_schema "CREATE TABLE questions (code varchar, locale character varying DEFAULT 'sv'::character varying NOT NULL)"
            end
          end

          it 'varchar(x)' do
            assert_parse_schema "CREATE TABLE questions (code varchar)"
            assert_parse_schema "CREATE TABLE questions (code varchar(20))"
            assert_parse_schema "CREATE TABLE questions (code varchar(20), id integer)"
            # assert_parse_schema "CREATE TABLE questions (code character varying(15))"
          end

          it 'char(x)' do
            assert_parse_schema "CREATE TABLE questions (code char)"
            assert_parse_schema "CREATE TABLE questions (code char(2))"
          end
          it 'character(x)' do
            assert_parse_schema "CREATE TABLE questions (code character)"
            assert_parse_schema "CREATE TABLE questions (code character(5))"
          end

          it 'bit, varbit' do
            assert_parse_schema "CREATE TABLE questions (code bit(2))"
            assert_parse_schema "CREATE TABLE questions (code bit)"
            assert_parse_schema "CREATE TABLE questions (code varbit(5))"
            assert_parse_schema "CREATE TABLE questions (code varbit)"
            # assert_parse_schema "CREATE TABLE questions (code bit varying(500))"
          end

          it 'number(p) number(p,s) decimal(p) decimal(p,s)' do
            assert_parse_schema "CREATE TABLE questions (code numeric(2))"
            assert_parse_schema "CREATE TABLE questions (code numeric(2, 3))"
            assert_parse_schema "CREATE TABLE questions (code numeric(2,3))"
            assert_parse_schema "CREATE TABLE questions (code decimal(5))"
            assert_parse_schema "CREATE TABLE questions (code decimal(5,1))"
            assert_parse_schema "CREATE TABLE questions (code decimal(5, 1))"
          end

          it 'interval' do
            assert_parse_schema 'CREATE TABLE films (someint interval)'
            assert_parse_schema "CREATE TABLE films (len interval hour to minute)"
            assert_parse_schema "CREATE TABLE films (len interval hour)"
            assert_parse_schema "CREATE TABLE films (len interval(4))"
            assert_parse_schema "CREATE TABLE films (len interval(6) day to second)"
          end

          it 'time' do
            assert_parse_schema "CREATE TABLE questions (t time)"
            assert_parse_schema "CREATE TABLE questions (t time(10))"
            assert_parse_schema "CREATE TABLE questions (t time WITHOUT TIME ZONE)"
            assert_parse_schema "CREATE TABLE questions (t time WITH TIME ZONE)"
            assert_parse_schema "CREATE TABLE questions (t time(10) WITHOUT TIME ZONE)"
            assert_parse_schema "CREATE TABLE questions (t time(10) WITH TIME ZONE)"
          end

          it 'timez' do
            assert_parse_schema "CREATE TABLE questions (t timez)"
            assert_parse_schema "CREATE TABLE questions (t timez(10))"
            assert_parse_schema "CREATE TABLE questions (t timez WITHOUt time ZONE)"
            assert_parse_schema "CREATE TABLE questions (t timez WITH TIME ZONE)"
            assert_parse_schema "CREATE TABLE questions (t timez(10) WITHOUt time ZONE)"
            assert_parse_schema "CREATE TABLE questions (t timez(10) WITH TIME ZONE)"
          end

          it 'timestamp' do
            assert_parse_schema "CREATE TABLE questions (t timestamp)"
            assert_parse_schema "CREATE TABLE questions (t timestamp(10))"
            assert_parse_schema "CREATE TABLE questions (t timestamp WITHOUT TIME ZONE)"
            assert_parse_schema "CREATE TABLE questions (t timestamp WITH TIME ZONE)"
            assert_parse_schema "CREATE TABLE questions (t timestamp(10) WITHOUT TIME ZONE)"
            assert_parse_schema "CREATE TABLE questions (t timestamp(10) WITH TIME ZONE)"
          end

          it 'timestampz' do
            assert_parse_schema "CREATE TABLE questions (t timestampz)"
            assert_parse_schema "CREATE TABLE questions (t timestampz(10))"
            assert_parse_schema "CREATE TABLE questions (t timestampz WITHOUt time ZONE)"
            assert_parse_schema "CREATE TABLE questions (t timestampz WITH TIME ZONE)"
            assert_parse_schema "CREATE TABLE questions (t timestampz(10) WITHOUt time ZONE)"
            assert_parse_schema "CREATE TABLE questions (t timestampz(10) WITH TIME ZONE)"
          end
        end

        describe 'column constraints' do
          # [ CONSTRAINT constraint_name ]
          # { NOT NULL |
          #   NULL |
          #   CHECK ( expression ) [ NO INHERIT ] |
          #   DEFAULT default_expr |
          #   UNIQUE index_parameters |
          #   PRIMARY KEY index_parameters |
          #   REFERENCES reftable [ ( refcolumn ) ] [ MATCH FULL | MATCH PARTIAL | MATCH SIMPLE ]
          #     [ ON DELETE action ] [ ON UPDATE action ] }
          # [ DEFERRABLE | NOT DEFERRABLE ] [ INITIALLY DEFERRED | INITIALLY IMMEDIATE ]
          #

          it 'column collation' do
            #  COLLATE collation
            assert_parse_schema "CREATE TABLE answers (id integer, some_text text COLLATE sv_SE)"
          end

          it 'default values' do
            assert_parse_schema "CREATE TABLE answers (id integer, some_num integer DEFAULT 5)"
            assert_parse_schema "CREATE TABLE answers (id integer, some_text text DEFAULT 'this is quoted', another_col char   )"
            assert_parse_schema "CREATE TABLE answers (sign_in_count integer DEFAULT 0     NULL)"
            assert_parse_schema "CREATE TABLE answers (sign_in_count integer DEFAULT 0 NOT NULL)"

          end

          it 'null / not null' do
            assert_parse_schema "CREATE TABLE answers (id integer, something boolean NULL)"
            assert_parse_schema "CREATE TABLE answers (id integer, something char(3) NULL)"
            assert_parse_schema "CREATE TABLE answers (id integer, something boolean NOT NULL)"
          end

          it 'primary key' do
            # PRIMARY KEY index_parameters,
            #  where index_parameters are:
            #    [ WITH ( storage_parameter [= value] [, ... ] ) ]
            #    [ USING INDEX TABLESPACE tablespace_name ]
            #
            assert_parse_schema "CREATE TABLE answers (id integer PRIMARY KEY, something boolean NOT NULL)"
            assert_parse_schema "CREATE TABLE answers (id integer PRIMARY KEY, something boolean NOT NULL)"
            assert_parse_schema "CREATE TABLE answers (id integer PRIMARY KEY (this), something boolean NOT NULL)"
            assert_parse_schema "CREATE TABLE answers (id integer PRIMARY KEY (this, that, another), something boolean NOT NULL)"
            assert_parse_schema "CREATE TABLE answers (id integer PRIMARY KEY USING INDEX TABLESPACE some_table, something boolean NULL)"
            # assert_parse_schema "CREATE TABLE answers (id integer PRIMARY KEY (this, that, another) USING INDEX TABLESPACE some_table, something boolean NULL)"
          end

          it 'unique' do
            assert_parse_schema "CREATE TABLE answers (id integer UNIQUE, something boolean NULL)"
            assert_parse_schema "CREATE TABLE answers (id integer UNIQUE (this), something boolean NULL)"
            assert_parse_schema "CREATE TABLE answers (id integer UNIQUE (this, that, another), something boolean NULL)"
            assert_parse_schema "CREATE TABLE answers (id integer UNIQUE (this, that, another), something boolean NULL)"
            assert_parse_schema "CREATE TABLE answers (id integer UNIQUE USING INDEX TABLESPACE some_table, something boolean NULL)"
            # assert_parse_schema "CREATE TABLE answers (id integer UNIQUE (this, that, another) USING INDEX TABLESPACE some_table, something boolean NULL)"
          end

          it 'check' do
            assert_parse_schema "CREATE TABLE answers (id integer CHECK, something boolean NULL)"
            assert_parse_schema "CREATE TABLE answers (id integer CHECK (some_expression), something boolean NULL)"
            assert_parse_schema "CREATE TABLE answers (id integer CHECK NO INHERIT, something boolean NULL)"
            # assert_parse_schema "CREATE TABLE answers (id integer CHECK (some_expression) NO INHERIT, something boolean NULL)"
          end

          it 'references' do
            # REFERENCES reftable [ ( refcolumn ) ] [ MATCH FULL | MATCH PARTIAL | MATCH SIMPLE ]
            #     [ ON DELETE action ] [ ON UPDATE action ] }
            assert_parse_schema "CREATE TABLE answers (id integer REFERENCES some_table, something boolean NULL)"
            assert_parse_schema "CREATE TABLE answers (id integer REFERENCES some_table (refcolumn), something boolean NULL)"
            assert_parse_schema "CREATE TABLE answers (id integer REFERENCES some_table MATCH FULL, something boolean NULL)"
            assert_parse_schema "CREATE TABLE answers (id integer REFERENCES some_table MATCH PARTIAL, something boolean NULL)"
            assert_parse_schema "CREATE TABLE answers (id integer REFERENCES some_table MATCH SIMPLE, something boolean NULL)"
            assert_parse_schema "CREATE TABLE answers (id integer REFERENCES some_table (refcolumn) MATCH FULL, something boolean NULL)"
            assert_parse_schema "CREATE TABLE answers (id integer REFERENCES some_table (refcolumn) MATCH PARTIAL, something boolean NULL)"
            assert_parse_schema "CREATE TABLE answers (id integer REFERENCES some_table (refcolumn) MATCH SIMPLE, something boolean NULL)"
          end

          it 'collation + defaults + constraints' do
            # assert_parse_schema "CREATE TABLE answers (id integer, something boolean NOT NULL DEFAULT true)"
            assert_parse_schema "CREATE TABLE answers (id integer, something boolean COLLATE sv_SE NOT NULL)"
            assert_parse_schema "CREATE TABLE answers (id integer PRIMARY KEY, something boolean  COLLATE sv_SE DEFERRABLE)"
          end

          it 'deferrable or immediate' do
            assert_parse_schema "CREATE TABLE answers (id integer, something boolean DEFERRABLE)"
            assert_parse_schema "CREATE TABLE answers (id integer, something boolean NOT DEFERRABLE)"

            assert_parse_schema "CREATE TABLE answers (id integer, something boolean INITIALLY DEFERRED)"
            assert_parse_schema "CREATE TABLE answers (id integer, something boolean INITIALLY IMMEDIATE)"

            assert_parse_schema "CREATE TABLE answers (id integer, something boolean DEFERRABLE INITIALLY DEFERRED)"
            assert_parse_schema "CREATE TABLE answers (id integer, something boolean DEFERRABLE INITIALLY IMMEDIATE)"
            assert_parse_schema "CREATE TABLE answers (id integer, something boolean NOT DEFERRABLE INITIALLY DEFERRED)"
            assert_parse_schema "CREATE TABLE answers (id integer, something boolean NOT DEFERRABLE INITIALLY IMMEDIATE)"
          end

          it 'constraint' do
            assert_parse_schema "CREATE TABLE answers (id integer, something boolean CONSTRAINT some_constraint)"
            assert_parse_schema "CREATE TABLE answers (id integer, something boolean CONSTRAINT some_constraint NULL)"
          end

        end

      end

      describe 'table type' do
        # [ GLOBAL | LOCAL ] { TEMPORARY | TEMP } | UNLOGGED ]
        it 'GLOBAL' do
          assert_parse_schema "CREATE GLOBAL TABLE answers_table"
        end
        it 'LOCAL' do
          assert_parse_schema "CREATE LOCAL TABLE answers_table"
        end
        it 'TEMPORARY' do
          assert_parse_schema "CREATE LOCAL TEMPORARY TABLE answers_table"
        end
        it 'TEMP' do
          assert_parse_schema "CREATE LOCAL TEMP TABLE answers_table"
        end
        it 'UNLOGGED' do
          assert_parse_schema "CREATE UNLOGGED GLOBAL TEMPORARY TABLE answers_table"
        end
      end

      it 'if not exists' do
        assert_parse_schema "CREATE TABLE IF NOT EXISTS answers (id integer)"
      end

    end

    describe 'SET statement' do
      # SET [ SESSION | LOCAL ] configuration_parameter { TO | = } { value | 'value' | DEFAULT }
      # SET [ SESSION | LOCAL ] TIME ZONE { timezone | LOCAL | DEFAULT }

      it 'SET configuration_parameter' do
        assert_parse_schema "SET this = 5"
        assert_parse_schema "SET this='that'"
        assert_parse_schema "SET this.here TO 'that'"
        assert_parse_schema "SET LOCAL this = 5"
        assert_parse_schema "SET SESSION this = 5"
      end

      # describe 'SET time zone' do
      #   pending
      # end
    end

    # ALTER TABLE [ IF EXISTS ] [ ONLY ] name [ * ]
    #   action [, ... ]
    # ALTER TABLE [ IF EXISTS ] [ ONLY ] name [ * ]
    #   RENAME [ COLUMN ] column_name TO new_column_name
    # ALTER TABLE [ IF EXISTS ] [ ONLY ] name [ * ]
    #   RENAME CONSTRAINT constraint_name TO new_constraint_name
    # ALTER TABLE [ IF EXISTS ] name
    #   RENAME TO new_name
    # ALTER TABLE [ IF EXISTS ] name
    #   SET SCHEMA new_schema
    # ALTER TABLE ALL IN TABLESPACE name [ OWNED BY role_name [, ... ] ]
    #  SET TABLESPACE new_tablespace [ NOWAIT ]
    #
    # ALTER TABLE public.answers_id_seq OWNER TO deploy;
    #
    # ALTER TABLE public.breed_profiles OWNER TO deploy;
    # ALTER TABLE public.validations_id_seq OWNER TO deploy;
    # ALTER TABLE ONLY public.answers ALTER COLUMN id SET DEFAULT nextval('public.answers_id_seq'::regclass);
    #
    describe 'ALTER TABLE' do

      describe 'ONLY' do

        describe 'actions' do

          describe 'ALTER COLUMN' do
            # ALTER [ COLUMN ] column_name [ SET DATA ] TYPE data_type [ COLLATE collation ] [ USING expression ]
            # ALTER [ COLUMN ] column_name SET DEFAULT expression
            # ALTER [ COLUMN ] column_name DROP DEFAULT
            # ALTER [ COLUMN ] column_name { SET | DROP } NOT NULL
            # ALTER [ COLUMN ] column_name SET STATISTICS integer
            # ALTER [ COLUMN ] column_name SET ( attribute_option = value [, ... ] )
            # ALTER [ COLUMN ] column_name RESET ( attribute_option [, ... ] )
            # ALTER [ COLUMN ] column_name
            #   SET STORAGE { PLAIN | EXTERNAL | EXTENDED | MAIN }

            it 'type' do
              assert_parse_schema "ALTER TABLE sometable ALTER COLUMN a_column SET DATA TYPE integer"
              assert_parse_schema "ALTER TABLE sometable ALTER COLUMN a_column  TYPE integer"
              assert_parse_schema "ALTER TABLE sometable ALTER COLUMN a_column  TYPE integer COLLATE sv_SE"
            end

            describe 'default' do
              it 'simple default true' do
                assert_parse_schema "ALTER TABLE public.answers ALTER COLUMN id SET DEFAULT true"
              end

              it 'with ::' do
                assert_parse_schema "ALTER TABLE public.answers ALTER COLUMN id SET DEFAULT 'public.answers_id_seq'::regclass;"
              end

              it 'nextval' do
                assert_parse_schema "ALTER TABLE public.answers ALTER COLUMN id SET DEFAULT nextval('public.answers_id_seq'::regclass);"
              end
            end

          end

          describe 'ADD COLUMN' do
            pending
          end

          describe 'DROP COLUMN' do
            pending
          end

          # it 'ADD table_constraint' do
          #   assert_parse_schema "ALTER TABLE public.breed_quiz_scoring_keys ADD CONSTRAINT fk_rails_b084479daf FOREIGN KEY (question_id ) NOT VALID"
          #   assert_parse_schema "ALTER TABLE some_table ADD constraint a_table_constraint FOREIGN KEY (column1, column2) REFERENCES reftable NOT VALID"
          # end

          describe 'ALTER TABLE some_table ADD CONSTRAINT table_constraint_using_index' do
            pending
          end

          describe 'ALTER TABLE some_table ALTER CONSTRAINT' do
            # ALTER CONSTRAINT constraint_name [ DEFERRABLE | NOT DEFERRABLE ] [ INITIALLY DEFERRED | INITIALLY IMMEDIATE ]
            pending
          end

          describe 'ALTER TABLE some_table VALIDATE CONSTRAINT constraint_name' do
            pending
          end

          describe 'ALTER TABLE some_table DROP CONSTRAINT constraint_name' do
            pending
          end

          # describe 'DISABLE TRIGGER' do
          #   pending
          # end
          #
          # describe 'ENABLE TRIGGER' do
          #   pending
          # end
          #
          # describe 'ENABLE REPLICA TRIGGER' do
          #   pending
          # end
          #
          # describe 'ENABLE ALWAYS TRIGGER' do
          #   pending
          # end
          #
          # describe 'DISABLE RULE' do
          #   pending
          # end
          #
          # describe 'ENABLE RULE' do
          #   pending
          # end
          #
          # describe 'ENABLE REPLICA RULE' do
          #   pending
          # end
          #
          # describe 'ENABLE ALWAYS RULE' do
          #   pending
          # end
          #
          # describe 'DISABLE ROW LEVEL SECURITY' do
          #   pending
          # end
          #
          # describe 'ENABLE ROW LEVEL SECURITY' do
          #   pending
          # end
          #
          # describe 'FORCE ROW LEVEL SECURITY' do
          #   pending
          # end
          #
          # describe 'NO FORCE ROW LEVEL SECURITY' do
          #   pending
          # end
          #
          # describe 'CLUSTER ON index_name' do
          #   pending
          # end
          #
          # describe 'SET WITHOUT CLUSTER' do
          #   pending
          # end

          describe 'ALTER TABLE some_table SET WITHOUT OIDS' do
            pending
          end

          describe 'ALTER TABLE some_table SET WITH OIDS' do
            pending
          end

          describe 'ALTER TABLE some_table SET TABLESPACE new_tablespace' do
            pending
          end

          describe 'ALTER TABLE some_table SET { LOGGED | UNLOGGED }' do
            pending
          end

          describe 'ALTER TABLE some_table SET ( storage_parameter [= value] [, ... ] )' do
            pending
          end

          describe 'ALTER TABLE some_table RESET ( storage_parameter [, ... ] )' do
            pending
          end

          describe 'ALTER TABLE some_table INHERIT parent_table' do
            pending
          end

          describe 'ALTER TABLE some_table NO INHERIT parent_table' do
            pending
          end

          # describe 'OF type_name' do
          #   pending
          # end
          #
          # describe 'NOT OF' do
          #   pending
          # end

          it 'OWNER TO' do
            assert_parse_schema "ALTER TABLE public.answers OWNER TO deploy;"
          end

          describe 'ALTER TABLE REPLICA IDENTITY' do
            # REPLICA IDENTITY { DEFAULT | USING INDEX index_name | FULL | NOTHING }
            pending
          end
        end

        describe 'RENAME column' do
          pending
        end

        describe 'RENAME constraint' do
          pending
        end

        describe 'ADD CONSTRAINT' do

          it 'foreign_key' do
            sql = "ALTER TABLE ONLY public.breed_quiz_scoring_keys ADD CONSTRAINT fk_rails_b084479daf FOREIGN KEY (question_id )"
            assert_parse_schema(sql)
          end

          it 'foreign_key with newline inbetween' do
            sql = "ALTER TABLE ONLY public.breed_quiz_scoring_keys\n       ADD CONSTRAINT fk_rails_b084479daf FOREIGN KEY (question_id )"
            assert_parse_schema(sql)
          end

          it 'foreign key references' do
            sql = "ALTER TABLE ONLY public.breed_quiz_scoring_keys\n" +
                  "ADD CONSTRAINT fk_rails_b084479daf FOREIGN KEY (question_id) REFERENCES public.questions(id);"
            assert_parse_schema(sql)
          end
        end
      end

      describe 'RENAME TO' do

        it 'ALTER TABLE distributors RENAME TO suppliers;' do
          assert_parse_schema "ALTER TABLE distributors RENAME TO suppliers;"
        end


        it 'ALTER TABLE IF EXISTS distributors RENAME TO suppliers;' do
          assert_parse_schema "ALTER TABLE IF EXISTS distributors RENAME TO suppliers;"
        end

      end

      it 'SET SCHEMA' do
        assert_parse_schema "ALTER TABLE public.a_table SET SCHEMA new_schema;"
        assert_parse_schema "ALTER TABLE IF EXISTS public.a_table SET SCHEMA new_schema;"
      end

      describe 'ALL IN TABLESPACE .. SET TABLESPACE' do
        pending
      end

    end

    describe 'COMMENT ON' do

      ['COLLATION', 'COLUMN', 'CONVERSION',
       'DATABASE', 'DOMAIN', 'EXTENSION', 'EVENT TRIGGER',
       'FOREIGN DATA WRAPPER', 'FOREIGN TABLE',
       'INDEX', 'MATERIALIZED VIEW',
       'ROLE', 'SCHEMA', 'SEQUENCE', 'SERVER', 'TABLE',
       'TEXT SEARCH CONFIGURATION',
       'TEXT SEARCH DICTIONARY', 'TEXT SEARCH PARSER',
       'TEXT SEARCH TEMPLATE',
       'TYPE', 'VIEW'
      ].each do |simple_target|
        it "#{simple_target} some_name" do
          assert_parse_schema "COMMENT ON #{simple_target} something IS 'this'"
        end
      end

      it 'TABLESPACE' do
        assert_parse_schema "COMMENT ON TABLESPACE something IS 'this'"
      end

      it 'EXTENSION' do
        assert_parse_schema "COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language'"
      end

      describe 'aggregate' do

        it 'order by' do
          # assert_parse_schema "COMMENT ON AGGREGATE this ( * ) is 'that'"
          assert_parse_schema "COMMENT ON AGGREGATE this ( integer) is 'that'"
          assert_parse_schema "COMMENT ON AGGREGATE this ( VARIADIC integer) is 'that'"
          assert_parse_schema "COMMENT ON AGGREGATE this ( VARIADIC that integer) is 'that'"
          assert_parse_schema "COMMENT ON AGGREGATE this (ORDER BY varchar) is 'that'"
          assert_parse_schema "COMMENT ON AGGREGATE this (ORDER BY somename varchar) is 'that'"
          assert_parse_schema "COMMENT ON AGGREGATE this (ORDER BY inout somename varchar) is 'that'"
          assert_parse_schema "COMMENT ON AGGREGATE this ( VARIADIC that integer, varchar) is 'that'"
          assert_parse_schema "COMMENT ON AGGREGATE this (ORDER BY inout somename varchar, something_else integer) is 'that'"

          # assert_parse_schema "COMMENT ON AGGREGATE this (integer ORDER BY varchar, integer) is 'that'"
        end

      end

    end

    # CREATE [ TEMPORARY | TEMP ] SEQUENCE [ IF NOT EXISTS ] name [ INCREMENT [ BY ] increment ]
    #     [ MINVALUE minvalue | NO MINVALUE ] [ MAXVALUE maxvalue | NO MAXVALUE ]
    #     [ START [ WITH ] start ] [ CACHE cache ] [ [ NO ] CYCLE ]
    #     [ OWNED BY { table_name.column_name | NONE } ]
    describe 'CREATE SEQUENCE' do

      it 'name' do
        assert_parse_schema "CREATE SEQUENCE counter1"
        assert_parse_schema "CREATE SEQUENCE table.counter1"
        assert_parse_schema "CREATE SEQUENCE schema.table.counter1"
      end

      it 'temporary clause' do
        # assert_parse_schema "CREATE SEQUENCE TEMP counter1"
        assert_parse_schema "CREATE SEQUENCE TEMPORARY counter1"

        assert_parse_schema "CREATE SEQUENCE TEMPORARY counter1 IF NOT EXISTS"

        assert_parse_schema "CREATE SEQUENCE TEMPORARY counter1 INCREMENT 3"
        assert_parse_schema "CREATE SEQUENCE TEMPORARY counter1 INCREMENT BY -3"

        assert_parse_schema "CREATE SEQUENCE TEMPORARY counter1 if not exists INCREMENT 3"
        assert_parse_schema "CREATE SEQUENCE TEMPORARY counter1 INCREMENT BY 3 START 1"
        assert_parse_schema "CREATE SEQUENCE TEMPORARY counter1 INCREMENT BY 3 START WITH 1"
        assert_parse_schema "CREATE SEQUENCE TEMPORARY counter1  START 1"
        assert_parse_schema "CREATE SEQUENCE TEMPORARY counter1  START WITH -10101"
      end

      it 'minvalue' do
        assert_parse_schema "CREATE SEQUENCE  counter1 NO MINVALUE"
        assert_parse_schema "CREATE SEQUENCE  counter1  MINVALUE -90099"
        assert_parse_schema "CREATE SEQUENCE  counter1  MINVALUE +999"
        assert_parse_schema "CREATE SEQUENCE  counter1  MINVALUE 1"
        assert_parse_schema "CREATE SEQUENCE TEMPORARY counter1 NO MINVALUE"
        assert_parse_schema "CREATE SEQUENCE TEMPORARY counter1  MINVALUE -90099"
        # assert_parse_schema "CREATE SEQUENCE TEMPORARY counter1  START WITH +10101 MINVALUE +999"
      end

      it 'maxvalue' do
        assert_parse_schema "CREATE SEQUENCE  counter1 NO MAXVALUE"
        assert_parse_schema "CREATE SEQUENCE  counter1  MAXVALUE -90099"
        assert_parse_schema "CREATE SEQUENCE  counter1  MAXVALUE +999"
        assert_parse_schema "CREATE SEQUENCE  counter1  MAXVALUE 1"
        assert_parse_schema "CREATE SEQUENCE TEMPORARY counter1 NO MAXVALUE"
        assert_parse_schema "CREATE SEQUENCE TEMPORARY counter1  MAXVALUE -90099"
      end

      it 'cache' do
        assert_parse_schema "CREATE SEQUENCE  counter1 CACHE some_cache"
      end

      it 'owned by' do
        assert_parse_schema "CREATE SEQUENCE  counter1 OWNED BY NONE"
        assert_parse_schema "CREATE SEQUENCE  counter1 OWNED BY table_name.column"
      end

      it 'cycle' do
        assert_parse_schema "CREATE SEQUENCE  counter1 CYCLE"
        assert_parse_schema "CREATE SEQUENCE  counter1 NO CYCLE"
        # assert_parse_schema "CREATE SEQUENCE  counter1 NO CYCLE CACHE some_cache OWNED BY table_name.column"
      end
    end

    # ALTER SEQUENCE [ IF EXISTS ] name [ INCREMENT [ BY ] increment ]
    #     [ MINVALUE minvalue | NO MINVALUE ] [ MAXVALUE maxvalue | NO MAXVALUE ]
    #     [ START [ WITH ] start ]
    #     [ RESTART [ [ WITH ] restart ] ]
    #     [ CACHE cache ] [ [ NO ] CYCLE ]
    #     [ OWNED BY { table_name.column_name | NONE } ]
    # ALTER SEQUENCE [ IF EXISTS ] name OWNER TO { new_owner | CURRENT_USER | SESSION_USER }
    # ALTER SEQUENCE [ IF EXISTS ] name RENAME TO new_name
    # ALTER SEQUENCE [ IF EXISTS ] name SET SCHEMA new_schema
    #
    # ALTER SEQUENCE public.breed_quiz_scoring_keys_id_seq OWNED BY public.breed_quiz_scoring_keys.id;
    # ALTER SEQUENCE public.breed_profiles_id_seq OWNED BY public.breed_profiles.id;
    # ALTER SEQUENCE public.columns_id_seq OWNED BY public.columns.id;
    #
    describe 'ALTER SEQUENCE' do

      it 'sequence name' do
        assert_parse_schema "ALTER SEQUENCE counter1"
        assert_parse_schema "ALTER SEQUENCE counters_table.counter1"
        assert_parse_schema "ALTER SEQUENCE public.counters_table.counter1"
        assert_parse_schema "Alter Sequence public.breed_quiz_scoring_keys_id_seq"

        assert_parse_schema "ALTER SEQUENCE IF EXISTS counter1"
      end

      it 'increment' do
        assert_parse_schema "ALTER SEQUENCE  counter1 INCREMENT 3"
        assert_parse_schema "ALTER SEQUENCE  counter1 INCREMENT BY -3"
      end

      it 'start with' do
        assert_parse_schema "ALTER SEQUENCE  counter1 INCREMENT BY 3 START 1"
        assert_parse_schema "ALTER SEQUENCE  counter1 INCREMENT BY 3 START WITH 1"
        assert_parse_schema "ALTER SEQUENCE  counter1  START 1"
        assert_parse_schema "ALTER SEQUENCE  counter1  START WITH -10101"
      end

      it 'minvalue' do
        assert_parse_schema "ALTER SEQUENCE  counter1  NO MINVALUE"
        assert_parse_schema "ALTER SEQUENCE  counter1 MINVALUE -90099"
        assert_parse_schema "ALTER SEQUENCE  counter1  MINVALUE +999"
        assert_parse_schema "ALTER SEQUENCE  counter1  MINVALUE 999"
        assert_parse_schema "ALTER SEQUENCE  counter1  START WITH -10101 NO MINVALUE"
        assert_parse_schema "ALTER SEQUENCE  counter1  START WITH -10101 MINVALUE -90099"
        assert_parse_schema "ALTER SEQUENCE  counter1  START WITH +10101 MINVALUE +999"
      end

      it 'maxvalue' do
        assert_parse_schema "ALTER SEQUENCE  counter1  START WITH -10101 NO MAXVALUE"
        assert_parse_schema "ALTER SEQUENCE  counter1  START WITH -10101 MAXVALUE -90099"
        assert_parse_schema "ALTER SEQUENCE  counter1  START WITH +10101 MAXVALUE +999"
      end

      it 'cache' do
        assert_parse_schema "ALTER SEQUENCE  counter1 CACHE some_cache"
      end

      it 'owned by' do
        assert_parse_schema "ALTER SEQUENCE  counter1 OWNED BY NONE"
        assert_parse_schema "ALTER SEQUENCE  counter1 OWNED BY table_name.column"
        assert_parse_schema "ALTER SEQUENCE public.breed_quiz_scoring_keys_id_seq OWNED BY public.breed_quiz_scoring_keys.id"
      end

      it 'cycle' do
        assert_parse_schema "ALTER SEQUENCE  counter1 CYCLE"
        assert_parse_schema "ALTER SEQUENCE  counter1 NO CYCLE"
        assert_parse_schema "ALTER SEQUENCE  counter1 NO CYCLE CACHE some_cache OWNED BY table_name.column"
      end

      # ALTER SEQUENCE [ IF EXISTS ] name OWNER TO { new_owner | CURRENT_USER | SESSION_USER }
      it 'change owner' do
        assert_parse_schema "ALTER SEQUENCE this OWNED BY table.col"
        assert_parse_schema "ALTER SEQUENCE IF EXISTS this OWNED BY table.col"
        assert_parse_schema "ALTER SEQUENCE this  OWNED BY NONE"
      end

      # ALTER SEQUENCE [ IF EXISTS ] name RENAME TO new_name
      it 'rename' do
        assert_parse_schema "ALTER SEQUENCE this RENAME TO new_name"
        assert_parse_schema "ALTER SEQUENCE IF EXISTS this RENAME TO new_name"
      end

      # ALTER SEQUENCE [ IF EXISTS ] name SET SCHEMA new_schema
      it 'set schema' do
        assert_parse_schema "ALTER SEQUENCE this SET SCHEMA newschema"
        assert_parse_schema "ALTER SEQUENCE IF EXISTS this SET SCHEMA new_schema"
      end
    end

    describe "ALTER TABLE ONLY public.answers ALTER COLUMN id SET DEFAULT nextval('public.answers_id_seq'::regclass);" do
      #   ALTER TABLE ONLY public.questions ALTER COLUMN id SET DEFAULT nextval('public.questions_id_seq'::regclass);
    end

    describe 'GRANT' do

      describe 'privileges on schema to role_specifications' do
        # GRANT role_name [, ...] TO role_specification [, ...]
        #     [ WITH ADMIN OPTION ]
        #     [ GRANTED BY role_specification ]
        # FIXME:  multiple role_names and role_specifications

        all_to_role = "GRANT ALL ON SCHEMA public TO postgres"
        all_to_public = "GRANT ALL ON SCHEMA public TO PUBLIC"
        this_to_them = "GRANT this on schema public to them"
        this_to_group_them = "GRANT this on schema public to GROUP them"
        this_that_to_them = "GRANT this, that on schema public to them"
        this_that_to_them_etc = "GRANT this, that on schema public to them, us, public, current_user"

        base_grant_stmts = [all_to_role, all_to_public, this_to_them,
                            this_to_group_them, this_that_to_them,
                            this_that_to_them_etc]

        it 'basic GRANT statements' do
          assert_parse_schema all_to_role
          assert_parse_schema all_to_public
          assert_parse_schema "GRANT ALL ON SCHEMA public TO CURRENT_USER"
          assert_parse_schema "GRANT ALL ON SCHEMA public TO SESSION_USER"
          assert_parse_schema this_to_them
          assert_parse_schema this_to_group_them
          assert_parse_schema this_that_to_them
          assert_parse_schema this_that_to_them_etc
        end

        context 'WITH ADMIN OPTION' do
          base_grant_stmts.each do |stmt|
            it stmt do
              assert_parse_schema "#{stmt} WITH ADMIN OPTION"
            end
          end
        end

        context 'GRANTED BY' do
          base_grant_stmts.each do |stmt|
            it stmt do
              assert_parse_schema "#{stmt} GRANTED BY us"
              assert_parse_schema "#{stmt} GRANTED BY GROUP us"
              assert_parse_schema "#{stmt} GRANTED BY public"
              assert_parse_schema "#{stmt} GRANTED BY current_user"
              assert_parse_schema "#{stmt} GRANTED BY session_user"
              assert_parse_schema "#{stmt} GRANTED BY session_user, public, GROUP US"
            end
          end
        end
      end

    end

    describe 'REVOKE' do

      describe 'privileges on schemas' do
        # REVOKE [ GRANT OPTION FOR ]
        #     { { CREATE | USAGE } [, ...] | ALL [ PRIVILEGES ] }
        #     ON SCHEMA schema_name [, ...]
        #     FROM role_specification [, ...]
        #     [ CASCADE | RESTRICT ]
        # FIXME: GRANT OPTION FOR
        #   create | usage ..., privileges,
        #    multiple schemas, multiple roled_specifications

        all_from_role = "ALL ON SCHEMA public FROM postgres"
        all_from_public = "ALL ON SCHEMA public FROM PUBLIC"
        all_from_current_user = "ALL ON SCHEMA public FROM CURRENT_USER"
        all_from_session_user = "ALL ON SCHEMA public FROM SESSION_USER"
        create_from_role = "CREATE ON SCHEMA public FROM postgres"
        usage_from_role = "USAGE ON SCHEMA public FROM postgres"

        base_revoke_stmts = [all_from_role, all_from_public,
                             all_from_current_user,
                             all_from_session_user,
                             create_from_role, usage_from_role]

        context 'basic REVOKE statements' do
          base_revoke_stmts.each do |base_stmt|
            base_revoke_stmt = "REVOKE #{base_stmt}"
            it base_revoke_stmt do
              assert_parse_schema base_revoke_stmt
            end
          end
        end

        context 'grant option for' do
          base_revoke_stmts.each do |base_stmt|
            base_grant_opt_for_stmt = "REVOKE GRANT OPTION FOR #{base_stmt}"
            it base_grant_opt_for_stmt do
              assert_parse_schema base_grant_opt_for_stmt
            end
          end
        end

        context 'all privileges' do
          [all_from_role, all_from_public,
           all_from_current_user,
           all_from_session_user].each do |all_stmt|
            all_priv_stmt = "REVOKE #{all_stmt.gsub('ALL', 'ALL PRIVILEGES')}"
            it all_priv_stmt do
              assert_parse_schema all_priv_stmt
            end
          end
        end

        context 'CASCADE' do
          base_revoke_stmts.each do |stmt|
            revoke_cascade_stmt = "REVOKE #{stmt} CASCADE"
            it revoke_cascade_stmt do
              assert_parse_schema revoke_cascade_stmt
            end
          end
        end

        context 'RESTRICT' do
          base_revoke_stmts.each do |stmt|
            revoke_restrict_stmt = "REVOKE #{stmt} RESTRICT"
            it revoke_restrict_stmt do
              assert_parse_schema revoke_restrict_stmt
            end
          end
        end
      end

      describe 'roles from role_specifications' do
        # REVOKE [ ADMIN OPTION FOR ]
        # role_name [, ...] FROM role_specification [, ...]
        # [ GRANTED BY role_specification ]
        # [ CASCADE | RESTRICT ]
        # FIXME: ADMIN OPTION FOR, GRANTED BY

        all_from_role = "ALL ON SCHEMA public FROM postgres"
        all_from_public = "ALL ON SCHEMA public FROM PUBLIC"
        this_from_them = "this on schema public from them"
        this_from_group_them = "this on schema public from GROUP them"
        this_that_from_them = "this, that on schema public from them"
        this_that_from_them_etc = "this, that on schema public from them, us, public, current_user"

        base_revoke_stmts = [all_from_role, all_from_public, this_from_them,
                             this_from_group_them, this_that_from_them,
                             this_that_from_them_etc]

        context 'basic REVOKE statements' do
          base_revoke_stmts.each do |base_stmt|
            base_revoke_stmt = "REVOKE #{base_stmt}"
            it base_revoke_stmt do
              assert_parse_schema base_revoke_stmt
            end
          end
        end

        context 'CASCADE' do
          base_revoke_stmts.each do |stmt|
            it stmt do
              assert_parse_schema "REVOKE #{stmt} CASCADE"
            end
          end
        end

        context 'RESTRICT' do
          base_revoke_stmts.each do |stmt|
            it stmt do
              assert_parse_schema "REVOKE #{stmt} RESTRICT"
            end
          end
        end

      end

    end

    describe 'CREATE EXTENSION' do
      # CREATE EXTENSION [ IF NOT EXISTS ] extension_name
      #        [ WITH ] [ SCHEMA schema_name ]
      #                 [ VERSION version ]
      #                 [ FROM old_version ]
      #                 [ CASCADE ]
      #
      #
      # COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
      # CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
      #
      it 'create extension psql' do
        assert_parse_schema "CREATE EXTENSION  plpgsql;"
        assert_parse_schema "CREATE EXTENSION IF NOT EXISTS plpgsql;"
        assert_parse_schema "CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;"
        assert_parse_schema "CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog VERSION a_version;"
        assert_parse_schema "CREATE EXTENSION IF NOT EXISTS plpgsql SCHEMA pg_catalog CASCADE VERSION 'version string';"
        assert_parse_schema "CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog FROM the_old_version;"
        assert_parse_schema "CREATE EXTENSION IF NOT EXISTS plpgsql SCHEMA pg_catalog CASCADE;"
      end

    end

    describe 'DDL SELECT set_config' do
      #   SELECT pg_catalog.set_config('search_path', '', false);

      it "SELECT pg_catalog.set_config('search_path', '', false);" do
        assert_parse_schema "SELECT pg_catalog.set_config('search_path', '', false);"
      end

    end

    it 'SELECT ... set_val' do
      assert_parse_schema " SELECT pg_catalog.setval('public.answers_id_seq', 1133, true);"
    end

    describe 'COPY data' do

      it 'No data (just header and terminal line)' do
        assert_parse_schema "COPY public.answers (id, question_id, text, short_text, help_text, weight, response_class, reference_identifier, data_export_identifier, common_namespace, common_identifier, display_order, is_exclusive, display_length, custom_class, custom_renderer, created_at, updated_at, default_value, api_id, display_type, input_mask, input_mask_placeholder, original_choice, is_comment, column_id, question_reference_id) FROM stdin;\n" +
                              "\\."
      end

      it 'one line of data' do
        assert_parse_schema "COPY public.answers (id, question_id, text, short_text, help_text, weight, response_class, reference_identifier, data_export_identifier, common_namespace, common_identifier, display_order, is_exclusive, display_length, custom_class, custom_renderer, created_at, updated_at, default_value, api_id, display_type, input_mask, input_mask_placeholder, original_choice, is_comment, column_id, question_reference_id) FROM stdin;\n" +
                              "1097	305	Ja	ja		\N	answer	ja	ja	\N		0	f	\N		\N	2017-04-04 04:04:18.419588	2018-11-16 17:16:26.553073		ab4c282d-de63-46ea-a0d2-038db3dc4f80	default				f	\N	1-haft-hund\n" +
                              "\\."
      end

      it '3 lines of data' do
        assert_parse_schema "COPY public.answers (id, question_id, text, short_text, help_text, weight, response_class, reference_identifier, data_export_identifier, common_namespace, common_identifier, display_order, is_exclusive, display_length, custom_class, custom_renderer, created_at, updated_at, default_value, api_id, display_type, input_mask, input_mask_placeholder, original_choice, is_comment, column_id, question_reference_id) FROM stdin;\n" +
                              "1097	305	Ja	ja		\N	answer	ja	ja	\N		0	f	\N		\N	2017-04-04 04:04:18.419588	2018-11-16 17:16:26.553073		ab4c282d-de63-46ea-a0d2-038db3dc4f80	default				f	\N	1-haft-hund\n" +
                              "1098	305	Nej	nej		\N	answer	nej	nej	\N		1	f	\N		\N	2017-04-04 05:20:08.619815	2018-11-16 17:16:26.553073		2971fe9e-5d73-4bd3-943f-82bd243a94a0	default				f	\N	1-haft-hund\n" +
                              "1104	306	Över 65 år	Över 65 år	För maximal trivsel med hundinnehavet på äldre dar är en lättskött hund att föredra - både med tanke på hundens motionsbehov och pälsvård. Tänk på att ni kan försäkra er mot oron - Vem skall ta hand om hunden om ni till exempel vistas en tid på sjukhus? Tala med ert försäkringsbolag.	\N	answer	65_over	ver_65_r	\N		4	f	\N		\N	2017-04-04 04:04:18.471384	2018-11-16 17:16:26.553073		5aeb0b78-d98f-4b55-89a7-4b35dfd21934	default				f	\N	2-hundägare-ålder\n" +
                              "\\."
      end

      it '3 lines of data, followed by other valid (not copy data)  lines' do
        assert_parse_schema "COPY public.answers (id, question_id, text, short_text, help_text, weight, response_class, reference_identifier, data_export_identifier, common_namespace, common_identifier, display_order, is_exclusive, display_length, custom_class, custom_renderer, created_at, updated_at, default_value, api_id, display_type, input_mask, input_mask_placeholder, original_choice, is_comment, column_id, question_reference_id) FROM stdin;\n" +
                              "1097	305	Ja	ja		\N	answer	ja	ja	\N		0	f	\N		\N	2017-04-04 04:04:18.419588	2018-11-16 17:16:26.553073		ab4c282d-de63-46ea-a0d2-038db3dc4f80	default				f	\N	1-haft-hund\n" +
                              "1098	305	Nej	nej		\N	answer	nej	nej	\N		1	f	\N		\N	2017-04-04 05:20:08.619815	2018-11-16 17:16:26.553073		2971fe9e-5d73-4bd3-943f-82bd243a94a0	default				f	\N	1-haft-hund\n" +
                              "1104	306	Över 65 år	Över 65 år	För maximal trivsel med hundinnehavet på äldre dar är en lättskött hund att föredra - både med tanke på hundens motionsbehov och pälsvård. Tänk på att ni kan försäkra er mot oron - Vem skall ta hand om hunden om ni till exempel vistas en tid på sjukhus? Tala med ert försäkringsbolag.	\N	answer	65_over	ver_65_r	\N		4	f	\N		\N	2017-04-04 04:04:18.471384	2018-11-16 17:16:26.553073		5aeb0b78-d98f-4b55-89a7-4b35dfd21934	default				f	\N	2-hundägare-ålder\n" +
                              "\\.\n" +
                              "\n" +
                              "CREATE TABLE films (" +
                              " code        varchar(5) CONSTRAINT firstkey PRIMARY KEY," +
                              "title       varchar(40) NOT NULL," +
                              "did         integer NOT NULL," +
                              "date_prod   date," +
                              "kind        varchar(10)," +
                              "fine_measurement float );\n" +
                              "\n"
      end
    end

    it 'example with interval hour to minute from postgres doc' do
      assert_parse_schema "CREATE TABLE films (" +
                            " code        varchar(5) CONSTRAINT firstkey PRIMARY KEY," +
                            "title       varchar(40) NOT NULL," +
                            "did         integer NOT NULL," +
                            "date_prod   date," +
                            "kind        varchar(10)," +
                            "fine_measurement float )"
    end

    it 'answers table' do
      sql = "CREATE TABLE public.answers (" +
        "id integer NOT NULL," +
        "question_id integer," +
        "text text," +
        "short_text text," +
        "help_text text," +
        "weight integer," +
        "response_class character varying," +
        "reference_identifier character varying," +
        "display_order integer," +
        "is_exclusive boolean," +
        "created_at timestamp without time zone," +
        "is_comment boolean DEFAULT false," +
        "column_id integer" +
        ")"

      assert_parse_schema sql
    end

    it 'create breed_quiz_scoring table' do
      sql = "CREATE TABLE public.breed_quiz_scoring_keys (" +
        "id integer NOT NULL," +
        "breed_profile_id integer," +
        "question_id integer," +
        "answer_id integer," +
        "score_value integer," +
        "created_at timestamp without time zone NOT NULL," +
        "updated_at timestamp without time zone NOT NULL," +
        "question_reference_id character varying," +
        "answer_reference_id character varying);"
      assert_parse_schema sql
    end

    it 'create table DDL with blank lines between' do

      sql = "CREATE TABLE public.answers (
    updated_at timestamp
);


CREATE TABLE public.answers (
    id integer
);


CREATE TABLE public.breed_profiles ( id integer);


"
      assert_parse_schema sql
    end
  end

  describe 'SQL files' do

    FIXTURES = File.join(__dir__, '..', 'fixtures')
    SMALL_START_SHORT_TABLE = 'start_create_1_table.sql'
    CREATE_TABLES_ONLY = 'rasval_production_20200402_2155-createTables-only.sql'
    RASVAL_AND_BPROFILES = 'rasval_production_20200402_2155-ONLY-answers-breedprofiles.sql'
    ENTIRE_RASVAL_SCHEMA = 'rasval_production_20200402_2155.sql'

    it_should_behave_like 'it can parse sql file', SMALL_START_SHORT_TABLE

    it_should_behave_like 'it can parse sql file', CREATE_TABLES_ONLY

    it_should_behave_like 'it can parse sql file', RASVAL_AND_BPROFILES
  end
end
