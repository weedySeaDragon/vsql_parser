
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


CREATE TABLE public.breed_quiz_scoring_keys (
    id integer NOT NULL,
    breed_profile_id integer,
    question_id integer,
    answer_id integer,
    score_value integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    question_reference_id character varying,
    answer_reference_id character varying);
