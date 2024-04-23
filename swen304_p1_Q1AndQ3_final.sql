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
    robbery_share numeric(10,2)
);


ALTER TABLE public.accomplices OWNER TO dsouzrhea;

--
-- Name: banks; Type: TABLE; Schema: public; Owner: dsouzrhea
--

CREATE TABLE public.banks (
    bank_name character varying(100) NOT NULL,
    city character varying(100) NOT NULL,
    no_accounts integer,
    sec_level character varying(20)
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
    CONSTRAINT hasskills_preference_check CHECK (((preference >= 0) AND (preference <= 3)))
);


ALTER TABLE public.hasskills OWNER TO dsouzrhea;

--
-- Name: robberies; Type: TABLE; Schema: public; Owner: dsouzrhea
--

CREATE TABLE public.robberies (
    bank_name character varying(20) NOT NULL,
    city character varying(20) NOT NULL,
    date_robbed date NOT NULL,
    amount numeric(20,2) NOT NULL
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
-- Name: robbers_robber_id_seq1; Type: SEQUENCE; Schema: public; Owner: dsouzrhea
--

ALTER TABLE public.robbers ALTER COLUMN robber_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.robbers_robber_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: robberyplans; Type: TABLE; Schema: public; Owner: dsouzrhea
--

CREATE TABLE public.robberyplans (
    bank_name character varying(20) NOT NULL,
    city character varying(20) NOT NULL,
    no_robbers integer,
    planned_date date NOT NULL
);


ALTER TABLE public.robberyplans OWNER TO dsouzrhea;

--
-- Name: skills; Type: TABLE; Schema: public; Owner: dsouzrhea
--

CREATE TABLE public.skills (
    skill_id integer NOT NULL,
    description character varying(20) NOT NULL,
    CONSTRAINT id_description_mismatch CHECK ((((skill_id || '-'::text) || (description)::text) = concat(skill_id, '-', description)))
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
-- Name: temp_accomplice; Type: TABLE; Schema: public; Owner: dsouzrhea
--

CREATE TABLE public.temp_accomplice (
    nickname character varying(20),
    bank_name character varying(20),
    city character varying(20),
    date_robbed date,
    robbery_share numeric(10,2)
);


ALTER TABLE public.temp_accomplice OWNER TO dsouzrhea;

--
-- Name: skills skill_id; Type: DEFAULT; Schema: public; Owner: dsouzrhea
--

ALTER TABLE ONLY public.skills ALTER COLUMN skill_id SET DEFAULT nextval('public.skills_skill_id_seq'::regclass);


--
-- Data for Name: accomplices; Type: TABLE DATA; Schema: public; Owner: dsouzrhea
--

COPY public.accomplices (robber_id, bank_name, city, date_robbed, robbery_share) FROM stdin;
1	Bad Bank	Chicago	2017-02-02	3010.00
1	NXP Bank	Chicago	2019-01-08	6406.00
1	Loanshark Bank	Evanston	2019-02-28	4997.00
1	Loanshark Bank	Chicago	2019-03-30	4201.00
1	Inter-Gang Bank	Evanston	2016-02-16	12103.00
1	Inter-Gang Bank	Evanston	2018-02-14	8769.00
2	NXP Bank	Chicago	2019-01-08	2300.00
3	Penny Pinchers	Evanston	2016-08-30	16500.00
3	Loanshark Bank	Evanston	2019-02-28	4997.00
3	Loanshark Bank	Chicago	2017-11-09	8200.00
3	Loanshark Bank	Chicago	2019-03-30	4201.00
3	Inter-Gang Bank	Evanston	2018-02-14	8769.00
4	Penny Pinchers	Evanston	2016-08-30	16500.00
4	NXP Bank	Chicago	2019-01-08	6408.32
4	Loanshark Bank	Chicago	2019-03-30	4201.00
4	Inter-Gang Bank	Evanston	2018-02-14	8769.00
4	Gun Chase Bank	Evanston	2016-04-30	3291.30
5	Inter-Gang Bank	Evanston	2017-03-13	60000.00
5	Loanshark Bank	Evanston	2016-04-20	10000.00
7	Penny Pinchers	Chicago	2016-08-30	450.00
7	Loanshark Bank	Evanston	2017-04-20	2749.00
7	Inter-Gang Bank	Evanston	2018-02-14	8769.00
7	Gun Chase Bank	Evanston	2016-04-30	3282.00
8	Penny Pinchers	Evanston	2016-08-30	16500.00
8	Penny Pinchers	Chicago	2016-08-30	450.00
8	Loanshark Bank	Evanston	2017-04-20	2747.00
8	Inter-Gang Bank	Evanston	2016-02-16	12103.00
10	Penny Pinchers	Evanston	2016-08-30	16500.00
10	Loanshark Bank	Chicago	2017-11-09	8200.00
10	Inter-Gang Bank	Evanston	2016-02-16	12103.00
10	Gun Chase Bank	Evanston	2016-04-30	3282.00
11	Penny Pinchers	Evanston	2017-10-30	3000.00
12	PickPocket Bank	Evanston	2016-03-30	31.99
13	Dollar Grabbers	Evanston	2017-11-08	2000.00
14	Dollar Grabbers	Evanston	2017-06-28	1790.00
15	Inter-Gang Bank	Evanston	2017-03-13	30000.00
15	PickPocket Bank	Chicago	2018-02-28	119.00
15	Penny Pinchers	Evanston	2017-10-30	3000.50
15	Penny Pinchers	Evanston	2019-05-30	3250.10
15	Loanshark Bank	Chicago	2019-03-30	4201.01
15	Inter-Gang Bank	Evanston	2016-02-16	12103.00
15	Inter-Gang Bank	Evanston	2018-02-14	8774.00
16	Gun Chase Bank	Evanston	2016-04-30	5000.00
16	Penny Pinchers	Evanston	2016-08-30	16500.80
16	NXP Bank	Chicago	2019-01-08	6406.00
16	Loanshark Bank	Evanston	2016-04-20	2747.00
16	Loanshark Bank	Chicago	2017-11-09	8200.00
16	Inter-Gang Bank	Evanston	2016-02-16	12103.00
16	Inter-Gang Bank	Evanston	2018-02-14	8769.00
17	Loanshark Bank	Evanston	2016-04-20	12880.00
17	PickPocket Bank	Chicago	2018-02-28	120.00
17	Penny Pinchers	Evanston	2016-08-30	16500.00
17	Penny Pinchers	Evanston	2019-05-30	3250.10
17	Loanshark Bank	Evanston	2017-04-20	2747.00
17	Loanshark Bank	Evanston	2019-02-28	4999.00
17	Inter-Gang Bank	Evanston	2016-02-16	12105.00
18	Dollar Grabbers	Evanston	2017-06-28	1790.00
18	Bad Bank	Chicago	2017-02-02	3010.00
18	Dollar Grabbers	Evanston	2017-11-08	2000.00
20	PickPocket Bank	Evanston	2018-01-30	42.99
20	NXP Bank	Chicago	2019-01-08	6406.00
20	Loanshark Bank	Chicago	2017-11-09	8200.00
21	Penny Pinchers	Evanston	2019-05-30	3250.10
21	Loanshark Bank	Evanston	2019-02-28	4997.00
21	Loanshark Bank	Chicago	2017-11-09	8200.00
22	Inter-Gang Bank	Evanston	2017-03-13	2620.00
22	PickPocket Bank	Chicago	2015-09-21	679.00
22	Penny Pinchers	Evanston	2019-05-30	3250.10
23	PickPocket Bank	Chicago	2015-09-21	679.00
23	NXP Bank	Chicago	2019-01-08	6406.00
24	PickPocket Bank	Evanston	2018-01-30	500.00
24	PickPocket Bank	Evanston	2016-03-30	2000.00
24	PickPocket Bank	Chicago	2015-09-21	681.00
24	Penny Pinchers	Evanston	2017-10-30	3000.00
24	Loanshark Bank	Chicago	2019-03-30	4201.00
24	Gun Chase Bank	Evanston	2016-04-30	3282.00
\.


--
-- Data for Name: banks; Type: TABLE DATA; Schema: public; Owner: dsouzrhea
--

COPY public.banks (bank_name, city, no_accounts, sec_level) FROM stdin;
NXP Bank	Chicago	1593311	very good
Bankrupt Bank	Evanston	444000	weak
Loanshark Bank	Evanston	7654321	excellent
Loanshark Bank	Deerfield	3456789	very good
Loanshark Bank	Chicago	121212	excellent
Inter-Gang Bank	Chicago	100000	excellent
Inter-Gang Bank	Evanston	555555	excellent
NXP Bank	Evanston	656565	excellent
Penny Pinchers	Chicago	156165	weak
Dollar Grabbers	Chicago	56005	very good
Penny Pinchers	Evanston	130013	excellent
Dollar Grabbers	Evanston	909090	good
Gun Chase Bank	Evanston	656565	excellent
Gun Chase Bank	Burbank	1999	weak
PickPocket Bank	Evanston	2000	very good
PickPocket Bank	Deerfield	6565	excellent
PickPocket Bank	Chicago	130013	weak
Hidden Treasure	Chicago	999999	excellent
Bad Bank	Chicago	6000	weak
Outside Bank	Chicago	5000	good
EasyLoan Bank	Evanston	0	excellent
\.


--
-- Data for Name: hasaccounts; Type: TABLE DATA; Schema: public; Owner: dsouzrhea
--

COPY public.hasaccounts (robber_id, bank_name, city) FROM stdin;
1	Bad Bank	Chicago
1	Inter-Gang Bank	Evanston
1	NXP Bank	Chicago
2	Loanshark Bank	Chicago
2	Loanshark Bank	Deerfield
3	NXP Bank	Chicago
3	Bankrupt Bank	Evanston
4	Loanshark Bank	Evanston
5	Inter-Gang Bank	Evanston
5	Loanshark Bank	Evanston
7	Inter-Gang Bank	Chicago
8	Penny Pinchers	Evanston
9	PickPocket Bank	Chicago
9	PickPocket Bank	Evanston
9	Bad Bank	Chicago
9	Dollar Grabbers	Chicago
11	Penny Pinchers	Evanston
12	Dollar Grabbers	Evanston
12	Gun Chase Bank	Evanston
13	Gun Chase Bank	Burbank
14	PickPocket Bank	Evanston
15	PickPocket Bank	Deerfield
17	PickPocket Bank	Chicago
18	Bad Bank	Chicago
18	Gun Chase Bank	Evanston
19	Gun Chase Bank	Burbank
20	PickPocket Bank	Evanston
21	PickPocket Bank	Evanston
22	PickPocket Bank	Chicago
23	Hidden Treasure	Chicago
24	Hidden Treasure	Chicago
\.


--
-- Data for Name: hasskills; Type: TABLE DATA; Schema: public; Owner: dsouzrhea
--

COPY public.hasskills (robber_id, skill_id, preference, grade) FROM stdin;
1	8	3	A+
1	7	2	C+
1	3	1	A+
2	1	1	A 
3	9	2	B+
3	6	1	B+
4	2	1	A 
5	9	2	C 
5	3	1	A+
6	10	1	B+
7	9	2	C+
7	6	1	A+
8	3	3	C 
8	11	2	C+
8	6	1	C+
9	5	1	B 
10	8	1	B 
11	7	1	A+
12	7	1	A 
13	12	1	B+
14	12	1	B 
15	3	1	A+
16	3	1	A 
17	2	2	C+
17	9	1	A+
18	10	3	A+
18	4	2	A 
18	11	1	B+
19	12	1	C 
20	9	1	C 
21	5	1	C 
22	6	2	C 
22	8	1	A+
23	2	2	C 
23	9	1	A 
24	6	3	B 
24	7	2	C+
24	1	1	B 
\.


--
-- Data for Name: robberies; Type: TABLE DATA; Schema: public; Owner: dsouzrhea
--

COPY public.robberies (bank_name, city, date_robbed, amount) FROM stdin;
NXP Bank	Chicago	2019-01-08	34302.30
Loanshark Bank	Evanston	2019-02-28	19990.00
Loanshark Bank	Chicago	2019-03-30	21005.00
Inter-Gang Bank	Evanston	2018-02-14	52619.00
Penny Pinchers	Chicago	2016-08-30	900.00
Penny Pinchers	Evanston	2016-08-30	99000.80
Gun Chase Bank	Evanston	2016-04-30	18131.30
PickPocket Bank	Evanston	2016-03-30	2031.99
PickPocket Bank	Chicago	2018-02-28	239.00
Loanshark Bank	Evanston	2017-04-20	10990.00
Inter-Gang Bank	Evanston	2016-02-16	72620.00
Penny Pinchers	Evanston	2017-10-30	9000.50
PickPocket Bank	Evanston	2018-01-30	542.99
Loanshark Bank	Chicago	2017-11-09	41000.00
Penny Pinchers	Evanston	2019-05-30	13000.40
PickPocket Bank	Chicago	2015-09-21	2039.00
Loanshark Bank	Evanston	2016-04-20	20880.00
Inter-Gang Bank	Evanston	2017-03-13	92620.00
Dollar Grabbers	Evanston	2017-11-08	4380.00
Dollar Grabbers	Evanston	2017-06-28	3580.00
Bad Bank	Chicago	2017-02-02	6020.00
\.


--
-- Data for Name: robbers; Type: TABLE DATA; Schema: public; Owner: dsouzrhea
--

COPY public.robbers (robber_id, nickname, age, no_years) FROM stdin;
1	Al Capone	31	2
2	Bugsy Malone	42	15
3	Lucky Luchiano	42	15
4	Anastazia	48	15
5	Mimmy The Mau Mau	18	0
6	Tony Genovese	28	16
7	Dutch Schulz	64	31
8	Clyde	20	0
9	Calamity Jane	44	3
10	Bonnie	19	0
11	Meyer Lansky	34	6
12	Moe Dalitz	41	3
13	Mickey Cohen	24	3
14	Kid Cann	14	0
15	Boo Boo Hoff	54	13
16	King Solomon	74	43
17	Bugsy Siegel	48	13
18	Vito Genovese	66	0
19	Mike Genovese	35	0
20	Longy Zwillman	35	6
21	Waxey Gordon	15	0
22	Greasy Guzik	25	1
23	Lepke Buchalter	25	1
24	Sonny Genovese	39	0
\.


--
-- Data for Name: robberyplans; Type: TABLE DATA; Schema: public; Owner: dsouzrhea
--

COPY public.robberyplans (bank_name, city, no_robbers, planned_date) FROM stdin;
NXP Bank	Chicago	5	2019-10-30
Loanshark Bank	Deerfield	4	2019-11-15
Inter-Gang Bank	Evanston	4	2019-12-31
Dollar Grabbers	Chicago	3	2019-12-10
Gun Chase Bank	Evanston	6	2019-10-30
PickPocket Bank	Deerfield	6	2019-12-15
PickPocket Bank	Chicago	2	2020-03-10
Hidden Treasure	Chicago	5	2020-01-11
NXP Bank	Chicago	5	2019-10-10
Bad Bank	Chicago	2	2020-02-02
PickPocket Bank	Deerfield	6	2019-11-30
\.


--
-- Data for Name: skills; Type: TABLE DATA; Schema: public; Owner: dsouzrhea
--

COPY public.skills (skill_id, description) FROM stdin;
2	Guarding
3	Planning
4	Cooking
5	Gun-Shooting
6	Lock-Picking
7	Safe-Cracking
8	Preaching
9	Driving
10	Eating
11	Scouting
12	Money Counting
1	Explosives
\.


--
-- Data for Name: temp_accomplice; Type: TABLE DATA; Schema: public; Owner: dsouzrhea
--

COPY public.temp_accomplice (nickname, bank_name, city, date_robbed, robbery_share) FROM stdin;
Al Capone	Inter-Gang Bank	Evanston	2018-02-14	8769.00
Al Capone	Inter-Gang Bank	Evanston	2016-02-16	12103.00
Al Capone	Loanshark Bank	Chicago	2019-03-30	4201.00
Al Capone	Loanshark Bank	Evanston	2019-02-28	4997.00
Al Capone	NXP Bank	Chicago	2019-01-08	6406.00
Al Capone	Bad Bank	Chicago	2017-02-02	3010.00
Lucky Luchiano	Inter-Gang Bank	Evanston	2018-02-14	8769.00
Lucky Luchiano	Loanshark Bank	Chicago	2019-03-30	4201.00
Lucky Luchiano	Loanshark Bank	Chicago	2017-11-09	8200.00
Lucky Luchiano	Loanshark Bank	Evanston	2019-02-28	4997.00
Lucky Luchiano	Penny Pinchers	Evanston	2016-08-30	16500.00
Anastazia	Gun Chase Bank	Evanston	2016-04-30	3291.30
Anastazia	Inter-Gang Bank	Evanston	2018-02-14	8769.00
Anastazia	Loanshark Bank	Chicago	2019-03-30	4201.00
Anastazia	NXP Bank	Chicago	2019-01-08	6408.32
Anastazia	Penny Pinchers	Evanston	2016-08-30	16500.00
Dutch Schulz	Gun Chase Bank	Evanston	2016-04-30	3282.00
Dutch Schulz	Inter-Gang Bank	Evanston	2018-02-14	8769.00
Dutch Schulz	Loanshark Bank	Evanston	2017-04-20	2749.00
Dutch Schulz	Penny Pinchers	Chicago	2016-08-30	450.00
Clyde	Inter-Gang Bank	Evanston	2016-02-16	12103.00
Clyde	Loanshark Bank	Evanston	2017-04-20	2747.00
Clyde	Penny Pinchers	Chicago	2016-08-30	450.00
Clyde	Penny Pinchers	Evanston	2016-08-30	16500.00
Bonnie	Gun Chase Bank	Evanston	2016-04-30	3282.00
Bonnie	Inter-Gang Bank	Evanston	2016-02-16	12103.00
Bonnie	Loanshark Bank	Chicago	2017-11-09	8200.00
Bonnie	Penny Pinchers	Evanston	2016-08-30	16500.00
Meyer Lansky	Penny Pinchers	Evanston	2017-10-30	3000.00
Moe Dalitz	PickPocket Bank	Evanston	2016-03-30	31.99
Boo Boo Hoff	Inter-Gang Bank	Evanston	2018-02-14	8774.00
Boo Boo Hoff	Inter-Gang Bank	Evanston	2016-02-16	12103.00
Boo Boo Hoff	Loanshark Bank	Chicago	2019-03-30	4201.01
Boo Boo Hoff	Penny Pinchers	Evanston	2019-05-30	3250.10
Boo Boo Hoff	Penny Pinchers	Evanston	2017-10-30	3000.50
Boo Boo Hoff	PickPocket Bank	Chicago	2018-02-28	119.00
King Solomon	Inter-Gang Bank	Evanston	2018-02-14	8769.00
King Solomon	Inter-Gang Bank	Evanston	2016-02-16	12103.00
King Solomon	Loanshark Bank	Chicago	2017-11-09	8200.00
King Solomon	Loanshark Bank	Evanston	2016-04-20	2747.00
King Solomon	NXP Bank	Chicago	2019-01-08	6406.00
King Solomon	Penny Pinchers	Evanston	2016-08-30	16500.80
Bugsy Siegel	Inter-Gang Bank	Evanston	2016-02-16	12105.00
Bugsy Siegel	Loanshark Bank	Evanston	2019-02-28	4999.00
Bugsy Siegel	Loanshark Bank	Evanston	2017-04-20	2747.00
Bugsy Siegel	Penny Pinchers	Evanston	2019-05-30	3250.10
Bugsy Siegel	Penny Pinchers	Evanston	2016-08-30	16500.00
Bugsy Siegel	PickPocket Bank	Chicago	2018-02-28	120.00
Sonny Genovese	Gun Chase Bank	Evanston	2016-04-30	3282.00
Sonny Genovese	Loanshark Bank	Chicago	2019-03-30	4201.00
Sonny Genovese	Penny Pinchers	Evanston	2017-10-30	3000.00
Sonny Genovese	PickPocket Bank	Chicago	2015-09-21	681.00
Longy Zwillman	Loanshark Bank	Chicago	2017-11-09	8200.00
Longy Zwillman	NXP Bank	Chicago	2019-01-08	6406.00
Longy Zwillman	PickPocket Bank	Evanston	2018-01-30	42.99
Waxey Gordon	Loanshark Bank	Chicago	2017-11-09	8200.00
Waxey Gordon	Loanshark Bank	Evanston	2019-02-28	4997.00
Waxey Gordon	Penny Pinchers	Evanston	2019-05-30	3250.10
Greasy Guzik	Penny Pinchers	Evanston	2019-05-30	3250.10
Greasy Guzik	PickPocket Bank	Chicago	2015-09-21	679.00
Lepke Buchalter	NXP Bank	Chicago	2019-01-08	6406.00
Lepke Buchalter	PickPocket Bank	Chicago	2015-09-21	679.00
Mimmy The Mau Mau	Loanshark Bank	Evanston	2016-04-20	10000.00
Bugsy Siegel	Loanshark Bank	Evanston	2016-04-20	12880.00
Mimmy The Mau Mau	Inter-Gang Bank	Evanston	2017-03-13	60000.00
Greasy Guzik	Inter-Gang Bank	Evanston	2017-03-13	2620.00
Boo Boo Hoff	Inter-Gang Bank	Evanston	2017-03-13	30000.00
King Solomon	Gun Chase Bank	Evanston	2016-04-30	5000.00
Bugsy Malone	NXP Bank	Chicago	2019-01-08	2300.00
Sonny Genovese	PickPocket Bank	Evanston	2016-03-30	2000.00
Sonny Genovese	PickPocket Bank	Evanston	2018-01-30	500.00
Vito Genovese	Dollar Grabbers	Evanston	2017-11-08	2000.00
Vito Genovese	Bad Bank	Chicago	2017-02-02	3010.00
Mickey Cohen	Dollar Grabbers	Evanston	2017-11-08	2000.00
Vito Genovese	Dollar Grabbers	Evanston	2017-06-28	1790.00
Kid Cann	Dollar Grabbers	Evanston	2017-06-28	1790.00
\.


--
-- Name: robbers_robber_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dsouzrhea
--

SELECT pg_catalog.setval('public.robbers_robber_id_seq', 24, true);


--
-- Name: robbers_robber_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: dsouzrhea
--

SELECT pg_catalog.setval('public.robbers_robber_id_seq1', 1, false);


--
-- Name: skills_skill_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dsouzrhea
--

SELECT pg_catalog.setval('public.skills_skill_id_seq', 12, true);


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
    ADD CONSTRAINT hasskills_robber_id_fkey FOREIGN KEY (robber_id) REFERENCES public.robbers(robber_id) ON UPDATE CASCADE ON DELETE CASCADE;


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

