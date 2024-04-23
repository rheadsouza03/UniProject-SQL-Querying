--
-- PostgreSQL database dump
--

-- Dumped from database version 14.10
-- Dumped by pg_dump version 14.11

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql_call_handler(); Type: FUNCTION; Schema: public; Owner: pgsql
--

CREATE FUNCTION public.plpgsql_call_handler() RETURNS language_handler
    LANGUAGE c
    AS '$libdir/plpgsql', 'plpgsql_call_handler';


ALTER FUNCTION public.plpgsql_call_handler() OWNER TO pgsql;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: accomplices; Type: TABLE; Schema: public; Owner: dsouzrhea
--

CREATE TABLE public.accomplices (
    robber_id integer NOT NULL,
    bank_name character varying(20) NOT NULL,
    city character varying(20) NOT NULL,
    date_robbed date NOT NULL,
    robbery_share numeric(10,2),
    CONSTRAINT accomplices_robbery_share_check CHECK ((robbery_share >= (0)::numeric))
);


ALTER TABLE public.accomplices OWNER TO dsouzrhea;

--
-- Name: banks; Type: TABLE; Schema: public; Owner: dsouzrhea
--

CREATE TABLE public.banks (
    bank_name character varying(100) NOT NULL,
    city character varying(100) NOT NULL,
    no_accounts integer,
    sec_level character varying(20),
    CONSTRAINT banks_no_accounts_check CHECK ((no_accounts > 0)),
    CONSTRAINT banks_sec_level_check CHECK (((sec_level)::text = ANY ((ARRAY['weak'::character varying, 'good'::character varying, 'very good'::character varying, 'excellent'::character varying])::text[])))
);


ALTER TABLE public.banks OWNER TO dsouzrhea;

--
-- Name: hasaccounts; Type: TABLE; Schema: public; Owner: dsouzrhea
--

CREATE TABLE public.hasaccounts (
    robber_id integer NOT NULL,
    bank_name character varying(20) NOT NULL,
    city character varying(20) NOT NULL
);


ALTER TABLE public.hasaccounts OWNER TO dsouzrhea;

--
-- Name: hasskills; Type: TABLE; Schema: public; Owner: dsouzrhea
--

CREATE TABLE public.hasskills (
    robber_id integer NOT NULL,
    skill_id integer NOT NULL,
    preference integer,
    grade character(2),
    CONSTRAINT hasskills_grade_check CHECK ((grade = ANY (ARRAY['A+'::bpchar, 'A'::bpchar, 'A-'::bpchar, 'B+'::bpchar, 'B'::bpchar, 'B-'::bpchar, 'C+'::bpchar, 'C'::bpchar, 'C-'::bpchar, 'D'::bpchar, 'E'::bpchar, 'F'::bpchar, 'K'::bpchar, 'P'::bpchar, 'G'::bpchar, 'J'::bpchar, 'L'::bpchar, 'Z'::bpchar]))),
    CONSTRAINT hasskills_preference_check CHECK (((preference >= 1) AND (preference <= 3)))
);


ALTER TABLE public.hasskills OWNER TO dsouzrhea;

--
-- Name: robberies; Type: TABLE; Schema: public; Owner: dsouzrhea
--

CREATE TABLE public.robberies (
    bank_name character varying(20) NOT NULL,
    city character varying(20) NOT NULL,
    date_robbed date NOT NULL,
    amount numeric(20,2)
);


ALTER TABLE public.robberies OWNER TO dsouzrhea;

--
-- Name: robbers; Type: TABLE; Schema: public; Owner: dsouzrhea
--

CREATE TABLE public.robbers (
    robber_id integer NOT NULL,
    nickname character varying(20),
    age integer,
    no_years integer,
    CONSTRAINT robbers_age_check CHECK ((age >= 0)),
    CONSTRAINT robbers_no_years_check CHECK ((no_years >= 0))
);


ALTER TABLE public.robbers OWNER TO dsouzrhea;

--
-- Name: robbers_robber_id_seq; Type: SEQUENCE; Schema: public; Owner: dsouzrhea
--

CREATE SEQUENCE public.robbers_robber_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.robbers_robber_id_seq OWNER TO dsouzrhea;

--
-- Name: robbers_robber_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dsouzrhea
--

ALTER SEQUENCE public.robbers_robber_id_seq OWNED BY public.robbers.robber_id;


--
-- Name: robberyplans; Type: TABLE; Schema: public; Owner: dsouzrhea
--

CREATE TABLE public.robberyplans (
    bank_name character varying(20) NOT NULL,
    city character varying(20) NOT NULL,
    no_robbers integer,
    planned_date date NOT NULL,
    CONSTRAINT robberyplans_no_robbers_check CHECK ((no_robbers >= 1))
);


ALTER TABLE public.robberyplans OWNER TO dsouzrhea;

--
-- Name: skills; Type: TABLE; Schema: public; Owner: dsouzrhea
--

CREATE TABLE public.skills (
    skill_id integer NOT NULL,
    description character varying(20) NOT NULL
);


ALTER TABLE public.skills OWNER TO dsouzrhea;

--
-- Name: skills_skill_id_seq; Type: SEQUENCE; Schema: public; Owner: dsouzrhea
--

CREATE SEQUENCE public.skills_skill_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.skills_skill_id_seq OWNER TO dsouzrhea;

--
-- Name: skills_skill_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dsouzrhea
--

ALTER SEQUENCE public.skills_skill_id_seq OWNED BY public.skills.skill_id;


--
-- Name: robbers robber_id; Type: DEFAULT; Schema: public; Owner: dsouzrhea
--

ALTER TABLE ONLY public.robbers ALTER COLUMN robber_id SET DEFAULT nextval('public.robbers_robber_id_seq'::regclass);


--
-- Name: skills skill_id; Type: DEFAULT; Schema: public; Owner: dsouzrhea
--

ALTER TABLE ONLY public.skills ALTER COLUMN skill_id SET DEFAULT nextval('public.skills_skill_id_seq'::regclass);


--
-- Data for Name: accomplices; Type: TABLE DATA; Schema: public; Owner: dsouzrhea
--

COPY public.accomplices (robber_id, bank_name, city, date_robbed, robbery_share) FROM stdin;
\.


--
-- Data for Name: banks; Type: TABLE DATA; Schema: public; Owner: dsouzrhea
--

COPY public.banks (bank_name, city, no_accounts, sec_level) FROM stdin;
\.


--
-- Data for Name: hasaccounts; Type: TABLE DATA; Schema: public; Owner: dsouzrhea
--

COPY public.hasaccounts (robber_id, bank_name, city) FROM stdin;
\.


--
-- Data for Name: hasskills; Type: TABLE DATA; Schema: public; Owner: dsouzrhea
--

COPY public.hasskills (robber_id, skill_id, preference, grade) FROM stdin;
\.


--
-- Data for Name: robberies; Type: TABLE DATA; Schema: public; Owner: dsouzrhea
--

COPY public.robberies (bank_name, city, date_robbed, amount) FROM stdin;
\.


--
-- Data for Name: robbers; Type: TABLE DATA; Schema: public; Owner: dsouzrhea
--

COPY public.robbers (robber_id, nickname, age, no_years) FROM stdin;
\.


--
-- Data for Name: robberyplans; Type: TABLE DATA; Schema: public; Owner: dsouzrhea
--

COPY public.robberyplans (bank_name, city, no_robbers, planned_date) FROM stdin;
\.


--
-- Data for Name: skills; Type: TABLE DATA; Schema: public; Owner: dsouzrhea
--

COPY public.skills (skill_id, description) FROM stdin;
\.


--
-- Name: robbers_robber_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dsouzrhea
--

SELECT pg_catalog.setval('public.robbers_robber_id_seq', 1, false);


--
-- Name: skills_skill_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dsouzrhea
--

SELECT pg_catalog.setval('public.skills_skill_id_seq', 1, false);


--
-- Name: accomplices accomplices_pkey; Type: CONSTRAINT; Schema: public; Owner: dsouzrhea
--

ALTER TABLE ONLY public.accomplices
    ADD CONSTRAINT accomplices_pkey PRIMARY KEY (robber_id, bank_name, city, date_robbed);


--
-- Name: banks banks_pkey; Type: CONSTRAINT; Schema: public; Owner: dsouzrhea
--

ALTER TABLE ONLY public.banks
    ADD CONSTRAINT banks_pkey PRIMARY KEY (bank_name, city);


--
-- Name: hasaccounts hasaccounts_pkey; Type: CONSTRAINT; Schema: public; Owner: dsouzrhea
--

ALTER TABLE ONLY public.hasaccounts
    ADD CONSTRAINT hasaccounts_pkey PRIMARY KEY (robber_id, bank_name, city);


--
-- Name: hasskills hasskills_pkey; Type: CONSTRAINT; Schema: public; Owner: dsouzrhea
--

ALTER TABLE ONLY public.hasskills
    ADD CONSTRAINT hasskills_pkey PRIMARY KEY (robber_id, skill_id);


--
-- Name: robberies robberies_pkey; Type: CONSTRAINT; Schema: public; Owner: dsouzrhea
--

ALTER TABLE ONLY public.robberies
    ADD CONSTRAINT robberies_pkey PRIMARY KEY (bank_name, city, date_robbed);


--
-- Name: robbers robbers_pkey; Type: CONSTRAINT; Schema: public; Owner: dsouzrhea
--

ALTER TABLE ONLY public.robbers
    ADD CONSTRAINT robbers_pkey PRIMARY KEY (robber_id);


--
-- Name: robberyplans robberyplans_pkey; Type: CONSTRAINT; Schema: public; Owner: dsouzrhea
--

ALTER TABLE ONLY public.robberyplans
    ADD CONSTRAINT robberyplans_pkey PRIMARY KEY (bank_name, city, planned_date);


--
-- Name: skills skills_description_key; Type: CONSTRAINT; Schema: public; Owner: dsouzrhea
--

ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_description_key UNIQUE (description);


--
-- Name: skills skills_pkey; Type: CONSTRAINT; Schema: public; Owner: dsouzrhea
--

ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_pkey PRIMARY KEY (skill_id);


--
-- Name: accomplices accomplices_bank_name_city_date_robbed_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dsouzrhea
--

ALTER TABLE ONLY public.accomplices
    ADD CONSTRAINT accomplices_bank_name_city_date_robbed_fkey FOREIGN KEY (bank_name, city, date_robbed) REFERENCES public.robberies(bank_name, city, date_robbed) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: accomplices accomplices_robber_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dsouzrhea
--

ALTER TABLE ONLY public.accomplices
    ADD CONSTRAINT accomplices_robber_id_fkey FOREIGN KEY (robber_id) REFERENCES public.robbers(robber_id);


--
-- Name: hasaccounts hasaccounts_bank_name_city_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dsouzrhea
--

ALTER TABLE ONLY public.hasaccounts
    ADD CONSTRAINT hasaccounts_bank_name_city_fkey FOREIGN KEY (bank_name, city) REFERENCES public.banks(bank_name, city);


--
-- Name: hasaccounts hasaccounts_robber_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dsouzrhea
--

ALTER TABLE ONLY public.hasaccounts
    ADD CONSTRAINT hasaccounts_robber_id_fkey FOREIGN KEY (robber_id) REFERENCES public.robbers(robber_id);


--
-- Name: hasskills hasskills_robber_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dsouzrhea
--

ALTER TABLE ONLY public.hasskills
    ADD CONSTRAINT hasskills_robber_id_fkey FOREIGN KEY (robber_id) REFERENCES public.robbers(robber_id);


--
-- Name: hasskills hasskills_skill_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dsouzrhea
--

ALTER TABLE ONLY public.hasskills
    ADD CONSTRAINT hasskills_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES public.skills(skill_id);


--
-- Name: robberies robberies_bank_name_city_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dsouzrhea
--

ALTER TABLE ONLY public.robberies
    ADD CONSTRAINT robberies_bank_name_city_fkey FOREIGN KEY (bank_name, city) REFERENCES public.banks(bank_name, city);


--
-- Name: robberyplans robberyplans_bank_name_city_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dsouzrhea
--

ALTER TABLE ONLY public.robberyplans
    ADD CONSTRAINT robberyplans_bank_name_city_fkey FOREIGN KEY (bank_name, city) REFERENCES public.banks(bank_name, city);


--
-- PostgreSQL database dump complete
--
