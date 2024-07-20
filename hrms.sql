-- This script was generated by a beta version of the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE public.activation_codes
(
    id integer NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    user_id integer NOT NULL,
    uid character varying(50) NOT NULL,
    activation_code character varying(50) NOT NULL,
    expiration_date timestamp without time zone NOT NULL,
    is_confirmed boolean NOT NULL,
    activation_date timestamp without time zone,
    created_date timestamp without time zone NOT NULL,
    is_deleted boolean NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.candidate_educations
(
    id integer NOT NULL,
    department_name character varying(255) NOT NULL,
    graduation_year integer,
    school_name character varying(255) NOT NULL,
    start_year integer NOT NULL,
    candidate_id integer NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.candidate_experiences
(
    id integer NOT NULL,
    company_name character varying(255) NOT NULL,
    leave_date date,
    "position" character varying(255) NOT NULL,
    start_date date NOT NULL,
    candidate_id integer NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.candidate_images
(
    id integer NOT NULL,
    uploaded_date timestamp without time zone,
    url character varying(255) NOT NULL,
    candidate_id integer NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.candidate_languages
(
    id integer NOT NULL,
    level smallint NOT NULL,
    language_id integer NOT NULL,
    candidate_id integer NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.candidate_links
(
    id integer NOT NULL,
    link_id integer NOT NULL,
    candidate_id integer NOT NULL,
    link character varying(255) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.candidate_skills
(
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    candidate_id integer NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.candidates
(
    id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    national_identity character varying(11) NOT NULL,
    date_of_birth date NOT NULL,
    description character varying(255),
    PRIMARY KEY (id)
);

CREATE TABLE public.cities
(
    id integer NOT NULL,
    name character varying(20) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.employees
(
    id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.employers
(
    id integer NOT NULL,
    company_name character varying(50) NOT NULL,
    web_address character varying(50) NOT NULL,
    phone_number character varying(50) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.employers_activation_by_employees
(
    id integer NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    employer_id integer NOT NULL,
    employee_id integer NOT NULL,
    is_confirmed boolean NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone,
    is_deleted boolean NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.job_positions
(
    id integer NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    uid character varying(50) NOT NULL,
    title character varying(50) NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone,
    is_deleted boolean NOT NULL,
    is_activated boolean,
    PRIMARY KEY (id)
);

CREATE TABLE public.job_posts
(
    id integer NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    uid character varying(50) NOT NULL,
    employer_id integer NOT NULL,
    job_position_id integer NOT NULL,
    city_id integer NOT NULL,
    description text NOT NULL,
    min_salary double precision NOT NULL,
    max_salary double precision NOT NULL,
    quota integer NOT NULL,
    appeal_deadline date NOT NULL,
    created_date timestamp without time zone NOT NULL,
    deleted_date timestamp without time zone,
    is_deleted boolean NOT NULL,
    is_activated boolean NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.languages
(
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.link_types
(
    id integer NOT NULL,
    type character varying(255) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.users
(
    id integer NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    uid character varying(50) NOT NULL,
    email character varying(30) NOT NULL,
    password character varying(20) NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone,
    is_deleted boolean NOT NULL,
    is_activated boolean,
    PRIMARY KEY (id)
);

ALTER TABLE public.activation_codes
    ADD FOREIGN KEY (user_id)
    REFERENCES public.users (id)
    NOT VALID;


ALTER TABLE public.candidate_educations
    ADD FOREIGN KEY (candidate_id)
    REFERENCES public.candidates (id)
    NOT VALID;


ALTER TABLE public.candidate_experiences
    ADD FOREIGN KEY (candidate_id)
    REFERENCES public.candidates (id)
    NOT VALID;


ALTER TABLE public.candidate_images
    ADD FOREIGN KEY (candidate_id)
    REFERENCES public.candidates (id)
    NOT VALID;


ALTER TABLE public.candidate_languages
    ADD FOREIGN KEY (candidate_id)
    REFERENCES public.candidates (id)
    NOT VALID;


ALTER TABLE public.candidate_languages
    ADD FOREIGN KEY (language_id)
    REFERENCES public.languages (id)
    NOT VALID;


ALTER TABLE public.candidate_links
    ADD FOREIGN KEY (candidate_id)
    REFERENCES public.candidates (id)
    NOT VALID;


ALTER TABLE public.candidate_links
    ADD FOREIGN KEY (link_id)
    REFERENCES public.link_types (id)
    NOT VALID;


ALTER TABLE public.candidate_skills
    ADD FOREIGN KEY (candidate_id)
    REFERENCES public.candidates (id)
    NOT VALID;


ALTER TABLE public.candidates
    ADD FOREIGN KEY (id)
    REFERENCES public.users (id)
    NOT VALID;


ALTER TABLE public.employees
    ADD FOREIGN KEY (id)
    REFERENCES public.users (id)
    NOT VALID;


ALTER TABLE public.employers
    ADD FOREIGN KEY (id)
    REFERENCES public.users (id)
    NOT VALID;


ALTER TABLE public.employers_activation_by_employees
    ADD FOREIGN KEY (employee_id)
    REFERENCES public.employees (id)
    NOT VALID;


ALTER TABLE public.employers_activation_by_employees
    ADD FOREIGN KEY (employer_id)
    REFERENCES public.employers (id)
    NOT VALID;


ALTER TABLE public.job_posts
    ADD FOREIGN KEY (city_id)
    REFERENCES public.cities (id)
    NOT VALID;


ALTER TABLE public.job_posts
    ADD FOREIGN KEY (employer_id)
    REFERENCES public.employers (id)
    NOT VALID;


ALTER TABLE public.job_posts
    ADD FOREIGN KEY (job_position_id)
    REFERENCES public.job_positions (id)
    NOT VALID;

END;
