--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.19
-- Dumped by pg_dump version 9.5.19

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: answers; Type: TABLE; Schema: public; Owner: deploy
--

CREATE TABLE public.answers (
    id integer NOT NULL,
    question_id integer,
    text text,
    short_text text,
    help_text text,
    weight integer,
    response_class character varying,
    reference_identifier character varying,
    data_export_identifier character varying,
    common_namespace character varying,
    common_identifier character varying,
    display_order integer,
    is_exclusive boolean,
    display_length integer,
    custom_class character varying,
    custom_renderer character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    default_value character varying,
    api_id character varying,
    display_type character varying,
    input_mask character varying,
    input_mask_placeholder character varying,
    original_choice character varying,
    is_comment boolean DEFAULT false,
    column_id integer,
    question_reference_id character varying
);


ALTER TABLE public.answers OWNER TO deploy;

--
-- Name: answers_id_seq; Type: SEQUENCE; Schema: public; Owner: deploy
--

CREATE SEQUENCE public.answers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.answers_id_seq OWNER TO deploy;

--
-- Name: answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: deploy
--

ALTER SEQUENCE public.answers_id_seq OWNED BY public.answers.id;


--
-- Name: breed_profiles; Type: TABLE; Schema: public; Owner: deploy
--

CREATE TABLE public.breed_profiles (
    id integer NOT NULL,
    name character varying,
    signal integer,
    flock integer,
    egna integer,
    jakt integer,
    apport integer,
    vatten integer,
    skall integer,
    vakt integer,
    comments text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    reference_identifier character varying,
    locale character varying,
    aktionradie_text character varying,
    aktionradie integer,
    arbetsbakgrund character varying,
    photo_file_name character varying,
    photo_content_type character varying,
    photo_file_size integer,
    photo_updated_at timestamp without time zone
);


ALTER TABLE public.breed_profiles OWNER TO deploy;

--
-- Name: breed_profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: deploy
--

CREATE SEQUENCE public.breed_profiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.breed_profiles_id_seq OWNER TO deploy;

--
-- Name: breed_profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: deploy
--

ALTER SEQUENCE public.breed_profiles_id_seq OWNED BY public.breed_profiles.id;


--
-- Name: breed_quiz_scoring_keys; Type: TABLE; Schema: public; Owner: deploy
--

CREATE TABLE public.breed_quiz_scoring_keys (
    id integer NOT NULL,
    breed_profile_id integer,
    question_id integer,
    answer_id integer,
    score_value integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    question_reference_id character varying,
    answer_reference_id character varying
);


ALTER TABLE public.breed_quiz_scoring_keys OWNER TO deploy;

--
-- Name: breed_quiz_scoring_keys_id_seq; Type: SEQUENCE; Schema: public; Owner: deploy
--

CREATE SEQUENCE public.breed_quiz_scoring_keys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.breed_quiz_scoring_keys_id_seq OWNER TO deploy;

--
-- Name: breed_quiz_scoring_keys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: deploy
--

ALTER SEQUENCE public.breed_quiz_scoring_keys_id_seq OWNED BY public.breed_quiz_scoring_keys.id;


--
-- Name: columns; Type: TABLE; Schema: public; Owner: deploy
--

CREATE TABLE public.columns (
    id integer NOT NULL,
    question_group_id integer,
    text text,
    answers_textbox text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.columns OWNER TO deploy;

--
-- Name: columns_id_seq; Type: SEQUENCE; Schema: public; Owner: deploy
--

CREATE SEQUENCE public.columns_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.columns_id_seq OWNER TO deploy;

--
-- Name: columns_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: deploy
--

ALTER SEQUENCE public.columns_id_seq OWNED BY public.columns.id;


--
-- Name: dependencies; Type: TABLE; Schema: public; Owner: deploy
--

CREATE TABLE public.dependencies (
    id integer NOT NULL,
    question_id integer,
    question_group_id integer,
    rule character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.dependencies OWNER TO deploy;

--
-- Name: dependencies_id_seq; Type: SEQUENCE; Schema: public; Owner: deploy
--

CREATE SEQUENCE public.dependencies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dependencies_id_seq OWNER TO deploy;

--
-- Name: dependencies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: deploy
--

ALTER SEQUENCE public.dependencies_id_seq OWNED BY public.dependencies.id;


--
-- Name: dependency_conditions; Type: TABLE; Schema: public; Owner: deploy
--

CREATE TABLE public.dependency_conditions (
    id integer NOT NULL,
    dependency_id integer,
    rule_key character varying,
    question_id integer,
    operator character varying,
    answer_id integer,
    datetime_value timestamp without time zone,
    integer_value integer,
    float_value double precision,
    unit character varying,
    text_value text,
    string_value character varying,
    response_other character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    column_id integer
);


ALTER TABLE public.dependency_conditions OWNER TO deploy;

--
-- Name: dependency_conditions_id_seq; Type: SEQUENCE; Schema: public; Owner: deploy
--

CREATE SEQUENCE public.dependency_conditions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dependency_conditions_id_seq OWNER TO deploy;

--
-- Name: dependency_conditions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: deploy
--

ALTER SEQUENCE public.dependency_conditions_id_seq OWNED BY public.dependency_conditions.id;


--
-- Name: question_additional_infos; Type: TABLE; Schema: public; Owner: deploy
--

CREATE TABLE public.question_additional_infos (
    id integer NOT NULL,
    question_id integer,
    locale character varying DEFAULT 'sv'::character varying NOT NULL,
    not_a_match_explanation character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    question_reference_id character varying
);


ALTER TABLE public.question_additional_infos OWNER TO deploy;

--
-- Name: question_additional_infos_id_seq; Type: SEQUENCE; Schema: public; Owner: deploy
--

CREATE SEQUENCE public.question_additional_infos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.question_additional_infos_id_seq OWNER TO deploy;

--
-- Name: question_additional_infos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: deploy
--

ALTER SEQUENCE public.question_additional_infos_id_seq OWNED BY public.question_additional_infos.id;


--
-- Name: question_groups; Type: TABLE; Schema: public; Owner: deploy
--

CREATE TABLE public.question_groups (
    id integer NOT NULL,
    text text,
    help_text text,
    reference_identifier character varying,
    data_export_identifier character varying,
    common_namespace character varying,
    common_identifier character varying,
    display_type character varying,
    custom_class character varying,
    custom_renderer character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    api_id character varying
);


ALTER TABLE public.question_groups OWNER TO deploy;

--
-- Name: question_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: deploy
--

CREATE SEQUENCE public.question_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.question_groups_id_seq OWNER TO deploy;

--
-- Name: question_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: deploy
--

ALTER SEQUENCE public.question_groups_id_seq OWNED BY public.question_groups.id;


--
-- Name: questions; Type: TABLE; Schema: public; Owner: deploy
--

CREATE TABLE public.questions (
    id integer NOT NULL,
    survey_section_id integer,
    question_group_id integer,
    text text,
    short_text text,
    help_text text,
    pick character varying,
    reference_identifier character varying,
    data_export_identifier character varying,
    common_namespace character varying,
    common_identifier character varying,
    display_order integer,
    display_type character varying,
    is_mandatory boolean,
    display_width integer,
    custom_class character varying,
    custom_renderer character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    correct_answer_id integer,
    api_id character varying,
    modifiable boolean DEFAULT true,
    dynamically_generate boolean DEFAULT false,
    dummy_blob character varying,
    dynamic_source character varying,
    report_code character varying,
    is_comment boolean DEFAULT false,
    preamble text,
    postscript text
);


ALTER TABLE public.questions OWNER TO deploy;

--
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: deploy
--

CREATE SEQUENCE public.questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.questions_id_seq OWNER TO deploy;

--
-- Name: questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: deploy
--

ALTER SEQUENCE public.questions_id_seq OWNED BY public.questions.id;


--
-- Name: quiz_scores; Type: TABLE; Schema: public; Owner: deploy
--

CREATE TABLE public.quiz_scores (
    id integer NOT NULL,
    response_set_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.quiz_scores OWNER TO deploy;

--
-- Name: quiz_scores_id_seq; Type: SEQUENCE; Schema: public; Owner: deploy
--

CREATE SEQUENCE public.quiz_scores_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quiz_scores_id_seq OWNER TO deploy;

--
-- Name: quiz_scores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: deploy
--

ALTER SEQUENCE public.quiz_scores_id_seq OWNED BY public.quiz_scores.id;


--
-- Name: response_sets; Type: TABLE; Schema: public; Owner: deploy
--

CREATE TABLE public.response_sets (
    id integer NOT NULL,
    user_id integer,
    survey_id integer,
    access_code character varying,
    started_at timestamp without time zone,
    completed_at timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    api_id character varying,
    test_data boolean DEFAULT false
);


ALTER TABLE public.response_sets OWNER TO deploy;

--
-- Name: response_sets_id_seq; Type: SEQUENCE; Schema: public; Owner: deploy
--

CREATE SEQUENCE public.response_sets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.response_sets_id_seq OWNER TO deploy;

--
-- Name: response_sets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: deploy
--

ALTER SEQUENCE public.response_sets_id_seq OWNED BY public.response_sets.id;


--
-- Name: responses; Type: TABLE; Schema: public; Owner: deploy
--

CREATE TABLE public.responses (
    id integer NOT NULL,
    response_set_id integer,
    question_id integer,
    answer_id integer,
    datetime_value timestamp without time zone,
    integer_value integer,
    float_value double precision,
    unit character varying,
    text_value text,
    string_value character varying,
    response_other character varying,
    response_group character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    survey_section_id integer,
    api_id character varying,
    blob character varying,
    column_id integer
);


ALTER TABLE public.responses OWNER TO deploy;

--
-- Name: responses_id_seq; Type: SEQUENCE; Schema: public; Owner: deploy
--

CREATE SEQUENCE public.responses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.responses_id_seq OWNER TO deploy;

--
-- Name: responses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: deploy
--

ALTER SEQUENCE public.responses_id_seq OWNED BY public.responses.id;


--
-- Name: rows; Type: TABLE; Schema: public; Owner: deploy
--

CREATE TABLE public.rows (
    id integer NOT NULL,
    question_group_id integer,
    text character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.rows OWNER TO deploy;

--
-- Name: rows_id_seq; Type: SEQUENCE; Schema: public; Owner: deploy
--

CREATE SEQUENCE public.rows_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rows_id_seq OWNER TO deploy;

--
-- Name: rows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: deploy
--

ALTER SEQUENCE public.rows_id_seq OWNED BY public.rows.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: deploy
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO deploy;

--
-- Name: survey_sections; Type: TABLE; Schema: public; Owner: deploy
--

CREATE TABLE public.survey_sections (
    id integer NOT NULL,
    survey_id integer,
    title character varying,
    description text,
    reference_identifier character varying,
    data_export_identifier character varying,
    common_namespace character varying,
    common_identifier character varying,
    display_order integer,
    custom_class character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    modifiable boolean DEFAULT true
);


ALTER TABLE public.survey_sections OWNER TO deploy;

--
-- Name: survey_sections_id_seq; Type: SEQUENCE; Schema: public; Owner: deploy
--

CREATE SEQUENCE public.survey_sections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.survey_sections_id_seq OWNER TO deploy;

--
-- Name: survey_sections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: deploy
--

ALTER SEQUENCE public.survey_sections_id_seq OWNED BY public.survey_sections.id;


--
-- Name: survey_translations; Type: TABLE; Schema: public; Owner: deploy
--

CREATE TABLE public.survey_translations (
    id integer NOT NULL,
    survey_id integer,
    locale character varying,
    translation text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.survey_translations OWNER TO deploy;

--
-- Name: survey_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: deploy
--

CREATE SEQUENCE public.survey_translations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.survey_translations_id_seq OWNER TO deploy;

--
-- Name: survey_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: deploy
--

ALTER SEQUENCE public.survey_translations_id_seq OWNED BY public.survey_translations.id;


--
-- Name: surveys; Type: TABLE; Schema: public; Owner: deploy
--

CREATE TABLE public.surveys (
    id integer NOT NULL,
    title character varying,
    description text,
    access_code character varying,
    reference_identifier character varying,
    data_export_identifier character varying,
    common_namespace character varying,
    common_identifier character varying,
    active_at timestamp without time zone,
    inactive_at timestamp without time zone,
    css_url character varying,
    custom_class character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    display_order integer,
    api_id character varying,
    survey_version integer DEFAULT 0,
    redirect_url character varying,
    template boolean DEFAULT false,
    user_id integer,
    preamble text,
    postscript text
);


ALTER TABLE public.surveys OWNER TO deploy;

--
-- Name: surveys_id_seq; Type: SEQUENCE; Schema: public; Owner: deploy
--

CREATE SEQUENCE public.surveys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.surveys_id_seq OWNER TO deploy;

--
-- Name: surveys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: deploy
--

ALTER SEQUENCE public.surveys_id_seq OWNED BY public.surveys.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: deploy
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    first_name character varying,
    last_name character varying,
    greeting character varying,
    is_admin boolean DEFAULT false
);


ALTER TABLE public.users OWNER TO deploy;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: deploy
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO deploy;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: deploy
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: validation_conditions; Type: TABLE; Schema: public; Owner: deploy
--

CREATE TABLE public.validation_conditions (
    id integer NOT NULL,
    validation_id integer,
    rule_key character varying,
    operator character varying,
    question_id integer,
    answer_id integer,
    datetime_value timestamp without time zone,
    integer_value integer,
    float_value double precision,
    unit character varying,
    text_value text,
    string_value character varying,
    response_other character varying,
    regexp character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.validation_conditions OWNER TO deploy;

--
-- Name: validation_conditions_id_seq; Type: SEQUENCE; Schema: public; Owner: deploy
--

CREATE SEQUENCE public.validation_conditions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.validation_conditions_id_seq OWNER TO deploy;

--
-- Name: validation_conditions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: deploy
--

ALTER SEQUENCE public.validation_conditions_id_seq OWNED BY public.validation_conditions.id;


--
-- Name: validations; Type: TABLE; Schema: public; Owner: deploy
--

CREATE TABLE public.validations (
    id integer NOT NULL,
    answer_id integer,
    rule character varying,
    message character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.validations OWNER TO deploy;

--
-- Name: validations_id_seq; Type: SEQUENCE; Schema: public; Owner: deploy
--

CREATE SEQUENCE public.validations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.validations_id_seq OWNER TO deploy;

--
-- Name: validations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: deploy
--

ALTER SEQUENCE public.validations_id_seq OWNED BY public.validations.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: deploy
--

ALTER TABLE ONLY public.answers ALTER COLUMN id SET DEFAULT nextval('public.answers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: deploy
--

ALTER TABLE ONLY public.breed_profiles ALTER COLUMN id SET DEFAULT nextval('public.breed_profiles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: deploy
--

ALTER TABLE ONLY public.breed_quiz_scoring_keys ALTER COLUMN id SET DEFAULT nextval('public.breed_quiz_scoring_keys_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: deploy
--

ALTER TABLE ONLY public.columns ALTER COLUMN id SET DEFAULT nextval('public.columns_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: deploy
--

ALTER TABLE ONLY public.dependencies ALTER COLUMN id SET DEFAULT nextval('public.dependencies_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: deploy
--

ALTER TABLE ONLY public.dependency_conditions ALTER COLUMN id SET DEFAULT nextval('public.dependency_conditions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: deploy
--

ALTER TABLE ONLY public.question_additional_infos ALTER COLUMN id SET DEFAULT nextval('public.question_additional_infos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: deploy
--

ALTER TABLE ONLY public.question_groups ALTER COLUMN id SET DEFAULT nextval('public.question_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: deploy
--

ALTER TABLE ONLY public.questions ALTER COLUMN id SET DEFAULT nextval('public.questions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: deploy
--

ALTER TABLE ONLY public.quiz_scores ALTER COLUMN id SET DEFAULT nextval('public.quiz_scores_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: deploy
--

ALTER TABLE ONLY public.response_sets ALTER COLUMN id SET DEFAULT nextval('public.response_sets_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: deploy
--

ALTER TABLE ONLY public.responses ALTER COLUMN id SET DEFAULT nextval('public.responses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: deploy
--

ALTER TABLE ONLY public.rows ALTER COLUMN id SET DEFAULT nextval('public.rows_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: deploy
--

ALTER TABLE ONLY public.survey_sections ALTER COLUMN id SET DEFAULT nextval('public.survey_sections_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: deploy
--

ALTER TABLE ONLY public.survey_translations ALTER COLUMN id SET DEFAULT nextval('public.survey_translations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: deploy
--

ALTER TABLE ONLY public.surveys ALTER COLUMN id SET DEFAULT nextval('public.surveys_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: deploy
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: deploy
--

ALTER TABLE ONLY public.validation_conditions ALTER COLUMN id SET DEFAULT nextval('public.validation_conditions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: deploy
--

ALTER TABLE ONLY public.validations ALTER COLUMN id SET DEFAULT nextval('public.validations_id_seq'::regclass);


--
-- Data for Name: answers; Type: TABLE DATA; Schema: public; Owner: deploy
--

COPY public.answers (id, question_id, text, short_text, help_text, weight, response_class, reference_identifier, data_export_identifier, common_namespace, common_identifier, display_order, is_exclusive, display_length, custom_class, custom_renderer, created_at, updated_at, default_value, api_id, display_type, input_mask, input_mask_placeholder, original_choice, is_comment, column_id, question_reference_id) FROM stdin;
1097	305	Ja	ja		\N	answer	ja	ja	\N		0	f	\N		\N	2017-04-04 04:04:18.419588	2018-11-16 17:16:26.553073		ab4c282d-de63-46ea-a0d2-038db3dc4f80	default				f	\N	1-haft-hund
1098	305	Nej	nej		\N	answer	nej	nej	\N		1	f	\N		\N	2017-04-04 05:20:08.619815	2018-11-16 17:16:26.553073		2971fe9e-5d73-4bd3-943f-82bd243a94a0	default				f	\N	1-haft-hund
1099	305	Ja, tillsammans med föräldrarna	Ja, tillsammans med föräldrarna		\N	answer	ja_med_föräldrar	tillsammans_med_f_r_ldrarna	\N		2	f	\N		\N	2017-04-06 16:50:13.376	2018-11-16 17:16:26.553073		686a0b7e-68f2-4cc8-842b-c9d01358e830	default				f	\N	1-haft-hund
1100	306	15-23 år	15-23 år		\N	answer	15_23	15_23_r	\N		0	f	\N		\N	2017-04-04 04:04:18.441208	2018-11-16 17:16:26.553073		4aef2318-56f7-4b06-85f2-0f0bf0214d79	default				f	\N	2-hundägare-ålder
1101	306	24-35 år	24-35 år		\N	answer	24_35	24_35_r	\N		1	f	\N		\N	2017-04-04 04:04:18.448732	2018-11-16 17:16:26.553073		0391ca70-41f5-495a-9ea7-cb80d40de66a	default				f	\N	2-hundägare-ålder
1102	306	36-50 år	36-50 år		\N	answer	36_50	36_50_r	\N		2	f	\N		\N	2017-04-04 04:04:18.455847	2018-11-16 17:16:26.553073		2482931a-9dae-47a4-a8a9-d9d57b75d2f4	default				f	\N	2-hundägare-ålder
1103	306	51-65 år	51-65 år		\N	answer	51_65	51_65_r	\N		3	f	\N		\N	2017-04-04 04:04:18.46336	2018-11-16 17:16:26.553073		189912e5-40d0-49ae-b80d-cce5028eaf83	default				f	\N	2-hundägare-ålder
1104	306	Över 65 år	Över 65 år	För maximal trivsel med hundinnehavet på äldre dar är en lättskött hund att föredra - både med tanke på hundens motionsbehov och pälsvård. Tänk på att ni kan försäkra er mot oron - Vem skall ta hand om hunden om ni till exempel vistas en tid på sjukhus? Tala med ert försäkringsbolag.	\N	answer	65_over	ver_65_r	\N		4	f	\N		\N	2017-04-04 04:04:18.471384	2018-11-16 17:16:26.553073		5aeb0b78-d98f-4b55-89a7-4b35dfd21934	default				f	\N	2-hundägare-ålder
1105	307	Inga barn	Inga barn		\N	answer	inga_barn	inga_barn	\N		0	f	\N		\N	2017-04-04 04:04:18.499799	2018-11-16 17:16:26.553073		da15e7ec-91dc-438d-a4b1-8393d68c4628	default				f	\N	3-yngsta-besökande-barn
1106	307	0-6 år	0-6 år	Barn tar mycket tid, och anledningen till att betydligt färre hundar passar om du kryssar i detta val är att hundar som kräver mycket tid av sin ägare väljs bort.	\N	answer	0_8	0_6_r	\N		1	f	\N		\N	2017-04-04 04:04:18.507559	2018-11-16 17:16:26.553073		2754127b-ecfa-48ff-ba2e-720d6860002f	default				f	\N	3-yngsta-besökande-barn
1107	307	7-12 år	7-12 år		\N	answer	9_12	7_12_r	\N		2	f	\N		\N	2017-04-04 04:04:18.515306	2018-11-16 17:16:26.553073		c1c06646-d482-4e54-a781-6aab410696f5	default				f	\N	3-yngsta-besökande-barn
1108	307	13-19 år	13-19 år		\N	answer	13_19	13_19_r	\N		3	f	\N		\N	2017-04-04 04:04:18.521746	2018-11-16 17:16:26.553073		d6a785fd-8dd3-4216-a478-a41e0355c802	default				f	\N	3-yngsta-besökande-barn
1109	308	Sällskap	Sällskap		\N	answer	sallskap	s_llskap	\N		0	f	\N		\N	2017-04-04 04:04:18.536272	2018-11-16 17:16:26.553073		dd79621c-1d86-4663-8a4b-dc53eb18a2c6	default				f	\N	4-funktion
1110	308	Tjänstehund / jakthund	Tjänstehund / jakthund		\N	answer	tjanstehund	tj_nstehund_jakthund	\N		1	f	\N		\N	2017-04-04 04:04:18.543227	2018-11-16 17:16:26.553073		613feeb1-93c9-4748-a271-b475c35dab9f	default				f	\N	4-funktion
1111	308	Aktiv med hundsport	Aktiv med hundsport		\N	answer	hundsport	aktiv_med_hundsport	\N		2	f	\N		\N	2017-04-04 04:04:18.549777	2018-11-16 17:16:26.553073		94d796d1-ab9d-4725-a8b6-c6081aaf1ac2	default				f	\N	4-funktion
1112	312	Polis / Vakt	Polis / Vakt		\N	answer	polis_vakt	polis_vakt	\N		0	f	\N		\N	2017-04-04 04:04:18.570975	2018-11-16 17:16:26.553073		b9d9fcfa-0c0a-4565-9aaa-688e987cdf83	default				f	\N	5-funktion-jakt
1113	312	Tull / Fjällräddning	Tull / Fjällräddning		\N	answer	tull_fjallraddning	tull_fj_llr_ddning	\N		1	f	\N		\N	2017-04-04 04:04:18.579421	2018-11-16 17:16:26.553073		96d34aff-1ff7-4ef1-a47d-eb364fd22ca7	default				f	\N	5-funktion-jakt
1114	312	Får / Ren / Boskaps / Gåsvallare	Får / Ren / Boskaps / Gåsvallare		\N	answer	far_ren_boskaps	r_ren_boskaps_g_svallare	\N		2	f	\N		\N	2017-04-04 04:04:18.585891	2018-11-16 17:16:26.553073		2071a805-d8eb-4b22-b68c-1f5f1043eae9	default				f	\N	5-funktion-jakt
1115	312	Badvakt / Fiskare	Badvakt / Fiskare		\N	answer	badvakt	badvakt_fiskare	\N		5	f	\N		\N	2017-04-06 17:12:10.144	2018-11-16 17:16:26.553073		b08f208b-3af4-4918-999b-b9f54bbb3af0	default				f	\N	5-funktion-jakt
1116	312	Fågeljakt	Fågeljakt		\N	answer	fageljakt	f_geljakt	\N		6	f	\N		\N	2017-04-06 17:12:12.995	2018-11-16 17:16:26.553073		f27f83e5-3ef5-4c88-a492-721704ab6b3e	default				f	\N	5-funktion-jakt
1117	312	Småviltjakt	Småviltjakt		\N	answer	smaviltjakt	sm_viltjakt	\N		8	f	\N		\N	2017-04-06 17:12:14.639	2018-11-16 17:16:26.553073		cbea0cac-261f-42ae-8003-35c6c40400ec	default				f	\N	5-funktion-jakt
1118	312	Klövviltjakt	Klövviltjakt		\N	answer	klovviltjakt	kl_vviltjakt	\N		7	f	\N		\N	2017-04-06 17:12:16.228	2018-11-16 17:16:26.553073		a75df768-c614-4fd3-bd71-a9041ee53b00	default				f	\N	5-funktion-jakt
1119	312	Apporterande	Apporterande		\N	answer	apporterande	apporterande	\N		9	f	\N		\N	2017-04-06 17:12:18.965	2018-11-16 17:16:26.553073		f6f2364d-83bb-4007-8fa0-7e80bc2e1084	default				f	\N	5-funktion-jakt
1120	312	Herdehund	Herdehund		\N	answer	herdehund	herdehund	\N		3	f	\N		\N	2017-04-06 17:12:17.64	2018-11-16 17:16:26.553073		f546ff61-00af-4434-97b0-4d0b62fcf652	default				f	\N	5-funktion-jakt
1121	312	Eftersök	Eftersök		\N	answer	eftersok	efters_k	\N		10	f	\N		\N	2017-04-06 17:12:20.351	2018-11-16 17:16:26.553073		5f7f631f-4341-49dd-a117-431a52292c56	default				f	\N	5-funktion-jakt
1123	309	En gång per vecka	En gång per vecka		\N	answer	en_gang	en_g_ng_per_vecka	\N		0	f	\N		\N	2017-04-04 04:04:18.608105	2018-11-16 17:16:26.553073		87928451-89b4-4ef1-82e4-109370ebd665	default				f	\N	6-vecko-pälsvård-tid
1124	309	Tre gånger per vecka	Tre gånger per vecka		\N	answer	tre_ganger	tre_g_nger_per_vecka	\N		1	f	\N		\N	2017-04-04 04:04:18.616232	2018-11-16 17:16:26.553073		c25841e9-89ab-4c34-bc63-9f4950fa2425	default				f	\N	6-vecko-pälsvård-tid
1125	309	Dagligen	Dagligen		\N	answer	dagligen	dagligen	\N		2	f	\N		\N	2017-04-06 16:59:32.585	2018-11-16 17:16:26.553073		1fb17f38-903c-4e1c-886b-10d0e2993c43	default				f	\N	6-vecko-pälsvård-tid
1131	311	En timme om dagen	En timme om dagen		\N	answer	en_timme	en_timme_om_dagen	\N		0	f	\N		\N	2017-04-04 04:04:18.674456	2018-11-16 17:16:26.553073		97c931ef-2709-46b3-a952-07c52c0e4d6a	default				f	\N	8-ute-tid-per-dag
1132	311	Två timmar om dagen	Två timmar om dagen		\N	answer	tva_timmar	tv_timmar_om_dagen	\N		1	f	\N		\N	2017-04-04 04:04:18.682469	2018-11-16 17:16:26.553073		dbd4bd8f-c9ef-4cf8-b704-d2724dbd98de	default				f	\N	8-ute-tid-per-dag
1126	310	Mycket liten (English Toy Terrier, Chihuahua, Dvärgspets…)	Mycket liten		\N	answer	mycket_liten	mycket_liten	\N		0	f	\N		\N	2017-04-04 04:04:18.631328	2018-11-16 17:16:26.553073		0a611676-9ea6-4bf5-9e3e-92ab55889a1f	default				f	\N	7-storlek
1127	310	Liten (Shih Tzu, Fransk Bulldog, Dans/Svensk Gårdshund…)	Liten		\N	answer	liten	liten	\N		1	f	\N		\N	2017-04-04 04:04:18.639275	2018-11-16 17:16:26.553073		c48f75a6-40af-4565-b8dc-459e1b6493ce	default				f	\N	7-storlek
1130	310	Mycket stor (Afganhund, Leonberger, Grand Danois…)	Mycket stor		\N	answer	mycket_stor	mycket_stor	\N		4	f	\N		\N	2017-04-04 04:04:18.660285	2018-11-16 17:16:26.553073		c9ba62de-f1db-48f0-8e30-c98fd1c674a4	default				f	\N	7-storlek
1128	310	Mellanstor (Cocker Spaniel, Norsk Buhund, Kelpie…)	Mellanstor		\N	answer	mellanstor	mellanstor	\N		2	f	\N		\N	2017-04-04 04:04:18.646005	2018-11-16 17:16:26.553073		7a8cb1d9-75c0-4d0a-b629-8fa3c2cf51a9	default				f	\N	7-storlek
1129	310	Stor (Schäfer, Airedaleterrier, Jämthund…)	Stor		\N	answer	stor	stor	\N		3	f	\N		\N	2017-04-04 04:04:18.653817	2018-11-16 17:16:26.553073		aa107dcf-ed82-456e-ac42-207abf0e6df6	default				f	\N	7-storlek
1133	311	Mer än två timmar per dag	Mer än två timmar per dag		\N	answer	mer_an_tva_timmar	n_tv_timmar_per_dag	\N		2	f	\N		\N	2017-04-04 04:04:18.689404	2018-11-16 17:16:26.553073		093847b7-1906-4794-ad69-2b0da0805b7e	default				f	\N	8-ute-tid-per-dag
1122	312	Assistans - Drag / Släd	Assistan - Drag / Släd		\N	answer	asistans_drag	assistans_drag_drag_sl_d	\N		4	f	\N		\N	2017-04-06 17:12:22.099	2018-11-16 17:16:26.553073		d56510e0-bded-48f2-bc7f-bb4cb69f3e98	default				f	\N	5-funktion-jakt
\.


--
-- Name: answers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: deploy
--

SELECT pg_catalog.setval('public.answers_id_seq', 1133, true);


--
-- Data for Name: breed_profiles; Type: TABLE DATA; Schema: public; Owner: deploy
--

COPY public.breed_profiles (id, name, signal, flock, egna, jakt, apport, vatten, skall, vakt, comments, created_at, updated_at, reference_identifier, locale, aktionradie_text, aktionradie, arbetsbakgrund, photo_file_name, photo_content_type, photo_file_size, photo_updated_at) FROM stdin;
4698	Welsh corgi pembroke	80	70	30	20	10	10	60	50		2017-04-28 09:47:10.708328	2018-11-16 17:16:25.810308	Welsh_corgi_pembroke	sv	Nära	\N	Lantbruks och Gårdshund, Vallare	welsh_corgi_pembroke_1.jpg	image/jpeg	110963	2017-04-28 10:30:08.943223
4489	Australian cattledog	80	90	30	40	20	30	40	70		2017-04-28 09:47:09.508784	2018-11-16 17:16:25.810308	Australian_cattledog	sv	Nära - Längre bort	\N	Lantbruks och Gårdshund, Boskapsvallare	australian_cattledog.jpg	image/jpeg	83039	2017-05-06 22:47:06.720234
4495	Basenji	90	30	90	90	0	70	10	60		2017-04-28 09:47:09.545525	2018-11-16 17:16:25.810308	Basenji	sv	Nära - Mycket långt bort	\N	Sökande och Ställande Jakthund	basenji.jpg	image/jpeg	142768	2017-05-06 22:54:09.23261
4550	Engelsk springer spaniel	80	80	30	90	100	100	20	40		2017-04-28 09:47:09.835791	2018-11-16 17:16:25.810308	Engelsk_springer_spaniel	sv	Nära - Längre bort	\N	Stötande och Apporterande Fågelhund	engelsk_springer_spaniel_1.jpg	image/jpeg	151868	2017-04-28 10:07:54.56526
4573	Griffon bruxellois	30	80	20	40	0	0	40	60		2017-04-28 09:47:09.944221	2018-11-16 17:16:25.810308	Griffon_bruxellois	sv	Mycket nära - Nära	\N	Gryt och Råtthund	griffon_bruxellois_1_1.jpg	image/jpeg	139873	2017-04-28 10:08:03.63646
4600	Kooikerhondje	90	90	20	80	80	100	10	30		2017-04-28 09:47:10.083647	2018-11-16 17:16:25.810308	Kooikerhondje	sv	Nära - Längre bort	\N	Stötande och Apporterande Fågelhund	kooikerhondje_.jpg	image/jpeg	146629	2017-04-28 10:10:36.949905
4501	Bearded collie	30	90	20	40	20	40	60	40		2017-04-28 09:47:09.584033	2018-11-16 17:16:25.810308	Bearded_collie	sv	Nära - Längre bort	\N	Fårvallare	bearded_collie.jpg	image/jpeg	124302	2017-05-06 22:55:56.596778
4596	Kerry blue terrier	30	70	40	50	20	20	20	70		2017-04-28 09:47:10.063521	2018-11-16 17:16:25.810308	Kerry_blue_terrier	sv	Nära - Längre bort	\N	Gryt och Råtthund	kerry_blue_terrier.jpg	image/jpeg	115401	2017-04-28 10:18:22.445926
4605	Lagotto romagnolo	60	80	20	80	100	100	20	20		2017-04-28 09:47:10.113906	2018-11-16 17:16:25.810308	Lagotto_romagnolo	sv	Nära - Längre bort	\N	Stötande och Apporterande Fågelhund	lagotto_romagnolo.jpg	image/jpeg	244491	2017-04-28 10:20:58.936887
4612	Löwchen	50	80	30	10	0	0	20	30		2017-04-28 09:47:10.160465	2018-11-16 17:16:25.810308	Löwchen	sv	Mycket nära - Nära	\N	Arbetande Sällskapshund	lowchen.jpg	image/jpeg	132398	2017-04-28 10:22:05.242835
4654	Sankt bernhardshund	80	70	40	20	20	40	20	70		2017-04-28 09:47:10.446584	2018-11-16 17:16:25.810308	Sankt_bernhardshund	sv	Nära	\N	Lantbruks och Gårdshund	sankt_bernhardshund_langh.jpg	image/jpeg	107586	2017-04-28 10:28:46.047192
4506	Bichon frisé	80	90	10	30	20	20	40	50		2017-04-28 09:47:09.608287	2018-11-16 17:16:25.810308	Bichon_frisé	sv	Mycket nära - Nära	\N	Arbetande Sällskapshund	bichon_frise.jpg	image/jpeg	105613	2017-05-06 22:58:07.216276
4487	Amerikansk cocker spaniel	50	90	30	90	100	100	60	50		2017-04-28 09:47:09.495841	2018-11-16 17:16:25.810308	Amerikansk_cocker_spaniel	sv	Nära - Längre bort	\N	Stötande och Apporterande Fågelhund	amerikansk_cocker_spaniel_1.jpg	image/jpeg	130227	2017-04-28 10:06:26.967945
4513	Bouvier des flandres	60	80	30	20	20	30	40	80		2017-04-28 09:47:09.642429	2018-11-16 17:16:25.810308	Bouvier_des_flandres	sv	Nära - Längre bort	\N	Lantbruks och Gårdshundar, Boskapsvallare	bouvier_1_1.jpg	image/jpeg	125138	2017-04-28 10:06:46.171722
4531	Cocker spaniel	70	80	20	100	100	100	20	20		2017-04-28 09:47:09.735498	2018-11-16 17:16:25.810308	Cocker_spaniel	sv	Nära	\N	Stötande och Apporterande Fågelhund	engelsk_cocker_spaniel_1.jpg	image/jpeg	176987	2017-04-28 10:04:49.699678
4601	Kromfohrländer	80	90	30	10	0	20	50	70		2017-04-28 09:47:10.087997	2018-11-16 17:16:25.810308	Kromfohrländer	sv	Mycket nära - Nära	\N	Vakt och Sällskapshund	kromfohrlander.jpg	image/jpeg	114420	2017-04-28 10:19:42.441468
4617	Mexikansk nakenhund	70	20	80	80	20	40	40	70	Speciell omvårdnad krävs för att hundens skinn skall må väl - smörjas ofta,skyddas mot sol och kyla.	2017-04-28 09:47:10.19273	2018-11-16 17:16:25.810308	Mexikansk_nakenhund	sv	Nära - Längre bort	\N	Jakt och vakthund	mexikansk_nakenhund_mellan.jpg	image/jpeg	110557	2017-04-28 10:23:45.914668
4631	Papillon	80	80	20	10	0	0	30	20		2017-04-28 09:47:10.285958	2018-11-16 17:16:25.810308	Papillon	sv	Mycket nära	\N	Arbetande Sällskapshund	papillon.jpg	image/jpeg	100294	2017-04-28 10:13:09.814083
4659	Schäfer	100	90	30	20	20	40	60	70		2017-04-28 09:47:10.481755	2018-11-16 17:16:25.810308	Schäfer	sv	Nära - Längre bort	\N	Fårvallare	schafer.jpg	image/jpeg	195416	2017-04-28 10:12:53.523488
4661	Shar pei	20	40	80	80	0	10	10	90	Viktigt att se till att hudvecken får luft så att det inte bildas fukt och eksem, tala med rasexpert.	2017-04-28 09:47:10.49536	2018-11-16 17:16:25.810308	Shar_pei	sv	Nära - Mycket långt bort	\N	Kamp, Jakt och Vakthund	shar_pei.jpg	image/jpeg	121199	2017-04-28 10:15:18.845638
4512	Bostonterrier	40	80	20	30	10	10	30	30		2017-04-28 09:47:09.637615	2018-11-16 17:16:25.810308	Bostonterrier	sv	Mycket nära - Nära	\N	Kamp och Stridshund	Bostonterrier.jpg	image/jpeg	159652	2017-05-06 22:59:07.684559
4520	Cairnterrier	50	50	70	80	0	0	70	70		2017-04-28 09:47:09.675647	2018-11-16 17:16:25.810308	Cairnterrier	sv	Nära - Längre bort	\N	Gryt och Råtthund	cairnterrier.jpg	image/jpeg	136259	2017-05-06 23:01:34.135425
4525	Chihuahua - korthårig	70	90	10	20	0	0	30	40		2017-04-28 09:47:09.69983	2018-11-16 17:16:25.810308	Chihuahuakorthårig	sv	Mycket nära	\N	Arbetande Sällskapshund	chihuahua_korth.jpg	image/jpeg	171953	2017-05-06 23:02:25.360337
4547	Engelsk bulldog	20	20	70	20	0	0	10	50	Många Bulldogar har svårt att orkar mer än en timmas promenad, ta det extra lugnt i sommar hettan.	2017-04-28 09:47:09.821683	2018-11-16 17:16:25.810308	Engelsk_bulldog	sv	Nära	\N	Kamp och Stridshund	engelsk_bulldogg.jpg	image/jpeg	147743	2017-05-06 23:06:44.738414
4558	Finsk spets	100	50	80	100	60	30	100	70		2017-04-28 09:47:09.874218	2018-11-16 17:16:25.810308	Finsk_spets	sv	Längre bort - Mycket långt bort	\N	Sökande och Ställande Jakthund	finsk_spets.jpg	image/jpeg	109001	2017-05-06 23:09:46.58713
4705	Cane Corso	70	60	50	40	20	20	30	90		2017-04-28 10:00:29.72639	2018-11-16 17:16:25.810308	Cane_Corso		Nära	\N	Lantbruks- och gårdshundar, Vaktande	cane_corso.jpg	image/jpeg	421748	2017-05-15 17:01:57.879931
4706	Terrier Brasileiro	80	70	50	60	10	0	70	80		2017-04-28 10:02:41.645384	2018-11-16 17:16:25.810308	Terrier_Brasileiro		Nära	\N	Gryt & råtthundar	terrier_brasileiro.jpg	image/jpeg	445590	2017-05-15 17:13:46.654108
4622	Newfoundlandshund	30	70	40	20	100	100	30	70		2017-04-28 09:47:10.224891	2018-11-16 17:16:25.810308	Newfoundlandshund	sv	Nära - Längre bort	\N	Apporterande livräddare i vatten	newfoundlandshund.jpg	image/jpeg	107274	2017-05-18 09:16:55.770735
4527	Chinese crested hairless	80	90	30	30	0	20	30	40	Speciell omvårdnad krävs för att hundens skinn skall må väl - smörjas ofta, skyddas mot sol och kyla. Rasen finns även med päls Chinese crested powder puff - kallad Pudervippa, på svenska.	2017-04-28 09:47:09.709984	2018-11-16 17:16:25.810308	Chinese_crested_hairless	sv	Mycket nära - Nära	\N	Arbetande Sällskapshund	chinese_crested_dog.jpg	image/jpeg	72191	2017-05-06 23:02:46.747375
4514	Boxer	60	70	30	20	30	20	20	60		2017-04-28 09:47:09.647166	2018-11-16 17:16:25.810308	Boxer	sv	Nära	\N	Lantbruks och Gårdshund	boxer_1.jpg	image/jpeg	216051	2017-04-28 10:07:02.525294
4482	Afghanhund	70	20	90	100	0	0	10	70		2017-04-28 09:47:09.462165	2018-11-16 17:16:25.810308	Afghanhund	sv	Längre bort - Mycket långt bort	\N	Snabbdrivande Jakthund	Afghanhund.jpg	image/jpeg	169851	2017-05-06 22:45:52.334781
4483	Airedaleterrier	80	70	60	60	10	60	30	70		2017-04-28 09:47:09.470824	2018-11-16 17:16:25.810308	Airedaleterrier	sv	Nära -Längre bort	\N	Gryt och Råtthund	airedaleterrier.jpg	image/jpeg	92877	2017-05-06 22:46:03.836393
4484	Akita	90	60	70	100	0	20	60	80		2017-04-28 09:47:09.476244	2018-11-16 17:16:25.810308	Akita	sv	Nära - Mycket långt bort	\N	Sökande och Ställande Jakthund	akita.jpg	image/jpeg	163295	2017-05-06 22:46:18.662081
4485	Alaskan malamute	100	70	80	70	0	20	80	70		2017-04-28 09:47:09.482707	2018-11-16 17:16:25.810308	Alaskan_malamute	sv	Nära - Längre bort	\N	Släd och Draghund	alaskan_malamute.jpg	image/jpeg	98375	2017-05-06 22:46:28.88042
4488	Appenseller sennenhund	90	70	40	20	10	20	30	70		2017-04-28 09:47:09.50178	2018-11-16 17:16:25.810308	Appenseller_sennenhund	sv	Nära	\N	Lantbruks och Gårdshund, Vallare	appenzeller_sennenhund.jpg	image/jpeg	71353	2017-05-06 22:46:42.778069
4486	American staffordshire terrier	60	80	60	40	10	10	10	70		2017-04-28 09:47:09.489269	2018-11-16 17:16:25.810308	American_staffordshire_terrier	sv	Nära	\N	Kamp och Stridshund	amerikansk_staffordshire_terrier_1.jpg	image/jpeg	274976	2017-04-28 10:06:36.147362
4491	Australian shepherd	70	90	20	30	20	20	50	50		2017-04-28 09:47:09.52122	2018-11-16 17:16:25.810308	Australian_shepherd	sv	Nära - Längre bort	\N	Fårvallare	austr_shepherd_1868.jpg	image/jpeg	75914	2017-05-06 22:47:43.445318
4492	Australisk terrier	70	60	60	80	0	0	60	80		2017-04-28 09:47:09.527428	2018-11-16 17:16:25.810308	Australisk_terrier	sv	Nära - Längre bort	\N	Gryt och Råtthund	australisk_terrier.jpg	image/jpeg	88843	2017-05-06 22:47:56.879182
4493	Azawakh	90	20	80	100	0	0	10	50		2017-04-28 09:47:09.532935	2018-11-16 17:16:25.810308	Azawakh	sv	Längre bort - Mycket långt bort	\N	Snabbdrivande Jakthund	azawakh.jpg	image/jpeg	72100	2017-05-06 22:48:15.913742
4494	Barbet	40	80	20	80	80	100	40	50		2017-04-28 09:47:09.539375	2018-11-16 17:16:25.810308	Barbet	sv	Nära - Längre bort	\N	Stötande och Apporterande Fågelhund	barbet.jpg	image/jpeg	149106	2017-05-06 22:54:01.368096
4498	Basset hound	70	20	90	100	0	20	100	20		2017-04-28 09:47:09.568198	2018-11-16 17:16:25.810308	Basset_hound	sv	Nära - Mycket långt bort	\N	Skalldrivande Jakthund	basset_hound.jpg	image/jpeg	76640	2017-05-06 22:54:55.227912
4496	Basset artésien normand	70	40	70	100	0	20	100	30		2017-04-28 09:47:09.55154	2018-11-16 17:16:25.810308	Basset_artésien_normand	sv	Nära - Mycket långt bort	\N	Skalldrivande Jakthund	basset_artesien_normand.jpg	image/jpeg	115125	2017-05-06 22:55:12.155571
4499	Bayersk viltspårhund	70	40	90	100	0	30	80	50		2017-04-28 09:47:09.573735	2018-11-16 17:16:25.810308	Bayersk_viltspårhund	sv	Längre bort - Mycket långt bort	\N	Skalldrivande Jakthund, Eftersökshund	bayersk_viltsparhund.jpg	image/jpeg	214574	2017-05-06 22:55:31.872578
4519	Bullterrier	40	40	70	60	0	0	10	60		2017-04-28 09:47:09.670986	2018-11-16 17:16:25.810308	Bullterrier	sv	Nära	\N	Kamp och Stridshund	bullterrier12.jpg	image/jpeg	126433	2017-05-18 09:10:16.622287
4500	Beagle	90	50	70	100	10	10	80	40		2017-04-28 09:47:09.579046	2018-11-16 17:16:25.810308	Beagle	sv	Nära - Mycket långt bort	\N	Skalldrivande Jakthund	beagle.jpg	image/jpeg	154654	2017-05-06 22:55:42.541747
4502	Beauceron	90	90	20	30	20	30	40	80		2017-04-28 09:47:09.58897	2018-11-16 17:16:25.810308	Beauceron	sv	Nära - Längre bort	\N	Lantbruks och Gårdshund, Boskapsvallare	beauceron.jpg	image/jpeg	66610	2017-05-06 22:56:09.892801
4503	Bedlingtonterrier	40	60	70	70	0	0	20	60		2017-04-28 09:47:09.59372	2018-11-16 17:16:25.810308	Bedlingtonterrier	sv	Nära - Längre bort	\N	Gryt och Råtthund	bedlingtonterrier.jpg	image/jpeg	115361	2017-05-06 22:56:23.869452
4504	Berger des pyrénées	80	80	30	30	20	40	60	70		2017-04-28 09:47:09.598519	2018-11-16 17:16:25.810308	Berger_des_pyrénées	sv	Nära - Mycket långt bort	\N	Lantbruks och Gårdshund, Vallare	berger_des_pyrenees.jpg	image/jpeg	98670	2017-05-06 22:56:33.678129
4507	Bichon havanais	50	90	10	30	10	10	30	40		2017-04-28 09:47:09.613001	2018-11-16 17:16:25.810308	Bichon_havanais	sv	Mycket nära - Nära	\N	Arbetande Sällskapshund	bichon_havanais.jpg	image/jpeg	70127	2017-05-06 22:58:11.184721
4509	Border collie	80	90	30	20	30	30	60	60		2017-04-28 09:47:09.62235	2018-11-16 17:16:25.810308	Border_collie	sv	Nära - Längre bort	\N	Fårvallare	border_collie.jpg	image/jpeg	71708	2017-05-06 22:58:23.544968
4510	Borderterrier	80	70	40	80	20	30	40	60		2017-04-28 09:47:09.627413	2018-11-16 17:16:25.810308	Borderterrier	sv	Nära - Längre bort	\N	Gryt och Råtthund	borderterrier.jpg	image/jpeg	97023	2017-05-06 22:58:36.978801
4511	Borzoi	80	20	90	100	0	0	10	30		2017-04-28 09:47:09.632683	2018-11-16 17:16:25.810308	Borzoi	sv	Längre bort - Mycket långt bort	\N	Snabbdrivande Jakthund	borzoi.jpg	image/jpeg	148209	2017-05-06 22:58:49.178388
4515	Bracco italiano	80	70	40	100	40	20	20	30		2017-04-28 09:47:09.651801	2018-11-16 17:16:25.810308	Bracco_italiano	sv	Nära - mycket långt bort	\N	Stående Fågelhund	bracco_italiano.jpg	image/jpeg	84479	2017-05-06 22:59:53.240797
4516	Breton	80	80	30	100	60	40	20	40		2017-04-28 09:47:09.656471	2018-11-16 17:16:25.810308	Breton	sv	Nära - Mycket långt bort	\N	Stående Fågelhund	breton.jpg	image/jpeg	73287	2017-05-06 23:00:02.346251
4517	Briard	20	80	30	30	20	20	40	70		2017-04-28 09:47:09.661358	2018-11-16 17:16:25.810308	Briard	sv	Nära - Längre bort	\N	lantbruks och Gårdshund, Boskapsvallare	briard.jpg	image/jpeg	174318	2017-05-06 23:00:10.408855
4518	Bullmastiff	70	60	30	20	10	20	30	80		2017-04-28 09:47:09.666284	2018-11-16 17:16:25.810308	Bullmastiff	sv	Nära	\N	Lantbruks och Gårdshund	bullmastiff.jpg	image/jpeg	113892	2017-05-06 23:00:18.171452
4521	Canaan dog	90	90	30	40	40	40	30	80		2017-04-28 09:47:09.680266	2018-11-16 17:16:25.810308	Canaan_dog	sv	Nära	\N	Vakt och Tjänstehund	canaan_dog.jpg	image/jpeg	65050	2017-05-06 23:01:44.717215
4522	Cavalier king charles spaniel	80	90	10	70	50	50	30	10		2017-04-28 09:47:09.684905	2018-11-16 17:16:25.810308	Cavalier_king_charles_spaniel	sv	Mycket nära - Nära	\N	Stötande och Apporterande Fågelhund	cavalier_king_charles_spaniel.jpg	image/jpeg	116251	2017-05-06 23:02:02.821369
4565	Gammal dansk hönsehund	70	80	20	100	60	50	10	30		2017-04-28 09:47:09.90728	2018-11-16 17:16:25.810308	Gammal_dansk_hönsehund	sv	Nära - Mycket långt bort	\N	Stående Fågelhund	gammel_dansk_honsehund.jpg	image/jpeg	183731	2017-05-06 23:12:01.709759
4481	Affenpinscher	10	50	50	60	0	10	30	60		2017-04-28 09:47:09.454884	2018-11-16 17:16:25.810308	Affenpinscher	sv	Nära	\N	Gryt och Råtthund	affenpinscher.jpg	image/jpeg	123638	2017-05-06 22:45:39.354344
4490	Australian kelpie	80	90	30	40	30	30	40	50		2017-04-28 09:47:09.514877	2018-11-16 17:16:25.810308	Australian_kelpie	sv	Nära - Längre bort	\N	Fårvallare	australian_kelpie.jpg	image/jpeg	72200	2017-05-06 22:47:27.392083
4505	Berner sennenhund	80	70	40	20	10	20	30	70		2017-04-28 09:47:09.603599	2018-11-16 17:16:25.810308	Berner_sennenhund	sv	Nära	\N	Lantbruks och Gårdshund, Vallare	berner_sennenhund.jpg	image/jpeg	131929	2017-05-06 22:56:46.510318
4579	Hannoveransk viltspårhund	70	30	90	100	0	30	80	60		2017-04-28 09:47:09.97348	2018-11-16 17:16:25.810308	Hannoveransk_viltspårhund	sv	Längre bort - Mycket längre bort	\N	Skalldrivande Jakthund, Eftersökshund	hannoveransk_viltsparhund.jpg	image/jpeg	89134	2017-05-06 23:16:19.978706
4707	Podengo portugues pequenon	80	60	60	70	0	10	30	30	Rasen finns i tre storlekar Pequenon -liten, Medio -mellan, Grande -stor. Samt i två olika hårlag släthårig/liso & strävhårig/cerdoso.	2017-04-29 21:58:48.581073	2018-11-16 17:16:25.810308	Podengo_portugues_pequenon		nära – långt bort	\N	Snabbdrivande jakthundar - jagar i flock	podengo_port_pequeno.jpg	image/jpeg	419984	2017-05-15 17:10:09.753958
4709	Prazsky krysarik	70	80	40	40	0	0	40	70		2017-04-29 22:02:38.28782	2018-11-16 17:16:25.810308	Prazsky_krysarik		nära	\N	Arbetande sällskapshundar	prazsky_krysarik.jpg	image/jpeg	446459	2017-05-15 17:11:01.937037
4708	Russkiy toy	60	90	20	30	0	0	70	60		2017-04-29 22:00:49.219244	2018-11-16 17:16:25.810308	Russkiy_toy		nära	\N	Arbetande sällskapshund	russkiy_toy.jpg	image/jpeg	501282	2017-05-15 17:12:01.634417
4583	Irish softcoated wheaten terrier	40	70	50	70	20	40	30	70		2017-04-28 09:47:09.992837	2018-11-16 17:16:25.810308	Irish_softcoated_wheaten_terrier	sv	Nära - Längre bort	\N	Gryt och Råtthund	irish_soft_coated_wheaten_terrier_2_1.jpg	image/jpeg	252262	2017-04-29 22:08:55.627196
4587	Irländsk varghund	90	60	80	100	0	0	20	40	Har mycket likhet med vinthundsgruppens jaktsätt.	2017-04-28 09:47:10.014025	2018-11-16 17:16:25.810308	Irländsk_varghund	sv	Längre bort - Mycket långt bort	\N	Sökande och Ställande Jakthund	irlandsk_varghund_1.jpg	image/jpeg	179391	2017-04-29 22:09:52.95918
4660	Sealyhamterrier	70	70	60	80	0	0	40	70		2017-04-28 09:47:10.48867	2018-11-16 17:16:25.810308	Sealyhamterrier	sv	Nära - Längre bort	\N	Gryt och Råtthund	sealyhamterrier.jpg	image/jpeg	104789	2017-04-29 22:24:08.579818
4675	Staffordshire bullterrier	20	50	50	40	0	0	10	80		2017-04-28 09:47:10.580608	2018-11-16 17:16:25.810308	Staffordshire_bullterrier	sv	Nära	\N	Kamp och Stridshund	staffordshire_bullterrier.jpg	image/jpeg	106930	2017-04-29 22:27:33.463615
4508	Bolognese	50	90	10	10	10	10	10	40		2017-04-28 09:47:09.61769	2018-11-16 17:16:25.810308	Bolognese	sv	Mycket nära - Nära	\N	Arbetande Sällskapshund	bolognese.jpg	image/jpeg	401027	2017-05-15 17:01:47.336061
4688	Volpino italiano	90	90	20	40	10	0	40	60		2017-04-28 09:47:10.653428	2018-11-16 17:16:25.810308	Volpino_italiano	sv	Mycket nära - Nära	\N	Arbetande sällskapshund	volpino_italiano.jpg	image/jpeg	107129	2017-04-29 22:32:37.405673
4629	Nova scotia duck tolling retriever	80	90	40	80	100	100	30	50		2017-04-28 09:47:10.272564	2018-11-16 17:16:25.810308	Nova_scotia_duck_tolling_retriever	sv	Nära - Längre bort	\N	Apporterande Fågelhund	nova_scotia_duck_tolling_retriever.jpg	image/jpeg	103467	2017-04-29 22:18:24.862711
4652	Saluki	80	40	60	100	0	0	10	30		2017-04-28 09:47:10.433231	2018-11-16 17:16:25.810308	Saluki	sv	Längre bort - Mycket långt bort	\N	Snabbdrivande Jakthund	saluki.jpg	image/jpeg	97977	2017-04-29 22:22:40.40913
4667	Skotsk hjorthund	90	60	80	100	0	0	20	30	Har många likheter med vinthundsgruppens jaktsätt.	2017-04-28 09:47:10.529369	2018-11-16 17:16:25.810308	Skotsk_hjorthund	sv	Längre bort - Mycket långt bort	\N	Sökande och Ställande Jakthund	skotsk_hjorthund.jpg	image/jpeg	240377	2017-04-29 22:24:53.460445
4680	Tax - långhårig	80	20	80	100	0	10	70	40		2017-04-28 09:47:10.612718	2018-11-16 17:16:25.810308	Taxlånghårig	sv	Nära - Mycket långt bort	\N	Skalldrivande Jakthund	tax_langh_normal.jpg	image/jpeg	157740	2017-04-29 22:29:27.752135
4685	Tibetansk terrier	30	70	40	40	10	10	30	60		2017-04-28 09:47:10.63966	2018-11-16 17:16:25.810308	Tibetansk_terrier	sv	Nära - Längre bort	\N	Lantbruks och Gårdshund, Vallare	tibetansk_terrier.jpg	image/jpeg	168424	2017-04-29 22:30:34.945995
4551	English toy terrier	60	80	40	60	0	0	40	60		2017-04-28 09:47:09.840273	2018-11-16 17:16:25.810308	English_toy_terrier	sv	Mycket nära - Nära	\N	Arbetande Sällskapshund	eng_toy_terr.jpg	image/jpeg	442938	2017-05-15 17:04:47.375685
4636	Phalène	80	80	20	10	0	0	20	20		2017-04-28 09:47:10.321205	2018-11-16 17:16:25.810308	Phalène	sv	Mycket nära	\N	Arbetande Sällskapshund	phalene.jpg	image/jpeg	499270	2017-05-15 17:09:55.169835
4553	Estrella mountain dog	70	40	70	20	10	20	20	80		2017-04-28 09:47:09.849909	2018-11-16 17:16:25.810308	Estrella_mountain_dog	sv	Nära - Mycket långt bort	\N	Lantbruks och Gårdshund, Herdehund	cao_da_serra_da_estrela.jpg	image/jpeg	83500	2017-05-15 17:20:00.954385
4497	Basset griffon vendéen Grand & Petit	70	40	80	100	0	20	100	40		2017-04-28 09:47:09.557078	2018-11-16 17:16:25.810308	Basset_griffon_vendéen_Grand__Petit	sv	Nära - Mycket långt bort	\N	Skalldrivande Jakthund	petit_basset_griffon_vendeen.jpg	image/jpeg	119011	2017-05-15 17:20:46.328653
4710	Jack Russel Terrier	80	70	60	70	10	0	60	70		2017-05-16 02:43:24.182812	2018-11-16 17:16:25.810308	Jack_Russel_Terrier		Nära - Längre bort	\N	Gryt och Råtthund	jack_russell_terrier_1.jpg	image/jpeg	97078	2017-05-16 02:43:23.822819
4633	Pekingese	10	40	20	0	0	0	10	20	De flesta Pekingeser klarar inte 1timmes promenad - utan rör sig i sin egen takt i sitt närområde, gärna i egen trädgård.	2017-04-28 09:47:10.300111	2018-11-16 17:16:25.810308	Pekingese	sv	Mycket nära	\N	Arbetande Sällskapshund	pekingese.jpg	image/jpeg	132525	2017-05-18 09:17:42.864027
4569	Grand danois	70	30	70	60	0	0	20	70	Har en del gemensamt med vinthundarnas jaktsätt.	2017-04-28 09:47:09.925862	2018-11-16 17:16:25.810308	Grand_danois	sv	Nära - Längre bort	\N	Sökande och Ställande Jakthund	grand_danois.jpg	image/jpeg	98100	2017-05-06 23:13:08.677836
4648	Pyrenéerhund	90	40	70	30	10	40	20	90		2017-04-28 09:47:10.406414	2018-11-16 17:16:25.810308	Pyrenéerhund	sv	Nära - Längre bort	\N	Lantbruks och Gårdshund, Herdehund	pyreneerhund.jpg	image/jpeg	100405	2017-05-18 09:18:05.261119
4540	Dogo argentino	80	70	40	80	10	20	20	90		2017-04-28 09:47:09.78544	2018-11-16 17:16:25.810308	Dogo_argentino	sv	Nära - Längre bort	\N	Lantbruks och Gårdshund med jakt	dogo_argentino.jpg	image/jpeg	68500	2017-05-06 23:05:27.720082
4526	Chihuahua - långhårig	70	90	10	20	0	0	30	40		2017-04-28 09:47:09.704945	2018-11-16 17:16:25.810308	Chihuahualånghårig	sv	Mycket nära	\N	Arbetande Sällskapshund	chihuahua_langh.jpg	image/jpeg	157846	2017-05-06 23:02:35.805765
4530	Clumber spaniel	70	80	20	100	100	100	40	40		2017-04-28 09:47:09.728926	2018-11-16 17:16:25.810308	Clumber_spaniel	sv	Nära	\N	Stötande och Apporterande Fågelhund	clumber_spaniel.jpg	image/jpeg	122110	2017-05-06 23:03:11.312876
4533	Collie - långhårig	90	90	20	20	20	20	50	20		2017-04-28 09:47:09.749542	2018-11-16 17:16:25.810308	Collielånghårig	sv	Nära - Längre bort	\N	Fårvallare	collie_langh.jpg	image/jpeg	112659	2017-05-06 23:04:40.244467
4532	Collie - korthårig	100	90	20	20	20	30	40	20		2017-04-28 09:47:09.742435	2018-11-16 17:16:25.810308	Colliekorthårig	sv	Nära - Längre bort	\N	Fårvallare	collie_korth.jpg	image/jpeg	434289	2017-05-15 17:03:05.078781
4535	Curly coated retriever	80	80	20	80	100	100	20	60	Pälsen skall endast masseras och inte borstas, tala med rasexperter om pälsvården.	2017-04-28 09:47:09.761934	2018-11-16 17:16:25.810308	Curly_coated_retriever	sv	Nära - Längre bort	\N	Apporterande Fågelhund	curly_coated_retriever.jpg	image/jpeg	77579	2017-05-06 23:04:50.529316
4536	Dalmatiner	70	70	60	80	40	40	60	80		2017-04-28 09:47:09.766756	2018-11-16 17:16:25.810308	Dalmatiner	sv	Nära - Längre bort	\N	Jakt och Vakthund, användes som vakt till hästekipage	dalmatiner.jpg	image/jpeg	125484	2017-05-06 23:04:58.893896
4534	Coton de tuléar	50	90	10	10	0	0	20	30		2017-04-28 09:47:09.75626	2018-11-16 17:16:25.810308	Coton_de_tuléar	sv	Mycket Nära	\N	Arbetande Sällskapshund	coton_de_tulear.jpg	image/jpeg	423833	2017-05-15 17:03:16.737067
4537	Dandie dinmont terrier	50	60	60	80	0	0	30	60		2017-04-28 09:47:09.771496	2018-11-16 17:16:25.810308	Dandie_dinmont_terrier	sv	Nära - Längre bort	\N	Gryt och Råtthund	dandie_dinmont_terrier.jpg	image/jpeg	91698	2017-05-06 23:05:09.174114
4543	Dvärgpinscher	80	80	30	60	0	0	70	80		2017-04-28 09:47:09.80018	2018-11-16 17:16:25.810308	Dvärgpinscher	sv	Mycket nära - Nära	\N	Gryt och Råtthund	dvärgpinscher.jpg	image/jpeg	872660	2017-05-15 17:03:32.023861
4539	Dobermann	90	90	20	50	20	10	40	90		2017-04-28 09:47:09.78076	2018-11-16 17:16:25.810308	Dobermann	sv	Nära - Längre bort	\N	Vakt och Tjänstehund	dobermann.jpg	image/jpeg	98429	2017-05-06 23:05:18.823284
4524	Chesapeake bay retriever	70	80	30	80	100	100	20	80		2017-04-28 09:47:09.69465	2018-11-16 17:16:25.810308	Chesapeake_bay_retriever	sv	Nära - Längre bort	\N	Apporterande Fågelhund	chesapeake_bay_retriever.jpg	image/jpeg	83658	2017-05-06 23:02:11.319657
4541	Dogue de bordeaux	60	60	20	20	10	10	20	90		2017-04-28 09:47:09.790404	2018-11-16 17:16:25.810308	Dogue_de_bordeaux	sv	Nära	\N	Lantbruks och Gårdshund	dogue_de_bordeaux.jpg	image/jpeg	94604	2017-05-06 23:05:39.272235
4542	Drever	80	20	80	100	0	20	100	60		2017-04-28 09:47:09.795325	2018-11-16 17:16:25.810308	Drever	sv	Längre bort - Mycket långt bort	\N	Skalldrivande Jakthund	drever.jpg	image/jpeg	120781	2017-05-06 23:06:38.262104
4546	Engelsk Blodhund	60	50	70	100	0	30	80	50		2017-04-28 09:47:09.817142	2018-11-16 17:16:25.810308	Engelsk_Blodhund	sv	Nära - Mycket långt bort	\N	Skalldrivande Jakthund	blodhund.jpg	image/jpeg	87222	2017-05-06 23:06:53.281549
4549	Engelsk setter	80	70	50	100	40	40	10	10		2017-04-28 09:47:09.831002	2018-11-16 17:16:25.810308	Engelsk_setter	sv	Längre bort - Mycket långt bort	\N	Stående fågelhund	engelsk_setter.jpg	image/jpeg	136241	2017-05-06 23:07:56.310831
4552	Entlebucher sennenhund	90	70	20	20	10	10	30	80		2017-04-28 09:47:09.84511	2018-11-16 17:16:25.810308	Entlebucher_sennenhund	sv	Nära	\N	Lantbruks och Gårdshund - Vaktande	entlebucher_sennenhund.jpg	image/jpeg	76620	2017-05-06 23:08:06.188642
4554	Eurasier	40	80	60	30	0	0	40	70		2017-04-28 09:47:09.854884	2018-11-16 17:16:25.810308	Eurasier	sv	Nära	\N	Sällskaps- och vaktande hund	eurasier.jpg	image/jpeg	87248	2017-05-06 23:08:16.290282
4555	Faraohund	90	30	70	100	0	0	10	30		2017-04-28 09:47:09.859715	2018-11-16 17:16:25.810308	Faraohund	sv	Längre bort - Mycket långt bort	\N	Snabbdrivande Jakthund	faraohund.jpg	image/jpeg	76754	2017-05-06 23:09:14.075359
4538	Dansk/svensk gårdshund	80	70	30	40	10	10	70	60		2017-04-28 09:47:09.776171	2018-11-16 17:16:25.810308	Dansksvensk_gårdshund	sv	Nära	\N	Lantbruks och Gårdshund	dansk_svensk_gardshund_1_1.jpg	image/jpeg	115551	2017-04-28 10:07:45.512107
4556	Field spaniel	70	80	30	80	80	50	20	30		2017-04-28 09:47:09.864668	2018-11-16 17:16:25.810308	Field_spaniel	sv	Längre bort	\N	Stötande och Apporterande Fågelhund	field_spaniel.jpg	image/jpeg	87333	2017-05-06 23:09:24.330237
4557	Finsk lapphund	80	70	40	60	0	10	70	60		2017-04-28 09:47:09.869472	2018-11-16 17:16:25.810308	Finsk_lapphund	sv	Nära	\N	Lantbruks och Gårdshund, Renvallare	finsk_lapphund.jpg	image/jpeg	113697	2017-05-06 23:09:34.938165
4559	Finsk stövare	80	30	80	100	0	20	100	40		2017-04-28 09:47:09.878894	2018-11-16 17:16:25.810308	Finsk_stövare	sv	Längre bort - Mycket långt bort	\N	Skalldrivande Jakthund	finsk_stovare.jpg	image/jpeg	96436	2017-05-06 23:09:57.636962
4529	Chow-chow	30	40	70	70	0	0	30	70		2017-04-28 09:47:09.721931	2018-11-16 17:16:25.810308	Chowchow	sv	Nära - Mycket långt bort	\N	Arbetande Sällskapshund	chow_chow.jpg	image/jpeg	81308	2017-05-18 09:11:29.068156
4548	Engelsk Mastiff	60	70	50	40	0	10	30	80		2017-04-28 09:47:09.826362	2018-11-16 17:16:25.810308	Engelsk_Mastiff	sv	Nära	\N	Lantbruks och Gårdshund	mastiff.jpg	image/jpeg	120925	2017-05-15 17:19:03.706293
4544	Dvärgschnauzer	60	80	30	50	0	0	50	60		2017-04-28 09:47:09.807699	2018-11-16 17:16:25.810308	Dvärgschnauzer	sv	Nära	\N	Gryt och Råtthund	dvargschn_svart_silv_(kopia).jpg	image/jpeg	136101	2017-05-18 09:11:03.034843
4560	Flatcoated retiever	60	80	20	80	100	70	10	20		2017-04-28 09:47:09.883847	2018-11-16 17:16:25.810308	Flatcoated_retiever	sv	Nära - Längre bort	\N	Apporterande Fågelhund	flatcoated_retriever.jpg	image/jpeg	150014	2017-05-06 23:10:08.707512
4563	Fransk bulldog	60	80	20	10	0	0	10	30		2017-04-28 09:47:09.898026	2018-11-16 17:16:25.810308	Fransk_bulldog	sv	Mycket nära - Nära	\N	Arbetande Sällskapshund	fransk_bulldogg.jpg	image/jpeg	110195	2017-05-06 23:10:21.283518
4545	Dvärgspets	70	80	10	20	20	0	60	60		2017-04-28 09:47:09.812503	2018-11-16 17:16:25.810308	Dvärgspets	sv	Mycket nära	\N	Arbetande sällskapshund	pomeranian.jpg	image/jpeg	111615	2017-05-16 02:34:30.785168
4564	Galgo espanol	80	20	80	100	0	0	10	20		2017-04-28 09:47:09.902466	2018-11-16 17:16:25.810308	Galgo_espanol	sv	Längre bort - Mycket långt bort	\N	Snabbdrivande Jakthund	galgo_espanol.jpg	image/jpeg	88895	2017-05-06 23:11:52.820175
4561	Foxterrier - släthårig	70	60	70	80	0	10	40	70		2017-04-28 09:47:09.888866	2018-11-16 17:16:25.810308	Foxterriersläthårig	sv	Nära - Längre bort	\N	Gryt och Råtthund	slatharig_foxterrier.jpg	image/jpeg	108077	2017-05-15 17:08:13.500321
4562	Foxterrier - strävhårig	70	60	70	80	0	10	40	70		2017-04-28 09:47:09.893558	2018-11-16 17:16:25.810308	Foxterriersträvhårig	sv	Nära - Längre bort	\N	Gryt och Råtthund	stravharig_foxterrier.jpg	image/jpeg	166866	2017-05-15 17:08:45.212335
4568	Gotlandsstövare	80	40	80	100	20	20	100	30		2017-04-28 09:47:09.921069	2018-11-16 17:16:25.810308	Gotlandsstövare	sv	Nära - Mycket långt bort	\N	Skalldrivande Jakthund	gotlandsstovare.jpg	image/jpeg	225172	2017-05-06 23:11:27.79226
4566	Golden retiever	80	90	10	70	100	100	20	20		2017-04-28 09:47:09.911984	2018-11-16 17:16:25.810308	Golden_retiever	sv	Nära - Längre bort	\N	Apporterande Fågelhund	golden_retriever.jpg	image/jpeg	156652	2017-05-06 23:12:10.134201
4567	Gordonsetter	80	80	50	100	40	40	10	10		2017-04-28 09:47:09.916578	2018-11-16 17:16:25.810308	Gordonsetter	sv	Längre bort - Mycket långt bort	\N	Stående Fågelhund	gordonsetter.jpg	image/jpeg	76419	2017-05-06 23:12:19.603182
4570	Great japanese dog	80	70	40	80	20	30	30	80		2017-04-28 09:47:09.930639	2018-11-16 17:16:25.810308	Great_japanese_dog	sv	Nära - Längre bort	\N	Sökande och Ställande Jakthund	great_japanese_dog.jpg	image/jpeg	75024	2017-05-06 23:13:17.043009
4571	Greyhound	80	40	80	100	0	0	10	10		2017-04-28 09:47:09.935015	2018-11-16 17:16:25.810308	Greyhound	sv	Längre bort - Mycket långt bort	\N	Snabbdrivande Jakthund	greyhound.jpg	image/jpeg	74263	2017-05-06 23:13:28.242923
4574	Groenendael	60	90	20	20	20	10	80	70		2017-04-28 09:47:09.949112	2018-11-16 17:16:25.810308	Groenendael	sv	Nära - Längre bort	\N	Fårvallare	groenendael.jpg	image/jpeg	198970	2017-05-06 23:14:10.748045
4575	Grosser Münsterländer	70	80	30	100	60	50	20	70		2017-04-28 09:47:09.953812	2018-11-16 17:16:25.810308	Grosser_Münsterländer	sv	Längre bort - Mycket långt bort	\N	Stående Fågelhund	grosser_munsterlander.jpg	image/jpeg	83796	2017-05-06 23:14:43.753157
4576	Grosser schweizer sennenhund	90	70	30	20	10	10	20	80		2017-04-28 09:47:09.958886	2018-11-16 17:16:25.810308	Grosser_schweizer_sennenhund	sv	Nära	\N	Lantbruks och Gårdshund	grosser_schweizer_sennenhund.jpg	image/jpeg	69069	2017-05-06 23:15:33.240019
4578	Hamiltonstövare	80	30	90	100	0	20	100	40		2017-04-28 09:47:09.968677	2018-11-16 17:16:25.810308	Hamiltonstövare	sv	Mycket långt bort	\N	Skalldrivande Jakthund	hamiltonstovare.jpg	image/jpeg	148525	2017-05-06 23:16:10.27387
4580	Hollandse herdershond	80	70	40	30	20	30	40	80		2017-04-28 09:47:09.978075	2018-11-16 17:16:25.810308	Hollandse_herdershond	sv	Nära - Längre bort	\N	Lantbruks och Gårdshund, Vallare	hollandse_herdershond_korth.jpg	image/jpeg	90004	2017-05-06 23:16:30.003537
4581	Hovawart	70	70	30	30	20	10	30	80		2017-04-28 09:47:09.982875	2018-11-16 17:16:25.810308	Hovawart	sv	Nära	\N	Lantbruks och Gårdshund	hovawart.jpg	image/jpeg	76499	2017-05-06 23:16:55.42918
4572	Griffon belge	40	80	20	40	0	0	40	60		2017-04-28 09:47:09.939384	2018-11-16 17:16:25.810308	Griffon_belge	sv	Mycket nära - Nära	\N	Gryt och Råtthund	griffon_belge.jpg	image/jpeg	472361	2017-05-15 17:06:48.144167
4577	Grönlandshund	100	60	80	60	0	20	80	70		2017-04-28 09:47:09.963971	2018-11-16 17:16:25.810308	Grönlandshund	sv	Nära - Längre bort	\N	Släd och Draghund	gronlandshund.jpg	image/jpeg	113034	2017-05-18 09:12:22.223525
4606	Lakelandterrier	40	60	70	70	10	10	20	70		2017-04-28 09:47:10.120475	2018-11-16 17:16:25.810308	Lakelandterrier	sv	Nära - Längre bort	\N	Gryt och Råtthund	lakelandterrier_(kopia).jpg	image/jpeg	135999	2017-05-18 09:16:32.354418
4593	Jämthund	100	60	70	100	0	20	80	60		2017-04-28 09:47:10.047134	2018-11-16 17:16:25.810308	Jämthund	sv	Längre bort - Mycket långt bort	\N	Sökande och Ställande Jakthund	jamthund_1.jpg	image/jpeg	109106	2017-04-28 10:17:20.386715
4595	Keeshond	70	80	20	30	20	10	60	70		2017-04-28 09:47:10.057391	2018-11-16 17:16:25.810308	Keeshond	sv	Nära	\N	Lantbruks och Gårdshund	Keeshund_1.jpg	image/jpeg	169638	2017-04-28 10:18:15.046725
4597	King charles spaniel	50	90	10	10	10	0	20	10		2017-04-28 09:47:10.068131	2018-11-16 17:16:25.810308	King_charles_spaniel	sv	Mycket nära	\N	Arbetande Sällskapshund	king_charles_spaniel.jpg	image/jpeg	113088	2017-04-28 10:19:12.749399
4598	Kleiner münsterländer	70	80	50	100	50	50	30	60		2017-04-28 09:47:10.073095	2018-11-16 17:16:25.810308	Kleiner_münsterländer	sv	Nära - Mycket långt bort	\N	Stående Fågelhund	kleiner_munsterlander.jpg	image/jpeg	158331	2017-04-28 10:19:19.855659
4602	Kuvasz	90	20	80	30	10	40	20	90		2017-04-28 09:47:10.093538	2018-11-16 17:16:25.810308	Kuvasz	sv	Nära - Mycket långt bort	\N	Lantbruks och Gårdshund, Herdehund	kuvasz.jpg	image/jpeg	149940	2017-04-28 10:19:55.497002
4599	Kleinspitz	70	80	20	30	10	10	70	70		2017-04-28 09:47:10.078913	2018-11-16 17:16:25.810308	Kleinspitz	sv	Mycket nära - Nära	\N	Lantbruks och Gårdshund	kleinspitz.jpg	image/jpeg	175604	2017-04-28 10:19:32.030778
4607	Lancashire heeler	80	80	30	30	10	20	80	60		2017-04-28 09:47:10.127251	2018-11-16 17:16:25.810308	Lancashire_heeler	sv	Nära - Längre bort	\N	Lantbruks och Gårdshund, Boskapsvallare	lancashire_heeler.jpg	image/jpeg	104652	2017-04-28 10:21:13.555483
4603	Labrador retriever	70	80	20	80	100	100	30	20		2017-04-28 09:47:10.100419	2018-11-16 17:16:25.810308	Labrador_retriever	sv	Nära - Längre bort	\N	Apporterande Fågelhund	Labrador_retriever.jpg	image/jpeg	110323	2017-04-28 10:20:03.723024
4604	Laekenois	90	80	20	30	20	20	60	70		2017-04-28 09:47:10.107291	2018-11-16 17:16:25.810308	Laekenois	sv	Nära - Längre bort	\N	Fårvallare	laekenois.jpg	image/jpeg	137457	2017-04-28 10:20:15.83369
4610	Leonberger	70	60	50	20	20	40	20	70		2017-04-28 09:47:10.146822	2018-11-16 17:16:25.810308	Leonberger	sv	Nära	\N	Lantbruks och Gårdshund	leonberger.jpg	image/jpeg	121859	2017-04-28 10:11:13.147059
4585	Irländsk röd setter	80	80	40	100	30	40	10	10		2017-04-28 09:47:10.002867	2018-11-16 17:16:25.810308	Irländsk_röd_setter	sv	Längre bort - Mycket långt bort	\N	Stående Fågelhund	irlandsk_rod_setter_1.jpg	image/jpeg	166150	2017-04-29 22:09:25.335128
4589	Isländsk fårhund	90	70	30	30	20	20	80	60		2017-04-28 09:47:10.024723	2018-11-16 17:16:25.810308	Isländsk_fårhund	sv	Nära	\N	Lantbruks och Gårdshund, Vallare	islandsk_farhund_1.jpg	image/jpeg	150895	2017-04-29 22:10:23.00927
4586	Irländsk terrier	80	70	60	80	20	20	20	80		2017-04-28 09:47:10.008335	2018-11-16 17:16:25.810308	Irländsk_terrier	sv	Nära - Längre bort	\N	Gryt och Råtthund	irlandsk_terrier_1.jpg	image/jpeg	267039	2017-04-29 22:09:39.210592
4588	Irländsk vattenspaniel	40	80	20	80	100	100	20	50		2017-04-28 09:47:10.019532	2018-11-16 17:16:25.810308	Irländsk_vattenspaniel	sv	Nära - Längre bort	\N	Apporterande Fågelhund	irlandsk_vattenspaniel_1.jpg	image/jpeg	208571	2017-04-29 22:10:09.014309
4590	Italiensk vinthund	60	60	60	100	0	0	0	0		2017-04-28 09:47:10.030243	2018-11-16 17:16:25.810308	Italiensk_vinthund	sv	Nära - Mycket långt bort	\N	Snabbdrivande Jakthund	italiensk_vinthund_1.jpg	image/jpeg	229118	2017-04-29 22:10:58.367676
4591	Japanese chin	30	100	10	0	0	0	20	30		2017-04-28 09:47:10.037743	2018-11-16 17:16:25.810308	Japanese_chin	sv	Mycket nära	\N	Arbetande Sällskapshund	japanese_chin_1.jpg	image/jpeg	161698	2017-04-29 22:16:11.664345
4594	Karelsk björnhund	80	60	80	100	30	10	70	80		2017-04-28 09:47:10.051668	2018-11-16 17:16:25.810308	Karelsk_björnhund	sv	Längre bort - Mycket långt bort	\N	Sökande och Ställande Jakthund	karelsk_bjornhund.jpg	image/jpeg	170328	2017-04-28 10:17:48.295099
4592	Japansk spets	80	80	20	40	10	0	70	60		2017-04-28 09:47:10.042404	2018-11-16 17:16:25.810308	Japansk_spets	sv	Mycket nära - Nära	\N	Arbetande Sällskapshund	japansk_spets_1.jpg	image/jpeg	98330	2017-04-29 22:16:22.783488
4584	Irländsk röd och vit setter	80	80	50	100	50	40	10	10		2017-04-28 09:47:09.997625	2018-11-16 17:16:25.810308	Irländsk_röd_och_vit_setter	sv	Längre bort - Mycket långt bort	\N	Stående Fågelhund	irlandsk_rod_vit_setter_1.jpg	image/jpeg	100893	2017-04-29 22:09:06.425992
4609	Lapsk Vallhund	90	100	30	40	40	30	80	80		2017-04-28 09:47:10.140463	2018-11-16 17:16:25.810308	Lapsk_Vallhund	sv	Nära - Längre bort	\N	Lantbruks och Gårdshundar,  Renvallare	lapsk_vallhund.jpg	image/jpeg	116862	2017-04-28 10:21:21.328274
4645	Pudel - toy	40	100	10	10	10	10	20	10		2017-04-28 09:47:10.385178	2018-11-16 17:16:25.810308	Pudeltoy	sv	Mycket nära	\N	Arbetande Sällskapshund	pudel_toy.jpg	image/jpeg	406200	2017-05-15 17:11:48.289223
4643	Pudel - mellan	40	90	10	40	60	60	40	30		2017-04-28 09:47:10.370821	2018-11-16 17:16:25.810308	Pudelmellan	sv	Mycket nära - Nära	\N	Apporterande Fågelhund	pudel_mellan.jpg	image/jpeg	635384	2017-05-15 17:11:43.892068
4618	Miniatyrbullterrier	40	50	60	40	0	0	10	60		2017-04-28 09:47:10.199149	2018-11-16 17:16:25.810308	Miniatyrbullterrier	sv	Nära	\N	Kamp och Stridshund	miniatyrbullterrier.jpg	image/jpeg	459937	2017-05-15 17:43:49.948983
4619	Mittelspitz	80	80	20	30	10	10	70	70		2017-04-28 09:47:10.205562	2018-11-16 17:16:25.810308	Mittelspitz	sv	Mycket nära - Nära	\N	Lantbruks och Gårdshund	tysk_spets_mittel.jpg	image/jpeg	518408	2017-05-15 17:07:25.482578
4635	Petit brabançon	60	80	20	40	0	0	40	60		2017-04-28 09:47:10.314165	2018-11-16 17:16:25.810308	Petit_brabançon	sv	Mycket nära - Nära	\N	Gryt och Råtthund	petit_brabancon.jpg	image/jpeg	514866	2017-05-15 17:09:42.489987
4642	Pudel - dvärg	40	90	10	10	10	10	20	20		2017-04-28 09:47:10.36454	2018-11-16 17:16:25.810308	Pudeldvärg	sv	Mycket nära - Nära	\N	Arbetande Sällskapshund	pudel_dvarg.jpg	image/jpeg	657494	2017-05-15 17:11:17.808053
4647	Pumi	60	70	30	30	10	20	60	70		2017-04-28 09:47:10.399555	2018-11-16 17:16:25.810308	Pumi	sv	Nära - Mycket långt bort	\N	Lantbruks och Gårdshund, Vallare	pumi.jpg	image/jpeg	125006	2017-04-28 10:13:49.52527
4620	Mops	30	80	30	10	0	0	10	10		2017-04-28 09:47:10.212269	2018-11-16 17:16:25.810308	Mops	sv	Mycket nära - Nära	\N	Arbetande Sällskapshund	mops.jpg	image/jpeg	119684	2017-04-28 10:09:30.658429
4649	Rhodesian ridgeback	80	60	50	70	20	20	20	80		2017-04-28 09:47:10.413549	2018-11-16 17:16:25.810308	Rhodesian_ridgeback	sv	Nära - Längre bort	\N	Sökande och Ställande jakthund	rhodesian_ridgeback.jpg	image/jpeg	122842	2017-04-29 22:22:20.171597
4625	Norsk Buhund	100	80	20	40	40	40	90	90		2017-04-28 09:47:10.245363	2018-11-16 17:16:25.810308	Norsk_Buhund	sv	Nära - Längre bort	\N	Lantbruks och Gårdshund, Vallare	norsk_buhund.jpg	image/jpeg	130318	2017-04-28 10:24:41.577175
4613	Malinois	90	90	20	30	20	20	70	70		2017-04-28 09:47:10.167126	2018-11-16 17:16:25.810308	Malinois	sv	Nära - Längre bort	\N	Fårvallare	Malinois.jpg	image/jpeg	229390	2017-04-28 10:12:33.238036
4650	Riesenschnauzer	50	70	40	40	10	30	30	80		2017-04-28 09:47:10.419946	2018-11-16 17:16:25.810308	Riesenschnauzer	sv	Nära - Längre bort	\N	Lantbruks och Gårdshund	riesenschnauzer_1.jpg	image/jpeg	209761	2017-04-28 10:16:20.851289
4614	Malteser	60	90	10	0	0	0	10	30		2017-04-28 09:47:10.173791	2018-11-16 17:16:25.810308	Malteser	sv	Mycket nära	\N	Arbetande Sällskapshund	malteser.jpg	image/jpeg	101334	2017-04-29 22:17:27.988971
4624	Norrbottenspets	100	60	60	100	40	40	100	70		2017-04-28 09:47:10.238823	2018-11-16 17:16:25.810308	Norrbottenspets	sv	Nära - Mycket långt bort	\N	Sökande och Ställande Jakthund	norrbottenspets.jpg	image/jpeg	198533	2017-04-28 10:23:23.413842
4627	Norsk Älghund - grå	100	60	60	100	20	40	90	60		2017-04-28 09:47:10.258725	2018-11-16 17:16:25.810308	Norsk_Älghundgrå	sv	Längre bort - Mycket långt bort	\N	Sökande och Ställande Jakthund	norsk_alghund_gra.jpg	image/jpeg	108427	2017-04-28 10:24:07.468123
4626	Norsk Lundehund	90	80	40	80	90	80	60	50		2017-04-28 09:47:10.252063	2018-11-16 17:16:25.810308	Norsk_Lundehund	sv	Nära - Längre bort	\N	Apporterande Fågelhund	norsk_lundehund.jpg	image/jpeg	165180	2017-04-28 10:25:03.716573
4628	Norwichterrier	50	50	50	80	0	0	60	70		2017-04-28 09:47:10.265781	2018-11-16 17:16:25.810308	Norwichterrier	sv	Nära - Längre bort	\N	Gryt och Råtthund	norwichterrier.jpg	image/jpeg	130239	2017-04-29 22:18:16.234937
4638	Podenco ibicenco	90	20	80	100	10	10	20	40		2017-04-28 09:47:10.338545	2018-11-16 17:16:25.810308	Podenco_ibicenco	sv	Längre bort - Mycket långt bort	\N	Snabbdrivande Jakthundar	podenco_ibicenco.jpg	image/jpeg	145598	2017-04-28 10:26:13.227597
4640	Polsk owczarek nizinny	20	30	70	30	10	30	30	90		2017-04-28 09:47:10.351853	2018-11-16 17:16:25.810308	Polsk_owczarek_nizinny	sv	Nära - Mycket långt bort	\N	Lantbruks och Gårdshund, Herdehund	polsk_owczarek_nizinny_1.jpg	image/jpeg	123553	2017-04-29 22:21:10.086382
4653	Samojedhund	90	50	60	80	30	30	70	60		2017-04-28 09:47:10.440209	2018-11-16 17:16:25.810308	Samojedhund	sv	Nära - Längre bort	\N	Släd och Draghund	samojedhund.jpg	image/jpeg	92843	2017-04-28 10:27:13.027021
4616	Maremmano-Abruzzese	90	20	80	40	10	30	20	90		2017-04-28 09:47:10.186168	2018-11-16 17:16:25.810308	MaremmanoAbruzzese	sv	Nära - Mycket långt bort	\N	Lantbruks och Gårdshund,  Herdehund	maremmano_abruzzese.jpg	image/jpeg	149256	2017-04-28 10:22:52.519413
4615	Manchesterterrier	70	70	60	70	0	0	40	90		2017-04-28 09:47:10.180053	2018-11-16 17:16:25.810308	Manchesterterrier	sv	Nära - Längre bort	\N	Gryt och Råtthund	manchesterterrier.jpg	image/jpeg	134284	2017-04-29 22:17:42.116881
4623	Norfolkterrier	50	50	50	80	0	0	70	70		2017-04-28 09:47:10.231575	2018-11-16 17:16:25.810308	Norfolkterrier	sv	Nära - Längre bort	\N	Gryt och Råtthund	norfolk_terrier.jpg	image/jpeg	317607	2017-04-29 22:18:06.897584
4630	Old english sheepdog	20	30	70	30	10	30	40	90		2017-04-28 09:47:10.279385	2018-11-16 17:16:25.810308	Old_english_sheepdog	sv	Nära - Mycket långt bort	\N	Lantbruks och Gårdshund, Herdehund	old_english_sheepdog.jpg	image/jpeg	109610	2017-04-29 22:19:51.977916
4634	Perro de agua espanol	40	90	20	70	100	100	20	40		2017-04-28 09:47:10.307337	2018-11-16 17:16:25.810308	Perro_de_agua_espanol	sv	Nära - Längre bort	\N	Stötande och Apporterande Fågelhund	perro_de_agua_espanol.jpg	image/jpeg	146462	2017-04-29 22:20:44.456827
4632	Parson russell terrier	80	70	60	70	10	0	60	70		2017-04-28 09:47:10.293065	2018-11-16 17:16:25.810308	Parson_russell_terrier	sv	Nära - Längre bort	\N	Gryt och Råtthund	parson_russell_terrier.jpg	image/jpeg	93261	2017-04-29 22:20:23.851119
4639	Pointer	70	50	60	100	40	40	10	10		2017-04-28 09:47:10.344886	2018-11-16 17:16:25.810308	Pointer	sv	Mycket långt bort	\N	Stående Fågelhund	pointer.jpg	image/jpeg	224312	2017-04-28 10:26:33.956095
4641	Portugisisk vattenhund	40	80	30	80	100	100	40	90		2017-04-28 09:47:10.358292	2018-11-16 17:16:25.810308	Portugisisk_vattenhund	sv	Nära - Längre bort	\N	Apporterande Fågelhund	portugisisk_vattenhund.jpg	image/jpeg	174477	2017-04-29 22:21:21.754527
4646	Puli	10	60	40	40	10	10	60	90	Skötsel av pälsen/snörena är viktig. Huden måste kunna andas, tala med rasexpert.	2017-04-28 09:47:10.391973	2018-11-16 17:16:25.810308	Puli	sv	Nära - Mycket långt bort	\N	Lantbruks och Gårdshund, Vallare	puli.jpg	image/jpeg	148078	2017-04-28 10:09:09.274895
4644	Pudel - stor	40	100	10	60	60	80	20	30		2017-04-28 09:47:10.378233	2018-11-16 17:16:25.810308	Pudelstor	sv	Nära - Längre bort	\N	Apporterande Fågelhund	storpudel.jpg	image/jpeg	149393	2017-04-29 22:21:33.045288
4651	Rottweiler	80	80	20	20	10	20	30	80		2017-04-28 09:47:10.426262	2018-11-16 17:16:25.810308	Rottweiler	sv	Nära	\N	Lantbruks och Gårdshund	rottweiler_2.jpg	image/jpeg	217942	2017-04-29 22:22:29.676438
4611	Lhasa apso	10	70	30	10	0	0	20	50		2017-04-28 09:47:10.153253	2018-11-16 17:16:25.810308	Lhasa_apso	sv	Mycket nära - Nära	\N	Arbetande Sällskapshund	lhasa_apso.jpg	image/jpeg	176183	2017-04-28 10:21:53.900924
4621	Mudi	60	70	30	40	10	30	70	90		2017-04-28 09:47:10.218386	2018-11-16 17:16:25.810308	Mudi	sv	Nära - Mycket långt bort	\N	Lantbruks och Gårdshund, Vallare	mudi.jpg	image/jpeg	201612	2017-04-28 10:12:02.76851
4637	Pinscher	80	80	40	60	10	0	50	80		2017-04-28 09:47:10.331507	2018-11-16 17:16:25.810308	Pinscher	sv	Nära - Längr bort	\N	Gryt och Råtthund	pinscher_2.jpg	image/jpeg	101650	2017-04-29 22:20:54.287522
4663	Shiba	80	30	70	100	20	20	50	80		2017-04-28 09:47:10.506002	2018-11-16 17:16:25.810308	Shiba	sv	Nära - Mycket långt bort	\N	Sökande och Ställande jakthund	shiba.jpg	image/jpeg	159470	2017-04-28 10:15:34.86848
4693	Västsibirisk laika	100	30	90	100	10	20	90	70		2017-04-28 09:47:10.680434	2018-11-16 17:16:25.810308	Västsibirisk_laika	sv	Längre bort - Mycket långt bort	\N	Sökande och Ställande Jakthund	vastsibirisk_lajka.jpg	image/jpeg	106001	2017-05-18 09:18:51.917767
4670	Sloughi	80	30	80	100	0	0	10	40		2017-04-28 09:47:10.546106	2018-11-16 17:16:25.810308	Sloughi	sv	Längre bort - Mycket långt bort	\N	Snabbdrivande Jakthund	sloughi.jpg	image/jpeg	453351	2017-05-15 17:13:36.088263
4683	Tibetansk mastiff	70	40	70	20	0	20	30	100		2017-04-28 09:47:10.629685	2018-11-16 17:16:25.810308	Tibetansk_mastiff	sv	Längre bort - Mycket lång bort	\N	Lantbruks och Gårdshund	tib_mastiff.jpg	image/jpeg	494448	2017-05-15 17:13:59.777135
4690	Vorsteh - långhårig	70	80	20	100	40	50	10	60		2017-04-28 09:47:10.663458	2018-11-16 17:16:25.810308	Vorstehlånghårig	sv	Längre bort - Mycket långt bort	\N	Stående Fågelhund	langharig_vorsteh.jpg	image/jpeg	143362	2017-05-15 17:14:27.405272
4696	Weimaraner - långhårig	50	80	30	100	50	60	10	40		2017-04-28 09:47:10.698251	2018-11-16 17:16:25.810308	Weimaranerlånghårig	sv	Nära - Mycket långt bort	\N	Stående Fågelhund	weimaraner_langh.jpg	image/jpeg	546185	2017-05-15 17:14:39.222695
4681	Tax - strävhårig	80	20	80	100	0	10	70	70		2017-04-28 09:47:10.61729	2018-11-16 17:16:25.810308	Taxsträvhårig	sv	Nära - Mycket långt bort	\N	Skalldrivande Jakthund	tax_stravh_dvarg.jpg	image/jpeg	142636	2017-05-18 09:18:29.130524
4658	Schnauzer	60	80	30	40	0	0	40	70		2017-04-28 09:47:10.474934	2018-11-16 17:16:25.810308	Schnauzer	sv	Nära - Längre bort	\N	Gryt och Råtthund	schnauzer.jpg	image/jpeg	225834	2017-04-28 10:15:11.254391
4662	Shetland sheepdog	80	80	30	30	20	10	70	40		2017-04-28 09:47:10.501362	2018-11-16 17:16:25.810308	Shetland_sheepdog	sv	Nära	\N	Fårvallare	shetland_sheepdog.jpg	image/jpeg	217739	2017-04-28 10:15:27.153405
4665	Siberian husky	100	70	50	70	20	20	70	70		2017-04-28 09:47:10.515361	2018-11-16 17:16:25.810308	Siberian_husky	sv	Nära - Längre bort	\N	Drag och Slädhund	siberian_husky.jpg	image/jpeg	108811	2017-04-28 10:28:21.880982
4694	Wachtelhund	60	80	30	90	90	90	40	70		2017-04-28 09:47:10.687836	2018-11-16 17:16:25.810308	Wachtelhund	sv	Nära - Längre bort	\N	Stötande och Apporterande Fågelhund	wachtelhund.jpg	image/jpeg	106953	2017-04-28 10:32:12.695685
4657	Schipperke	30	70	30	40	10	10	70	60		2017-04-28 09:47:10.468146	2018-11-16 17:16:25.810308	Schipperke	sv	Nära - Mycket långt bort	\N	Lantbruks och Gårdshund, Vallare	schipperke.jpg	image/jpeg	202774	2017-04-28 10:14:27.862451
4656	Schillerstövare	70	40	90	100	0	20	100	60		2017-04-28 09:47:10.461151	2018-11-16 17:16:25.810308	Schillerstövare	sv	Mycket långt bort	\N	Skalldrivande Jakthund	schillerstovare.jpg	image/jpeg	205485	2017-04-29 22:24:00.391453
4664	Shih tzu	10	70	30	10	0	0	20	40		2017-04-28 09:47:10.510695	2018-11-16 17:16:25.810308	Shih_tzu	sv	Mycket nära - Nära	\N	Arbetande Sällskapshund	shih_tzu.jpg	image/jpeg	107329	2017-04-29 22:24:24.185579
4666	Silky terrier	60	70	60	70	0	0	60	80		2017-04-28 09:47:10.52429	2018-11-16 17:16:25.810308	Silky_terrier	sv	Nära	\N	Gryt och Råtthund	sikyterrier_1.jpg	image/jpeg	119836	2017-04-29 22:24:42.907716
4668	Skotsk terrier	20	30	70	70	0	0	30	70		2017-04-28 09:47:10.535073	2018-11-16 17:16:25.810308	Skotsk_terrier	sv	Nära - Längre bort	\N	Gryt och Råtthund	skotsk_terrier.jpg	image/jpeg	167998	2017-04-29 22:25:11.648841
4669	Skyeterrier	10	70	60	70	0	0	20	80		2017-04-28 09:47:10.539793	2018-11-16 17:16:25.810308	Skyeterrier	sv	Nära - Längre bort	\N	Gryt och Råtthund	skyeterrier.jpg	image/jpeg	126149	2017-04-29 22:25:22.708724
4673	Spinone	70	80	30	100	50	60	10	10		2017-04-28 09:47:10.566761	2018-11-16 17:16:25.810308	Spinone	sv	Nära - Mycket långt bort	\N	Stående Fågelhund	spinone_.jpg	image/jpeg	149920	2017-04-29 22:27:05.072552
4672	Smålandsstövare	80	30	90	100	10	20	100	80		2017-04-28 09:47:10.559632	2018-11-16 17:16:25.810308	Smålandsstövare	sv	Längre bort - Mycket längre bort	\N	Skalldrivande Jakthundar	smalandsstovare.jpg	image/jpeg	179288	2017-04-29 22:26:56.56781
4674	Stabyhoun	70	80	20	100	60	70	30	30		2017-04-28 09:47:10.573638	2018-11-16 17:16:25.810308	Stabyhoun	sv	Nära - Mycket långt bort	\N	Stående Fågelhund	stabyhoun.jpg	image/jpeg	114207	2017-04-29 22:27:14.526901
4678	Svensk lapphund	70	80	30	60	20	20	90	90		2017-04-28 09:47:10.601935	2018-11-16 17:16:25.810308	Svensk_lapphund	sv	Nära - Längre bort	\N	Lantbruks och Gårdshund, Vallare	svensk_lapphund.jpg	image/jpeg	127575	2017-04-29 22:28:07.571454
4676	Sussex spaniel	60	80	30	80	90	90	30	30		2017-04-28 09:47:10.587953	2018-11-16 17:16:25.810308	Sussex_spaniel	sv	Nära - Längre bort	\N	Stötande och Apporterande Fågelhund	sussex_spaniel.jpg	image/jpeg	125871	2017-04-29 22:27:44.417607
4677	Svart terrier	50	80	30	40	20	30	40	90		2017-04-28 09:47:10.59507	2018-11-16 17:16:25.810308	Svart_terrier	sv	Nära - Längre Bort	\N	Vakt och Tjänstehund	svart_terrier.jpg	image/jpeg	101600	2017-04-29 22:27:55.924565
4679	Tax - korthårig	80	20	80	100	0	10	70	50		2017-04-28 09:47:10.608234	2018-11-16 17:16:25.810308	Taxkorthårig	sv	Nära - Mycket långt bort	\N	Skalldrivande Jakthund	tax_korth_normal.jpg	image/jpeg	143097	2017-04-29 22:29:10.760906
4682	Tervueren	80	90	20	30	20	20	70	70		2017-04-28 09:47:10.621978	2018-11-16 17:16:25.810308	Tervueren	sv	Nära - Längre bort	\N	Fårvallare	tervueren.jpg	image/jpeg	110812	2017-04-29 22:30:02.662326
4684	Tibetansk spaniel	60	60	40	30	0	0	20	40		2017-04-28 09:47:10.634881	2018-11-16 17:16:25.810308	Tibetansk_spaniel	sv	Mycket nära - Nära	\N	Arbetande Sällskapshund	tibetansk_spaniel.jpg	image/jpeg	113679	2017-04-29 22:30:16.519865
4686	Tysk jaktterrier	70	70	60	100	20	10	40	100		2017-04-28 09:47:10.644246	2018-11-16 17:16:25.810308	Tysk_jaktterrier	sv	Nära - Längre bort	\N	Gryt och Råtthund	tysk_jaktterrier.jpg	image/jpeg	182535	2017-04-29 22:30:51.907784
4692	Västgötaspets	90	80	30	40	10	20	80	70		2017-04-28 09:47:10.674989	2018-11-16 17:16:25.810308	Västgötaspets	sv	Nära - Längre bort	\N	Lantbruks och Gårdshund, Vallare	vastgotaspets_2.jpg	image/jpeg	124696	2017-04-29 22:32:09.989325
4689	Vorsteh - korthårig	80	80	30	100	40	40	10	60		2017-04-28 09:47:10.658284	2018-11-16 17:16:25.810308	Vorstehkorthårig	sv	Längre bort - Mycket långt bort	\N	Stående Fågelhund	vorsteh_kortharig_1.jpg	image/jpeg	140128	2017-04-29 22:32:52.885093
4691	Vorsteh - strävhårig	80	80	30	100	40	60	10	70		2017-04-28 09:47:10.668876	2018-11-16 17:16:25.810308	Vorstehsträvhårig	sv	Längre bort - Mycket långt bort	\N	Stående Fågelhund	vorsteh_stravharig_1.jpg	image/jpeg	130446	2017-04-29 22:33:10.456243
4655	Schapendoes	20	60	40	20	10	20	40	60		2017-04-28 09:47:10.453562	2018-11-16 17:16:25.810308	Schapendoes	sv	Nära - Mycket långt bort	\N	Lantbruks och Gårdshund, Vallare	schapendoes.jpg	image/jpeg	142869	2017-04-29 22:23:50.337692
4687	Ungersk vizsla - kort & strävhårig	70	80	30	100	50	60	20	20		2017-04-28 09:47:10.64867	2018-11-16 17:16:25.810308	Ungersk_vizslakort__strävhårig	sv	Nära - Mycket långt bort	\N	Stående Fågelhund	ungersk_vizsla.jpg	image/jpeg	122564	2017-04-29 22:31:54.276676
4695	Weimaraner - korthårig	40	80	30	100	50	50	10	50		2017-04-28 09:47:10.693098	2018-11-16 17:16:25.810308	Weimaranerkorthårig	sv	Nära - Mycket långt bort	\N	Stående Fågelhund	weimaraner_kortharig_2.jpg	image/jpeg	151329	2017-04-28 10:32:38.000122
4697	Welsh corgi cardigan	80	70	30	20	10	10	60	50		2017-04-28 09:47:10.703093	2018-11-16 17:16:25.810308	Welsh_corgi_cardigan	sv	Nära	\N	Lantbruks och Gårdshund, Vallare	welsh_corgi_cardigan.jpg	image/jpeg	116406	2017-04-28 10:29:21.624307
4703	Yorkshireterrier	60	70	50	70	0	0	60	60		2017-04-28 09:47:10.73645	2018-11-16 17:16:25.810308	Yorkshireterrier	sv	Nära	\N	Gryt och Råtthund	yorkshireterrier.jpg	image/jpeg	123936	2017-04-28 10:27:32.650894
4702	Whippet	80	60	70	100	0	0	10	30		2017-04-28 09:47:10.72991	2018-11-16 17:16:25.810308	Whippet	sv	Nära - Mycket långt bort	\N	Snabbdrivande Jakthund	whippet.jpg	image/jpeg	125347	2017-04-28 10:27:48.977976
4699	Welsh springer spaniel	80	90	20	80	90	90	30	10		2017-04-28 09:47:10.713622	2018-11-16 17:16:25.810308	Welsh_springer_spaniel	sv	Nära - Längre bort	\N	Stötande och Apporterande Fågelhund	welsh_springer_spaniel_2.jpg	image/jpeg	144379	2017-04-28 10:30:57.516768
4700	Welshterrier	70	60	60	80	0	10	40	70		2017-04-28 09:47:10.719044	2018-11-16 17:16:25.810308	Welshterrier	sv	Nära - Längre bort	\N	Gryt och Råtthund	welshterrier.jpg	image/jpeg	123517	2017-04-28 10:31:17.148058
4701	West highland white terrier	80	40	60	70	0	10	50	60		2017-04-28 09:47:10.724471	2018-11-16 17:16:25.810308	West_highland_white_terrier	sv	Nära - Längre bort	\N	Gryt och Råtthund	west_highland_white_terrier.jpg	image/jpeg	171084	2017-04-28 10:31:40.785843
4671	Slovensky Kopov	80	70	30	100	0	20	50	60	Jakthund för vildsvin, sedan länge i hemlandet.	2017-04-28 09:47:10.552456	2018-11-16 17:16:25.810308	Slovensky_Kopov	sv	Nära - Mycket långt bort	\N	Sökande och Ställande Jakthund	slovensky_kopov.jpg	image/jpeg	169887	2017-04-29 22:25:39.165939
4704	Östsibirisk laika	100	30	90	100	10	20	90	70		2017-04-28 09:47:10.743279	2018-11-16 17:16:25.810308	Östsibirisk_laika	sv	Längre bort - Mycket långt bort	\N	Sökande och Ställande Jakthund	ostsibirisk__lajka.jpg	image/jpeg	95877	2017-05-18 09:17:17.687577
\.


--
-- Name: fk_rails_b084479daf; Type: FK CONSTRAINT; Schema: public; Owner: deploy
--

ALTER TABLE ONLY public.breed_quiz_scoring_keys
    ADD CONSTRAINT fk_rails_b084479daf FOREIGN KEY (question_id) REFERENCES public.questions(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

