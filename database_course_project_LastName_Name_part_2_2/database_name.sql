--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0
-- Dumped by pg_dump version 17.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: bridgepatientriskfactor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bridgepatientriskfactor (
    bridgekey integer NOT NULL,
    patientkey integer NOT NULL,
    riskfactorkey integer NOT NULL
);


ALTER TABLE public.bridgepatientriskfactor OWNER TO postgres;

--
-- Name: bridgepatientriskfactor_bridgekey_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bridgepatientriskfactor_bridgekey_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bridgepatientriskfactor_bridgekey_seq OWNER TO postgres;

--
-- Name: bridgepatientriskfactor_bridgekey_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bridgepatientriskfactor_bridgekey_seq OWNED BY public.bridgepatientriskfactor.bridgekey;


--
-- Name: dimcountry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dimcountry (
    countrykey integer NOT NULL,
    countryname character varying(100) NOT NULL,
    continent character varying(100) NOT NULL,
    hemisphere character varying(100) NOT NULL
);


ALTER TABLE public.dimcountry OWNER TO postgres;

--
-- Name: dimcountry_countrykey_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dimcountry_countrykey_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dimcountry_countrykey_seq OWNER TO postgres;

--
-- Name: dimcountry_countrykey_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dimcountry_countrykey_seq OWNED BY public.dimcountry.countrykey;


--
-- Name: dimdiet; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dimdiet (
    dietkey integer NOT NULL,
    diettype character varying(50) NOT NULL,
    CONSTRAINT chk_diettype CHECK (((diettype)::text = ANY ((ARRAY['Healthy'::character varying, 'Average'::character varying, 'Unhealthy'::character varying])::text[])))
);


ALTER TABLE public.dimdiet OWNER TO postgres;

--
-- Name: dimdiet_dietkey_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dimdiet_dietkey_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dimdiet_dietkey_seq OWNER TO postgres;

--
-- Name: dimdiet_dietkey_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dimdiet_dietkey_seq OWNED BY public.dimdiet.dietkey;


--
-- Name: dimpatient; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dimpatient (
    patientkey integer NOT NULL,
    patientid character varying(50) NOT NULL,
    age integer,
    sex character varying(10),
    stresslevel integer,
    income numeric(12,2),
    CONSTRAINT chk_patientid_length CHECK ((char_length((patientid)::text) > 0)),
    CONSTRAINT dimpatient_age_check CHECK ((age > 0)),
    CONSTRAINT dimpatient_income_check CHECK ((income >= (0)::numeric)),
    CONSTRAINT dimpatient_sex_check CHECK (((sex)::text = ANY ((ARRAY['Male'::character varying, 'Female'::character varying])::text[]))),
    CONSTRAINT dimpatient_stresslevel_check CHECK ((stresslevel >= 0))
);


ALTER TABLE public.dimpatient OWNER TO postgres;

--
-- Name: dimpatient_patientkey_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dimpatient_patientkey_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dimpatient_patientkey_seq OWNER TO postgres;

--
-- Name: dimpatient_patientkey_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dimpatient_patientkey_seq OWNED BY public.dimpatient.patientkey;


--
-- Name: dimriskfactor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dimriskfactor (
    riskfactorkey integer NOT NULL,
    riskfactorname character varying(100) NOT NULL
);


ALTER TABLE public.dimriskfactor OWNER TO postgres;

--
-- Name: dimriskfactor_riskfactorkey_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dimriskfactor_riskfactorkey_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dimriskfactor_riskfactorkey_seq OWNER TO postgres;

--
-- Name: dimriskfactor_riskfactorkey_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dimriskfactor_riskfactorkey_seq OWNED BY public.dimriskfactor.riskfactorkey;


--
-- Name: dimtime; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dimtime (
    timekey integer NOT NULL,
    fulldate date NOT NULL,
    day integer NOT NULL,
    month integer NOT NULL,
    year integer NOT NULL,
    quarter integer NOT NULL,
    CONSTRAINT dimtime_quarter_check CHECK (((quarter >= 1) AND (quarter <= 4)))
);


ALTER TABLE public.dimtime OWNER TO postgres;

--
-- Name: dimtime_timekey_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dimtime_timekey_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dimtime_timekey_seq OWNER TO postgres;

--
-- Name: dimtime_timekey_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dimtime_timekey_seq OWNED BY public.dimtime.timekey;


--
-- Name: factheartattackrisk; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.factheartattackrisk (
    factkey integer NOT NULL,
    patientkey integer NOT NULL,
    countrykey integer NOT NULL,
    dietkey integer NOT NULL,
    timekey integer,
    cholesterol numeric(6,2),
    systolicbp integer,
    diastolicbp integer,
    heartrate integer,
    bmi numeric(5,2),
    triglycerides numeric(6,2),
    heartattackrisk boolean DEFAULT false NOT NULL,
    CONSTRAINT factheartattackrisk_bmi_check CHECK ((bmi > (0)::numeric)),
    CONSTRAINT factheartattackrisk_cholesterol_check CHECK ((cholesterol >= (0)::numeric)),
    CONSTRAINT factheartattackrisk_diastolicbp_check CHECK ((diastolicbp > 0)),
    CONSTRAINT factheartattackrisk_heartrate_check CHECK ((heartrate > 0)),
    CONSTRAINT factheartattackrisk_systolicbp_check CHECK ((systolicbp > 0)),
    CONSTRAINT factheartattackrisk_triglycerides_check CHECK ((triglycerides >= (0)::numeric))
);


ALTER TABLE public.factheartattackrisk OWNER TO postgres;

--
-- Name: factheartattackrisk_factkey_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.factheartattackrisk_factkey_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.factheartattackrisk_factkey_seq OWNER TO postgres;

--
-- Name: factheartattackrisk_factkey_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.factheartattackrisk_factkey_seq OWNED BY public.factheartattackrisk.factkey;


--
-- Name: staging_table; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.staging_table (
    patient_id character varying(50),
    age integer,
    sex character varying(10),
    cholesterol integer,
    blood_pressure character varying(10),
    heart_rate integer,
    diabetes integer,
    family_history integer,
    smoking integer,
    obesity integer,
    alcohol_consumption integer,
    exercise_hours_per_week numeric(5,2),
    diet character varying(20),
    previous_heart_problems integer,
    medication_use integer,
    stress_level integer,
    sedentary_hours_per_day numeric(5,2),
    income integer,
    bmi numeric(5,2),
    triglycerides integer,
    physical_activity_days_per_week integer,
    sleep_hours_per_day numeric(5,2),
    country character varying(50),
    continent character varying(50),
    hemisphere character varying(50),
    heart_attack_risk integer
);


ALTER TABLE public.staging_table OWNER TO postgres;

--
-- Name: bridgepatientriskfactor bridgekey; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bridgepatientriskfactor ALTER COLUMN bridgekey SET DEFAULT nextval('public.bridgepatientriskfactor_bridgekey_seq'::regclass);


--
-- Name: dimcountry countrykey; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dimcountry ALTER COLUMN countrykey SET DEFAULT nextval('public.dimcountry_countrykey_seq'::regclass);


--
-- Name: dimdiet dietkey; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dimdiet ALTER COLUMN dietkey SET DEFAULT nextval('public.dimdiet_dietkey_seq'::regclass);


--
-- Name: dimpatient patientkey; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dimpatient ALTER COLUMN patientkey SET DEFAULT nextval('public.dimpatient_patientkey_seq'::regclass);


--
-- Name: dimriskfactor riskfactorkey; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dimriskfactor ALTER COLUMN riskfactorkey SET DEFAULT nextval('public.dimriskfactor_riskfactorkey_seq'::regclass);


--
-- Name: dimtime timekey; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dimtime ALTER COLUMN timekey SET DEFAULT nextval('public.dimtime_timekey_seq'::regclass);


--
-- Name: factheartattackrisk factkey; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factheartattackrisk ALTER COLUMN factkey SET DEFAULT nextval('public.factheartattackrisk_factkey_seq'::regclass);


--
-- Data for Name: bridgepatientriskfactor; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.bridgepatientriskfactor VALUES (1, 2639, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (2, 2730, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (3, 2822, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (4, 2556, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (5, 3012, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (6, 2700, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (7, 2545, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (8, 2879, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (9, 2945, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (10, 2722, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (11, 3013, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (12, 2722, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (13, 2804, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (14, 2614, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (15, 2994, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (16, 2612, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (17, 2825, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (18, 2793, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (19, 2649, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (20, 2708, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (21, 2662, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (22, 3042, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (23, 2551, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (24, 2735, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (25, 3044, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (26, 2691, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (27, 2691, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (28, 2695, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (29, 2952, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (30, 2624, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (31, 3034, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (32, 2936, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (33, 3033, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (34, 2800, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (35, 2815, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (36, 2994, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (37, 2858, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (38, 2680, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (39, 2563, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (40, 2777, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (41, 2803, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (42, 2545, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (43, 2996, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (44, 2686, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (45, 2881, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (46, 3044, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (47, 2781, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (48, 2915, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (49, 2957, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (50, 3035, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (51, 3036, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (52, 2610, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (53, 2674, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (54, 2543, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (55, 2668, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (56, 2971, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (57, 3011, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (58, 2730, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (59, 2784, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (60, 2963, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (61, 2658, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (62, 2966, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (63, 2587, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (64, 2972, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (65, 2991, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (66, 2784, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (67, 2765, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (68, 2979, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (69, 2868, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (70, 2759, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (71, 2937, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (72, 2646, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (73, 3012, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (74, 2950, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (75, 2578, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (76, 2737, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (77, 2685, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (78, 2644, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (79, 2916, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (80, 2706, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (81, 2715, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (82, 2761, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (83, 2588, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (84, 2956, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (85, 2657, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (86, 2607, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (87, 3036, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (88, 2752, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (89, 2772, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (90, 2740, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (91, 3018, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (92, 2806, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (93, 2593, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (94, 3020, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (95, 2670, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (96, 2686, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (97, 2554, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (98, 2595, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (99, 2557, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (100, 2553, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (101, 2645, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (102, 2928, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (103, 2710, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (104, 2734, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (105, 2755, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (106, 3047, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (107, 2986, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (108, 2873, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (109, 3037, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (110, 2835, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (111, 2563, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (112, 2803, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (113, 2759, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (114, 3009, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (115, 2950, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (116, 2598, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (117, 2660, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (118, 2641, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (119, 2975, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (120, 2881, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (121, 2561, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (122, 2815, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (123, 2614, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (124, 2952, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (125, 2908, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (126, 2552, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (127, 2882, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (128, 2910, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (129, 2813, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (130, 2954, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (131, 2700, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (132, 2811, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (133, 2775, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (134, 2844, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (135, 2895, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (136, 2565, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (137, 2762, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (138, 2774, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (139, 2555, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (140, 2598, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (141, 2948, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (142, 2655, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (143, 2742, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (144, 2981, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (145, 2570, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (146, 3048, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (147, 2896, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (148, 2919, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (149, 2546, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (150, 2763, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (151, 2631, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (152, 2780, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (153, 2752, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (154, 2831, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (155, 2986, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (156, 2777, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (157, 2927, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (158, 2679, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (159, 2954, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (160, 2709, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (161, 2855, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (162, 3017, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (163, 2662, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (164, 2967, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (165, 3023, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (166, 2577, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (167, 2925, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (168, 2929, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (169, 2671, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (170, 2925, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (171, 2555, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (172, 2982, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (173, 2590, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (174, 2821, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (175, 2757, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (176, 2791, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (177, 2653, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (178, 2560, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (179, 2728, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (180, 2967, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (181, 2922, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (182, 2633, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (183, 2843, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (184, 2579, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (185, 2808, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (186, 2575, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (187, 2850, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (188, 2947, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (189, 3028, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (190, 2650, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (191, 2542, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (192, 2878, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (193, 2886, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (194, 2690, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (195, 2723, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (196, 2543, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (197, 2941, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (198, 3000, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (199, 2719, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (200, 2864, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (201, 2812, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (202, 2960, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (203, 2857, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (204, 3044, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (205, 2782, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (206, 2721, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (207, 2931, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (208, 2903, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (209, 2963, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (210, 2562, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (211, 2651, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (212, 2890, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (213, 2789, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (214, 2701, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (215, 2887, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (216, 2620, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (217, 2840, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (218, 2974, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (219, 2764, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (220, 2668, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (221, 2547, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (222, 3020, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (223, 2900, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (224, 2823, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (225, 2972, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (226, 2551, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (227, 2737, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (228, 2625, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (229, 2856, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (230, 3011, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (231, 2965, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (232, 2720, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (233, 2575, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (234, 2558, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (235, 2696, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (236, 2635, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (237, 2975, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (238, 2734, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (239, 2667, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (240, 2795, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (241, 3024, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (242, 2836, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (243, 2898, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (244, 2572, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (245, 3016, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (246, 2639, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (247, 2955, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (248, 2658, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (249, 2645, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (250, 2604, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (251, 2580, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (252, 2907, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (253, 2890, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (254, 2652, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (255, 2725, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (256, 2548, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (257, 2557, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (258, 2870, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (259, 2585, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (260, 2750, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (261, 2643, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (262, 2809, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (263, 2547, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (264, 2884, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (265, 2559, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (266, 2774, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (267, 2548, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (268, 2638, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (269, 2571, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (270, 2719, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (271, 2599, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (272, 2951, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (273, 3004, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (274, 2690, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (275, 2661, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (276, 2847, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (277, 2999, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (278, 2768, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (279, 2838, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (280, 2847, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (281, 2911, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (282, 3014, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (283, 2930, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (284, 2620, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (285, 2792, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (286, 2857, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (287, 2853, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (288, 2984, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (289, 2962, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (290, 2684, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (291, 2935, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (292, 3007, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (293, 2581, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (294, 2587, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (295, 2560, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (296, 2699, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (297, 2928, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (298, 3008, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (299, 2672, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (300, 2756, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (301, 2898, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (302, 2944, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (303, 2833, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (304, 2851, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (305, 2787, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (306, 2654, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (307, 2630, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (308, 2923, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (309, 2968, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (310, 2787, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (311, 2770, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (312, 2833, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (313, 3003, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (314, 2814, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (315, 2841, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (316, 2735, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (317, 2566, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (318, 2725, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (319, 2936, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (320, 2636, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (321, 2591, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (322, 2559, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (323, 2771, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (324, 2844, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (325, 2770, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (326, 3042, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (327, 2859, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (328, 2561, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (329, 2954, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (330, 2998, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (331, 2877, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (332, 3005, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (333, 2621, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (334, 2863, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (335, 2681, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (336, 2858, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (337, 2760, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (338, 2638, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (339, 2970, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (340, 2964, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (341, 3032, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (342, 2902, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (343, 2872, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (344, 2713, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (345, 2701, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (346, 2843, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (347, 2913, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (348, 3025, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (349, 2966, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (350, 3026, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (351, 2948, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (352, 2918, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (353, 2711, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (354, 2626, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (355, 2579, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (356, 3030, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (357, 3025, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (358, 2605, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (359, 2869, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (360, 2682, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (361, 2915, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (362, 2856, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (363, 2763, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (364, 2541, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (365, 2975, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (366, 2590, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (367, 2808, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (368, 2699, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (369, 2832, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (370, 2978, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (371, 2706, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (372, 2816, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (373, 2823, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (374, 2829, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (375, 2716, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (376, 2637, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (377, 3042, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (378, 2880, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (379, 2861, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (380, 2790, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (381, 2619, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (382, 2651, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (383, 2812, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (384, 2923, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (385, 2758, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (386, 2564, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (387, 2623, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (388, 2788, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (389, 2678, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (390, 3010, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (391, 2889, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (392, 2613, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (393, 2941, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (394, 3027, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (395, 3041, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (396, 2660, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (397, 2934, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (398, 2687, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (399, 2549, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (400, 2761, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (401, 2870, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (402, 2666, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (403, 2658, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (404, 2854, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (405, 2931, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (406, 2962, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (407, 2796, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (408, 2709, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (409, 2965, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (410, 2684, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (411, 2718, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (412, 3033, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (413, 3019, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (414, 2632, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (415, 2647, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (416, 2992, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (417, 2935, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (418, 2705, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (419, 2848, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (420, 2868, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (421, 2634, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (422, 2816, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (423, 2865, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (424, 2990, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (425, 2688, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (426, 2866, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (427, 2570, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (428, 2840, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (429, 2796, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (430, 2830, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (431, 2980, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (432, 2765, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (433, 2918, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (434, 2592, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (435, 2924, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (436, 3047, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (437, 3025, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (438, 2702, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (439, 3031, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (440, 2666, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (441, 2836, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (442, 2988, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (443, 2813, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (444, 2588, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (445, 2910, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (446, 2573, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (447, 2778, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (448, 2736, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (449, 2745, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (450, 2602, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (451, 2550, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (452, 3014, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (453, 2899, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (454, 3028, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (455, 2708, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (456, 2576, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (457, 2962, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (458, 2969, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (459, 2737, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (460, 2562, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (461, 2670, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (462, 2882, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (463, 3019, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (464, 2999, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (465, 2979, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (466, 2696, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (467, 2985, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (468, 2693, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (469, 3003, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (470, 2824, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (471, 3046, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (472, 2607, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (473, 2612, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (474, 2851, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (475, 2815, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (476, 2871, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (477, 2921, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (478, 2612, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (479, 2613, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (480, 2726, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (481, 2997, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (482, 2586, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (483, 2909, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (484, 2569, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (485, 2865, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (486, 2779, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (487, 2982, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (488, 2879, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (489, 2668, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (490, 2565, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (491, 3040, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (492, 2628, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (493, 2900, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (494, 2825, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (495, 2994, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (496, 3046, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (497, 3017, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (498, 2885, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (499, 2716, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (500, 2798, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (501, 2714, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (502, 2790, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (503, 2617, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (504, 2812, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (505, 2907, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (506, 2901, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (507, 3016, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (508, 2740, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (509, 2849, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (510, 3021, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (511, 3004, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (512, 2555, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (513, 2864, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (514, 2594, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (515, 2593, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (516, 2600, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (517, 2596, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (518, 2546, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (519, 2712, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (520, 2660, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (521, 2727, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (522, 2786, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (523, 3024, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (524, 2873, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (525, 2689, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (526, 2554, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (527, 2917, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (528, 2747, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (529, 2584, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (530, 2616, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (531, 2940, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (532, 2578, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (533, 2674, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (534, 2651, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (535, 2640, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (536, 2938, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (537, 2673, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (538, 2894, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (539, 2983, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (540, 2760, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (541, 2580, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (542, 2949, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (543, 2606, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (544, 2648, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (545, 3035, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (546, 2861, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (547, 2713, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (548, 2749, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (549, 2867, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (550, 2868, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (551, 3022, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (552, 2926, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (553, 2774, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (554, 2817, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (555, 2919, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (556, 2561, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (557, 2885, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (558, 2942, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (559, 2927, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (560, 2585, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (561, 2554, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (562, 3027, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (563, 2973, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (564, 2552, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (565, 2966, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (566, 2748, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (567, 2587, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (568, 2904, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (569, 2842, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (570, 2577, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (571, 2575, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (572, 2848, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (573, 3003, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (574, 2676, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (575, 2736, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (576, 2584, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (577, 2896, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (578, 3031, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (579, 2961, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (580, 2704, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (581, 2884, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (582, 2809, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (583, 2831, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (584, 2781, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (585, 2786, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (586, 2603, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (587, 2621, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (588, 3002, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (589, 2669, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (590, 2705, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (591, 2933, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (592, 2666, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (593, 2617, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (594, 2652, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (595, 2601, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (596, 2627, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (597, 2959, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (598, 3009, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (599, 2944, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (600, 2977, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (601, 2878, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (602, 2706, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (603, 2745, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (604, 2664, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (605, 2603, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (606, 2659, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (607, 2780, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (608, 2677, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (609, 2792, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (610, 2911, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (611, 2676, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (612, 3027, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (613, 2671, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (614, 2714, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (615, 2596, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (616, 2897, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (617, 2643, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (618, 2656, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (619, 3006, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (620, 2600, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (621, 2763, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (622, 2974, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (623, 2820, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (624, 2876, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (625, 2744, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (626, 2630, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (627, 2615, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (628, 2860, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (629, 3041, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (630, 2696, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (631, 2679, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (632, 2830, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (633, 2874, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (634, 2757, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (635, 2978, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (636, 3038, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (637, 2695, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (638, 2652, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (639, 3006, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (640, 2766, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (641, 2741, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (642, 2750, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (643, 2971, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (644, 2615, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (645, 2969, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (646, 3043, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (647, 3018, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (648, 2741, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (649, 2794, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (650, 2598, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (651, 2776, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (652, 2746, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (653, 2729, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (654, 2852, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (655, 2606, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (656, 2953, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (657, 2837, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (658, 2692, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (659, 2803, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (660, 2830, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (661, 2755, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (662, 2805, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (663, 2862, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (664, 2688, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (665, 2829, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (666, 2924, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (667, 2704, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (668, 2916, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (669, 2797, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (670, 2750, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (671, 2558, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (672, 2610, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (673, 2627, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (674, 2808, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (675, 2871, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (676, 2709, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (677, 2589, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (678, 2984, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (679, 3002, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (680, 2961, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (681, 2562, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (682, 2582, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (683, 2723, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (684, 3032, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (685, 2819, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (686, 2767, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (687, 2669, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (688, 2739, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (689, 2807, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (690, 2890, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (691, 2650, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (692, 2924, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (693, 2838, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (694, 2848, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (695, 2541, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (696, 2940, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (697, 2605, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (698, 2913, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (699, 2827, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (700, 2691, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (701, 3023, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (702, 2731, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (703, 2817, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (704, 2743, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (705, 2880, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (706, 3019, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (707, 2863, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (708, 2664, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (709, 3039, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (710, 2794, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (711, 2974, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (712, 2762, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (713, 2897, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (714, 2599, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (715, 2648, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (716, 2779, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (717, 2568, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (718, 2782, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (719, 2576, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (720, 2866, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (721, 2832, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (722, 2674, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (723, 2741, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (724, 2814, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (725, 2796, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (726, 2985, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (727, 2629, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (728, 2886, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (729, 2907, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (730, 2942, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (731, 2692, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (732, 2980, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (733, 2922, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (734, 3021, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (735, 2834, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (736, 3030, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (737, 2634, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (738, 2728, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (739, 2917, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (740, 2547, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (741, 2550, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (742, 2558, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (743, 2912, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (744, 2837, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (745, 2919, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (746, 2829, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (747, 2548, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (748, 3041, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (749, 2792, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (750, 2884, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (751, 2797, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (752, 2780, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (753, 2905, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (754, 2977, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (755, 2889, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (756, 2799, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (757, 2566, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (758, 2769, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (759, 2553, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (760, 2807, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (761, 2938, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (762, 2765, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (763, 2574, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (764, 2840, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (765, 2911, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (766, 2786, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (767, 2874, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (768, 2766, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (769, 2914, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (770, 2647, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (771, 3029, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (772, 2729, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (773, 2592, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (774, 2732, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (775, 2573, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (776, 2753, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (777, 2820, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (778, 2958, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (779, 2997, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (780, 2647, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (781, 2768, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (782, 2785, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (783, 2564, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (784, 2991, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (785, 2675, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (786, 2767, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (787, 2602, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (788, 2818, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (789, 2826, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (790, 2749, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (791, 3039, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (792, 2867, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (793, 2589, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (794, 2744, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (795, 2707, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (796, 2811, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (797, 3029, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (798, 2839, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (799, 2988, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (800, 2597, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (801, 2623, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (802, 2892, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (803, 2567, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (804, 2665, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (805, 2947, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (806, 2788, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (807, 2604, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (808, 2772, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (809, 2801, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (810, 2785, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (811, 2702, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (812, 2686, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (813, 2973, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (814, 2576, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (815, 3017, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (816, 2791, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (817, 2777, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (818, 2751, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (819, 2882, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (820, 3005, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (821, 2711, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (822, 2899, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (823, 2783, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (824, 2843, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (825, 2854, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (826, 2875, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (827, 3043, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (828, 2992, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (829, 2795, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (830, 2707, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (831, 2964, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (832, 2656, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (833, 2903, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (834, 2642, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (835, 2893, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (836, 3037, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (837, 2955, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (838, 2714, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (839, 2717, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (840, 2964, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (841, 2891, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (842, 2838, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (843, 2847, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (844, 2694, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (845, 2567, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (846, 2596, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (847, 2939, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (848, 2987, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (849, 2819, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (850, 2604, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (851, 2945, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (852, 2906, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (853, 2677, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (854, 3047, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (855, 2906, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (856, 2568, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (857, 2983, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (858, 2688, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (859, 2877, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (860, 2915, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (861, 2805, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (862, 2908, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (863, 2673, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (864, 2795, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (865, 2949, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (866, 2845, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (867, 2642, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (868, 2983, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (869, 2667, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (870, 2608, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (871, 2976, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (872, 2877, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (873, 3030, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (874, 2631, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (875, 2622, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (876, 2758, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (877, 2550, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (878, 2933, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (879, 2942, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (880, 2722, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (881, 2894, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (882, 2920, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (883, 2581, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (884, 2841, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (885, 2712, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (886, 2675, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (887, 3005, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (888, 2669, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (889, 2619, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (890, 3033, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (891, 2754, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (892, 2559, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (893, 2858, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (894, 2557, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (895, 3010, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (896, 2544, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (897, 2747, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (898, 2961, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (899, 2773, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (900, 2719, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (901, 2998, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (902, 2681, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (903, 2609, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (904, 2990, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (905, 3036, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (906, 2589, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (907, 3014, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (908, 2697, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (909, 2828, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (910, 2769, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (911, 2977, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (912, 2810, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (913, 2832, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (914, 2657, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (915, 2702, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (916, 2979, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (917, 3034, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (918, 2638, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (919, 2918, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (920, 2582, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (921, 2659, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (922, 2733, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (923, 2629, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (924, 2684, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (925, 3007, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (926, 2703, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (927, 2571, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (928, 2841, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (929, 3038, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (930, 2644, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (931, 2661, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (932, 2947, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (933, 2614, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (934, 2661, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (935, 2583, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (936, 2650, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (937, 2934, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (938, 2767, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (939, 2849, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (940, 2733, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (941, 2921, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (942, 2556, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (943, 2797, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (944, 2958, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (945, 2642, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (946, 2732, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (947, 2695, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (948, 2755, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (949, 2749, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (950, 2556, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (951, 2960, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (952, 2850, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (953, 2846, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (954, 2805, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (955, 2952, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (956, 2988, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (957, 2711, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (958, 2693, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (959, 2622, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (960, 2939, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (961, 2893, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (962, 2697, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (963, 2572, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (964, 2616, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (965, 2591, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (966, 2860, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (967, 2969, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (968, 2818, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (969, 3015, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (970, 2545, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (971, 2976, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (972, 2824, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (973, 2968, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (974, 2853, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (975, 2943, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (976, 2753, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (977, 2821, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (978, 2708, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (979, 2873, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (980, 2569, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (981, 2601, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (982, 2655, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (983, 2790, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (984, 2971, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (985, 2627, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (986, 3028, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (987, 2897, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (988, 2640, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (989, 2968, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (990, 2677, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (991, 2744, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (992, 2909, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (993, 2768, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (994, 2637, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (995, 3026, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (996, 2543, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (997, 2883, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (998, 2914, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (999, 2703, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (1000, 2887, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (1001, 2879, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (1002, 2887, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (1003, 3032, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (1004, 2943, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (1005, 2583, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (1006, 3006, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (1007, 2715, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (1008, 2846, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (1009, 2853, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (1010, 2681, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (1011, 2752, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (1012, 2601, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (1013, 2835, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (1014, 2724, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (1015, 2729, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (1016, 2645, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (1017, 2597, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (1018, 2747, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (1019, 2783, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (1020, 2736, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (1021, 2895, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (1022, 2931, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (1023, 2956, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (1024, 3001, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (1025, 2789, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (1026, 2637, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (1027, 2905, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (1028, 2846, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (1029, 2726, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (1030, 2710, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (1031, 2646, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (1032, 2929, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (1033, 2957, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (1034, 2678, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (1035, 2885, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (1036, 2821, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (1037, 2679, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (1038, 2936, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (1039, 2771, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (1040, 2834, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (1041, 2990, 18);
INSERT INTO public.bridgepatientriskfactor VALUES (1042, 2738, 17);
INSERT INTO public.bridgepatientriskfactor VALUES (1043, 2927, 16);
INSERT INTO public.bridgepatientriskfactor VALUES (1044, 3016, 18);


--
-- Data for Name: dimcountry; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.dimcountry VALUES (101, 'New Zealand', 'Australia', 'Southern Hemisphere');
INSERT INTO public.dimcountry VALUES (102, 'United Kingdom', 'Europe', 'Northern Hemisphere');
INSERT INTO public.dimcountry VALUES (103, 'France', 'Europe', 'Northern Hemisphere');
INSERT INTO public.dimcountry VALUES (104, 'Vietnam', 'Asia', 'Northern Hemisphere');
INSERT INTO public.dimcountry VALUES (105, 'India', 'Asia', 'Northern Hemisphere');
INSERT INTO public.dimcountry VALUES (106, 'Japan', 'Asia', 'Northern Hemisphere');
INSERT INTO public.dimcountry VALUES (107, 'United States', 'North America', 'Northern Hemisphere');
INSERT INTO public.dimcountry VALUES (108, 'Thailand', 'Asia', 'Northern Hemisphere');
INSERT INTO public.dimcountry VALUES (109, 'Australia', 'Australia', 'Southern Hemisphere');
INSERT INTO public.dimcountry VALUES (110, 'Nigeria', 'Africa', 'Northern Hemisphere');
INSERT INTO public.dimcountry VALUES (111, 'Spain', 'Europe', 'Southern Hemisphere');
INSERT INTO public.dimcountry VALUES (112, 'Colombia', 'South America', 'Northern Hemisphere');
INSERT INTO public.dimcountry VALUES (113, 'Canada', 'North America', 'Northern Hemisphere');
INSERT INTO public.dimcountry VALUES (114, 'Brazil', 'South America', 'Southern Hemisphere');
INSERT INTO public.dimcountry VALUES (115, 'Argentina', 'South America', 'Southern Hemisphere');
INSERT INTO public.dimcountry VALUES (116, 'South Africa', 'Africa', 'Southern Hemisphere');
INSERT INTO public.dimcountry VALUES (117, 'South Korea', 'Asia', 'Northern Hemisphere');
INSERT INTO public.dimcountry VALUES (118, 'Italy', 'Europe', 'Southern Hemisphere');
INSERT INTO public.dimcountry VALUES (119, 'China', 'Asia', 'Northern Hemisphere');
INSERT INTO public.dimcountry VALUES (120, 'Germany', 'Europe', 'Northern Hemisphere');


--
-- Data for Name: dimdiet; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.dimdiet VALUES (16, 'Unhealthy');
INSERT INTO public.dimdiet VALUES (17, 'Average');
INSERT INTO public.dimdiet VALUES (18, 'Healthy');


--
-- Data for Name: dimpatient; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.dimpatient VALUES (2541, 'VSV3386', 90, 'Male', 4, 283904.00);
INSERT INTO public.dimpatient VALUES (2542, 'YTR7765', 26, 'Female', 9, 169454.00);
INSERT INTO public.dimpatient VALUES (2543, 'OKX6945', 69, 'Female', 6, 27654.00);
INSERT INTO public.dimpatient VALUES (2544, 'NKF4625', 32, 'Female', 7, 160680.00);
INSERT INTO public.dimpatient VALUES (2545, 'KTU2333', 80, 'Male', 6, 55296.00);
INSERT INTO public.dimpatient VALUES (2546, 'SIO9750', 77, 'Male', 4, 32763.00);
INSERT INTO public.dimpatient VALUES (2547, 'YKA1578', 89, 'Male', 1, 262651.00);
INSERT INTO public.dimpatient VALUES (2548, 'SCA4405', 77, 'Male', 3, 180235.00);
INSERT INTO public.dimpatient VALUES (2549, 'QGJ6378', 76, 'Male', 9, 136616.00);
INSERT INTO public.dimpatient VALUES (2550, 'MFC2532', 74, 'Male', 5, 289933.00);
INSERT INTO public.dimpatient VALUES (2551, 'JDP9221', 40, 'Male', 4, 178241.00);
INSERT INTO public.dimpatient VALUES (2552, 'PNK2263', 75, 'Female', 6, 232143.00);
INSERT INTO public.dimpatient VALUES (2553, 'WCW0650', 35, 'Male', 9, 72569.00);
INSERT INTO public.dimpatient VALUES (2554, 'LEE8234', 38, 'Male', 7, 202662.00);
INSERT INTO public.dimpatient VALUES (2555, 'FLG2019', 52, 'Female', 3, 135099.00);
INSERT INTO public.dimpatient VALUES (2556, 'YZU1958', 80, 'Male', 4, 203014.00);
INSERT INTO public.dimpatient VALUES (2557, 'IPU0926', 45, 'Male', 2, 261792.00);
INSERT INTO public.dimpatient VALUES (2558, 'RQS7383', 48, 'Male', 4, 250386.00);
INSERT INTO public.dimpatient VALUES (2559, 'ZOY4018', 50, 'Male', 8, 95865.00);
INSERT INTO public.dimpatient VALUES (2560, 'KCY9500', 36, 'Male', 8, 102220.00);
INSERT INTO public.dimpatient VALUES (2561, 'WER6567', 45, 'Male', 8, 86260.00);
INSERT INTO public.dimpatient VALUES (2562, 'YOD3294', 31, 'Male', 2, 269959.00);
INSERT INTO public.dimpatient VALUES (2563, 'ZJI5100', 66, 'Female', 8, 203637.00);
INSERT INTO public.dimpatient VALUES (2564, 'NCU4581', 46, 'Female', 6, 193248.00);
INSERT INTO public.dimpatient VALUES (2565, 'NQS1727', 60, 'Male', 9, 193069.00);
INSERT INTO public.dimpatient VALUES (2566, 'IED0019', 58, 'Female', 2, 257788.00);
INSERT INTO public.dimpatient VALUES (2567, 'RNA0445', 88, 'Female', 8, 285832.00);
INSERT INTO public.dimpatient VALUES (2568, 'YTR1728', 90, 'Female', 6, 73167.00);
INSERT INTO public.dimpatient VALUES (2569, 'NBD0612', 29, 'Female', 8, 220053.00);
INSERT INTO public.dimpatient VALUES (2570, 'AYM4283', 82, 'Male', 2, 131867.00);
INSERT INTO public.dimpatient VALUES (2571, 'KTW5157', 72, 'Male', 3, 176507.00);
INSERT INTO public.dimpatient VALUES (2572, 'PKU2212', 32, 'Male', 7, 105975.00);
INSERT INTO public.dimpatient VALUES (2573, 'CIV0067', 22, 'Male', 8, 26329.00);
INSERT INTO public.dimpatient VALUES (2574, 'DRT6328', 31, 'Female', 1, 30816.00);
INSERT INTO public.dimpatient VALUES (2575, 'IUH2759', 56, 'Female', 10, 235004.00);
INSERT INTO public.dimpatient VALUES (2576, 'VAE5681', 25, 'Male', 5, 157825.00);
INSERT INTO public.dimpatient VALUES (2577, 'UMW1846', 19, 'Male', 2, 193418.00);
INSERT INTO public.dimpatient VALUES (2578, 'NHU7732', 85, 'Male', 1, 162314.00);
INSERT INTO public.dimpatient VALUES (2579, 'XXM0972', 84, 'Male', 4, 122093.00);
INSERT INTO public.dimpatient VALUES (2580, 'JXV3603', 56, 'Female', 9, 97153.00);
INSERT INTO public.dimpatient VALUES (2581, 'NHX8643', 31, 'Female', 5, 187864.00);
INSERT INTO public.dimpatient VALUES (2582, 'JSV9471', 74, 'Male', 7, 48943.00);
INSERT INTO public.dimpatient VALUES (2583, 'OBX7266', 89, 'Female', 9, 169933.00);
INSERT INTO public.dimpatient VALUES (2584, 'LPN6836', 58, 'Female', 9, 283638.00);
INSERT INTO public.dimpatient VALUES (2585, 'AYY8711', 26, 'Male', 3, 57948.00);
INSERT INTO public.dimpatient VALUES (2586, 'BCR8001', 21, 'Female', 10, 122051.00);
INSERT INTO public.dimpatient VALUES (2587, 'XHY0495', 44, 'Male', 8, 242224.00);
INSERT INTO public.dimpatient VALUES (2588, 'DNY3115', 46, 'Male', 5, 128868.00);
INSERT INTO public.dimpatient VALUES (2589, 'XFP2219', 81, 'Female', 1, 20858.00);
INSERT INTO public.dimpatient VALUES (2590, 'FUM7288', 36, 'Male', 3, 203019.00);
INSERT INTO public.dimpatient VALUES (2591, 'OVT8107', 63, 'Male', 7, 297069.00);
INSERT INTO public.dimpatient VALUES (2592, 'RVJ3813', 79, 'Male', 7, 110048.00);
INSERT INTO public.dimpatient VALUES (2593, 'YVI8512', 53, 'Female', 2, 284801.00);
INSERT INTO public.dimpatient VALUES (2594, 'EDK0937', 56, 'Female', 9, 68601.00);
INSERT INTO public.dimpatient VALUES (2595, 'AMH0692', 83, 'Female', 3, 261285.00);
INSERT INTO public.dimpatient VALUES (2596, 'FPS0415', 77, 'Male', 9, 29886.00);
INSERT INTO public.dimpatient VALUES (2597, 'BDG2694', 54, 'Female', 8, 50984.00);
INSERT INTO public.dimpatient VALUES (2598, 'DWN2141', 63, 'Male', 1, 247960.00);
INSERT INTO public.dimpatient VALUES (2599, 'DBA0284', 89, 'Male', 9, 264172.00);
INSERT INTO public.dimpatient VALUES (2600, 'XBI0592', 50, 'Female', 1, 21501.00);
INSERT INTO public.dimpatient VALUES (2601, 'CFU1297', 82, 'Male', 6, 217539.00);
INSERT INTO public.dimpatient VALUES (2602, 'HGB5652', 90, 'Male', 10, 154900.00);
INSERT INTO public.dimpatient VALUES (2603, 'JPD8131', 73, 'Male', 2, 254849.00);
INSERT INTO public.dimpatient VALUES (2604, 'MYN6230', 81, 'Male', 9, 286374.00);
INSERT INTO public.dimpatient VALUES (2605, 'GXA9148', 28, 'Male', 10, 165452.00);
INSERT INTO public.dimpatient VALUES (2606, 'DFW2933', 56, 'Female', 2, 55412.00);
INSERT INTO public.dimpatient VALUES (2607, 'GMX4668', 61, 'Male', 7, 185111.00);
INSERT INTO public.dimpatient VALUES (2608, 'XSS0940', 63, 'Male', 5, 227989.00);
INSERT INTO public.dimpatient VALUES (2609, 'SNL4419', 35, 'Male', 4, 187632.00);
INSERT INTO public.dimpatient VALUES (2610, 'WFR1570', 41, 'Male', 9, 126596.00);
INSERT INTO public.dimpatient VALUES (2611, 'JEK2629', 27, 'Female', 2, 148649.00);
INSERT INTO public.dimpatient VALUES (2612, 'LTU0801', 70, 'Female', 3, 242491.00);
INSERT INTO public.dimpatient VALUES (2613, 'RKM6961', 50, 'Male', 9, 261735.00);
INSERT INTO public.dimpatient VALUES (2614, 'DXB2434', 69, 'Male', 5, 267997.00);
INSERT INTO public.dimpatient VALUES (2615, 'WDB5143', 45, 'Male', 2, 265090.00);
INSERT INTO public.dimpatient VALUES (2616, 'RHR1854', 53, 'Male', 2, 213726.00);
INSERT INTO public.dimpatient VALUES (2617, 'OSV3898', 55, 'Female', 5, 297321.00);
INSERT INTO public.dimpatient VALUES (2618, 'TLC3781', 24, 'Female', 4, 223931.00);
INSERT INTO public.dimpatient VALUES (2619, 'GOM4176', 28, 'Male', 8, 33123.00);
INSERT INTO public.dimpatient VALUES (2620, 'YJN3447', 19, 'Female', 3, 209450.00);
INSERT INTO public.dimpatient VALUES (2621, 'BOK4939', 63, 'Female', 2, 52552.00);
INSERT INTO public.dimpatient VALUES (2622, 'RVN4963', 45, 'Male', 9, 216565.00);
INSERT INTO public.dimpatient VALUES (2623, 'XUO9577', 69, 'Female', 9, 197644.00);
INSERT INTO public.dimpatient VALUES (2624, 'MLA0112', 46, 'Male', 3, 183757.00);
INSERT INTO public.dimpatient VALUES (2625, 'WYV0966', 90, 'Male', 7, 190450.00);
INSERT INTO public.dimpatient VALUES (2626, 'NVB1072', 23, 'Female', 6, 111047.00);
INSERT INTO public.dimpatient VALUES (2627, 'FON8872', 32, 'Male', 7, 278335.00);
INSERT INTO public.dimpatient VALUES (2628, 'HYS8827', 38, 'Female', 4, 124280.00);
INSERT INTO public.dimpatient VALUES (2629, 'OKR6669', 24, 'Male', 6, 172355.00);
INSERT INTO public.dimpatient VALUES (2630, 'ICO8112', 80, 'Male', 9, 194486.00);
INSERT INTO public.dimpatient VALUES (2631, 'KMA0239', 63, 'Female', 2, 51834.00);
INSERT INTO public.dimpatient VALUES (2632, 'MSW4208', 90, 'Male', 2, 110213.00);
INSERT INTO public.dimpatient VALUES (2633, 'UCU0940', 26, 'Female', 1, 110616.00);
INSERT INTO public.dimpatient VALUES (2634, 'JDS3385', 30, 'Male', 6, 169864.00);
INSERT INTO public.dimpatient VALUES (2635, 'FXK2707', 64, 'Female', 7, 52233.00);
INSERT INTO public.dimpatient VALUES (2636, 'SLE3369', 27, 'Female', 6, 71276.00);
INSERT INTO public.dimpatient VALUES (2637, 'DDG3686', 42, 'Male', 5, 94144.00);
INSERT INTO public.dimpatient VALUES (2638, 'ZZQ4895', 49, 'Male', 8, 45680.00);
INSERT INTO public.dimpatient VALUES (2639, 'HGA9732', 70, 'Female', 9, 202088.00);
INSERT INTO public.dimpatient VALUES (2640, 'XZD4751', 60, 'Male', 9, 199652.00);
INSERT INTO public.dimpatient VALUES (2641, 'BNA7793', 74, 'Female', 6, 185546.00);
INSERT INTO public.dimpatient VALUES (2642, 'JKY9288', 90, 'Female', 4, 243025.00);
INSERT INTO public.dimpatient VALUES (2643, 'PSU2093', 88, 'Female', 6, 105028.00);
INSERT INTO public.dimpatient VALUES (2644, 'UIP9627', 23, 'Male', 10, 236752.00);
INSERT INTO public.dimpatient VALUES (2645, 'XYT8290', 67, 'Female', 7, 241188.00);
INSERT INTO public.dimpatient VALUES (2646, 'YJO3659', 29, 'Male', 7, 96158.00);
INSERT INTO public.dimpatient VALUES (2647, 'AFU8750', 49, 'Female', 7, 168024.00);
INSERT INTO public.dimpatient VALUES (2648, 'SIQ8677', 39, 'Male', 1, 171416.00);
INSERT INTO public.dimpatient VALUES (2649, 'UIB5375', 67, 'Male', 3, 37631.00);
INSERT INTO public.dimpatient VALUES (2650, 'EDI3563', 84, 'Male', 7, 281871.00);
INSERT INTO public.dimpatient VALUES (2651, 'QWD3129', 51, 'Male', 3, 257061.00);
INSERT INTO public.dimpatient VALUES (2652, 'AIY9747', 65, 'Female', 4, 43556.00);
INSERT INTO public.dimpatient VALUES (2653, 'HLK1794', 24, 'Female', 9, 50437.00);
INSERT INTO public.dimpatient VALUES (2654, 'LBY7992', 50, 'Male', 2, 278301.00);
INSERT INTO public.dimpatient VALUES (2655, 'THX6401', 61, 'Male', 7, 147936.00);
INSERT INTO public.dimpatient VALUES (2656, 'XJQ7283', 77, 'Female', 7, 296118.00);
INSERT INTO public.dimpatient VALUES (2657, 'OYV6908', 76, 'Male', 8, 275954.00);
INSERT INTO public.dimpatient VALUES (2658, 'FXR8774', 75, 'Male', 6, 294591.00);
INSERT INTO public.dimpatient VALUES (2659, 'ZTA1405', 85, 'Female', 10, 25496.00);
INSERT INTO public.dimpatient VALUES (2660, 'DWI7052', 34, 'Male', 4, 202637.00);
INSERT INTO public.dimpatient VALUES (2661, 'YZE4908', 64, 'Male', 6, 279143.00);
INSERT INTO public.dimpatient VALUES (2662, 'JFL6450', 21, 'Male', 9, 273127.00);
INSERT INTO public.dimpatient VALUES (2663, 'UYU5044', 30, 'Female', 8, 139504.00);
INSERT INTO public.dimpatient VALUES (2664, 'LMZ2207', 60, 'Male', 6, 98373.00);
INSERT INTO public.dimpatient VALUES (2665, 'BRG9907', 40, 'Male', 7, 270213.00);
INSERT INTO public.dimpatient VALUES (2666, 'BTO2579', 62, 'Male', 1, 167376.00);
INSERT INTO public.dimpatient VALUES (2667, 'IIR4559', 53, 'Female', 6, 104654.00);
INSERT INTO public.dimpatient VALUES (2668, 'NBU0726', 25, 'Male', 7, 259397.00);
INSERT INTO public.dimpatient VALUES (2669, 'GMP5640', 59, 'Male', 8, 220645.00);
INSERT INTO public.dimpatient VALUES (2670, 'VEL6785', 54, 'Female', 3, 205263.00);
INSERT INTO public.dimpatient VALUES (2671, 'GBX5187', 75, 'Female', 3, 43227.00);
INSERT INTO public.dimpatient VALUES (2672, 'JJP8674', 70, 'Male', 4, 233933.00);
INSERT INTO public.dimpatient VALUES (2673, 'AGS2988', 21, 'Male', 4, 91485.00);
INSERT INTO public.dimpatient VALUES (2674, 'LTG3105', 85, 'Female', 8, 266549.00);
INSERT INTO public.dimpatient VALUES (2675, 'TFH5628', 55, 'Male', 3, 75517.00);
INSERT INTO public.dimpatient VALUES (2676, 'DKF7925', 61, 'Male', 5, 105580.00);
INSERT INTO public.dimpatient VALUES (2677, 'YBI6619', 42, 'Female', 3, 171299.00);
INSERT INTO public.dimpatient VALUES (2678, 'OUM0988', 22, 'Male', 8, 29666.00);
INSERT INTO public.dimpatient VALUES (2679, 'GVI1884', 46, 'Male', 6, 193855.00);
INSERT INTO public.dimpatient VALUES (2680, 'KSR1075', 58, 'Male', 4, 97233.00);
INSERT INTO public.dimpatient VALUES (2681, 'UFC0697', 53, 'Female', 4, 76456.00);
INSERT INTO public.dimpatient VALUES (2682, 'XTF7566', 24, 'Male', 2, 190767.00);
INSERT INTO public.dimpatient VALUES (2683, 'TNT2035', 29, 'Female', 7, 292302.00);
INSERT INTO public.dimpatient VALUES (2684, 'AUW6865', 75, 'Male', 8, 211915.00);
INSERT INTO public.dimpatient VALUES (2685, 'WMO3684', 26, 'Male', 6, 249377.00);
INSERT INTO public.dimpatient VALUES (2686, 'PBX8054', 67, 'Male', 1, 23997.00);
INSERT INTO public.dimpatient VALUES (2687, 'WKX1032', 27, 'Female', 4, 255216.00);
INSERT INTO public.dimpatient VALUES (2688, 'YJM3019', 28, 'Male', 7, 28245.00);
INSERT INTO public.dimpatient VALUES (2689, 'RXN2426', 39, 'Female', 4, 62515.00);
INSERT INTO public.dimpatient VALUES (2690, 'XJI2791', 32, 'Male', 1, 236984.00);
INSERT INTO public.dimpatient VALUES (2691, 'SQE3213', 44, 'Male', 7, 59122.00);
INSERT INTO public.dimpatient VALUES (2692, 'PQR7571', 41, 'Male', 2, 255891.00);
INSERT INTO public.dimpatient VALUES (2693, 'XBZ9674', 36, 'Male', 4, 59049.00);
INSERT INTO public.dimpatient VALUES (2694, 'DZP9719', 37, 'Male', 6, 80970.00);
INSERT INTO public.dimpatient VALUES (2695, 'RPJ7752', 18, 'Male', 6, 56227.00);
INSERT INTO public.dimpatient VALUES (2696, 'SXP6277', 75, 'Male', 6, 171482.00);
INSERT INTO public.dimpatient VALUES (2697, 'ZOO7941', 54, 'Female', 2, 241339.00);
INSERT INTO public.dimpatient VALUES (2698, 'ZMF2605', 18, 'Female', 9, 249273.00);
INSERT INTO public.dimpatient VALUES (2699, 'CPC7799', 30, 'Male', 9, 80512.00);
INSERT INTO public.dimpatient VALUES (2700, 'VTL9882', 73, 'Female', 9, 212803.00);
INSERT INTO public.dimpatient VALUES (2701, 'AND5753', 75, 'Male', 10, 78546.00);
INSERT INTO public.dimpatient VALUES (2702, 'FEQ1964', 76, 'Male', 5, 194461.00);
INSERT INTO public.dimpatient VALUES (2703, 'LLN6231', 82, 'Male', 5, 136235.00);
INSERT INTO public.dimpatient VALUES (2704, 'VTW9069', 88, 'Male', 2, 165300.00);
INSERT INTO public.dimpatient VALUES (2705, 'WPW0617', 56, 'Male', 7, 153711.00);
INSERT INTO public.dimpatient VALUES (2706, 'TJD3106', 81, 'Male', 6, 262885.00);
INSERT INTO public.dimpatient VALUES (2707, 'EIM7657', 33, 'Male', 4, 103758.00);
INSERT INTO public.dimpatient VALUES (2708, 'CQG3050', 21, 'Male', 3, 236723.00);
INSERT INTO public.dimpatient VALUES (2709, 'ZUN7568', 83, 'Female', 6, 196638.00);
INSERT INTO public.dimpatient VALUES (2710, 'OFU9592', 74, 'Male', 1, 35855.00);
INSERT INTO public.dimpatient VALUES (2711, 'GNL2507', 71, 'Female', 5, 259886.00);
INSERT INTO public.dimpatient VALUES (2712, 'CVD9526', 46, 'Male', 4, 246774.00);
INSERT INTO public.dimpatient VALUES (2713, 'RSF4019', 31, 'Female', 1, 78445.00);
INSERT INTO public.dimpatient VALUES (2714, 'WAR7163', 72, 'Male', 9, 249614.00);
INSERT INTO public.dimpatient VALUES (2715, 'OEZ7393', 70, 'Male', 4, 56378.00);
INSERT INTO public.dimpatient VALUES (2716, 'PDA0257', 77, 'Female', 1, 123697.00);
INSERT INTO public.dimpatient VALUES (2717, 'HZU0037', 22, 'Female', 4, 147795.00);
INSERT INTO public.dimpatient VALUES (2718, 'GMI1141', 67, 'Male', 4, 252331.00);
INSERT INTO public.dimpatient VALUES (2719, 'FVR1432', 21, 'Male', 7, 21679.00);
INSERT INTO public.dimpatient VALUES (2720, 'NQJ4259', 79, 'Male', 2, 139789.00);
INSERT INTO public.dimpatient VALUES (2721, 'KTY9107', 71, 'Male', 2, 112462.00);
INSERT INTO public.dimpatient VALUES (2722, 'CYT4743', 59, 'Male', 4, 43410.00);
INSERT INTO public.dimpatient VALUES (2723, 'FXR0426', 32, 'Male', 2, 177090.00);
INSERT INTO public.dimpatient VALUES (2724, 'CXO1479', 21, 'Male', 5, 184318.00);
INSERT INTO public.dimpatient VALUES (2725, 'ZML0212', 61, 'Female', 4, 107666.00);
INSERT INTO public.dimpatient VALUES (2726, 'MRG3205', 23, 'Male', 4, 116037.00);
INSERT INTO public.dimpatient VALUES (2727, 'EAI3641', 29, 'Female', 5, 179966.00);
INSERT INTO public.dimpatient VALUES (2728, 'BNQ1608', 80, 'Male', 6, 103777.00);
INSERT INTO public.dimpatient VALUES (2729, 'KLT7600', 53, 'Male', 2, 101399.00);
INSERT INTO public.dimpatient VALUES (2730, 'RMZ5516', 58, 'Female', 5, 230081.00);
INSERT INTO public.dimpatient VALUES (2731, 'NSF4755', 28, 'Female', 5, 250406.00);
INSERT INTO public.dimpatient VALUES (2732, 'UTO3905', 59, 'Male', 2, 63242.00);
INSERT INTO public.dimpatient VALUES (2733, 'VCY3069', 80, 'Female', 10, 277985.00);
INSERT INTO public.dimpatient VALUES (2734, 'MGP8803', 88, 'Female', 1, 281058.00);
INSERT INTO public.dimpatient VALUES (2735, 'FYQ1629', 54, 'Female', 7, 51539.00);
INSERT INTO public.dimpatient VALUES (2736, 'PVI2611', 21, 'Male', 6, 21002.00);
INSERT INTO public.dimpatient VALUES (2737, 'PLH7490', 63, 'Male', 9, 51289.00);
INSERT INTO public.dimpatient VALUES (2738, 'PLR8209', 56, 'Male', 3, 67386.00);
INSERT INTO public.dimpatient VALUES (2739, 'IAC2550', 25, 'Male', 8, 43792.00);
INSERT INTO public.dimpatient VALUES (2740, 'AWU6228', 69, 'Female', 4, 66662.00);
INSERT INTO public.dimpatient VALUES (2741, 'VKY0282', 72, 'Male', 7, 240018.00);
INSERT INTO public.dimpatient VALUES (2742, 'DUX2118', 86, 'Female', 3, 202033.00);
INSERT INTO public.dimpatient VALUES (2743, 'JOQ3887', 26, 'Female', 10, 260829.00);
INSERT INTO public.dimpatient VALUES (2744, 'EIH9699', 41, 'Male', 10, 196083.00);
INSERT INTO public.dimpatient VALUES (2745, 'SDW5368', 73, 'Female', 6, 90408.00);
INSERT INTO public.dimpatient VALUES (2746, 'BZA4960', 19, 'Male', 7, 211414.00);
INSERT INTO public.dimpatient VALUES (2747, 'CZE1114', 21, 'Male', 1, 285768.00);
INSERT INTO public.dimpatient VALUES (2748, 'CJV4418', 42, 'Male', 2, 51439.00);
INSERT INTO public.dimpatient VALUES (2749, 'AAX1328', 28, 'Male', 3, 115859.00);
INSERT INTO public.dimpatient VALUES (2750, 'LHF7235', 61, 'Male', 9, 137974.00);
INSERT INTO public.dimpatient VALUES (2751, 'BGQ6260', 23, 'Female', 7, 150608.00);
INSERT INTO public.dimpatient VALUES (2752, 'ZFY8621', 89, 'Male', 7, 269876.00);
INSERT INTO public.dimpatient VALUES (2753, 'IWI0601', 43, 'Male', 8, 291544.00);
INSERT INTO public.dimpatient VALUES (2754, 'GAG2896', 26, 'Female', 7, 43076.00);
INSERT INTO public.dimpatient VALUES (2755, 'IPH2474', 53, 'Male', 7, 27409.00);
INSERT INTO public.dimpatient VALUES (2756, 'TLA1423', 65, 'Female', 4, 25919.00);
INSERT INTO public.dimpatient VALUES (2757, 'OUS8176', 86, 'Female', 8, 45443.00);
INSERT INTO public.dimpatient VALUES (2758, 'DTV5850', 84, 'Female', 7, 281179.00);
INSERT INTO public.dimpatient VALUES (2759, 'XHX1600', 69, 'Female', 3, 153107.00);
INSERT INTO public.dimpatient VALUES (2760, 'VAY6611', 27, 'Female', 6, 207906.00);
INSERT INTO public.dimpatient VALUES (2761, 'LDS5768', 86, 'Male', 10, 274242.00);
INSERT INTO public.dimpatient VALUES (2762, 'AOF0204', 71, 'Female', 3, 174378.00);
INSERT INTO public.dimpatient VALUES (2763, 'TWJ6230', 76, 'Male', 1, 37467.00);
INSERT INTO public.dimpatient VALUES (2764, 'TRV5341', 47, 'Male', 1, 221301.00);
INSERT INTO public.dimpatient VALUES (2765, 'BNF7145', 74, 'Male', 1, 258104.00);
INSERT INTO public.dimpatient VALUES (2766, 'FTJ5456', 43, 'Female', 4, 209703.00);
INSERT INTO public.dimpatient VALUES (2767, 'GAN8948', 66, 'Male', 4, 292920.00);
INSERT INTO public.dimpatient VALUES (2768, 'KQK7643', 34, 'Male', 8, 38814.00);
INSERT INTO public.dimpatient VALUES (2769, 'QDJ7359', 76, 'Male', 5, 91055.00);
INSERT INTO public.dimpatient VALUES (2770, 'EML8897', 31, 'Male', 1, 102674.00);
INSERT INTO public.dimpatient VALUES (2771, 'ITN4331', 72, 'Female', 4, 44491.00);
INSERT INTO public.dimpatient VALUES (2772, 'ZBC0359', 76, 'Male', 7, 286446.00);
INSERT INTO public.dimpatient VALUES (2773, 'ZXA5748', 76, 'Male', 8, 279967.00);
INSERT INTO public.dimpatient VALUES (2774, 'ADG8069', 39, 'Male', 9, 105818.00);
INSERT INTO public.dimpatient VALUES (2775, 'WLY3711', 76, 'Male', 2, 188946.00);
INSERT INTO public.dimpatient VALUES (2776, 'JTS2700', 78, 'Male', 6, 280881.00);
INSERT INTO public.dimpatient VALUES (2777, 'VEC6403', 56, 'Female', 6, 280909.00);
INSERT INTO public.dimpatient VALUES (2778, 'YWD5623', 40, 'Female', 6, 137537.00);
INSERT INTO public.dimpatient VALUES (2779, 'WMN2843', 30, 'Male', 6, 149387.00);
INSERT INTO public.dimpatient VALUES (2780, 'PXI9906', 24, 'Male', 10, 122258.00);
INSERT INTO public.dimpatient VALUES (2781, 'KEM8350', 85, 'Female', 9, 201076.00);
INSERT INTO public.dimpatient VALUES (2782, 'UTK7966', 85, 'Male', 10, 21717.00);
INSERT INTO public.dimpatient VALUES (2783, 'YGC6271', 85, 'Male', 5, 223172.00);
INSERT INTO public.dimpatient VALUES (2784, 'YNQ3329', 83, 'Male', 3, 250467.00);
INSERT INTO public.dimpatient VALUES (2785, 'ZAR0685', 89, 'Male', 4, 79041.00);
INSERT INTO public.dimpatient VALUES (2786, 'QJA1796', 35, 'Male', 6, 214110.00);
INSERT INTO public.dimpatient VALUES (2787, 'PLA0781', 20, 'Male', 9, 185582.00);
INSERT INTO public.dimpatient VALUES (2788, 'IRJ5181', 81, 'Female', 7, 49335.00);
INSERT INTO public.dimpatient VALUES (2789, 'KJS3508', 79, 'Male', 7, 109045.00);
INSERT INTO public.dimpatient VALUES (2790, 'KFX0233', 43, 'Female', 10, 108436.00);
INSERT INTO public.dimpatient VALUES (2791, 'BBF7318', 75, 'Male', 3, 182515.00);
INSERT INTO public.dimpatient VALUES (2792, 'IAB5092', 22, 'Male', 8, 153954.00);
INSERT INTO public.dimpatient VALUES (2793, 'WAY4212', 42, 'Female', 8, 279489.00);
INSERT INTO public.dimpatient VALUES (2794, 'VUW1193', 18, 'Male', 1, 186141.00);
INSERT INTO public.dimpatient VALUES (2795, 'NWZ9873', 69, 'Male', 7, 231394.00);
INSERT INTO public.dimpatient VALUES (2796, 'IHY0559', 69, 'Male', 6, 202813.00);
INSERT INTO public.dimpatient VALUES (2797, 'WPO9038', 65, 'Male', 7, 226407.00);
INSERT INTO public.dimpatient VALUES (2798, 'YBH3172', 70, 'Male', 3, 291894.00);
INSERT INTO public.dimpatient VALUES (2799, 'VGQ3461', 31, 'Female', 1, 60746.00);
INSERT INTO public.dimpatient VALUES (2800, 'AIW4911', 87, 'Male', 7, 50675.00);
INSERT INTO public.dimpatient VALUES (2801, 'WKQ4013', 34, 'Female', 4, 80379.00);
INSERT INTO public.dimpatient VALUES (2802, 'IUJ5442', 27, 'Female', 2, 264135.00);
INSERT INTO public.dimpatient VALUES (2803, 'YSP0073', 71, 'Male', 4, 163066.00);
INSERT INTO public.dimpatient VALUES (2804, 'FFF6730', 79, 'Female', 1, 98663.00);
INSERT INTO public.dimpatient VALUES (2805, 'IKY4481', 67, 'Male', 1, 286299.00);
INSERT INTO public.dimpatient VALUES (2806, 'WXM0274', 81, 'Male', 6, 81743.00);
INSERT INTO public.dimpatient VALUES (2807, 'SCF7137', 26, 'Male', 6, 194384.00);
INSERT INTO public.dimpatient VALUES (2808, 'MSP7682', 68, 'Female', 8, 290957.00);
INSERT INTO public.dimpatient VALUES (2809, 'DXT5853', 37, 'Male', 3, 188465.00);
INSERT INTO public.dimpatient VALUES (2810, 'KKR6535', 52, 'Male', 5, 266611.00);
INSERT INTO public.dimpatient VALUES (2811, 'RRG8947', 85, 'Male', 1, 204162.00);
INSERT INTO public.dimpatient VALUES (2812, 'GBU1842', 88, 'Male', 8, 95608.00);
INSERT INTO public.dimpatient VALUES (2813, 'OHD3889', 24, 'Male', 10, 226086.00);
INSERT INTO public.dimpatient VALUES (2814, 'OMY0486', 36, 'Male', 1, 54373.00);
INSERT INTO public.dimpatient VALUES (2815, 'JHC9731', 59, 'Male', 7, 212902.00);
INSERT INTO public.dimpatient VALUES (2816, 'CJA3176', 87, 'Male', 8, 201510.00);
INSERT INTO public.dimpatient VALUES (2817, 'KAE4264', 77, 'Male', 10, 290828.00);
INSERT INTO public.dimpatient VALUES (2818, 'HHA8617', 27, 'Male', 2, 271798.00);
INSERT INTO public.dimpatient VALUES (2819, 'YYU9565', 60, 'Male', 1, 292173.00);
INSERT INTO public.dimpatient VALUES (2820, 'CEY4537', 44, 'Female', 4, 157088.00);
INSERT INTO public.dimpatient VALUES (2821, 'JDK0538', 68, 'Male', 1, 113458.00);
INSERT INTO public.dimpatient VALUES (2822, 'UIW1798', 80, 'Male', 10, 160046.00);
INSERT INTO public.dimpatient VALUES (2823, 'UBJ2564', 70, 'Female', 6, 191558.00);
INSERT INTO public.dimpatient VALUES (2824, 'RCM4245', 50, 'Male', 8, 151785.00);
INSERT INTO public.dimpatient VALUES (2825, 'QZH6722', 60, 'Male', 8, 88117.00);
INSERT INTO public.dimpatient VALUES (2826, 'NXO4034', 25, 'Male', 1, 59634.00);
INSERT INTO public.dimpatient VALUES (2827, 'XPP2301', 21, 'Female', 9, 176010.00);
INSERT INTO public.dimpatient VALUES (2828, 'BMW7812', 67, 'Male', 9, 261404.00);
INSERT INTO public.dimpatient VALUES (2829, 'TEE0405', 78, 'Male', 6, 171126.00);
INSERT INTO public.dimpatient VALUES (2830, 'WQL5946', 48, 'Female', 9, 161237.00);
INSERT INTO public.dimpatient VALUES (2831, 'NEY6909', 43, 'Male', 5, 190006.00);
INSERT INTO public.dimpatient VALUES (2832, 'TFV1722', 52, 'Female', 1, 285490.00);
INSERT INTO public.dimpatient VALUES (2833, 'YMO9545', 46, 'Male', 9, 59552.00);
INSERT INTO public.dimpatient VALUES (2834, 'DCY3282', 73, 'Male', 5, 265839.00);
INSERT INTO public.dimpatient VALUES (2835, 'BBJ3290', 42, 'Male', 8, 133766.00);
INSERT INTO public.dimpatient VALUES (2836, 'LUQ7573', 82, 'Female', 2, 136486.00);
INSERT INTO public.dimpatient VALUES (2837, 'ACQ6112', 79, 'Male', 6, 162055.00);
INSERT INTO public.dimpatient VALUES (2838, 'YLM6170', 57, 'Male', 3, 190120.00);
INSERT INTO public.dimpatient VALUES (2839, 'CSV3638', 18, 'Female', 9, 82682.00);
INSERT INTO public.dimpatient VALUES (2840, 'XCL5519', 80, 'Male', 1, 210852.00);
INSERT INTO public.dimpatient VALUES (2841, 'QWU3141', 50, 'Male', 9, 199774.00);
INSERT INTO public.dimpatient VALUES (2842, 'ZOF8895', 82, 'Male', 4, 233769.00);
INSERT INTO public.dimpatient VALUES (2843, 'SCZ5893', 67, 'Male', 1, 37324.00);
INSERT INTO public.dimpatient VALUES (2844, 'UCE0281', 76, 'Male', 8, 75901.00);
INSERT INTO public.dimpatient VALUES (2845, 'NCR3052', 25, 'Female', 7, 53756.00);
INSERT INTO public.dimpatient VALUES (2846, 'ZVX8100', 62, 'Male', 8, 191267.00);
INSERT INTO public.dimpatient VALUES (2847, 'ROF8089', 67, 'Female', 4, 143070.00);
INSERT INTO public.dimpatient VALUES (2848, 'GBB8361', 52, 'Male', 10, 129295.00);
INSERT INTO public.dimpatient VALUES (2849, 'YLI3019', 51, 'Male', 2, 20375.00);
INSERT INTO public.dimpatient VALUES (2850, 'AZR0892', 82, 'Male', 4, 230457.00);
INSERT INTO public.dimpatient VALUES (2851, 'CJP0345', 39, 'Male', 8, 117045.00);
INSERT INTO public.dimpatient VALUES (2852, 'PHK4364', 34, 'Female', 10, 38329.00);
INSERT INTO public.dimpatient VALUES (2853, 'VHY7394', 25, 'Male', 1, 95625.00);
INSERT INTO public.dimpatient VALUES (2854, 'FPC1521', 72, 'Female', 2, 81973.00);
INSERT INTO public.dimpatient VALUES (2855, 'NRR1900', 49, 'Male', 5, 246202.00);
INSERT INTO public.dimpatient VALUES (2856, 'XBY2113', 28, 'Male', 3, 226181.00);
INSERT INTO public.dimpatient VALUES (2857, 'XBP3543', 50, 'Male', 5, 119607.00);
INSERT INTO public.dimpatient VALUES (2858, 'CSF6016', 18, 'Male', 2, 278606.00);
INSERT INTO public.dimpatient VALUES (2859, 'BEG2015', 41, 'Female', 5, 106922.00);
INSERT INTO public.dimpatient VALUES (2860, 'BAL8838', 59, 'Male', 4, 21365.00);
INSERT INTO public.dimpatient VALUES (2861, 'PUN6734', 37, 'Male', 1, 206564.00);
INSERT INTO public.dimpatient VALUES (2862, 'YCH0527', 43, 'Male', 2, 198613.00);
INSERT INTO public.dimpatient VALUES (2863, 'MSW1926', 18, 'Male', 6, 298786.00);
INSERT INTO public.dimpatient VALUES (2864, 'VQD2926', 51, 'Male', 4, 215460.00);
INSERT INTO public.dimpatient VALUES (2865, 'VDU1518', 47, 'Male', 8, 112844.00);
INSERT INTO public.dimpatient VALUES (2866, 'NZU5544', 44, 'Male', 10, 120152.00);
INSERT INTO public.dimpatient VALUES (2867, 'KMG9748', 26, 'Male', 3, 127291.00);
INSERT INTO public.dimpatient VALUES (2868, 'COP0566', 38, 'Male', 9, 48376.00);
INSERT INTO public.dimpatient VALUES (2869, 'KZY7247', 75, 'Female', 2, 202561.00);
INSERT INTO public.dimpatient VALUES (2870, 'XRL5497', 86, 'Male', 3, 163789.00);
INSERT INTO public.dimpatient VALUES (2871, 'DTO8732', 22, 'Male', 6, 200491.00);
INSERT INTO public.dimpatient VALUES (2872, 'NWW5751', 86, 'Male', 7, 245266.00);
INSERT INTO public.dimpatient VALUES (2873, 'VNW7565', 84, 'Male', 7, 50176.00);
INSERT INTO public.dimpatient VALUES (2874, 'GAZ0067', 20, 'Male', 3, 175627.00);
INSERT INTO public.dimpatient VALUES (2875, 'GDY0435', 90, 'Male', 5, 290188.00);
INSERT INTO public.dimpatient VALUES (2876, 'OEI6632', 24, 'Female', 10, 137445.00);
INSERT INTO public.dimpatient VALUES (2877, 'VCC8420', 76, 'Male', 9, 239402.00);
INSERT INTO public.dimpatient VALUES (2878, 'HSD6283', 73, 'Female', 8, 50030.00);
INSERT INTO public.dimpatient VALUES (2879, 'FPA6845', 87, 'Male', 3, 30371.00);
INSERT INTO public.dimpatient VALUES (2880, 'XZE0584', 69, 'Male', 2, 51970.00);
INSERT INTO public.dimpatient VALUES (2881, 'VYB5146', 23, 'Female', 8, 99373.00);
INSERT INTO public.dimpatient VALUES (2882, 'SHL1488', 54, 'Male', 3, 76597.00);
INSERT INTO public.dimpatient VALUES (2883, 'ITY8640', 25, 'Female', 10, 136230.00);
INSERT INTO public.dimpatient VALUES (2884, 'GFO8847', 66, 'Male', 6, 160555.00);
INSERT INTO public.dimpatient VALUES (2885, 'PMI1491', 74, 'Female', 4, 26246.00);
INSERT INTO public.dimpatient VALUES (2886, 'VHJ9494', 45, 'Female', 8, 176112.00);
INSERT INTO public.dimpatient VALUES (2887, 'IZV0688', 64, 'Male', 5, 207208.00);
INSERT INTO public.dimpatient VALUES (2888, 'RWL3584', 30, 'Female', 6, 290740.00);
INSERT INTO public.dimpatient VALUES (2889, 'FKE2991', 56, 'Male', 1, 115503.00);
INSERT INTO public.dimpatient VALUES (2890, 'UOI8257', 61, 'Male', 5, 53735.00);
INSERT INTO public.dimpatient VALUES (2891, 'NXO7861', 67, 'Male', 9, 175221.00);
INSERT INTO public.dimpatient VALUES (2892, 'FNE9444', 27, 'Female', 8, 26073.00);
INSERT INTO public.dimpatient VALUES (2893, 'RQX1211', 60, 'Male', 8, 234966.00);
INSERT INTO public.dimpatient VALUES (2894, 'GNK9443', 29, 'Male', 3, 123956.00);
INSERT INTO public.dimpatient VALUES (2895, 'GMZ7138', 33, 'Female', 9, 149575.00);
INSERT INTO public.dimpatient VALUES (2896, 'PUS3059', 62, 'Female', 7, 230906.00);
INSERT INTO public.dimpatient VALUES (2897, 'EML6491', 65, 'Male', 1, 62935.00);
INSERT INTO public.dimpatient VALUES (2898, 'WYS5546', 45, 'Male', 5, 220491.00);
INSERT INTO public.dimpatient VALUES (2899, 'EAB3469', 86, 'Male', 5, 149205.00);
INSERT INTO public.dimpatient VALUES (2900, 'DNC4502', 19, 'Male', 5, 173234.00);
INSERT INTO public.dimpatient VALUES (2901, 'UHW7173', 74, 'Female', 9, 150064.00);
INSERT INTO public.dimpatient VALUES (2902, 'JJX0859', 70, 'Male', 10, 225432.00);
INSERT INTO public.dimpatient VALUES (2903, 'GPC7174', 49, 'Male', 2, 140406.00);
INSERT INTO public.dimpatient VALUES (2904, 'FYX5444', 62, 'Male', 6, 167906.00);
INSERT INTO public.dimpatient VALUES (2905, 'KQB2627', 27, 'Male', 10, 175078.00);
INSERT INTO public.dimpatient VALUES (2906, 'KTW5072', 86, 'Male', 5, 168404.00);
INSERT INTO public.dimpatient VALUES (2907, 'AVV5863', 83, 'Female', 2, 296988.00);
INSERT INTO public.dimpatient VALUES (2908, 'EFR0340', 77, 'Male', 8, 72920.00);
INSERT INTO public.dimpatient VALUES (2909, 'VWX9664', 33, 'Male', 6, 97058.00);
INSERT INTO public.dimpatient VALUES (2910, 'FKI0908', 77, 'Female', 1, 121329.00);
INSERT INTO public.dimpatient VALUES (2911, 'QSQ1337', 75, 'Male', 9, 299050.00);
INSERT INTO public.dimpatient VALUES (2912, 'LKE3475', 20, 'Male', 8, 269569.00);
INSERT INTO public.dimpatient VALUES (2913, 'EGC7479', 34, 'Male', 8, 257229.00);
INSERT INTO public.dimpatient VALUES (2914, 'ULO8651', 72, 'Female', 3, 264511.00);
INSERT INTO public.dimpatient VALUES (2915, 'GFT1011', 66, 'Male', 7, 139451.00);
INSERT INTO public.dimpatient VALUES (2916, 'YLL9363', 19, 'Male', 5, 295211.00);
INSERT INTO public.dimpatient VALUES (2917, 'SXI5502', 25, 'Male', 4, 168088.00);
INSERT INTO public.dimpatient VALUES (2918, 'MGU4677', 60, 'Female', 7, 131723.00);
INSERT INTO public.dimpatient VALUES (2919, 'MGR9885', 42, 'Female', 1, 209247.00);
INSERT INTO public.dimpatient VALUES (2920, 'BCC7629', 36, 'Female', 1, 138838.00);
INSERT INTO public.dimpatient VALUES (2921, 'ISA3150', 50, 'Male', 8, 277215.00);
INSERT INTO public.dimpatient VALUES (2922, 'OMR5899', 88, 'Male', 1, 179312.00);
INSERT INTO public.dimpatient VALUES (2923, 'ELD0719', 60, 'Male', 7, 186453.00);
INSERT INTO public.dimpatient VALUES (2924, 'XOA9385', 83, 'Male', 6, 173171.00);
INSERT INTO public.dimpatient VALUES (2925, 'WSF0425', 73, 'Male', 4, 213403.00);
INSERT INTO public.dimpatient VALUES (2926, 'IUI9926', 38, 'Female', 6, 281484.00);
INSERT INTO public.dimpatient VALUES (2927, 'SLJ3300', 27, 'Male', 10, 96599.00);
INSERT INTO public.dimpatient VALUES (2928, 'CFZ8373', 71, 'Male', 9, 175465.00);
INSERT INTO public.dimpatient VALUES (2929, 'VLD1162', 75, 'Male', 6, 50029.00);
INSERT INTO public.dimpatient VALUES (2930, 'PZM6937', 18, 'Male', 10, 138696.00);
INSERT INTO public.dimpatient VALUES (2931, 'HPS8287', 42, 'Male', 9, 62873.00);
INSERT INTO public.dimpatient VALUES (2932, 'DVE3895', 33, 'Female', 8, 166848.00);
INSERT INTO public.dimpatient VALUES (2933, 'OIV0569', 29, 'Male', 9, 109419.00);
INSERT INTO public.dimpatient VALUES (2934, 'NBT8626', 45, 'Male', 4, 132314.00);
INSERT INTO public.dimpatient VALUES (2935, 'IFZ1439', 63, 'Female', 9, 248256.00);
INSERT INTO public.dimpatient VALUES (2936, 'EJU5290', 43, 'Male', 10, 122282.00);
INSERT INTO public.dimpatient VALUES (2937, 'ONL5969', 31, 'Female', 2, 223499.00);
INSERT INTO public.dimpatient VALUES (2938, 'GDC1817', 90, 'Male', 7, 294623.00);
INSERT INTO public.dimpatient VALUES (2939, 'RKV2333', 77, 'Female', 2, 290100.00);
INSERT INTO public.dimpatient VALUES (2940, 'OQD2740', 41, 'Male', 7, 273899.00);
INSERT INTO public.dimpatient VALUES (2941, 'EPM2146', 23, 'Male', 3, 276765.00);
INSERT INTO public.dimpatient VALUES (2942, 'FUD7151', 44, 'Female', 1, 297991.00);
INSERT INTO public.dimpatient VALUES (2943, 'AHF8900', 79, 'Male', 2, 132271.00);
INSERT INTO public.dimpatient VALUES (2944, 'PQL7102', 39, 'Male', 1, 298655.00);
INSERT INTO public.dimpatient VALUES (2945, 'VCB3963', 90, 'Male', 3, 137071.00);
INSERT INTO public.dimpatient VALUES (2946, 'XGG5032', 35, 'Female', 7, 256308.00);
INSERT INTO public.dimpatient VALUES (2947, 'BXW5852', 22, 'Male', 9, 167478.00);
INSERT INTO public.dimpatient VALUES (2948, 'TOE8211', 52, 'Male', 2, 238370.00);
INSERT INTO public.dimpatient VALUES (2949, 'HTW2151', 26, 'Male', 2, 30974.00);
INSERT INTO public.dimpatient VALUES (2950, 'SOH9843', 22, 'Male', 9, 259754.00);
INSERT INTO public.dimpatient VALUES (2951, 'XGF9824', 60, 'Female', 3, 109194.00);
INSERT INTO public.dimpatient VALUES (2952, 'HKW6197', 45, 'Female', 2, 150259.00);
INSERT INTO public.dimpatient VALUES (2953, 'TRR4979', 36, 'Male', 1, 77762.00);
INSERT INTO public.dimpatient VALUES (2954, 'NCU1956', 36, 'Male', 10, 223132.00);
INSERT INTO public.dimpatient VALUES (2955, 'Jan-49', 60, 'Male', 4, 140911.00);
INSERT INTO public.dimpatient VALUES (2956, 'ZLM2405', 90, 'Female', 4, 274393.00);
INSERT INTO public.dimpatient VALUES (2957, 'EUK0592', 89, 'Female', 8, 65113.00);
INSERT INTO public.dimpatient VALUES (2958, 'RFT4958', 50, 'Female', 5, 112620.00);
INSERT INTO public.dimpatient VALUES (2959, 'QYD6811', 18, 'Male', 5, 261988.00);
INSERT INTO public.dimpatient VALUES (2960, 'IGP0445', 63, 'Female', 3, 293766.00);
INSERT INTO public.dimpatient VALUES (2961, 'CQM6221', 69, 'Male', 8, 57106.00);
INSERT INTO public.dimpatient VALUES (2962, 'JFH5824', 42, 'Female', 2, 278527.00);
INSERT INTO public.dimpatient VALUES (2963, 'TYI7747', 35, 'Male', 9, 105068.00);
INSERT INTO public.dimpatient VALUES (2964, 'BFE4900', 56, 'Male', 7, 295082.00);
INSERT INTO public.dimpatient VALUES (2965, 'IDQ6872', 82, 'Female', 8, 137246.00);
INSERT INTO public.dimpatient VALUES (2966, 'JOE7050', 86, 'Male', 6, 201645.00);
INSERT INTO public.dimpatient VALUES (2967, 'JLN3497', 84, 'Male', 9, 125640.00);
INSERT INTO public.dimpatient VALUES (2968, 'ENK3334', 27, 'Male', 2, 53345.00);
INSERT INTO public.dimpatient VALUES (2969, 'PVC5447', 49, 'Male', 5, 124315.00);
INSERT INTO public.dimpatient VALUES (2970, 'LMH8932', 23, 'Female', 9, 197970.00);
INSERT INTO public.dimpatient VALUES (2971, 'LJI9585', 70, 'Male', 1, 225119.00);
INSERT INTO public.dimpatient VALUES (2972, 'NNR3835', 86, 'Female', 9, 267462.00);
INSERT INTO public.dimpatient VALUES (2973, 'LDJ4682', 30, 'Female', 3, 173953.00);
INSERT INTO public.dimpatient VALUES (2974, 'TQT8266', 53, 'Male', 8, 182477.00);
INSERT INTO public.dimpatient VALUES (2975, 'NXR3682', 60, 'Male', 7, 268377.00);
INSERT INTO public.dimpatient VALUES (2976, 'OGV4421', 40, 'Male', 5, 129026.00);
INSERT INTO public.dimpatient VALUES (2977, 'TTM1692', 47, 'Male', 6, 278913.00);
INSERT INTO public.dimpatient VALUES (2978, 'SHO0718', 27, 'Male', 10, 91890.00);
INSERT INTO public.dimpatient VALUES (2979, 'MMW1532', 80, 'Male', 1, 235115.00);
INSERT INTO public.dimpatient VALUES (2980, 'AOC1459', 47, 'Male', 8, 153639.00);
INSERT INTO public.dimpatient VALUES (2981, 'SDD6614', 21, 'Male', 10, 26329.00);
INSERT INTO public.dimpatient VALUES (2982, 'WMA0365', 30, 'Male', 10, 28797.00);
INSERT INTO public.dimpatient VALUES (2983, 'ATI9164', 28, 'Male', 7, 171302.00);
INSERT INTO public.dimpatient VALUES (2984, 'DWZ6826', 56, 'Male', 1, 46221.00);
INSERT INTO public.dimpatient VALUES (2985, 'IYH1719', 67, 'Male', 7, 134915.00);
INSERT INTO public.dimpatient VALUES (2986, 'AGH6728', 52, 'Female', 1, 59008.00);
INSERT INTO public.dimpatient VALUES (2987, 'BNI9906', 21, 'Female', 9, 235282.00);
INSERT INTO public.dimpatient VALUES (2988, 'TBH2833', 67, 'Female', 8, 156241.00);
INSERT INTO public.dimpatient VALUES (2989, 'LXD8525', 22, 'Female', 4, 128229.00);
INSERT INTO public.dimpatient VALUES (2990, 'DSD1356', 67, 'Male', 2, 152146.00);
INSERT INTO public.dimpatient VALUES (2991, 'DHP4080', 55, 'Male', 2, 158030.00);
INSERT INTO public.dimpatient VALUES (2992, 'EHN8840', 83, 'Female', 9, 24274.00);
INSERT INTO public.dimpatient VALUES (2993, 'UNR0089', 29, 'Female', 1, 108812.00);
INSERT INTO public.dimpatient VALUES (2994, 'ZLT2622', 81, 'Male', 6, 200231.00);
INSERT INTO public.dimpatient VALUES (2995, 'LGH0316', 18, 'Female', 2, 96215.00);
INSERT INTO public.dimpatient VALUES (2996, 'BSV5917', 29, 'Female', 6, 138186.00);
INSERT INTO public.dimpatient VALUES (2997, 'ING6106', 69, 'Female', 10, 285955.00);
INSERT INTO public.dimpatient VALUES (2998, 'YBZ4650', 32, 'Male', 9, 89938.00);
INSERT INTO public.dimpatient VALUES (2999, 'DKF5216', 33, 'Male', 1, 291028.00);
INSERT INTO public.dimpatient VALUES (3000, 'ERP9347', 80, 'Male', 4, 51385.00);
INSERT INTO public.dimpatient VALUES (3001, 'TTO9115', 48, 'Male', 4, 139560.00);
INSERT INTO public.dimpatient VALUES (3002, 'TFX1105', 83, 'Male', 10, 47175.00);
INSERT INTO public.dimpatient VALUES (3003, 'MYI3162', 45, 'Male', 9, 196560.00);
INSERT INTO public.dimpatient VALUES (3004, 'KBN1743', 50, 'Male', 8, 31206.00);
INSERT INTO public.dimpatient VALUES (3005, 'RGF8556', 32, 'Male', 9, 86689.00);
INSERT INTO public.dimpatient VALUES (3006, 'VHL1612', 62, 'Female', 7, 89349.00);
INSERT INTO public.dimpatient VALUES (3007, 'TRI7066', 88, 'Male', 2, 155187.00);
INSERT INTO public.dimpatient VALUES (3008, 'LTS6151', 82, 'Male', 5, 265224.00);
INSERT INTO public.dimpatient VALUES (3009, 'YRQ9870', 84, 'Female', 6, 253943.00);
INSERT INTO public.dimpatient VALUES (3010, 'EMG4617', 69, 'Male', 9, 161549.00);
INSERT INTO public.dimpatient VALUES (3011, 'SOM8522', 57, 'Female', 4, 250419.00);
INSERT INTO public.dimpatient VALUES (3012, 'XGC0081', 60, 'Female', 1, 214528.00);
INSERT INTO public.dimpatient VALUES (3013, 'ZQC1238', 19, 'Female', 7, 287151.00);
INSERT INTO public.dimpatient VALUES (3014, 'UQC2723', 37, 'Male', 5, 72564.00);
INSERT INTO public.dimpatient VALUES (3015, 'XAQ9706', 34, 'Female', 5, 35141.00);
INSERT INTO public.dimpatient VALUES (3016, 'PID6523', 69, 'Female', 8, 39574.00);
INSERT INTO public.dimpatient VALUES (3017, 'QXI7953', 68, 'Male', 7, 152688.00);
INSERT INTO public.dimpatient VALUES (3018, 'JQO6134', 76, 'Female', 9, 224877.00);
INSERT INTO public.dimpatient VALUES (3019, 'YAV3073', 67, 'Female', 2, 76582.00);
INSERT INTO public.dimpatient VALUES (3020, 'OVC8311', 58, 'Male', 2, 282291.00);
INSERT INTO public.dimpatient VALUES (3021, 'CVA7420', 87, 'Male', 3, 288093.00);
INSERT INTO public.dimpatient VALUES (3022, 'KEC9602', 65, 'Male', 3, 194568.00);
INSERT INTO public.dimpatient VALUES (3023, 'YTL7126', 86, 'Female', 4, 167843.00);
INSERT INTO public.dimpatient VALUES (3024, 'RDI3071', 84, 'Male', 7, 95237.00);
INSERT INTO public.dimpatient VALUES (3025, 'RCE5059', 64, 'Male', 8, 107142.00);
INSERT INTO public.dimpatient VALUES (3026, 'XGD7682', 48, 'Female', 10, 239320.00);
INSERT INTO public.dimpatient VALUES (3027, 'JKE5424', 75, 'Male', 9, 62142.00);
INSERT INTO public.dimpatient VALUES (3028, 'KTF7352', 51, 'Female', 4, 23985.00);
INSERT INTO public.dimpatient VALUES (3029, 'QMA7405', 78, 'Male', 5, 213849.00);
INSERT INTO public.dimpatient VALUES (3030, 'KTR4778', 63, 'Male', 4, 262933.00);
INSERT INTO public.dimpatient VALUES (3031, 'LTC1110', 36, 'Female', 9, 205962.00);
INSERT INTO public.dimpatient VALUES (3032, 'MBI0008', 66, 'Male', 1, 156946.00);
INSERT INTO public.dimpatient VALUES (3033, 'RCB7108', 63, 'Male', 4, 258559.00);
INSERT INTO public.dimpatient VALUES (3034, 'IRX7433', 44, 'Female', 5, 256161.00);
INSERT INTO public.dimpatient VALUES (3035, 'FJG4009', 66, 'Male', 8, 201188.00);
INSERT INTO public.dimpatient VALUES (3036, 'WXS2566', 41, 'Male', 9, 118069.00);
INSERT INTO public.dimpatient VALUES (3037, 'PSY8110', 62, 'Male', 5, 133245.00);
INSERT INTO public.dimpatient VALUES (3038, 'KCE3422', 46, 'Female', 4, 132614.00);
INSERT INTO public.dimpatient VALUES (3039, 'LWB8244', 41, 'Female', 4, 271326.00);
INSERT INTO public.dimpatient VALUES (3040, 'ICO9779', 53, 'Female', 1, 49893.00);
INSERT INTO public.dimpatient VALUES (3041, 'PYL5477', 50, 'Male', 10, 246809.00);
INSERT INTO public.dimpatient VALUES (3042, 'XCQ5937', 20, 'Male', 5, 25086.00);
INSERT INTO public.dimpatient VALUES (3043, 'ENZ9640', 33, 'Male', 7, 239725.00);
INSERT INTO public.dimpatient VALUES (3044, 'MWZ5398', 25, 'Male', 6, 38665.00);
INSERT INTO public.dimpatient VALUES (3045, 'STU6861', 38, 'Female', 1, 144954.00);
INSERT INTO public.dimpatient VALUES (3046, 'GLV2486', 26, 'Male', 9, 77329.00);
INSERT INTO public.dimpatient VALUES (3047, 'WMP6003', 45, 'Male', 3, 266582.00);
INSERT INTO public.dimpatient VALUES (3048, 'ALW1741', 85, 'Female', 4, 151317.00);


--
-- Data for Name: dimriskfactor; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.dimriskfactor VALUES (16, 'Diabetes');
INSERT INTO public.dimriskfactor VALUES (17, 'Smoking');
INSERT INTO public.dimriskfactor VALUES (18, 'Obesity');


--
-- Data for Name: dimtime; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: factheartattackrisk; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.factheartattackrisk VALUES (1, 2828, 115, 17, NULL, 208.00, 158, 88, 72, 31.25, 286.00, false);
INSERT INTO public.factheartattackrisk VALUES (2, 2747, 113, 16, NULL, 389.00, 165, 93, 98, 27.19, 235.00, false);
INSERT INTO public.factheartattackrisk VALUES (3, 2987, 103, 18, NULL, 324.00, 174, 99, 72, 28.18, 587.00, false);
INSERT INTO public.factheartattackrisk VALUES (4, 2967, 113, 17, NULL, 383.00, 163, 100, 73, 36.46, 378.00, false);
INSERT INTO public.factheartattackrisk VALUES (5, 2884, 108, 16, NULL, 318.00, 91, 88, 93, 21.81, 231.00, false);
INSERT INTO public.factheartattackrisk VALUES (6, 2697, 120, 16, NULL, 297.00, 172, 86, 48, 20.15, 795.00, true);
INSERT INTO public.factheartattackrisk VALUES (7, 2625, 113, 18, NULL, 358.00, 102, 73, 84, 28.89, 284.00, true);
INSERT INTO public.factheartattackrisk VALUES (8, 2579, 106, 17, NULL, 220.00, 131, 68, 107, 22.22, 370.00, true);
INSERT INTO public.factheartattackrisk VALUES (9, 3042, 114, 17, NULL, 145.00, 144, 105, 68, 35.81, 790.00, false);
INSERT INTO public.factheartattackrisk VALUES (10, 2766, 106, 16, NULL, 248.00, 160, 70, 55, 22.56, 232.00, false);
INSERT INTO public.factheartattackrisk VALUES (11, 2878, 116, 17, NULL, 373.00, 107, 69, 97, 22.87, 469.00, false);
INSERT INTO public.factheartattackrisk VALUES (12, 2803, 107, 17, NULL, 374.00, 158, 71, 70, 32.49, 523.00, false);
INSERT INTO public.factheartattackrisk VALUES (13, 2596, 104, 16, NULL, 228.00, 101, 72, 68, 35.10, 590.00, true);
INSERT INTO public.factheartattackrisk VALUES (14, 2819, 119, 18, NULL, 259.00, 169, 72, 85, 25.56, 506.00, true);
INSERT INTO public.factheartattackrisk VALUES (15, 2704, 119, 16, NULL, 297.00, 112, 81, 102, 25.49, 635.00, false);
INSERT INTO public.factheartattackrisk VALUES (16, 2834, 118, 17, NULL, 122.00, 114, 88, 97, 36.52, 773.00, true);
INSERT INTO public.factheartattackrisk VALUES (17, 2614, 114, 17, NULL, 379.00, 173, 75, 40, 28.33, 68.00, false);
INSERT INTO public.factheartattackrisk VALUES (18, 2868, 108, 18, NULL, 166.00, 120, 74, 56, 29.52, 402.00, false);
INSERT INTO public.factheartattackrisk VALUES (19, 2600, 107, 17, NULL, 303.00, 120, 100, 104, 25.96, 517.00, true);
INSERT INTO public.factheartattackrisk VALUES (20, 2893, 113, 18, NULL, 145.00, 160, 98, 71, 29.16, 247.00, false);
INSERT INTO public.factheartattackrisk VALUES (21, 3032, 113, 16, NULL, 340.00, 180, 101, 69, 38.09, 747.00, false);
INSERT INTO public.factheartattackrisk VALUES (22, 2622, 103, 18, NULL, 294.00, 130, 84, 66, 25.12, 360.00, true);
INSERT INTO public.factheartattackrisk VALUES (23, 2654, 111, 18, NULL, 359.00, 175, 60, 97, 34.65, 358.00, false);
INSERT INTO public.factheartattackrisk VALUES (24, 3024, 114, 16, NULL, 202.00, 173, 109, 81, 29.63, 526.00, false);
INSERT INTO public.factheartattackrisk VALUES (25, 2954, 113, 18, NULL, 133.00, 161, 90, 97, 22.39, 605.00, false);
INSERT INTO public.factheartattackrisk VALUES (26, 2632, 111, 18, NULL, 159.00, 140, 95, 52, 26.07, 667.00, false);
INSERT INTO public.factheartattackrisk VALUES (27, 3001, 108, 16, NULL, 271.00, 148, 105, 105, 21.58, 316.00, false);
INSERT INTO public.factheartattackrisk VALUES (28, 2551, 103, 17, NULL, 273.00, 160, 76, 96, 26.42, 551.00, false);
INSERT INTO public.factheartattackrisk VALUES (29, 2804, 119, 16, NULL, 328.00, 113, 78, 74, 31.63, 482.00, false);
INSERT INTO public.factheartattackrisk VALUES (30, 2598, 105, 16, NULL, 154.00, 99, 81, 102, 39.27, 718.00, false);
INSERT INTO public.factheartattackrisk VALUES (31, 2636, 115, 18, NULL, 135.00, 120, 77, 49, 22.78, 297.00, true);
INSERT INTO public.factheartattackrisk VALUES (32, 2826, 111, 16, NULL, 197.00, 178, 72, 45, 18.52, 661.00, false);
INSERT INTO public.factheartattackrisk VALUES (33, 2968, 110, 16, NULL, 321.00, 111, 91, 50, 34.20, 558.00, true);
INSERT INTO public.factheartattackrisk VALUES (34, 2870, 103, 18, NULL, 375.00, 99, 85, 46, 18.79, 209.00, false);
INSERT INTO public.factheartattackrisk VALUES (35, 2637, 105, 18, NULL, 360.00, 103, 107, 44, 29.70, 586.00, true);
INSERT INTO public.factheartattackrisk VALUES (36, 2555, 101, 16, NULL, 360.00, 94, 60, 106, 27.10, 743.00, true);
INSERT INTO public.factheartattackrisk VALUES (37, 2802, 115, 16, NULL, 263.00, 127, 109, 83, 39.84, 411.00, false);
INSERT INTO public.factheartattackrisk VALUES (38, 2996, 115, 17, NULL, 201.00, 134, 60, 86, 33.79, 785.00, false);
INSERT INTO public.factheartattackrisk VALUES (39, 2843, 105, 18, NULL, 347.00, 115, 92, 65, 38.72, 790.00, false);
INSERT INTO public.factheartattackrisk VALUES (40, 2894, 113, 16, NULL, 129.00, 124, 93, 86, 32.17, 697.00, false);
INSERT INTO public.factheartattackrisk VALUES (41, 2663, 101, 16, NULL, 135.00, 104, 96, 101, 27.47, 519.00, false);
INSERT INTO public.factheartattackrisk VALUES (42, 2977, 105, 18, NULL, 229.00, 144, 108, 65, 35.25, 595.00, true);
INSERT INTO public.factheartattackrisk VALUES (43, 2742, 113, 16, NULL, 251.00, 101, 90, 96, 21.81, 452.00, true);
INSERT INTO public.factheartattackrisk VALUES (44, 2691, 107, 18, NULL, 121.00, 115, 109, 51, 27.09, 158.00, true);
INSERT INTO public.factheartattackrisk VALUES (45, 2857, 103, 16, NULL, 190.00, 149, 73, 43, 25.77, 679.00, false);
INSERT INTO public.factheartattackrisk VALUES (46, 3043, 118, 18, NULL, 185.00, 120, 63, 79, 37.21, 675.00, true);
INSERT INTO public.factheartattackrisk VALUES (47, 2651, 115, 16, NULL, 197.00, 106, 106, 79, 24.67, 785.00, false);
INSERT INTO public.factheartattackrisk VALUES (48, 2823, 106, 18, NULL, 279.00, 102, 76, 86, 29.97, 792.00, true);
INSERT INTO public.factheartattackrisk VALUES (49, 2811, 117, 17, NULL, 336.00, 114, 92, 73, 25.58, 584.00, false);
INSERT INTO public.factheartattackrisk VALUES (50, 2574, 104, 16, NULL, 192.00, 124, 93, 90, 30.15, 366.00, true);
INSERT INTO public.factheartattackrisk VALUES (51, 2964, 101, 16, NULL, 180.00, 173, 108, 94, 18.29, 741.00, false);
INSERT INTO public.factheartattackrisk VALUES (52, 2560, 120, 17, NULL, 203.00, 173, 109, 101, 28.01, 523.00, true);
INSERT INTO public.factheartattackrisk VALUES (53, 2902, 118, 18, NULL, 368.00, 168, 91, 78, 29.76, 474.00, false);
INSERT INTO public.factheartattackrisk VALUES (54, 2805, 109, 17, NULL, 222.00, 159, 79, 105, 37.26, 92.00, false);
INSERT INTO public.factheartattackrisk VALUES (55, 2562, 107, 16, NULL, 243.00, 100, 80, 92, 30.99, 410.00, false);
INSERT INTO public.factheartattackrisk VALUES (56, 2813, 109, 17, NULL, 218.00, 118, 76, 68, 27.18, 398.00, false);
INSERT INTO public.factheartattackrisk VALUES (57, 2597, 119, 16, NULL, 120.00, 103, 83, 54, 18.78, 493.00, true);
INSERT INTO public.factheartattackrisk VALUES (58, 2612, 104, 17, NULL, 279.00, 152, 90, 52, 39.00, 614.00, false);
INSERT INTO public.factheartattackrisk VALUES (59, 2710, 110, 16, NULL, 285.00, 151, 85, 109, 39.78, 682.00, false);
INSERT INTO public.factheartattackrisk VALUES (60, 2714, 106, 16, NULL, 377.00, 144, 98, 61, 28.51, 106.00, true);
INSERT INTO public.factheartattackrisk VALUES (61, 2675, 115, 16, NULL, 369.00, 109, 95, 64, 23.40, 216.00, false);
INSERT INTO public.factheartattackrisk VALUES (62, 2835, 117, 17, NULL, 311.00, 92, 61, 82, 32.16, 408.00, false);
INSERT INTO public.factheartattackrisk VALUES (63, 2568, 116, 17, NULL, 139.00, 179, 93, 85, 28.28, 628.00, false);
INSERT INTO public.factheartattackrisk VALUES (64, 2585, 120, 16, NULL, 266.00, 120, 69, 46, 32.33, 481.00, true);
INSERT INTO public.factheartattackrisk VALUES (65, 2974, 113, 17, NULL, 133.00, 161, 108, 110, 27.68, 67.00, false);
INSERT INTO public.factheartattackrisk VALUES (66, 3030, 114, 17, NULL, 153.00, 131, 76, 86, 19.68, 82.00, true);
INSERT INTO public.factheartattackrisk VALUES (67, 2679, 109, 17, NULL, 120.00, 107, 65, 50, 36.49, 305.00, true);
INSERT INTO public.factheartattackrisk VALUES (68, 3011, 119, 17, NULL, 220.00, 132, 109, 94, 37.81, 164.00, false);
INSERT INTO public.factheartattackrisk VALUES (69, 2581, 114, 18, NULL, 339.00, 131, 97, 42, 35.46, 211.00, false);
INSERT INTO public.factheartattackrisk VALUES (70, 2765, 120, 16, NULL, 329.00, 149, 73, 96, 37.68, 511.00, true);
INSERT INTO public.factheartattackrisk VALUES (71, 2621, 113, 16, NULL, 203.00, 177, 99, 55, 30.87, 766.00, true);
INSERT INTO public.factheartattackrisk VALUES (72, 2588, 111, 16, NULL, 333.00, 130, 94, 63, 23.91, 547.00, false);
INSERT INTO public.factheartattackrisk VALUES (73, 2950, 110, 17, NULL, 398.00, 174, 93, 82, 39.41, 327.00, true);
INSERT INTO public.factheartattackrisk VALUES (74, 3040, 120, 16, NULL, 124.00, 110, 105, 93, 34.12, 367.00, false);
INSERT INTO public.factheartattackrisk VALUES (75, 2938, 109, 17, NULL, 183.00, 116, 98, 69, 22.16, 681.00, true);
INSERT INTO public.factheartattackrisk VALUES (76, 2991, 109, 18, NULL, 163.00, 139, 107, 63, 26.61, 131.00, true);
INSERT INTO public.factheartattackrisk VALUES (77, 2888, 117, 17, NULL, 362.00, 164, 76, 41, 35.04, 42.00, false);
INSERT INTO public.factheartattackrisk VALUES (78, 2603, 114, 18, NULL, 390.00, 104, 83, 48, 18.95, 692.00, true);
INSERT INTO public.factheartattackrisk VALUES (79, 2718, 119, 18, NULL, 192.00, 118, 86, 100, 23.21, 664.00, false);
INSERT INTO public.factheartattackrisk VALUES (80, 2786, 103, 16, NULL, 200.00, 122, 77, 110, 30.76, 543.00, false);
INSERT INTO public.factheartattackrisk VALUES (81, 3047, 119, 16, NULL, 396.00, 109, 74, 76, 38.94, 689.00, true);
INSERT INTO public.factheartattackrisk VALUES (82, 2774, 106, 16, NULL, 255.00, 160, 70, 81, 33.09, 569.00, false);
INSERT INTO public.factheartattackrisk VALUES (83, 2616, 109, 17, NULL, 209.00, 92, 65, 98, 31.85, 408.00, false);
INSERT INTO public.factheartattackrisk VALUES (84, 2875, 112, 17, NULL, 247.00, 151, 101, 101, 38.59, 458.00, true);
INSERT INTO public.factheartattackrisk VALUES (85, 2961, 110, 17, NULL, 250.00, 95, 78, 75, 19.54, 683.00, false);
INSERT INTO public.factheartattackrisk VALUES (86, 2634, 112, 17, NULL, 227.00, 115, 73, 40, 20.81, 408.00, false);
INSERT INTO public.factheartattackrisk VALUES (87, 2628, 102, 16, NULL, 246.00, 148, 94, 58, 35.77, 779.00, false);
INSERT INTO public.factheartattackrisk VALUES (88, 2580, 117, 17, NULL, 223.00, 100, 66, 68, 33.04, 136.00, true);
INSERT INTO public.factheartattackrisk VALUES (89, 2591, 109, 17, NULL, 379.00, 163, 110, 71, 28.10, 643.00, true);
INSERT INTO public.factheartattackrisk VALUES (90, 2822, 110, 16, NULL, 330.00, 122, 80, 53, 33.94, 653.00, true);
INSERT INTO public.factheartattackrisk VALUES (91, 2640, 117, 17, NULL, 195.00, 118, 91, 68, 22.48, 55.00, true);
INSERT INTO public.factheartattackrisk VALUES (92, 2543, 118, 16, NULL, 222.00, 110, 104, 60, 19.14, 275.00, false);
INSERT INTO public.factheartattackrisk VALUES (93, 2939, 104, 16, NULL, 194.00, 149, 83, 77, 38.91, 314.00, false);
INSERT INTO public.factheartattackrisk VALUES (94, 2756, 115, 18, NULL, 178.00, 134, 100, 48, 21.33, 760.00, false);
INSERT INTO public.factheartattackrisk VALUES (95, 2564, 110, 16, NULL, 155.00, 116, 85, 105, 37.53, 404.00, false);
INSERT INTO public.factheartattackrisk VALUES (96, 2924, 101, 18, NULL, 240.00, 165, 79, 69, 18.09, 587.00, false);
INSERT INTO public.factheartattackrisk VALUES (97, 2927, 102, 16, NULL, 237.00, 102, 69, 65, 32.19, 576.00, false);
INSERT INTO public.factheartattackrisk VALUES (98, 2937, 115, 18, NULL, 333.00, 168, 107, 106, 18.32, 690.00, false);
INSERT INTO public.factheartattackrisk VALUES (99, 2601, 101, 17, NULL, 216.00, 160, 67, 109, 20.81, 648.00, false);
INSERT INTO public.factheartattackrisk VALUES (100, 2983, 117, 18, NULL, 276.00, 92, 71, 65, 34.56, 385.00, false);
INSERT INTO public.factheartattackrisk VALUES (101, 2602, 118, 17, NULL, 224.00, 164, 65, 98, 22.85, 255.00, false);
INSERT INTO public.factheartattackrisk VALUES (102, 2648, 115, 17, NULL, 326.00, 155, 104, 47, 22.55, 468.00, true);
INSERT INTO public.factheartattackrisk VALUES (103, 2976, 116, 17, NULL, 198.00, 104, 98, 59, 22.08, 784.00, false);
INSERT INTO public.factheartattackrisk VALUES (104, 2761, 108, 17, NULL, 301.00, 159, 76, 51, 34.37, 509.00, false);
INSERT INTO public.factheartattackrisk VALUES (105, 2738, 102, 17, NULL, 314.00, 152, 94, 51, 35.59, 205.00, true);
INSERT INTO public.factheartattackrisk VALUES (106, 2916, 116, 16, NULL, 227.00, 108, 78, 81, 36.33, 209.00, false);
INSERT INTO public.factheartattackrisk VALUES (107, 2771, 119, 17, NULL, 304.00, 168, 90, 57, 37.13, 109.00, false);
INSERT INTO public.factheartattackrisk VALUES (108, 3000, 102, 18, NULL, 334.00, 105, 108, 110, 31.36, 530.00, false);
INSERT INTO public.factheartattackrisk VALUES (109, 2681, 109, 16, NULL, 301.00, 146, 94, 47, 18.33, 654.00, false);
INSERT INTO public.factheartattackrisk VALUES (110, 2662, 105, 17, NULL, 213.00, 109, 65, 97, 36.16, 232.00, true);
INSERT INTO public.factheartattackrisk VALUES (111, 2642, 112, 16, NULL, 254.00, 166, 89, 102, 39.51, 331.00, false);
INSERT INTO public.factheartattackrisk VALUES (112, 2749, 104, 16, NULL, 237.00, 163, 61, 73, 19.41, 485.00, true);
INSERT INTO public.factheartattackrisk VALUES (113, 2759, 114, 18, NULL, 230.00, 117, 76, 107, 28.79, 250.00, false);
INSERT INTO public.factheartattackrisk VALUES (114, 2745, 113, 18, NULL, 248.00, 106, 60, 70, 28.82, 113.00, false);
INSERT INTO public.factheartattackrisk VALUES (115, 2767, 114, 18, NULL, 316.00, 159, 70, 58, 30.66, 377.00, true);
INSERT INTO public.factheartattackrisk VALUES (116, 2701, 112, 17, NULL, 277.00, 145, 92, 87, 25.08, 180.00, false);
INSERT INTO public.factheartattackrisk VALUES (117, 2779, 111, 18, NULL, 388.00, 170, 106, 41, 27.77, 229.00, false);
INSERT INTO public.factheartattackrisk VALUES (118, 2989, 117, 16, NULL, 206.00, 134, 94, 104, 39.85, 602.00, false);
INSERT INTO public.factheartattackrisk VALUES (119, 2922, 110, 18, NULL, 384.00, 113, 80, 67, 36.70, 285.00, false);
INSERT INTO public.factheartattackrisk VALUES (120, 2956, 101, 16, NULL, 205.00, 163, 102, 93, 27.62, 471.00, false);
INSERT INTO public.factheartattackrisk VALUES (121, 2837, 102, 16, NULL, 261.00, 149, 100, 65, 19.95, 554.00, false);
INSERT INTO public.factheartattackrisk VALUES (122, 2631, 114, 16, NULL, 308.00, 125, 76, 96, 24.11, 344.00, true);
INSERT INTO public.factheartattackrisk VALUES (123, 2818, 108, 18, NULL, 246.00, 100, 67, 71, 35.29, 416.00, true);
INSERT INTO public.factheartattackrisk VALUES (124, 2930, 102, 18, NULL, 396.00, 110, 101, 45, 31.71, 445.00, false);
INSERT INTO public.factheartattackrisk VALUES (125, 2923, 115, 18, NULL, 338.00, 149, 69, 96, 33.85, 385.00, true);
INSERT INTO public.factheartattackrisk VALUES (126, 2852, 103, 17, NULL, 382.00, 135, 63, 63, 38.92, 709.00, true);
INSERT INTO public.factheartattackrisk VALUES (127, 2975, 113, 16, NULL, 291.00, 137, 67, 72, 37.55, 426.00, true);
INSERT INTO public.factheartattackrisk VALUES (128, 3014, 119, 17, NULL, 163.00, 178, 78, 53, 19.95, 528.00, false);
INSERT INTO public.factheartattackrisk VALUES (129, 2928, 101, 17, NULL, 129.00, 116, 73, 107, 29.76, 388.00, false);
INSERT INTO public.factheartattackrisk VALUES (130, 2567, 115, 18, NULL, 168.00, 110, 72, 48, 38.33, 314.00, false);
INSERT INTO public.factheartattackrisk VALUES (131, 2547, 114, 18, NULL, 247.00, 100, 88, 79, 38.20, 441.00, false);
INSERT INTO public.factheartattackrisk VALUES (132, 2707, 102, 17, NULL, 218.00, 121, 72, 98, 33.74, 306.00, false);
INSERT INTO public.factheartattackrisk VALUES (133, 2778, 104, 18, NULL, 237.00, 174, 102, 49, 19.69, 749.00, false);
INSERT INTO public.factheartattackrisk VALUES (134, 2727, 106, 16, NULL, 388.00, 177, 94, 53, 37.22, 347.00, true);
INSERT INTO public.factheartattackrisk VALUES (135, 2957, 111, 18, NULL, 227.00, 126, 108, 79, 23.67, 341.00, false);
INSERT INTO public.factheartattackrisk VALUES (136, 2809, 111, 16, NULL, 171.00, 120, 101, 88, 22.04, 451.00, false);
INSERT INTO public.factheartattackrisk VALUES (137, 2850, 110, 18, NULL, 378.00, 118, 105, 96, 40.00, 286.00, true);
INSERT INTO public.factheartattackrisk VALUES (138, 3023, 114, 18, NULL, 124.00, 142, 88, 96, 28.96, 356.00, false);
INSERT INTO public.factheartattackrisk VALUES (139, 2711, 101, 16, NULL, 279.00, 128, 105, 56, 39.95, 336.00, false);
INSERT INTO public.factheartattackrisk VALUES (140, 2572, 112, 17, NULL, 338.00, 143, 75, 85, 32.50, 455.00, true);
INSERT INTO public.factheartattackrisk VALUES (141, 2855, 117, 17, NULL, 253.00, 103, 78, 49, 34.48, 223.00, true);
INSERT INTO public.factheartattackrisk VALUES (142, 3015, 110, 18, NULL, 245.00, 116, 102, 87, 37.89, 766.00, false);
INSERT INTO public.factheartattackrisk VALUES (143, 2935, 109, 17, NULL, 226.00, 132, 76, 94, 32.54, 262.00, false);
INSERT INTO public.factheartattackrisk VALUES (144, 2644, 104, 17, NULL, 248.00, 169, 92, 88, 19.40, 239.00, false);
INSERT INTO public.factheartattackrisk VALUES (145, 2641, 105, 17, NULL, 281.00, 113, 79, 58, 32.03, 555.00, false);
INSERT INTO public.factheartattackrisk VALUES (146, 2909, 102, 17, NULL, 123.00, 99, 71, 101, 25.16, 363.00, false);
INSERT INTO public.factheartattackrisk VALUES (147, 2722, 113, 18, NULL, 173.00, 96, 93, 85, 28.06, 489.00, false);
INSERT INTO public.factheartattackrisk VALUES (148, 2986, 112, 18, NULL, 231.00, 145, 82, 66, 36.87, 788.00, false);
INSERT INTO public.factheartattackrisk VALUES (149, 2896, 105, 17, NULL, 234.00, 173, 62, 61, 23.84, 121.00, false);
INSERT INTO public.factheartattackrisk VALUES (150, 3025, 120, 18, NULL, 224.00, 179, 62, 59, 22.02, 553.00, true);
INSERT INTO public.factheartattackrisk VALUES (151, 2545, 115, 17, NULL, 268.00, 100, 69, 102, 29.61, 485.00, false);
INSERT INTO public.factheartattackrisk VALUES (152, 2627, 115, 18, NULL, 253.00, 153, 77, 57, 29.47, 617.00, false);
INSERT INTO public.factheartattackrisk VALUES (153, 3008, 107, 16, NULL, 396.00, 156, 74, 60, 23.66, 471.00, false);
INSERT INTO public.factheartattackrisk VALUES (154, 2561, 104, 17, NULL, 133.00, 162, 82, 76, 21.28, 174.00, false);
INSERT INTO public.factheartattackrisk VALUES (155, 2688, 117, 18, NULL, 209.00, 98, 109, 81, 28.96, 167.00, true);
INSERT INTO public.factheartattackrisk VALUES (156, 2607, 106, 18, NULL, 306.00, 165, 89, 64, 25.87, 563.00, false);
INSERT INTO public.factheartattackrisk VALUES (157, 2953, 111, 17, NULL, 133.00, 150, 73, 87, 39.33, 665.00, false);
INSERT INTO public.factheartattackrisk VALUES (158, 2973, 119, 18, NULL, 186.00, 163, 102, 82, 23.62, 605.00, true);
INSERT INTO public.factheartattackrisk VALUES (159, 2882, 108, 17, NULL, 293.00, 134, 90, 67, 25.84, 65.00, false);
INSERT INTO public.factheartattackrisk VALUES (160, 2971, 119, 17, NULL, 161.00, 133, 60, 74, 27.29, 657.00, true);
INSERT INTO public.factheartattackrisk VALUES (161, 2549, 112, 16, NULL, 243.00, 157, 110, 42, 36.62, 237.00, false);
INSERT INTO public.factheartattackrisk VALUES (162, 2744, 104, 18, NULL, 398.00, 96, 106, 56, 33.63, 141.00, true);
INSERT INTO public.factheartattackrisk VALUES (163, 2587, 106, 17, NULL, 380.00, 173, 82, 75, 21.72, 767.00, true);
INSERT INTO public.factheartattackrisk VALUES (164, 2611, 109, 17, NULL, 297.00, 96, 92, 75, 18.04, 292.00, false);
INSERT INTO public.factheartattackrisk VALUES (165, 2557, 103, 17, NULL, 247.00, 162, 71, 82, 23.59, 743.00, true);
INSERT INTO public.factheartattackrisk VALUES (166, 2772, 115, 17, NULL, 133.00, 91, 83, 93, 27.22, 563.00, false);
INSERT INTO public.factheartattackrisk VALUES (167, 2892, 101, 18, NULL, 195.00, 148, 89, 69, 25.41, 214.00, false);
INSERT INTO public.factheartattackrisk VALUES (168, 2904, 101, 16, NULL, 239.00, 145, 98, 86, 24.85, 221.00, true);
INSERT INTO public.factheartattackrisk VALUES (169, 3016, 115, 18, NULL, 149.00, 180, 108, 81, 23.41, 447.00, false);
INSERT INTO public.factheartattackrisk VALUES (170, 2962, 119, 18, NULL, 320.00, 98, 67, 110, 32.14, 634.00, false);
INSERT INTO public.factheartattackrisk VALUES (171, 2919, 120, 18, NULL, 246.00, 154, 81, 100, 22.04, 460.00, false);
INSERT INTO public.factheartattackrisk VALUES (172, 2686, 106, 16, NULL, 208.00, 172, 64, 99, 35.47, 711.00, false);
INSERT INTO public.factheartattackrisk VALUES (173, 2789, 120, 17, NULL, 219.00, 118, 75, 56, 36.74, 216.00, false);
INSERT INTO public.factheartattackrisk VALUES (174, 2900, 108, 16, NULL, 335.00, 144, 60, 80, 34.21, 97.00, false);
INSERT INTO public.factheartattackrisk VALUES (175, 2609, 110, 16, NULL, 265.00, 133, 63, 92, 29.62, 267.00, true);
INSERT INTO public.factheartattackrisk VALUES (176, 2726, 106, 16, NULL, 380.00, 154, 102, 76, 32.07, 695.00, false);
INSERT INTO public.factheartattackrisk VALUES (177, 2692, 115, 16, NULL, 178.00, 123, 91, 64, 25.09, 717.00, true);
INSERT INTO public.factheartattackrisk VALUES (178, 3021, 109, 18, NULL, 253.00, 102, 82, 95, 37.40, 795.00, false);
INSERT INTO public.factheartattackrisk VALUES (179, 3031, 117, 18, NULL, 126.00, 146, 76, 88, 21.18, 383.00, false);
INSERT INTO public.factheartattackrisk VALUES (180, 2960, 113, 17, NULL, 251.00, 178, 83, 108, 21.36, 332.00, true);
INSERT INTO public.factheartattackrisk VALUES (181, 2687, 117, 17, NULL, 307.00, 123, 72, 90, 23.24, 785.00, false);
INSERT INTO public.factheartattackrisk VALUES (182, 2815, 103, 16, NULL, 359.00, 154, 63, 74, 21.99, 449.00, false);
INSERT INTO public.factheartattackrisk VALUES (183, 2785, 105, 16, NULL, 270.00, 158, 85, 73, 18.46, 701.00, false);
INSERT INTO public.factheartattackrisk VALUES (184, 3007, 105, 16, NULL, 336.00, 161, 105, 57, 22.41, 524.00, false);
INSERT INTO public.factheartattackrisk VALUES (185, 2752, 119, 17, NULL, 225.00, 131, 70, 81, 21.16, 549.00, false);
INSERT INTO public.factheartattackrisk VALUES (186, 2630, 102, 16, NULL, 193.00, 169, 90, 74, 37.09, 31.00, true);
INSERT INTO public.factheartattackrisk VALUES (187, 2994, 113, 17, NULL, 148.00, 154, 95, 60, 18.43, 276.00, false);
INSERT INTO public.factheartattackrisk VALUES (188, 2946, 120, 16, NULL, 358.00, 110, 104, 56, 32.78, 569.00, true);
INSERT INTO public.factheartattackrisk VALUES (189, 2650, 109, 16, NULL, 296.00, 121, 65, 57, 32.14, 744.00, true);
INSERT INTO public.factheartattackrisk VALUES (190, 2736, 112, 18, NULL, 206.00, 142, 104, 67, 26.78, 128.00, false);
INSERT INTO public.factheartattackrisk VALUES (191, 3027, 102, 18, NULL, 339.00, 153, 89, 88, 32.33, 331.00, true);
INSERT INTO public.factheartattackrisk VALUES (192, 2951, 112, 17, NULL, 377.00, 125, 95, 49, 25.25, 327.00, true);
INSERT INTO public.factheartattackrisk VALUES (193, 2729, 115, 18, NULL, 136.00, 135, 92, 65, 35.14, 52.00, true);
INSERT INTO public.factheartattackrisk VALUES (194, 2915, 115, 16, NULL, 200.00, 143, 83, 93, 32.16, 394.00, false);
INSERT INTO public.factheartattackrisk VALUES (195, 2671, 110, 17, NULL, 234.00, 149, 73, 41, 26.11, 54.00, true);
INSERT INTO public.factheartattackrisk VALUES (196, 3020, 111, 16, NULL, 364.00, 96, 66, 50, 20.88, 739.00, true);
INSERT INTO public.factheartattackrisk VALUES (197, 2845, 118, 18, NULL, 353.00, 157, 98, 83, 32.92, 407.00, false);
INSERT INTO public.factheartattackrisk VALUES (198, 2646, 116, 17, NULL, 252.00, 120, 109, 79, 24.80, 751.00, false);
INSERT INTO public.factheartattackrisk VALUES (199, 2674, 113, 18, NULL, 232.00, 171, 69, 102, 22.18, 436.00, true);
INSERT INTO public.factheartattackrisk VALUES (200, 2876, 119, 17, NULL, 387.00, 106, 101, 78, 28.33, 473.00, false);
INSERT INTO public.factheartattackrisk VALUES (201, 2776, 109, 16, NULL, 299.00, 90, 105, 66, 18.33, 218.00, false);
INSERT INTO public.factheartattackrisk VALUES (202, 2723, 117, 17, NULL, 357.00, 133, 77, 89, 36.25, 654.00, false);
INSERT INTO public.factheartattackrisk VALUES (203, 2995, 112, 18, NULL, 214.00, 179, 88, 68, 18.31, 129.00, true);
INSERT INTO public.factheartattackrisk VALUES (204, 2638, 104, 17, NULL, 279.00, 177, 70, 86, 23.68, 579.00, false);
INSERT INTO public.factheartattackrisk VALUES (205, 2748, 102, 16, NULL, 370.00, 98, 73, 68, 22.48, 492.00, false);
INSERT INTO public.factheartattackrisk VALUES (206, 2709, 109, 17, NULL, 345.00, 174, 61, 104, 20.09, 696.00, false);
INSERT INTO public.factheartattackrisk VALUES (207, 2566, 101, 18, NULL, 351.00, 176, 110, 89, 39.99, 202.00, false);
INSERT INTO public.factheartattackrisk VALUES (208, 2999, 116, 18, NULL, 344.00, 167, 62, 92, 19.96, 197.00, false);
INSERT INTO public.factheartattackrisk VALUES (209, 2653, 113, 18, NULL, 152.00, 103, 82, 44, 37.57, 521.00, false);
INSERT INTO public.factheartattackrisk VALUES (210, 2678, 104, 18, NULL, 303.00, 171, 75, 105, 39.10, 325.00, false);
INSERT INTO public.factheartattackrisk VALUES (211, 3004, 102, 16, NULL, 193.00, 158, 87, 73, 24.04, 35.00, true);
INSERT INTO public.factheartattackrisk VALUES (212, 2925, 103, 17, NULL, 150.00, 131, 109, 57, 25.97, 123.00, false);
INSERT INTO public.factheartattackrisk VALUES (213, 2608, 104, 17, NULL, 131.00, 124, 94, 83, 22.66, 694.00, false);
INSERT INTO public.factheartattackrisk VALUES (214, 2780, 114, 17, NULL, 334.00, 164, 71, 107, 36.94, 434.00, false);
INSERT INTO public.factheartattackrisk VALUES (215, 2854, 101, 17, NULL, 202.00, 100, 81, 92, 33.51, 131.00, false);
INSERT INTO public.factheartattackrisk VALUES (216, 2584, 101, 16, NULL, 276.00, 164, 90, 109, 18.07, 248.00, false);
INSERT INTO public.factheartattackrisk VALUES (217, 2694, 117, 16, NULL, 190.00, 108, 64, 64, 38.43, 648.00, true);
INSERT INTO public.factheartattackrisk VALUES (218, 2615, 109, 17, NULL, 226.00, 179, 63, 83, 34.19, 348.00, false);
INSERT INTO public.factheartattackrisk VALUES (219, 2682, 118, 16, NULL, 272.00, 141, 75, 72, 25.02, 750.00, false);
INSERT INTO public.factheartattackrisk VALUES (220, 2788, 110, 16, NULL, 373.00, 116, 93, 73, 26.55, 431.00, true);
INSERT INTO public.factheartattackrisk VALUES (221, 2969, 117, 18, NULL, 263.00, 115, 78, 108, 26.64, 714.00, false);
INSERT INTO public.factheartattackrisk VALUES (222, 2605, 117, 16, NULL, 194.00, 146, 107, 78, 22.27, 649.00, false);
INSERT INTO public.factheartattackrisk VALUES (223, 2792, 116, 18, NULL, 357.00, 102, 105, 96, 22.44, 668.00, false);
INSERT INTO public.factheartattackrisk VALUES (224, 2883, 113, 16, NULL, 302.00, 151, 95, 94, 37.99, 401.00, false);
INSERT INTO public.factheartattackrisk VALUES (225, 2970, 115, 17, NULL, 337.00, 133, 82, 48, 28.57, 610.00, true);
INSERT INTO public.factheartattackrisk VALUES (226, 2676, 119, 17, NULL, 205.00, 134, 72, 105, 24.54, 244.00, false);
INSERT INTO public.factheartattackrisk VALUES (227, 2764, 117, 18, NULL, 170.00, 157, 104, 95, 25.75, 691.00, false);
INSERT INTO public.factheartattackrisk VALUES (228, 3038, 112, 16, NULL, 356.00, 126, 107, 62, 19.63, 88.00, true);
INSERT INTO public.factheartattackrisk VALUES (229, 2703, 116, 17, NULL, 297.00, 105, 103, 90, 31.62, 532.00, false);
INSERT INTO public.factheartattackrisk VALUES (230, 2848, 103, 16, NULL, 274.00, 168, 110, 77, 39.40, 777.00, false);
INSERT INTO public.factheartattackrisk VALUES (231, 2734, 114, 17, NULL, 122.00, 162, 71, 57, 18.50, 121.00, false);
INSERT INTO public.factheartattackrisk VALUES (232, 2981, 113, 16, NULL, 188.00, 115, 87, 51, 38.04, 420.00, false);
INSERT INTO public.factheartattackrisk VALUES (233, 2980, 109, 18, NULL, 125.00, 99, 64, 103, 22.58, 350.00, false);
INSERT INTO public.factheartattackrisk VALUES (234, 2570, 101, 16, NULL, 200.00, 126, 109, 80, 29.72, 652.00, false);
INSERT INTO public.factheartattackrisk VALUES (235, 3003, 103, 17, NULL, 328.00, 99, 90, 78, 37.49, 413.00, false);
INSERT INTO public.factheartattackrisk VALUES (236, 2869, 114, 18, NULL, 389.00, 123, 107, 51, 39.46, 779.00, false);
INSERT INTO public.factheartattackrisk VALUES (237, 2899, 110, 16, NULL, 225.00, 165, 71, 48, 35.28, 558.00, false);
INSERT INTO public.factheartattackrisk VALUES (238, 2787, 117, 18, NULL, 201.00, 127, 89, 55, 20.78, 109.00, false);
INSERT INTO public.factheartattackrisk VALUES (239, 2799, 103, 16, NULL, 205.00, 121, 66, 110, 18.20, 754.00, false);
INSERT INTO public.factheartattackrisk VALUES (240, 2825, 102, 16, NULL, 138.00, 159, 98, 101, 24.31, 760.00, false);
INSERT INTO public.factheartattackrisk VALUES (241, 2797, 115, 16, NULL, 376.00, 165, 70, 89, 20.96, 753.00, false);
INSERT INTO public.factheartattackrisk VALUES (242, 2758, 115, 16, NULL, 181.00, 138, 89, 59, 38.05, 457.00, false);
INSERT INTO public.factheartattackrisk VALUES (243, 2931, 115, 17, NULL, 277.00, 119, 91, 107, 20.71, 122.00, true);
INSERT INTO public.factheartattackrisk VALUES (244, 3037, 117, 17, NULL, 138.00, 102, 107, 55, 32.65, 312.00, false);
INSERT INTO public.factheartattackrisk VALUES (245, 2777, 106, 16, NULL, 230.00, 97, 93, 76, 29.64, 778.00, false);
INSERT INTO public.factheartattackrisk VALUES (246, 2984, 106, 18, NULL, 263.00, 120, 65, 64, 23.55, 676.00, false);
INSERT INTO public.factheartattackrisk VALUES (247, 2958, 109, 17, NULL, 184.00, 118, 82, 74, 37.80, 775.00, false);
INSERT INTO public.factheartattackrisk VALUES (248, 2730, 107, 16, NULL, 275.00, 178, 86, 98, 25.69, 183.00, false);
INSERT INTO public.factheartattackrisk VALUES (249, 2699, 111, 16, NULL, 163.00, 92, 82, 86, 29.68, 601.00, true);
INSERT INTO public.factheartattackrisk VALUES (250, 2998, 103, 18, NULL, 243.00, 111, 69, 95, 36.39, 317.00, false);
INSERT INTO public.factheartattackrisk VALUES (251, 2880, 107, 18, NULL, 370.00, 164, 92, 105, 37.20, 592.00, true);
INSERT INTO public.factheartattackrisk VALUES (252, 2862, 105, 16, NULL, 394.00, 137, 109, 79, 34.01, 113.00, false);
INSERT INTO public.factheartattackrisk VALUES (253, 2575, 119, 18, NULL, 155.00, 154, 92, 72, 26.31, 191.00, false);
INSERT INTO public.factheartattackrisk VALUES (254, 2851, 102, 17, NULL, 190.00, 91, 62, 60, 35.03, 83.00, true);
INSERT INTO public.factheartattackrisk VALUES (255, 2972, 120, 18, NULL, 128.00, 155, 104, 104, 38.21, 32.00, false);
INSERT INTO public.factheartattackrisk VALUES (256, 2817, 105, 18, NULL, 217.00, 124, 91, 52, 34.05, 453.00, true);
INSERT INTO public.factheartattackrisk VALUES (257, 2656, 110, 18, NULL, 220.00, 125, 72, 57, 39.17, 423.00, true);
INSERT INTO public.factheartattackrisk VALUES (258, 2839, 103, 17, NULL, 353.00, 159, 108, 46, 21.91, 455.00, false);
INSERT INTO public.factheartattackrisk VALUES (259, 2949, 104, 17, NULL, 225.00, 106, 64, 58, 18.84, 234.00, true);
INSERT INTO public.factheartattackrisk VALUES (260, 2810, 105, 18, NULL, 396.00, 103, 106, 84, 22.58, 650.00, false);
INSERT INTO public.factheartattackrisk VALUES (261, 2861, 106, 18, NULL, 399.00, 162, 62, 70, 20.87, 565.00, false);
INSERT INTO public.factheartattackrisk VALUES (262, 2649, 116, 16, NULL, 378.00, 105, 80, 57, 29.75, 798.00, false);
INSERT INTO public.factheartattackrisk VALUES (263, 2565, 118, 17, NULL, 283.00, 175, 70, 55, 35.04, 769.00, false);
INSERT INTO public.factheartattackrisk VALUES (264, 2731, 119, 16, NULL, 289.00, 125, 93, 44, 23.11, 412.00, true);
INSERT INTO public.factheartattackrisk VALUES (265, 2806, 110, 16, NULL, 120.00, 98, 108, 78, 31.88, 455.00, false);
INSERT INTO public.factheartattackrisk VALUES (266, 2800, 112, 17, NULL, 138.00, 123, 95, 83, 19.50, 63.00, true);
INSERT INTO public.factheartattackrisk VALUES (267, 2613, 109, 16, NULL, 131.00, 133, 102, 40, 33.90, 576.00, true);
INSERT INTO public.factheartattackrisk VALUES (268, 2846, 103, 18, NULL, 284.00, 157, 100, 109, 37.23, 198.00, true);
INSERT INTO public.factheartattackrisk VALUES (269, 2821, 120, 16, NULL, 270.00, 110, 67, 106, 25.06, 93.00, false);
INSERT INTO public.factheartattackrisk VALUES (270, 2827, 106, 16, NULL, 321.00, 142, 96, 102, 21.80, 764.00, false);
INSERT INTO public.factheartattackrisk VALUES (271, 2629, 108, 16, NULL, 327.00, 133, 91, 82, 36.35, 82.00, false);
INSERT INTO public.factheartattackrisk VALUES (272, 2942, 116, 18, NULL, 262.00, 128, 94, 42, 21.94, 737.00, true);
INSERT INTO public.factheartattackrisk VALUES (273, 2739, 109, 18, NULL, 212.00, 115, 109, 54, 28.26, 94.00, false);
INSERT INTO public.factheartattackrisk VALUES (274, 2773, 109, 16, NULL, 153.00, 175, 62, 87, 28.36, 211.00, false);
INSERT INTO public.factheartattackrisk VALUES (275, 2595, 103, 17, NULL, 216.00, 155, 110, 85, 21.50, 298.00, true);
INSERT INTO public.factheartattackrisk VALUES (276, 2753, 113, 18, NULL, 152.00, 95, 63, 62, 33.82, 288.00, false);
INSERT INTO public.factheartattackrisk VALUES (277, 3034, 109, 18, NULL, 350.00, 161, 94, 104, 31.36, 735.00, true);
INSERT INTO public.factheartattackrisk VALUES (278, 2936, 120, 18, NULL, 192.00, 117, 76, 66, 29.06, 190.00, false);
INSERT INTO public.factheartattackrisk VALUES (279, 2717, 110, 17, NULL, 345.00, 179, 82, 72, 38.45, 281.00, true);
INSERT INTO public.factheartattackrisk VALUES (280, 2554, 116, 17, NULL, 128.00, 179, 65, 56, 34.36, 146.00, false);
INSERT INTO public.factheartattackrisk VALUES (281, 2755, 117, 17, NULL, 311.00, 96, 77, 69, 20.14, 574.00, false);
INSERT INTO public.factheartattackrisk VALUES (282, 2757, 108, 18, NULL, 206.00, 167, 64, 57, 38.04, 359.00, false);
INSERT INTO public.factheartattackrisk VALUES (283, 2808, 113, 16, NULL, 125.00, 142, 68, 57, 21.53, 155.00, false);
INSERT INTO public.factheartattackrisk VALUES (284, 2865, 107, 17, NULL, 385.00, 138, 66, 42, 19.62, 719.00, false);
INSERT INTO public.factheartattackrisk VALUES (285, 2911, 119, 16, NULL, 121.00, 180, 103, 49, 34.09, 466.00, true);
INSERT INTO public.factheartattackrisk VALUES (286, 2866, 108, 18, NULL, 330.00, 90, 62, 85, 21.81, 106.00, false);
INSERT INTO public.factheartattackrisk VALUES (287, 2698, 117, 18, NULL, 356.00, 137, 64, 48, 22.62, 492.00, true);
INSERT INTO public.factheartattackrisk VALUES (288, 2864, 118, 18, NULL, 321.00, 163, 84, 86, 35.62, 275.00, false);
INSERT INTO public.factheartattackrisk VALUES (289, 2706, 112, 18, NULL, 283.00, 158, 108, 85, 22.60, 517.00, true);
INSERT INTO public.factheartattackrisk VALUES (290, 2658, 119, 16, NULL, 155.00, 151, 68, 103, 37.55, 788.00, true);
INSERT INTO public.factheartattackrisk VALUES (291, 2664, 109, 17, NULL, 162.00, 168, 97, 91, 36.72, 273.00, false);
INSERT INTO public.factheartattackrisk VALUES (292, 2952, 105, 16, NULL, 203.00, 156, 106, 72, 26.02, 515.00, false);
INSERT INTO public.factheartattackrisk VALUES (293, 3033, 109, 16, NULL, 141.00, 103, 75, 107, 33.52, 187.00, false);
INSERT INTO public.factheartattackrisk VALUES (294, 2921, 101, 17, NULL, 283.00, 103, 61, 105, 28.92, 544.00, true);
INSERT INTO public.factheartattackrisk VALUES (295, 2901, 112, 16, NULL, 361.00, 105, 103, 51, 20.57, 784.00, false);
INSERT INTO public.factheartattackrisk VALUES (296, 2569, 109, 18, NULL, 200.00, 173, 65, 109, 21.54, 103.00, true);
INSERT INTO public.factheartattackrisk VALUES (297, 2700, 101, 17, NULL, 220.00, 116, 74, 68, 33.60, 132.00, true);
INSERT INTO public.factheartattackrisk VALUES (298, 2782, 105, 17, NULL, 201.00, 131, 96, 82, 23.20, 118.00, false);
INSERT INTO public.factheartattackrisk VALUES (299, 3029, 112, 16, NULL, 244.00, 141, 68, 64, 18.41, 115.00, true);
INSERT INTO public.factheartattackrisk VALUES (300, 2763, 115, 16, NULL, 150.00, 99, 108, 99, 23.95, 544.00, false);
INSERT INTO public.factheartattackrisk VALUES (301, 2833, 113, 18, NULL, 295.00, 121, 96, 90, 39.62, 709.00, false);
INSERT INTO public.factheartattackrisk VALUES (302, 2594, 105, 18, NULL, 287.00, 110, 96, 95, 23.77, 85.00, true);
INSERT INTO public.factheartattackrisk VALUES (303, 2885, 107, 16, NULL, 339.00, 112, 66, 58, 29.41, 38.00, false);
INSERT INTO public.factheartattackrisk VALUES (304, 2661, 108, 17, NULL, 144.00, 133, 70, 67, 22.95, 117.00, false);
INSERT INTO public.factheartattackrisk VALUES (305, 3046, 118, 16, NULL, 382.00, 171, 99, 67, 39.92, 223.00, true);
INSERT INTO public.factheartattackrisk VALUES (306, 2665, 112, 18, NULL, 354.00, 96, 100, 79, 31.96, 362.00, false);
INSERT INTO public.factheartattackrisk VALUES (307, 2620, 103, 17, NULL, 153.00, 180, 92, 48, 35.24, 411.00, true);
INSERT INTO public.factheartattackrisk VALUES (308, 2794, 112, 16, NULL, 163.00, 142, 67, 51, 23.43, 614.00, true);
INSERT INTO public.factheartattackrisk VALUES (309, 2667, 103, 17, NULL, 122.00, 156, 75, 64, 26.86, 133.00, true);
INSERT INTO public.factheartattackrisk VALUES (310, 2737, 115, 18, NULL, 230.00, 162, 67, 94, 33.99, 547.00, false);
INSERT INTO public.factheartattackrisk VALUES (311, 2814, 104, 18, NULL, 225.00, 90, 100, 91, 37.49, 498.00, false);
INSERT INTO public.factheartattackrisk VALUES (312, 2985, 120, 16, NULL, 363.00, 109, 107, 60, 21.69, 645.00, true);
INSERT INTO public.factheartattackrisk VALUES (313, 2824, 118, 18, NULL, 173.00, 168, 68, 72, 36.93, 492.00, false);
INSERT INTO public.factheartattackrisk VALUES (314, 2635, 106, 17, NULL, 265.00, 146, 100, 41, 27.11, 339.00, false);
INSERT INTO public.factheartattackrisk VALUES (315, 2696, 115, 18, NULL, 352.00, 108, 75, 55, 32.27, 787.00, true);
INSERT INTO public.factheartattackrisk VALUES (316, 2542, 102, 18, NULL, 228.00, 145, 62, 108, 22.86, 558.00, true);
INSERT INTO public.factheartattackrisk VALUES (317, 2945, 105, 16, NULL, 136.00, 168, 68, 100, 23.55, 733.00, true);
INSERT INTO public.factheartattackrisk VALUES (318, 2672, 117, 17, NULL, 140.00, 112, 108, 76, 24.53, 697.00, false);
INSERT INTO public.factheartattackrisk VALUES (319, 2618, 106, 17, NULL, 196.00, 150, 95, 50, 19.93, 648.00, false);
INSERT INTO public.factheartattackrisk VALUES (320, 2546, 110, 17, NULL, 172.00, 122, 97, 76, 27.36, 663.00, true);
INSERT INTO public.factheartattackrisk VALUES (321, 2836, 115, 17, NULL, 319.00, 161, 77, 102, 30.34, 291.00, true);
INSERT INTO public.factheartattackrisk VALUES (322, 3048, 102, 17, NULL, 325.00, 115, 61, 87, 34.09, 502.00, true);
INSERT INTO public.factheartattackrisk VALUES (323, 2576, 119, 17, NULL, 162.00, 92, 105, 93, 27.59, 569.00, true);
INSERT INTO public.factheartattackrisk VALUES (324, 2990, 109, 17, NULL, 331.00, 100, 89, 102, 26.67, 341.00, false);
INSERT INTO public.factheartattackrisk VALUES (325, 2548, 104, 16, NULL, 392.00, 96, 60, 94, 19.99, 78.00, false);
INSERT INTO public.factheartattackrisk VALUES (326, 2689, 102, 18, NULL, 220.00, 137, 100, 75, 19.01, 35.00, false);
INSERT INTO public.factheartattackrisk VALUES (327, 2918, 105, 17, NULL, 308.00, 94, 109, 73, 20.54, 81.00, false);
INSERT INTO public.factheartattackrisk VALUES (328, 2670, 112, 18, NULL, 284.00, 93, 102, 101, 32.29, 257.00, false);
INSERT INTO public.factheartattackrisk VALUES (329, 2955, 103, 16, NULL, 147.00, 114, 103, 101, 26.32, 624.00, false);
INSERT INTO public.factheartattackrisk VALUES (330, 2590, 117, 18, NULL, 193.00, 105, 90, 61, 26.00, 91.00, true);
INSERT INTO public.factheartattackrisk VALUES (331, 2859, 116, 16, NULL, 250.00, 90, 78, 51, 29.77, 374.00, false);
INSERT INTO public.factheartattackrisk VALUES (332, 2879, 117, 17, NULL, 122.00, 126, 74, 108, 25.05, 767.00, false);
INSERT INTO public.factheartattackrisk VALUES (333, 2690, 103, 17, NULL, 299.00, 177, 75, 96, 20.95, 270.00, false);
INSERT INTO public.factheartattackrisk VALUES (334, 2578, 117, 18, NULL, 261.00, 179, 104, 93, 28.25, 797.00, false);
INSERT INTO public.factheartattackrisk VALUES (335, 2624, 117, 17, NULL, 187.00, 101, 75, 95, 29.12, 306.00, false);
INSERT INTO public.factheartattackrisk VALUES (336, 3026, 111, 17, NULL, 368.00, 172, 86, 91, 38.32, 446.00, true);
INSERT INTO public.factheartattackrisk VALUES (337, 2720, 105, 17, NULL, 346.00, 173, 63, 85, 29.79, 778.00, true);
INSERT INTO public.factheartattackrisk VALUES (338, 2751, 113, 16, NULL, 243.00, 177, 95, 67, 39.63, 464.00, false);
INSERT INTO public.factheartattackrisk VALUES (339, 2830, 102, 18, NULL, 122.00, 93, 62, 62, 30.89, 164.00, true);
INSERT INTO public.factheartattackrisk VALUES (340, 2890, 104, 18, NULL, 338.00, 171, 65, 82, 21.46, 103.00, true);
INSERT INTO public.factheartattackrisk VALUES (341, 2796, 113, 16, NULL, 234.00, 91, 68, 96, 34.39, 502.00, false);
INSERT INTO public.factheartattackrisk VALUES (342, 2860, 108, 17, NULL, 294.00, 175, 77, 51, 37.93, 92.00, true);
INSERT INTO public.factheartattackrisk VALUES (343, 2677, 108, 17, NULL, 218.00, 143, 83, 79, 35.21, 450.00, false);
INSERT INTO public.factheartattackrisk VALUES (344, 2863, 102, 17, NULL, 304.00, 165, 78, 95, 20.05, 722.00, false);
INSERT INTO public.factheartattackrisk VALUES (345, 3006, 116, 17, NULL, 173.00, 163, 63, 64, 20.23, 556.00, true);
INSERT INTO public.factheartattackrisk VALUES (346, 2910, 118, 16, NULL, 286.00, 124, 88, 64, 37.56, 184.00, false);
INSERT INTO public.factheartattackrisk VALUES (347, 2623, 110, 17, NULL, 359.00, 99, 82, 110, 25.32, 428.00, false);
INSERT INTO public.factheartattackrisk VALUES (348, 2829, 101, 17, NULL, 273.00, 166, 86, 67, 22.61, 273.00, true);
INSERT INTO public.factheartattackrisk VALUES (349, 2965, 104, 16, NULL, 123.00, 165, 78, 84, 28.29, 796.00, false);
INSERT INTO public.factheartattackrisk VALUES (350, 2693, 112, 17, NULL, 124.00, 145, 65, 43, 35.74, 174.00, false);
INSERT INTO public.factheartattackrisk VALUES (351, 2933, 113, 16, NULL, 139.00, 158, 76, 54, 33.89, 656.00, false);
INSERT INTO public.factheartattackrisk VALUES (352, 3044, 120, 16, NULL, 244.00, 132, 76, 103, 27.61, 134.00, false);
INSERT INTO public.factheartattackrisk VALUES (353, 3009, 116, 16, NULL, 321.00, 163, 106, 99, 26.77, 196.00, false);
INSERT INTO public.factheartattackrisk VALUES (354, 2733, 109, 17, NULL, 263.00, 126, 84, 59, 21.93, 121.00, false);
INSERT INTO public.factheartattackrisk VALUES (355, 2769, 104, 18, NULL, 291.00, 107, 83, 66, 38.65, 744.00, false);
INSERT INTO public.factheartattackrisk VALUES (356, 2563, 103, 16, NULL, 318.00, 137, 72, 43, 19.60, 733.00, true);
INSERT INTO public.factheartattackrisk VALUES (357, 2959, 112, 18, NULL, 399.00, 111, 109, 63, 27.35, 623.00, false);
INSERT INTO public.factheartattackrisk VALUES (358, 2657, 105, 17, NULL, 185.00, 114, 80, 68, 19.74, 522.00, false);
INSERT INTO public.factheartattackrisk VALUES (359, 2721, 116, 17, NULL, 183.00, 160, 61, 86, 26.22, 376.00, false);
INSERT INTO public.factheartattackrisk VALUES (360, 2947, 105, 17, NULL, 151.00, 169, 60, 43, 32.08, 730.00, false);
INSERT INTO public.factheartattackrisk VALUES (361, 2705, 110, 18, NULL, 300.00, 111, 76, 95, 28.28, 410.00, false);
INSERT INTO public.factheartattackrisk VALUES (362, 2963, 114, 18, NULL, 358.00, 151, 69, 53, 31.38, 463.00, true);
INSERT INTO public.factheartattackrisk VALUES (363, 2793, 116, 17, NULL, 165.00, 146, 84, 109, 34.05, 97.00, false);
INSERT INTO public.factheartattackrisk VALUES (364, 2626, 102, 18, NULL, 126.00, 139, 99, 61, 21.29, 99.00, true);
INSERT INTO public.factheartattackrisk VALUES (365, 2541, 111, 16, NULL, 203.00, 162, 79, 71, 21.21, 464.00, false);
INSERT INTO public.factheartattackrisk VALUES (366, 2784, 116, 17, NULL, 275.00, 95, 74, 102, 36.55, 593.00, false);
INSERT INTO public.factheartattackrisk VALUES (367, 2988, 115, 17, NULL, 343.00, 148, 87, 46, 39.16, 719.00, true);
INSERT INTO public.factheartattackrisk VALUES (368, 2847, 112, 18, NULL, 366.00, 114, 88, 107, 18.34, 549.00, false);
INSERT INTO public.factheartattackrisk VALUES (369, 2872, 118, 16, NULL, 317.00, 117, 64, 45, 25.22, 47.00, true);
INSERT INTO public.factheartattackrisk VALUES (370, 2820, 102, 16, NULL, 135.00, 90, 103, 70, 21.98, 148.00, true);
INSERT INTO public.factheartattackrisk VALUES (371, 2743, 114, 17, NULL, 386.00, 159, 87, 57, 34.52, 302.00, false);
INSERT INTO public.factheartattackrisk VALUES (372, 2556, 115, 18, NULL, 259.00, 114, 60, 98, 33.75, 57.00, false);
INSERT INTO public.factheartattackrisk VALUES (373, 2913, 109, 18, NULL, 158.00, 147, 91, 77, 30.62, 280.00, false);
INSERT INTO public.factheartattackrisk VALUES (374, 2838, 101, 18, NULL, 157.00, 178, 106, 42, 24.39, 389.00, false);
INSERT INTO public.factheartattackrisk VALUES (375, 2992, 119, 18, NULL, 326.00, 99, 83, 89, 35.44, 180.00, true);
INSERT INTO public.factheartattackrisk VALUES (376, 2891, 109, 16, NULL, 120.00, 139, 106, 102, 28.92, 717.00, false);
INSERT INTO public.factheartattackrisk VALUES (377, 2577, 111, 18, NULL, 206.00, 165, 103, 45, 36.42, 239.00, false);
INSERT INTO public.factheartattackrisk VALUES (378, 2867, 110, 18, NULL, 242.00, 178, 104, 47, 34.09, 629.00, true);
INSERT INTO public.factheartattackrisk VALUES (379, 2812, 119, 16, NULL, 151.00, 162, 66, 83, 34.17, 294.00, false);
INSERT INTO public.factheartattackrisk VALUES (380, 2719, 115, 18, NULL, 370.00, 162, 73, 61, 24.62, 186.00, false);
INSERT INTO public.factheartattackrisk VALUES (381, 2897, 102, 17, NULL, 241.00, 161, 79, 66, 35.69, 700.00, true);
INSERT INTO public.factheartattackrisk VALUES (382, 2619, 111, 16, NULL, 311.00, 148, 82, 62, 21.04, 592.00, false);
INSERT INTO public.factheartattackrisk VALUES (383, 2841, 113, 17, NULL, 365.00, 155, 65, 110, 33.78, 774.00, true);
INSERT INTO public.factheartattackrisk VALUES (384, 2553, 102, 18, NULL, 155.00, 171, 67, 41, 23.39, 181.00, false);
INSERT INTO public.factheartattackrisk VALUES (385, 2550, 119, 18, NULL, 237.00, 162, 101, 58, 29.91, 471.00, false);
INSERT INTO public.factheartattackrisk VALUES (386, 2873, 117, 17, NULL, 195.00, 160, 107, 78, 28.05, 375.00, true);
INSERT INTO public.factheartattackrisk VALUES (387, 2673, 111, 18, NULL, 284.00, 158, 92, 110, 22.33, 388.00, true);
INSERT INTO public.factheartattackrisk VALUES (388, 2926, 119, 18, NULL, 354.00, 139, 69, 74, 35.17, 155.00, true);
INSERT INTO public.factheartattackrisk VALUES (389, 2914, 111, 16, NULL, 257.00, 167, 74, 54, 30.25, 467.00, false);
INSERT INTO public.factheartattackrisk VALUES (390, 2781, 101, 18, NULL, 376.00, 101, 67, 87, 35.27, 603.00, true);
INSERT INTO public.factheartattackrisk VALUES (391, 2807, 114, 17, NULL, 399.00, 112, 109, 98, 24.89, 616.00, false);
INSERT INTO public.factheartattackrisk VALUES (392, 3005, 116, 16, NULL, 348.00, 165, 91, 104, 19.60, 331.00, false);
INSERT INTO public.factheartattackrisk VALUES (393, 3012, 104, 18, NULL, 347.00, 97, 78, 83, 22.45, 521.00, false);
INSERT INTO public.factheartattackrisk VALUES (394, 2680, 101, 16, NULL, 321.00, 141, 104, 93, 22.93, 380.00, true);
INSERT INTO public.factheartattackrisk VALUES (395, 2582, 113, 17, NULL, 159.00, 103, 72, 70, 36.99, 778.00, true);
INSERT INTO public.factheartattackrisk VALUES (396, 2908, 108, 17, NULL, 321.00, 132, 103, 41, 38.21, 495.00, false);
INSERT INTO public.factheartattackrisk VALUES (397, 2544, 108, 17, NULL, 175.00, 141, 78, 49, 20.33, 267.00, true);
INSERT INTO public.factheartattackrisk VALUES (398, 2840, 115, 16, NULL, 316.00, 146, 90, 51, 24.10, 698.00, true);
INSERT INTO public.factheartattackrisk VALUES (399, 2895, 109, 17, NULL, 138.00, 177, 66, 90, 23.26, 318.00, false);
INSERT INTO public.factheartattackrisk VALUES (400, 2887, 113, 17, NULL, 230.00, 120, 84, 49, 21.79, 410.00, false);
INSERT INTO public.factheartattackrisk VALUES (401, 2831, 101, 16, NULL, 356.00, 119, 72, 67, 28.68, 207.00, true);
INSERT INTO public.factheartattackrisk VALUES (402, 3022, 113, 18, NULL, 124.00, 101, 87, 105, 20.51, 780.00, false);
INSERT INTO public.factheartattackrisk VALUES (403, 3041, 120, 18, NULL, 308.00, 140, 80, 105, 25.42, 579.00, false);
INSERT INTO public.factheartattackrisk VALUES (404, 2741, 107, 17, NULL, 252.00, 157, 101, 44, 27.22, 51.00, false);
INSERT INTO public.factheartattackrisk VALUES (405, 2762, 116, 17, NULL, 213.00, 91, 61, 110, 34.48, 84.00, false);
INSERT INTO public.factheartattackrisk VALUES (406, 2655, 116, 16, NULL, 261.00, 121, 73, 103, 32.91, 675.00, false);
INSERT INTO public.factheartattackrisk VALUES (407, 3045, 115, 18, NULL, 190.00, 172, 80, 98, 18.63, 735.00, false);
INSERT INTO public.factheartattackrisk VALUES (408, 2929, 114, 17, NULL, 392.00, 131, 67, 71, 30.68, 425.00, true);
INSERT INTO public.factheartattackrisk VALUES (409, 2944, 101, 17, NULL, 298.00, 125, 64, 104, 18.76, 310.00, false);
INSERT INTO public.factheartattackrisk VALUES (410, 2604, 104, 18, NULL, 170.00, 100, 104, 81, 18.51, 126.00, false);
INSERT INTO public.factheartattackrisk VALUES (411, 2993, 109, 18, NULL, 373.00, 101, 106, 48, 36.68, 56.00, true);
INSERT INTO public.factheartattackrisk VALUES (412, 2849, 105, 18, NULL, 244.00, 140, 89, 43, 32.58, 394.00, false);
INSERT INTO public.factheartattackrisk VALUES (413, 2732, 119, 18, NULL, 269.00, 108, 104, 84, 35.09, 472.00, false);
INSERT INTO public.factheartattackrisk VALUES (414, 2775, 116, 17, NULL, 377.00, 98, 96, 100, 37.06, 669.00, true);
INSERT INTO public.factheartattackrisk VALUES (415, 2586, 117, 18, NULL, 202.00, 133, 64, 43, 34.70, 688.00, true);
INSERT INTO public.factheartattackrisk VALUES (416, 2684, 114, 18, NULL, 203.00, 116, 82, 108, 23.93, 655.00, false);
INSERT INTO public.factheartattackrisk VALUES (417, 2871, 119, 16, NULL, 370.00, 168, 69, 110, 24.96, 39.00, true);
INSERT INTO public.factheartattackrisk VALUES (418, 2877, 106, 18, NULL, 296.00, 177, 87, 79, 27.22, 333.00, false);
INSERT INTO public.factheartattackrisk VALUES (419, 2666, 114, 18, NULL, 202.00, 153, 81, 65, 38.94, 501.00, false);
INSERT INTO public.factheartattackrisk VALUES (420, 2889, 108, 18, NULL, 153.00, 103, 96, 55, 24.68, 232.00, false);
INSERT INTO public.factheartattackrisk VALUES (421, 2683, 101, 16, NULL, 394.00, 114, 62, 95, 26.02, 479.00, true);
INSERT INTO public.factheartattackrisk VALUES (422, 3019, 112, 16, NULL, 359.00, 95, 64, 63, 36.06, 211.00, true);
INSERT INTO public.factheartattackrisk VALUES (423, 2898, 107, 18, NULL, 129.00, 99, 60, 100, 23.74, 197.00, false);
INSERT INTO public.factheartattackrisk VALUES (424, 2735, 103, 17, NULL, 212.00, 169, 67, 66, 28.79, 540.00, false);
INSERT INTO public.factheartattackrisk VALUES (425, 2941, 103, 17, NULL, 267.00, 92, 107, 64, 38.32, 433.00, false);
INSERT INTO public.factheartattackrisk VALUES (426, 2592, 114, 17, NULL, 397.00, 175, 67, 64, 34.89, 179.00, false);
INSERT INTO public.factheartattackrisk VALUES (427, 2856, 112, 16, NULL, 352.00, 131, 67, 43, 32.51, 223.00, false);
INSERT INTO public.factheartattackrisk VALUES (428, 2668, 108, 17, NULL, 291.00, 123, 106, 88, 27.70, 551.00, true);
INSERT INTO public.factheartattackrisk VALUES (429, 2907, 112, 17, NULL, 368.00, 171, 75, 95, 26.12, 490.00, false);
INSERT INTO public.factheartattackrisk VALUES (430, 3039, 117, 17, NULL, 129.00, 92, 108, 81, 31.77, 204.00, false);
INSERT INTO public.factheartattackrisk VALUES (431, 2599, 117, 17, NULL, 229.00, 162, 75, 57, 33.74, 795.00, false);
INSERT INTO public.factheartattackrisk VALUES (432, 2783, 113, 18, NULL, 310.00, 163, 96, 66, 32.04, 267.00, false);
INSERT INTO public.factheartattackrisk VALUES (433, 2660, 107, 17, NULL, 360.00, 158, 60, 50, 32.64, 644.00, false);
INSERT INTO public.factheartattackrisk VALUES (434, 2979, 105, 16, NULL, 341.00, 118, 72, 84, 21.85, 525.00, false);
INSERT INTO public.factheartattackrisk VALUES (435, 2905, 118, 18, NULL, 253.00, 113, 108, 65, 34.64, 88.00, false);
INSERT INTO public.factheartattackrisk VALUES (436, 2685, 105, 18, NULL, 183.00, 177, 103, 93, 22.01, 255.00, false);
INSERT INTO public.factheartattackrisk VALUES (437, 2920, 105, 18, NULL, 319.00, 124, 81, 45, 28.04, 244.00, false);
INSERT INTO public.factheartattackrisk VALUES (438, 2874, 113, 17, NULL, 259.00, 104, 108, 108, 27.36, 546.00, false);
INSERT INTO public.factheartattackrisk VALUES (439, 2816, 106, 17, NULL, 328.00, 147, 97, 77, 21.39, 486.00, false);
INSERT INTO public.factheartattackrisk VALUES (440, 2639, 102, 17, NULL, 276.00, 160, 69, 67, 29.10, 320.00, false);
INSERT INTO public.factheartattackrisk VALUES (441, 2903, 120, 16, NULL, 384.00, 175, 72, 65, 37.55, 319.00, false);
INSERT INTO public.factheartattackrisk VALUES (442, 2708, 104, 18, NULL, 253.00, 159, 82, 40, 21.25, 58.00, false);
INSERT INTO public.factheartattackrisk VALUES (443, 2760, 118, 18, NULL, 296.00, 163, 98, 78, 29.33, 591.00, false);
INSERT INTO public.factheartattackrisk VALUES (444, 2702, 107, 18, NULL, 201.00, 108, 104, 70, 21.36, 165.00, false);
INSERT INTO public.factheartattackrisk VALUES (445, 2571, 105, 16, NULL, 145.00, 179, 81, 47, 36.34, 732.00, false);
INSERT INTO public.factheartattackrisk VALUES (446, 2716, 116, 17, NULL, 303.00, 152, 75, 109, 28.04, 195.00, true);
INSERT INTO public.factheartattackrisk VALUES (447, 2770, 117, 17, NULL, 314.00, 138, 82, 102, 36.70, 478.00, false);
INSERT INTO public.factheartattackrisk VALUES (448, 2844, 105, 16, NULL, 180.00, 101, 64, 68, 32.28, 461.00, false);
INSERT INTO public.factheartattackrisk VALUES (449, 2795, 113, 17, NULL, 190.00, 115, 100, 85, 18.00, 458.00, false);
INSERT INTO public.factheartattackrisk VALUES (450, 2750, 110, 18, NULL, 250.00, 108, 103, 97, 21.09, 631.00, false);
INSERT INTO public.factheartattackrisk VALUES (451, 2643, 112, 16, NULL, 209.00, 140, 88, 76, 24.79, 717.00, true);
INSERT INTO public.factheartattackrisk VALUES (452, 2754, 106, 17, NULL, 194.00, 164, 96, 110, 36.03, 741.00, false);
INSERT INTO public.factheartattackrisk VALUES (453, 2593, 115, 17, NULL, 294.00, 175, 104, 45, 29.07, 301.00, true);
INSERT INTO public.factheartattackrisk VALUES (454, 2798, 101, 18, NULL, 265.00, 111, 108, 60, 19.54, 574.00, true);
INSERT INTO public.factheartattackrisk VALUES (455, 2886, 111, 18, NULL, 148.00, 160, 98, 93, 37.85, 50.00, false);
INSERT INTO public.factheartattackrisk VALUES (456, 2583, 108, 18, NULL, 166.00, 152, 107, 46, 33.15, 315.00, false);
INSERT INTO public.factheartattackrisk VALUES (457, 3036, 118, 16, NULL, 204.00, 142, 63, 54, 31.35, 314.00, false);
INSERT INTO public.factheartattackrisk VALUES (458, 2858, 112, 17, NULL, 159.00, 158, 67, 58, 22.57, 194.00, true);
INSERT INTO public.factheartattackrisk VALUES (459, 2645, 112, 17, NULL, 200.00, 96, 96, 91, 28.95, 292.00, true);
INSERT INTO public.factheartattackrisk VALUES (460, 2659, 116, 18, NULL, 127.00, 122, 89, 78, 27.53, 555.00, false);
INSERT INTO public.factheartattackrisk VALUES (461, 2881, 120, 16, NULL, 201.00, 145, 63, 79, 20.79, 286.00, false);
INSERT INTO public.factheartattackrisk VALUES (462, 2725, 102, 18, NULL, 344.00, 143, 108, 79, 36.98, 199.00, true);
INSERT INTO public.factheartattackrisk VALUES (463, 3018, 108, 18, NULL, 290.00, 131, 91, 66, 23.64, 160.00, false);
INSERT INTO public.factheartattackrisk VALUES (464, 2948, 105, 17, NULL, 205.00, 132, 103, 76, 30.94, 149.00, false);
INSERT INTO public.factheartattackrisk VALUES (465, 2712, 112, 18, NULL, 295.00, 140, 82, 91, 29.63, 527.00, false);
INSERT INTO public.factheartattackrisk VALUES (466, 2791, 103, 17, NULL, 161.00, 134, 100, 102, 22.09, 115.00, false);
INSERT INTO public.factheartattackrisk VALUES (467, 2966, 109, 17, NULL, 280.00, 129, 94, 105, 24.33, 406.00, true);
INSERT INTO public.factheartattackrisk VALUES (468, 2801, 111, 17, NULL, 269.00, 138, 79, 65, 20.38, 161.00, false);
INSERT INTO public.factheartattackrisk VALUES (469, 2768, 103, 16, NULL, 185.00, 167, 108, 47, 24.87, 125.00, false);
INSERT INTO public.factheartattackrisk VALUES (470, 2906, 108, 18, NULL, 295.00, 117, 89, 52, 36.59, 200.00, true);
INSERT INTO public.factheartattackrisk VALUES (471, 3002, 120, 17, NULL, 243.00, 93, 108, 100, 31.38, 277.00, false);
INSERT INTO public.factheartattackrisk VALUES (472, 2982, 113, 18, NULL, 140.00, 131, 101, 58, 22.13, 308.00, false);
INSERT INTO public.factheartattackrisk VALUES (473, 2728, 112, 18, NULL, 132.00, 142, 107, 51, 35.01, 784.00, false);
INSERT INTO public.factheartattackrisk VALUES (474, 2610, 114, 16, NULL, 335.00, 112, 75, 43, 35.75, 51.00, false);
INSERT INTO public.factheartattackrisk VALUES (475, 3010, 102, 16, NULL, 132.00, 128, 92, 60, 26.41, 69.00, false);
INSERT INTO public.factheartattackrisk VALUES (476, 2940, 105, 18, NULL, 374.00, 117, 98, 83, 20.96, 286.00, true);
INSERT INTO public.factheartattackrisk VALUES (477, 2695, 117, 16, NULL, 356.00, 156, 103, 54, 37.41, 427.00, false);
INSERT INTO public.factheartattackrisk VALUES (478, 2943, 116, 18, NULL, 301.00, 96, 66, 101, 38.03, 779.00, false);
INSERT INTO public.factheartattackrisk VALUES (479, 2617, 114, 18, NULL, 126.00, 104, 102, 59, 39.29, 236.00, false);
INSERT INTO public.factheartattackrisk VALUES (480, 2746, 101, 16, NULL, 193.00, 145, 96, 89, 24.58, 202.00, false);
INSERT INTO public.factheartattackrisk VALUES (481, 2552, 103, 17, NULL, 319.00, 94, 62, 85, 36.77, 77.00, true);
INSERT INTO public.factheartattackrisk VALUES (482, 2713, 119, 18, NULL, 277.00, 176, 97, 63, 28.44, 500.00, false);
INSERT INTO public.factheartattackrisk VALUES (483, 2559, 110, 18, NULL, 198.00, 112, 71, 57, 23.36, 601.00, false);
INSERT INTO public.factheartattackrisk VALUES (484, 2715, 102, 16, NULL, 213.00, 153, 83, 50, 30.84, 255.00, false);
INSERT INTO public.factheartattackrisk VALUES (485, 2932, 110, 17, NULL, 267.00, 94, 86, 100, 23.68, 269.00, true);
INSERT INTO public.factheartattackrisk VALUES (486, 2647, 112, 16, NULL, 335.00, 136, 83, 95, 33.11, 425.00, false);
INSERT INTO public.factheartattackrisk VALUES (487, 2633, 101, 16, NULL, 213.00, 125, 78, 44, 23.16, 191.00, false);
INSERT INTO public.factheartattackrisk VALUES (488, 2652, 119, 16, NULL, 308.00, 105, 96, 105, 21.90, 479.00, true);
INSERT INTO public.factheartattackrisk VALUES (489, 2724, 108, 16, NULL, 196.00, 168, 105, 48, 26.16, 79.00, false);
INSERT INTO public.factheartattackrisk VALUES (490, 2912, 110, 17, NULL, 206.00, 142, 93, 80, 36.71, 231.00, false);
INSERT INTO public.factheartattackrisk VALUES (491, 2832, 116, 16, NULL, 322.00, 157, 62, 66, 25.26, 168.00, true);
INSERT INTO public.factheartattackrisk VALUES (492, 2853, 119, 17, NULL, 291.00, 141, 102, 75, 24.36, 709.00, true);
INSERT INTO public.factheartattackrisk VALUES (493, 3028, 115, 17, NULL, 179.00, 161, 63, 67, 32.10, 398.00, true);
INSERT INTO public.factheartattackrisk VALUES (494, 3017, 113, 17, NULL, 380.00, 176, 77, 72, 29.24, 575.00, false);
INSERT INTO public.factheartattackrisk VALUES (495, 2934, 108, 17, NULL, 128.00, 162, 91, 40, 27.39, 319.00, true);
INSERT INTO public.factheartattackrisk VALUES (496, 2842, 107, 17, NULL, 266.00, 167, 103, 102, 24.22, 606.00, false);
INSERT INTO public.factheartattackrisk VALUES (497, 2740, 120, 18, NULL, 346.00, 101, 84, 45, 37.68, 355.00, false);
INSERT INTO public.factheartattackrisk VALUES (498, 2997, 101, 17, NULL, 199.00, 116, 80, 85, 25.51, 55.00, false);
INSERT INTO public.factheartattackrisk VALUES (499, 2573, 110, 17, NULL, 399.00, 141, 85, 99, 35.76, 636.00, false);
INSERT INTO public.factheartattackrisk VALUES (500, 3013, 104, 17, NULL, 143.00, 151, 60, 42, 37.18, 64.00, false);
INSERT INTO public.factheartattackrisk VALUES (501, 2558, 119, 17, NULL, 312.00, 121, 95, 95, 23.19, 780.00, false);
INSERT INTO public.factheartattackrisk VALUES (502, 3035, 109, 18, NULL, 288.00, 90, 72, 99, 32.00, 575.00, true);
INSERT INTO public.factheartattackrisk VALUES (503, 2978, 115, 16, NULL, 395.00, 99, 94, 81, 26.95, 515.00, false);
INSERT INTO public.factheartattackrisk VALUES (504, 2669, 106, 17, NULL, 149.00, 143, 67, 104, 24.20, 97.00, false);
INSERT INTO public.factheartattackrisk VALUES (505, 2606, 112, 17, NULL, 273.00, 171, 70, 90, 30.51, 251.00, false);
INSERT INTO public.factheartattackrisk VALUES (506, 2589, 101, 16, NULL, 163.00, 178, 105, 74, 39.32, 245.00, false);
INSERT INTO public.factheartattackrisk VALUES (507, 2790, 101, 17, NULL, 247.00, 139, 100, 74, 33.19, 228.00, true);
INSERT INTO public.factheartattackrisk VALUES (508, 2917, 102, 17, NULL, 337.00, 170, 89, 104, 18.52, 719.00, true);


--
-- Data for Name: staging_table; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.staging_table VALUES ('BMW7812', 67, 'Male', 208, '158/88', 72, 0, 0, 1, 0, 0, 4.17, 'Average', 0, 0, 9, 6.62, 261404, 31.25, 286, 0, 6.00, 'Argentina', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('CZE1114', 21, 'Male', 389, '165/93', 98, 1, 1, 1, 1, 1, 1.81, 'Unhealthy', 1, 0, 1, 4.96, 285768, 27.19, 235, 1, 7.00, 'Canada', 'North America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('BNI9906', 21, 'Female', 324, '174/99', 72, 1, 0, 0, 0, 0, 2.08, 'Healthy', 1, 1, 9, 9.46, 235282, 28.18, 587, 4, 4.00, 'France', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('JLN3497', 84, 'Male', 383, '163/100', 73, 1, 1, 1, 0, 1, 9.83, 'Average', 1, 0, 9, 7.65, 125640, 36.46, 378, 3, 4.00, 'Canada', 'North America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('GFO8847', 66, 'Male', 318, '91/88', 93, 1, 1, 1, 1, 0, 5.80, 'Unhealthy', 1, 0, 6, 1.51, 160555, 21.81, 231, 1, 5.00, 'Thailand', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('ZOO7941', 54, 'Female', 297, '172/86', 48, 1, 1, 1, 0, 1, 0.63, 'Unhealthy', 1, 1, 2, 7.80, 241339, 20.15, 795, 5, 10.00, 'Germany', 'Europe', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('WYV0966', 90, 'Male', 358, '102/73', 84, 0, 0, 1, 0, 1, 4.10, 'Healthy', 0, 0, 7, 0.63, 190450, 28.89, 284, 4, 10.00, 'Canada', 'North America', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('XXM0972', 84, 'Male', 220, '131/68', 107, 0, 0, 1, 1, 1, 3.43, 'Average', 0, 1, 4, 10.54, 122093, 22.22, 370, 6, 7.00, 'Japan', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('XCQ5937', 20, 'Male', 145, '144/105', 68, 1, 0, 1, 1, 0, 16.87, 'Average', 0, 0, 5, 11.35, 25086, 35.81, 790, 7, 4.00, 'Brazil', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('FTJ5456', 43, 'Female', 248, '160/70', 55, 0, 1, 1, 1, 1, 0.19, 'Unhealthy', 0, 0, 4, 4.06, 209703, 22.56, 232, 7, 7.00, 'Japan', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('HSD6283', 73, 'Female', 373, '107/69', 97, 1, 1, 1, 0, 1, 16.84, 'Average', 1, 1, 8, 8.92, 50030, 22.87, 469, 0, 4.00, 'South Africa', 'Africa', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('YSP0073', 71, 'Male', 374, '158/71', 70, 1, 1, 1, 1, 1, 8.25, 'Average', 0, 0, 4, 7.23, 163066, 32.49, 523, 4, 8.00, 'United States', 'North America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('FPS0415', 77, 'Male', 228, '101/72', 68, 1, 1, 1, 1, 1, 19.63, 'Unhealthy', 0, 0, 9, 10.92, 29886, 35.10, 590, 7, 6.00, 'Vietnam', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('YYU9565', 60, 'Male', 259, '169/72', 85, 1, 1, 1, 0, 1, 17.04, 'Healthy', 1, 1, 1, 8.73, 292173, 25.56, 506, 1, 4.00, 'China', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('VTW9069', 88, 'Male', 297, '112/81', 102, 1, 1, 1, 0, 1, 15.39, 'Unhealthy', 0, 1, 2, 10.43, 165300, 25.49, 635, 3, 6.00, 'China', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('DCY3282', 73, 'Male', 122, '114/88', 97, 1, 1, 1, 0, 1, 14.56, 'Average', 0, 0, 5, 10.09, 265839, 36.52, 773, 5, 8.00, 'Italy', 'Europe', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('DXB2434', 69, 'Male', 379, '173/75', 40, 1, 1, 1, 1, 1, 4.18, 'Average', 1, 0, 5, 9.06, 267997, 28.33, 68, 3, 6.00, 'Brazil', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('COP0566', 38, 'Male', 166, '120/74', 56, 1, 0, 1, 1, 0, 8.92, 'Healthy', 0, 1, 9, 3.66, 48376, 29.52, 402, 0, 6.00, 'Thailand', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('XBI0592', 50, 'Female', 303, '120/100', 104, 1, 0, 1, 0, 1, 4.94, 'Average', 1, 1, 1, 7.59, 21501, 25.96, 517, 1, 5.00, 'United States', 'North America', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('RQX1211', 60, 'Male', 145, '160/98', 71, 1, 0, 1, 0, 1, 1.89, 'Healthy', 1, 0, 8, 5.99, 234966, 29.16, 247, 7, 7.00, 'Canada', 'North America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('MBI0008', 66, 'Male', 340, '180/101', 69, 1, 0, 1, 1, 0, 9.11, 'Unhealthy', 1, 1, 1, 6.22, 156946, 38.09, 747, 1, 10.00, 'Canada', 'North America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('RVN4963', 45, 'Male', 294, '130/84', 66, 0, 0, 1, 1, 1, 13.69, 'Healthy', 0, 0, 9, 7.01, 216565, 25.12, 360, 4, 6.00, 'France', 'Europe', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('LBY7992', 50, 'Male', 359, '175/60', 97, 0, 1, 1, 0, 1, 8.35, 'Healthy', 1, 0, 2, 4.05, 278301, 34.65, 358, 4, 8.00, 'Spain', 'Europe', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('RDI3071', 84, 'Male', 202, '173/109', 81, 1, 1, 1, 0, 1, 11.00, 'Unhealthy', 1, 0, 7, 7.12, 95237, 29.63, 526, 0, 9.00, 'Brazil', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('NCU1956', 36, 'Male', 133, '161/90', 97, 1, 0, 1, 1, 1, 3.62, 'Healthy', 1, 0, 10, 10.96, 223132, 22.39, 605, 5, 10.00, 'Canada', 'North America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('MSW4208', 90, 'Male', 159, '140/95', 52, 0, 0, 1, 0, 1, 10.71, 'Healthy', 0, 1, 2, 1.22, 110213, 26.07, 667, 4, 5.00, 'Spain', 'Europe', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('TTO9115', 48, 'Male', 271, '148/105', 105, 0, 1, 1, 0, 1, 13.59, 'Unhealthy', 1, 0, 4, 8.48, 139560, 21.58, 316, 3, 8.00, 'Thailand', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('JDP9221', 40, 'Male', 273, '160/76', 96, 0, 0, 1, 1, 1, 17.63, 'Average', 1, 1, 4, 4.55, 178241, 26.42, 551, 4, 6.00, 'France', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('FFF6730', 79, 'Female', 328, '113/78', 74, 0, 0, 1, 0, 1, 16.90, 'Unhealthy', 0, 0, 1, 5.21, 98663, 31.63, 482, 4, 6.00, 'China', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('DWN2141', 63, 'Male', 154, '99/81', 102, 1, 0, 1, 1, 0, 7.95, 'Unhealthy', 1, 1, 1, 7.27, 247960, 39.27, 718, 4, 10.00, 'India', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('SLE3369', 27, 'Female', 135, '120/77', 49, 1, 1, 0, 0, 1, 16.91, 'Healthy', 0, 0, 6, 9.12, 71276, 22.78, 297, 1, 10.00, 'Argentina', 'South America', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('NXO4034', 25, 'Male', 197, '178/72', 45, 0, 1, 1, 0, 1, 18.85, 'Unhealthy', 1, 1, 1, 1.42, 59634, 18.52, 661, 0, 6.00, 'Spain', 'Europe', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('ENK3334', 27, 'Male', 321, '111/91', 50, 1, 0, 1, 1, 0, 0.76, 'Unhealthy', 1, 1, 2, 3.38, 53345, 34.20, 558, 7, 8.00, 'Nigeria', 'Africa', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('XRL5497', 86, 'Male', 375, '99/85', 46, 1, 1, 1, 0, 0, 3.47, 'Healthy', 0, 1, 3, 1.87, 163789, 18.79, 209, 6, 10.00, 'France', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('DDG3686', 42, 'Male', 360, '103/107', 44, 1, 0, 1, 1, 1, 8.50, 'Healthy', 0, 0, 5, 9.58, 94144, 29.70, 586, 1, 4.00, 'India', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('FLG2019', 52, 'Female', 360, '94/60', 106, 1, 0, 1, 1, 0, 11.31, 'Unhealthy', 0, 0, 3, 7.70, 135099, 27.10, 743, 4, 5.00, 'New Zealand', 'Australia', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('IUJ5442', 27, 'Female', 263, '127/109', 83, 0, 1, 0, 0, 0, 2.10, 'Unhealthy', 0, 0, 2, 9.36, 264135, 39.84, 411, 2, 9.00, 'Argentina', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('BSV5917', 29, 'Female', 201, '134/60', 86, 0, 0, 0, 1, 1, 3.97, 'Average', 1, 0, 6, 10.97, 138186, 33.79, 785, 0, 10.00, 'Argentina', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('SCZ5893', 67, 'Male', 347, '115/92', 65, 1, 0, 1, 1, 1, 13.87, 'Healthy', 1, 0, 1, 1.25, 37324, 38.72, 790, 1, 10.00, 'India', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('GNK9443', 29, 'Male', 129, '124/93', 86, 0, 1, 1, 1, 1, 12.11, 'Unhealthy', 1, 1, 3, 3.64, 123956, 32.17, 697, 4, 6.00, 'Canada', 'North America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('UYU5044', 30, 'Female', 135, '104/96', 101, 0, 0, 0, 0, 1, 5.73, 'Unhealthy', 1, 1, 8, 9.75, 139504, 27.47, 519, 1, 5.00, 'New Zealand', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('TTM1692', 47, 'Male', 229, '144/108', 65, 1, 0, 1, 1, 0, 5.37, 'Healthy', 1, 0, 6, 4.61, 278913, 35.25, 595, 0, 7.00, 'India', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('DUX2118', 86, 'Female', 251, '101/90', 96, 0, 1, 1, 0, 1, 7.49, 'Unhealthy', 1, 1, 3, 11.04, 202033, 21.81, 452, 5, 4.00, 'Canada', 'North America', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('SQE3213', 44, 'Male', 121, '115/109', 51, 1, 0, 1, 1, 1, 16.66, 'Healthy', 0, 0, 7, 5.26, 59122, 27.09, 158, 4, 10.00, 'United States', 'North America', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('XBP3543', 50, 'Male', 190, '149/73', 43, 1, 1, 1, 0, 0, 0.62, 'Unhealthy', 0, 0, 5, 0.87, 119607, 25.77, 679, 7, 9.00, 'France', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('ENZ9640', 33, 'Male', 185, '120/63', 79, 0, 1, 1, 1, 0, 16.16, 'Healthy', 0, 1, 7, 11.08, 239725, 37.21, 675, 6, 4.00, 'Italy', 'Europe', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('QWD3129', 51, 'Male', 197, '106/106', 79, 1, 1, 1, 1, 0, 14.12, 'Unhealthy', 0, 0, 3, 1.54, 257061, 24.67, 785, 1, 5.00, 'Argentina', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('UBJ2564', 70, 'Female', 279, '102/76', 86, 0, 0, 1, 1, 1, 2.59, 'Healthy', 1, 1, 6, 1.09, 191558, 29.97, 792, 4, 6.00, 'Japan', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('RRG8947', 85, 'Male', 336, '114/92', 73, 1, 1, 1, 0, 1, 17.75, 'Average', 0, 1, 1, 10.38, 204162, 25.58, 584, 7, 10.00, 'South Korea', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('DRT6328', 31, 'Female', 192, '124/93', 90, 1, 0, 0, 0, 1, 3.60, 'Unhealthy', 1, 0, 1, 10.38, 30816, 30.15, 366, 5, 10.00, 'Vietnam', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('BFE4900', 56, 'Male', 180, '173/108', 94, 1, 1, 1, 1, 1, 7.27, 'Unhealthy', 1, 0, 7, 5.86, 295082, 18.29, 741, 6, 7.00, 'New Zealand', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('KCY9500', 36, 'Male', 203, '173/109', 101, 1, 1, 1, 0, 0, 14.21, 'Average', 1, 0, 8, 10.86, 102220, 28.01, 523, 2, 6.00, 'Germany', 'Europe', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('JJX0859', 70, 'Male', 368, '168/91', 78, 0, 0, 1, 0, 0, 2.16, 'Healthy', 1, 1, 10, 11.64, 225432, 29.76, 474, 5, 10.00, 'Italy', 'Europe', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('IKY4481', 67, 'Male', 222, '159/79', 105, 1, 1, 1, 1, 0, 0.52, 'Average', 1, 1, 1, 0.86, 286299, 37.26, 92, 0, 8.00, 'Australia', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('YOD3294', 31, 'Male', 243, '100/80', 92, 1, 1, 1, 1, 1, 2.40, 'Unhealthy', 0, 1, 2, 7.25, 269959, 30.99, 410, 7, 9.00, 'United States', 'North America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('OHD3889', 24, 'Male', 218, '118/76', 68, 0, 1, 1, 1, 1, 6.32, 'Average', 0, 1, 10, 10.90, 226086, 27.18, 398, 3, 8.00, 'Australia', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('BDG2694', 54, 'Female', 120, '103/83', 54, 1, 1, 1, 0, 0, 15.04, 'Unhealthy', 1, 0, 8, 9.77, 50984, 18.78, 493, 0, 5.00, 'China', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('LTU0801', 70, 'Female', 279, '152/90', 52, 1, 1, 1, 1, 1, 9.66, 'Average', 0, 1, 3, 0.41, 242491, 39.00, 614, 3, 10.00, 'Vietnam', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('OFU9592', 74, 'Male', 285, '151/85', 109, 1, 1, 1, 0, 1, 5.58, 'Unhealthy', 0, 1, 1, 10.87, 35855, 39.78, 682, 6, 10.00, 'Nigeria', 'Africa', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('WAR7163', 72, 'Male', 377, '144/98', 61, 1, 1, 1, 1, 0, 17.44, 'Unhealthy', 1, 1, 9, 3.48, 249614, 28.51, 106, 1, 10.00, 'Japan', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('TFH5628', 55, 'Male', 369, '109/95', 64, 1, 0, 1, 0, 0, 1.40, 'Unhealthy', 1, 0, 3, 4.64, 75517, 23.40, 216, 5, 10.00, 'Argentina', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('BBJ3290', 42, 'Male', 311, '92/61', 82, 1, 0, 1, 0, 1, 1.77, 'Average', 0, 0, 8, 4.62, 133766, 32.16, 408, 1, 7.00, 'South Korea', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('YTR1728', 90, 'Female', 139, '179/93', 85, 0, 1, 1, 1, 1, 1.71, 'Average', 1, 0, 6, 6.26, 73167, 28.28, 628, 7, 9.00, 'South Africa', 'Africa', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('AYY8711', 26, 'Male', 266, '120/69', 46, 1, 0, 1, 0, 1, 18.19, 'Unhealthy', 0, 0, 3, 5.63, 57948, 32.33, 481, 7, 5.00, 'Germany', 'Europe', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('TQT8266', 53, 'Male', 133, '161/108', 110, 1, 1, 1, 1, 0, 4.87, 'Average', 1, 0, 8, 2.09, 182477, 27.68, 67, 4, 9.00, 'Canada', 'North America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('KTR4778', 63, 'Male', 153, '131/76', 86, 1, 1, 1, 1, 1, 18.60, 'Average', 0, 0, 4, 11.66, 262933, 19.68, 82, 0, 4.00, 'Brazil', 'South America', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('GVI1884', 46, 'Male', 120, '107/65', 50, 1, 0, 1, 1, 1, 4.95, 'Average', 0, 0, 6, 6.57, 193855, 36.49, 305, 1, 10.00, 'Australia', 'Australia', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('SOM8522', 57, 'Female', 220, '132/109', 94, 1, 1, 1, 0, 0, 13.66, 'Average', 1, 1, 4, 11.12, 250419, 37.81, 164, 2, 5.00, 'China', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('NHX8643', 31, 'Female', 339, '131/97', 42, 1, 0, 0, 1, 0, 12.37, 'Healthy', 0, 0, 5, 6.76, 187864, 35.46, 211, 5, 6.00, 'Brazil', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('BNF7145', 74, 'Male', 329, '149/73', 96, 1, 0, 1, 1, 1, 14.09, 'Unhealthy', 1, 0, 1, 1.73, 258104, 37.68, 511, 0, 4.00, 'Germany', 'Europe', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('BOK4939', 63, 'Female', 203, '177/99', 55, 1, 0, 1, 0, 1, 17.33, 'Unhealthy', 0, 1, 2, 8.30, 52552, 30.87, 766, 1, 9.00, 'Canada', 'North America', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('DNY3115', 46, 'Male', 333, '130/94', 63, 1, 1, 1, 0, 0, 18.11, 'Unhealthy', 1, 1, 5, 11.04, 128868, 23.91, 547, 5, 10.00, 'Spain', 'Europe', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('SOH9843', 22, 'Male', 398, '174/93', 82, 1, 1, 1, 0, 0, 18.42, 'Average', 0, 1, 9, 5.20, 259754, 39.41, 327, 3, 6.00, 'Nigeria', 'Africa', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('ICO9779', 53, 'Female', 124, '110/105', 93, 0, 0, 1, 0, 0, 1.02, 'Unhealthy', 0, 1, 1, 1.79, 49893, 34.12, 367, 7, 10.00, 'Germany', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('GDC1817', 90, 'Male', 183, '116/98', 69, 1, 0, 1, 0, 0, 19.71, 'Average', 0, 1, 7, 4.92, 294623, 22.16, 681, 2, 8.00, 'Australia', 'Australia', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('DHP4080', 55, 'Male', 163, '139/107', 63, 0, 0, 1, 1, 0, 11.48, 'Healthy', 1, 1, 2, 9.35, 158030, 26.61, 131, 0, 7.00, 'Australia', 'Australia', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('RWL3584', 30, 'Female', 362, '164/76', 41, 0, 1, 0, 0, 0, 9.02, 'Average', 0, 1, 6, 2.47, 290740, 35.04, 42, 3, 5.00, 'South Korea', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('JPD8131', 73, 'Male', 390, '104/83', 48, 1, 0, 1, 0, 1, 14.82, 'Healthy', 0, 1, 2, 8.93, 254849, 18.95, 692, 4, 6.00, 'Brazil', 'South America', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('GMI1141', 67, 'Male', 192, '118/86', 100, 0, 0, 1, 0, 1, 19.81, 'Healthy', 1, 0, 4, 9.51, 252331, 23.21, 664, 0, 10.00, 'China', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('QJA1796', 35, 'Male', 200, '122/77', 110, 1, 0, 1, 1, 1, 14.63, 'Unhealthy', 0, 0, 6, 7.16, 214110, 30.76, 543, 7, 4.00, 'France', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('WMP6003', 45, 'Male', 396, '109/74', 76, 1, 1, 1, 1, 0, 17.89, 'Unhealthy', 1, 1, 3, 8.96, 266582, 38.94, 689, 3, 5.00, 'China', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('ADG8069', 39, 'Male', 255, '160/70', 81, 1, 0, 1, 1, 1, 14.14, 'Unhealthy', 1, 0, 9, 10.37, 105818, 33.09, 569, 0, 6.00, 'Japan', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('RHR1854', 53, 'Male', 209, '92/65', 98, 1, 0, 1, 0, 1, 12.10, 'Average', 0, 0, 2, 2.32, 213726, 31.85, 408, 7, 8.00, 'Australia', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('GDY0435', 90, 'Male', 247, '151/101', 101, 0, 1, 1, 0, 1, 14.20, 'Average', 1, 0, 5, 1.95, 290188, 38.59, 458, 7, 5.00, 'Colombia', 'South America', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('CQM6221', 69, 'Male', 250, '95/78', 75, 1, 1, 1, 1, 0, 7.30, 'Average', 0, 1, 8, 9.95, 57106, 19.54, 683, 3, 5.00, 'Nigeria', 'Africa', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('JDS3385', 30, 'Male', 227, '115/73', 40, 1, 1, 1, 0, 0, 15.32, 'Average', 1, 1, 6, 2.74, 169864, 20.81, 408, 3, 9.00, 'Colombia', 'South America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('HYS8827', 38, 'Female', 246, '148/94', 58, 1, 0, 0, 0, 0, 16.05, 'Unhealthy', 0, 0, 4, 2.80, 124280, 35.77, 779, 3, 7.00, 'United Kingdom', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('JXV3603', 56, 'Female', 223, '100/66', 68, 1, 0, 1, 0, 0, 19.62, 'Average', 0, 0, 9, 5.30, 97153, 33.04, 136, 2, 4.00, 'South Korea', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('OVT8107', 63, 'Male', 379, '163/110', 71, 1, 0, 1, 0, 1, 8.30, 'Average', 1, 0, 7, 9.15, 297069, 28.10, 643, 6, 5.00, 'Australia', 'Australia', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('UIW1798', 80, 'Male', 330, '122/80', 53, 0, 0, 1, 0, 1, 4.51, 'Unhealthy', 0, 0, 10, 9.77, 160046, 33.94, 653, 4, 7.00, 'Nigeria', 'Africa', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('XZD4751', 60, 'Male', 195, '118/91', 68, 1, 1, 1, 0, 1, 17.40, 'Average', 1, 1, 9, 11.31, 199652, 22.48, 55, 1, 5.00, 'South Korea', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('OKX6945', 69, 'Female', 222, '110/104', 60, 1, 0, 1, 1, 1, 2.06, 'Unhealthy', 0, 0, 6, 3.67, 27654, 19.14, 275, 7, 8.00, 'Italy', 'Europe', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('RKV2333', 77, 'Female', 194, '149/83', 77, 1, 0, 1, 0, 1, 0.73, 'Unhealthy', 1, 1, 2, 10.55, 290100, 38.91, 314, 6, 6.00, 'Vietnam', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('TLA1423', 65, 'Female', 178, '134/100', 48, 0, 1, 1, 0, 0, 0.84, 'Healthy', 1, 1, 4, 1.27, 25919, 21.33, 760, 3, 5.00, 'Argentina', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('NCU4581', 46, 'Female', 155, '116/85', 105, 1, 0, 1, 0, 1, 18.42, 'Unhealthy', 0, 0, 6, 0.10, 193248, 37.53, 404, 3, 5.00, 'Nigeria', 'Africa', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('XOA9385', 83, 'Male', 240, '165/79', 69, 1, 0, 1, 1, 1, 0.95, 'Healthy', 0, 1, 6, 6.52, 173171, 18.09, 587, 1, 8.00, 'New Zealand', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('SLJ3300', 27, 'Male', 237, '102/69', 65, 1, 1, 1, 1, 0, 3.76, 'Unhealthy', 1, 0, 10, 11.44, 96599, 32.19, 576, 7, 6.00, 'United Kingdom', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('ONL5969', 31, 'Female', 333, '168/107', 106, 1, 0, 0, 0, 0, 15.73, 'Healthy', 1, 0, 2, 4.66, 223499, 18.32, 690, 7, 4.00, 'Argentina', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('CFU1297', 82, 'Male', 216, '160/67', 109, 1, 1, 1, 1, 1, 15.58, 'Average', 0, 0, 6, 5.22, 217539, 20.81, 648, 1, 5.00, 'New Zealand', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('ATI9164', 28, 'Male', 276, '92/71', 65, 1, 0, 1, 1, 1, 13.12, 'Healthy', 1, 1, 7, 0.81, 171302, 34.56, 385, 1, 5.00, 'South Korea', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('HGB5652', 90, 'Male', 224, '164/65', 98, 1, 0, 1, 0, 1, 3.56, 'Average', 1, 0, 10, 9.62, 154900, 22.85, 255, 4, 5.00, 'Italy', 'Europe', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('SIQ8677', 39, 'Male', 326, '155/104', 47, 1, 0, 1, 0, 0, 12.82, 'Average', 1, 0, 1, 2.26, 171416, 22.55, 468, 2, 8.00, 'Argentina', 'South America', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('OGV4421', 40, 'Male', 198, '104/98', 59, 1, 1, 1, 0, 1, 15.13, 'Average', 1, 0, 5, 7.46, 129026, 22.08, 784, 1, 9.00, 'South Africa', 'Africa', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('LDS5768', 86, 'Male', 301, '159/76', 51, 1, 0, 1, 0, 0, 1.94, 'Average', 1, 1, 10, 2.20, 274242, 34.37, 509, 5, 9.00, 'Thailand', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('PLR8209', 56, 'Male', 314, '152/94', 51, 0, 1, 1, 0, 1, 11.59, 'Average', 0, 1, 3, 6.34, 67386, 35.59, 205, 2, 5.00, 'United Kingdom', 'Europe', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('YLL9363', 19, 'Male', 227, '108/78', 81, 1, 1, 1, 0, 1, 14.69, 'Unhealthy', 0, 1, 5, 2.78, 295211, 36.33, 209, 7, 8.00, 'South Africa', 'Africa', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('ITN4331', 72, 'Female', 304, '168/90', 57, 0, 0, 1, 1, 1, 8.81, 'Average', 0, 0, 4, 7.48, 44491, 37.13, 109, 6, 6.00, 'China', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('ERP9347', 80, 'Male', 334, '105/108', 110, 0, 0, 1, 0, 0, 9.34, 'Healthy', 0, 0, 4, 4.75, 51385, 31.36, 530, 0, 9.00, 'United Kingdom', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('UFC0697', 53, 'Female', 301, '146/94', 47, 1, 1, 1, 1, 0, 2.54, 'Unhealthy', 1, 1, 4, 6.72, 76456, 18.33, 654, 4, 4.00, 'Australia', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('JFL6450', 21, 'Male', 213, '109/65', 97, 1, 0, 1, 0, 1, 5.04, 'Average', 0, 0, 9, 5.83, 273127, 36.16, 232, 7, 4.00, 'India', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('JKY9288', 90, 'Female', 254, '166/89', 102, 1, 0, 1, 1, 0, 9.82, 'Unhealthy', 0, 0, 4, 3.50, 243025, 39.51, 331, 0, 5.00, 'Colombia', 'South America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('AAX1328', 28, 'Male', 237, '163/61', 73, 1, 0, 1, 1, 0, 13.58, 'Unhealthy', 1, 1, 3, 1.92, 115859, 19.41, 485, 7, 8.00, 'Vietnam', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('XHX1600', 69, 'Female', 230, '117/76', 107, 0, 0, 1, 1, 1, 7.75, 'Healthy', 1, 0, 3, 8.11, 153107, 28.79, 250, 3, 6.00, 'Brazil', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('SDW5368', 73, 'Female', 248, '106/60', 70, 1, 1, 1, 0, 1, 3.20, 'Healthy', 0, 1, 6, 8.00, 90408, 28.82, 113, 6, 10.00, 'Canada', 'North America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('GAN8948', 66, 'Male', 316, '159/70', 58, 1, 0, 1, 1, 0, 10.76, 'Healthy', 0, 1, 4, 0.57, 292920, 30.66, 377, 0, 7.00, 'Brazil', 'South America', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('AND5753', 75, 'Male', 277, '145/92', 87, 1, 1, 1, 0, 1, 4.08, 'Average', 0, 0, 10, 6.21, 78546, 25.08, 180, 6, 5.00, 'Colombia', 'South America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('WMN2843', 30, 'Male', 388, '170/106', 41, 1, 1, 1, 0, 1, 1.20, 'Healthy', 0, 1, 6, 6.39, 149387, 27.77, 229, 1, 6.00, 'Spain', 'Europe', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('LXD8525', 22, 'Female', 206, '134/94', 104, 0, 1, 0, 0, 1, 6.43, 'Unhealthy', 0, 0, 4, 4.01, 128229, 39.85, 602, 0, 6.00, 'South Korea', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('OMR5899', 88, 'Male', 384, '113/80', 67, 1, 0, 1, 0, 0, 16.18, 'Healthy', 0, 1, 1, 3.75, 179312, 36.70, 285, 2, 8.00, 'Nigeria', 'Africa', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('ZLM2405', 90, 'Female', 205, '163/102', 93, 1, 1, 1, 0, 0, 5.78, 'Unhealthy', 1, 1, 4, 2.80, 274393, 27.62, 471, 2, 10.00, 'New Zealand', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('ACQ6112', 79, 'Male', 261, '149/100', 65, 0, 1, 1, 1, 1, 3.87, 'Unhealthy', 0, 1, 6, 2.62, 162055, 19.95, 554, 6, 7.00, 'United Kingdom', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('KMA0239', 63, 'Female', 308, '125/76', 96, 1, 1, 1, 0, 1, 13.28, 'Unhealthy', 1, 1, 2, 7.48, 51834, 24.11, 344, 6, 10.00, 'Brazil', 'South America', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('HHA8617', 27, 'Male', 246, '100/67', 71, 1, 1, 1, 0, 1, 8.01, 'Healthy', 0, 0, 2, 2.25, 271798, 35.29, 416, 3, 6.00, 'Thailand', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('PZM6937', 18, 'Male', 396, '110/101', 45, 0, 0, 1, 0, 1, 14.88, 'Healthy', 1, 1, 10, 10.32, 138696, 31.71, 445, 3, 6.00, 'United Kingdom', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('ELD0719', 60, 'Male', 338, '149/69', 96, 1, 1, 1, 0, 0, 18.85, 'Healthy', 1, 1, 7, 3.58, 186453, 33.85, 385, 0, 8.00, 'Argentina', 'South America', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('PHK4364', 34, 'Female', 382, '135/63', 63, 1, 0, 0, 0, 1, 10.03, 'Average', 1, 1, 10, 10.68, 38329, 38.92, 709, 2, 6.00, 'France', 'Europe', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('NXR3682', 60, 'Male', 291, '137/67', 72, 1, 0, 1, 1, 1, 16.89, 'Unhealthy', 1, 1, 7, 10.96, 268377, 37.55, 426, 4, 4.00, 'Canada', 'North America', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('UQC2723', 37, 'Male', 163, '178/78', 53, 1, 1, 1, 1, 0, 18.05, 'Average', 0, 1, 5, 8.62, 72564, 19.95, 528, 1, 7.00, 'China', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('CFZ8373', 71, 'Male', 129, '116/73', 107, 1, 1, 1, 0, 1, 15.80, 'Average', 0, 0, 9, 5.33, 175465, 29.76, 388, 2, 7.00, 'New Zealand', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('RNA0445', 88, 'Female', 168, '110/72', 48, 1, 1, 1, 0, 0, 4.14, 'Healthy', 0, 0, 8, 5.87, 285832, 38.33, 314, 5, 4.00, 'Argentina', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('YKA1578', 89, 'Male', 247, '100/88', 79, 1, 0, 1, 1, 1, 8.10, 'Healthy', 1, 1, 1, 2.05, 262651, 38.20, 441, 1, 10.00, 'Brazil', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('EIM7657', 33, 'Male', 218, '121/72', 98, 0, 1, 1, 1, 1, 16.11, 'Average', 1, 1, 4, 10.62, 103758, 33.74, 306, 5, 9.00, 'United Kingdom', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('YWD5623', 40, 'Female', 237, '174/102', 49, 1, 0, 0, 0, 0, 15.03, 'Healthy', 1, 1, 6, 9.94, 137537, 19.69, 749, 5, 6.00, 'Vietnam', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('EAI3641', 29, 'Female', 388, '177/94', 53, 1, 0, 0, 0, 1, 2.78, 'Unhealthy', 1, 0, 5, 0.05, 179966, 37.22, 347, 3, 6.00, 'Japan', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('EUK0592', 89, 'Female', 227, '126/108', 79, 1, 1, 1, 0, 0, 2.30, 'Healthy', 0, 1, 8, 2.46, 65113, 23.67, 341, 4, 10.00, 'Spain', 'Europe', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('DXT5853', 37, 'Male', 171, '120/101', 88, 1, 1, 1, 0, 1, 11.40, 'Unhealthy', 1, 0, 3, 8.73, 188465, 22.04, 451, 1, 5.00, 'Spain', 'Europe', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('AZR0892', 82, 'Male', 378, '118/105', 96, 1, 1, 1, 0, 0, 1.99, 'Healthy', 1, 0, 4, 6.25, 230457, 40.00, 286, 2, 4.00, 'Nigeria', 'Africa', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('YTL7126', 86, 'Female', 124, '142/88', 96, 1, 0, 1, 0, 0, 14.01, 'Healthy', 0, 1, 4, 1.88, 167843, 28.96, 356, 1, 8.00, 'Brazil', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('GNL2507', 71, 'Female', 279, '128/105', 56, 1, 1, 1, 1, 1, 12.17, 'Unhealthy', 1, 0, 5, 4.26, 259886, 39.95, 336, 6, 5.00, 'New Zealand', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('PKU2212', 32, 'Male', 338, '143/75', 85, 1, 0, 1, 0, 1, 6.21, 'Average', 1, 0, 7, 7.32, 105975, 32.50, 455, 1, 4.00, 'Colombia', 'South America', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('NRR1900', 49, 'Male', 253, '103/78', 49, 0, 0, 1, 0, 1, 10.80, 'Average', 1, 0, 5, 7.97, 246202, 34.48, 223, 7, 8.00, 'South Korea', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('XAQ9706', 34, 'Female', 245, '116/102', 87, 0, 0, 0, 1, 0, 15.19, 'Healthy', 0, 1, 5, 11.74, 35141, 37.89, 766, 7, 6.00, 'Nigeria', 'Africa', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('IFZ1439', 63, 'Female', 226, '132/76', 94, 0, 0, 1, 1, 1, 3.65, 'Average', 1, 0, 9, 7.96, 248256, 32.54, 262, 5, 8.00, 'Australia', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('UIP9627', 23, 'Male', 248, '169/92', 88, 0, 1, 1, 1, 1, 18.98, 'Average', 1, 1, 10, 6.60, 236752, 19.40, 239, 3, 6.00, 'Vietnam', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('BNA7793', 74, 'Female', 281, '113/79', 58, 0, 0, 1, 0, 1, 7.26, 'Average', 0, 0, 6, 0.38, 185546, 32.03, 555, 0, 7.00, 'India', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('VWX9664', 33, 'Male', 123, '99/71', 101, 0, 0, 1, 1, 0, 12.74, 'Average', 0, 1, 6, 0.93, 97058, 25.16, 363, 5, 5.00, 'United Kingdom', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('CYT4743', 59, 'Male', 173, '96/93', 85, 1, 0, 1, 1, 1, 3.91, 'Healthy', 1, 1, 4, 2.33, 43410, 28.06, 489, 1, 8.00, 'Canada', 'North America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('AGH6728', 52, 'Female', 231, '145/82', 66, 1, 0, 1, 0, 1, 1.54, 'Healthy', 1, 0, 1, 4.21, 59008, 36.87, 788, 7, 10.00, 'Colombia', 'South America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('PUS3059', 62, 'Female', 234, '173/62', 61, 1, 0, 1, 0, 0, 13.83, 'Average', 1, 0, 7, 4.34, 230906, 23.84, 121, 6, 10.00, 'India', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('RCE5059', 64, 'Male', 224, '179/62', 59, 1, 1, 1, 1, 0, 10.71, 'Healthy', 1, 0, 8, 6.48, 107142, 22.02, 553, 1, 9.00, 'Germany', 'Europe', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('KTU2333', 80, 'Male', 268, '100/69', 102, 1, 1, 1, 1, 0, 8.93, 'Average', 1, 1, 6, 4.95, 55296, 29.61, 485, 2, 7.00, 'Argentina', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('FON8872', 32, 'Male', 253, '153/77', 57, 1, 0, 1, 1, 1, 19.41, 'Healthy', 0, 1, 7, 4.68, 278335, 29.47, 617, 3, 5.00, 'Argentina', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('LTS6151', 82, 'Male', 396, '156/74', 60, 0, 1, 1, 0, 1, 19.30, 'Unhealthy', 1, 1, 5, 5.40, 265224, 23.66, 471, 6, 10.00, 'United States', 'North America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('WER6567', 45, 'Male', 133, '162/82', 76, 1, 0, 1, 1, 0, 2.75, 'Average', 1, 1, 8, 7.20, 86260, 21.28, 174, 6, 7.00, 'Vietnam', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('YJM3019', 28, 'Male', 209, '98/109', 81, 1, 0, 1, 1, 0, 4.03, 'Healthy', 1, 0, 7, 11.16, 28245, 28.96, 167, 3, 9.00, 'South Korea', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('GMX4668', 61, 'Male', 306, '165/89', 64, 1, 0, 1, 0, 0, 15.76, 'Healthy', 1, 0, 7, 7.10, 185111, 25.87, 563, 6, 5.00, 'Japan', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('TRR4979', 36, 'Male', 133, '150/73', 87, 0, 1, 1, 0, 0, 14.70, 'Average', 1, 1, 1, 2.56, 77762, 39.33, 665, 7, 10.00, 'Spain', 'Europe', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('LDJ4682', 30, 'Female', 186, '163/102', 82, 1, 0, 0, 1, 0, 1.06, 'Healthy', 1, 1, 3, 1.37, 173953, 23.62, 605, 0, 8.00, 'China', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('SHL1488', 54, 'Male', 293, '134/90', 67, 1, 1, 1, 1, 0, 12.04, 'Average', 0, 0, 3, 5.64, 76597, 25.84, 65, 5, 5.00, 'Thailand', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('LJI9585', 70, 'Male', 161, '133/60', 74, 1, 1, 1, 1, 0, 1.62, 'Average', 1, 0, 1, 4.50, 225119, 27.29, 657, 2, 5.00, 'China', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('QGJ6378', 76, 'Male', 243, '157/110', 42, 0, 1, 1, 0, 1, 19.82, 'Unhealthy', 1, 1, 9, 9.69, 136616, 36.62, 237, 0, 4.00, 'Colombia', 'South America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('EIH9699', 41, 'Male', 398, '96/106', 56, 1, 0, 1, 1, 0, 8.81, 'Healthy', 0, 0, 10, 1.75, 196083, 33.63, 141, 0, 7.00, 'Vietnam', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('XHY0495', 44, 'Male', 380, '173/82', 75, 1, 0, 1, 1, 0, 15.64, 'Average', 0, 0, 8, 9.68, 242224, 21.72, 767, 6, 6.00, 'Japan', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('JEK2629', 27, 'Female', 297, '96/92', 75, 0, 1, 0, 0, 1, 2.88, 'Average', 1, 0, 2, 0.87, 148649, 18.04, 292, 6, 8.00, 'Australia', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('IPU0926', 45, 'Male', 247, '162/71', 82, 1, 0, 1, 1, 0, 6.79, 'Average', 0, 1, 2, 9.62, 261792, 23.59, 743, 3, 4.00, 'France', 'Europe', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('ZBC0359', 76, 'Male', 133, '91/83', 93, 0, 0, 1, 1, 1, 16.15, 'Average', 0, 1, 7, 0.92, 286446, 27.22, 563, 1, 10.00, 'Argentina', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('FNE9444', 27, 'Female', 195, '148/89', 69, 0, 1, 0, 1, 1, 6.09, 'Healthy', 0, 1, 8, 5.26, 26073, 25.41, 214, 5, 6.00, 'New Zealand', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('FYX5444', 62, 'Male', 239, '145/98', 86, 0, 1, 1, 0, 0, 16.78, 'Unhealthy', 1, 1, 6, 9.60, 167906, 24.85, 221, 5, 9.00, 'New Zealand', 'Australia', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('PID6523', 69, 'Female', 149, '180/108', 81, 1, 1, 1, 1, 1, 3.86, 'Healthy', 0, 1, 8, 6.93, 39574, 23.41, 447, 3, 5.00, 'Argentina', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('JFH5824', 42, 'Female', 320, '98/67', 110, 1, 0, 1, 1, 0, 7.28, 'Healthy', 0, 1, 2, 7.34, 278527, 32.14, 634, 2, 4.00, 'China', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('MGR9885', 42, 'Female', 246, '154/81', 100, 1, 1, 1, 1, 1, 16.23, 'Healthy', 1, 1, 1, 1.33, 209247, 22.04, 460, 2, 9.00, 'Germany', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('PBX8054', 67, 'Male', 208, '172/64', 99, 1, 0, 1, 1, 0, 8.96, 'Unhealthy', 0, 1, 1, 9.03, 23997, 35.47, 711, 2, 5.00, 'Japan', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('KJS3508', 79, 'Male', 219, '118/75', 56, 1, 1, 1, 0, 1, 19.88, 'Average', 1, 1, 7, 4.32, 109045, 36.74, 216, 2, 9.00, 'Germany', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('DNC4502', 19, 'Male', 335, '144/60', 80, 1, 0, 1, 0, 1, 7.18, 'Unhealthy', 1, 0, 5, 3.18, 173234, 34.21, 97, 1, 4.00, 'Thailand', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('SNL4419', 35, 'Male', 265, '133/63', 92, 0, 1, 1, 0, 1, 16.11, 'Unhealthy', 0, 0, 4, 5.12, 187632, 29.62, 267, 0, 8.00, 'Nigeria', 'Africa', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('MRG3205', 23, 'Male', 380, '154/102', 76, 0, 1, 1, 1, 0, 9.20, 'Unhealthy', 0, 0, 4, 8.64, 116037, 32.07, 695, 5, 9.00, 'Japan', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('PQR7571', 41, 'Male', 178, '123/91', 64, 1, 1, 1, 0, 1, 9.20, 'Unhealthy', 0, 0, 2, 11.14, 255891, 25.09, 717, 5, 5.00, 'Argentina', 'South America', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('CVA7420', 87, 'Male', 253, '102/82', 95, 0, 0, 1, 1, 1, 6.78, 'Healthy', 0, 1, 3, 8.36, 288093, 37.40, 795, 5, 9.00, 'Australia', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('LTC1110', 36, 'Female', 126, '146/76', 88, 1, 1, 0, 1, 1, 8.21, 'Healthy', 0, 0, 9, 5.78, 205962, 21.18, 383, 1, 5.00, 'South Korea', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('IGP0445', 63, 'Female', 251, '178/83', 108, 1, 1, 1, 0, 0, 4.31, 'Average', 0, 1, 3, 10.52, 293766, 21.36, 332, 5, 4.00, 'Canada', 'North America', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('WKX1032', 27, 'Female', 307, '123/72', 90, 1, 1, 0, 0, 1, 5.59, 'Average', 0, 0, 4, 5.78, 255216, 23.24, 785, 6, 5.00, 'South Korea', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('JHC9731', 59, 'Male', 359, '154/63', 74, 1, 0, 1, 1, 1, 17.51, 'Unhealthy', 1, 0, 7, 2.58, 212902, 21.99, 449, 0, 6.00, 'France', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('ZAR0685', 89, 'Male', 270, '158/85', 73, 1, 1, 1, 0, 0, 13.52, 'Unhealthy', 1, 0, 4, 11.52, 79041, 18.46, 701, 7, 7.00, 'India', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('TRI7066', 88, 'Male', 336, '161/105', 57, 1, 1, 1, 0, 0, 19.85, 'Unhealthy', 0, 1, 2, 11.13, 155187, 22.41, 524, 7, 8.00, 'India', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('ZFY8621', 89, 'Male', 225, '131/70', 81, 1, 0, 1, 1, 0, 16.60, 'Average', 0, 1, 7, 0.55, 269876, 21.16, 549, 4, 4.00, 'China', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('ICO8112', 80, 'Male', 193, '169/90', 74, 1, 0, 1, 0, 0, 15.04, 'Unhealthy', 0, 0, 9, 8.32, 194486, 37.09, 31, 5, 4.00, 'United Kingdom', 'Europe', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('ZLT2622', 81, 'Male', 148, '154/95', 60, 1, 1, 1, 1, 1, 14.00, 'Average', 1, 1, 6, 0.58, 200231, 18.43, 276, 6, 6.00, 'Canada', 'North America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('XGG5032', 35, 'Female', 358, '110/104', 56, 0, 0, 0, 0, 1, 9.33, 'Unhealthy', 0, 1, 7, 5.90, 256308, 32.78, 569, 7, 6.00, 'Germany', 'Europe', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('EDI3563', 84, 'Male', 296, '121/65', 57, 1, 1, 1, 1, 0, 15.73, 'Unhealthy', 1, 1, 7, 6.93, 281871, 32.14, 744, 5, 9.00, 'Australia', 'Australia', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('PVI2611', 21, 'Male', 206, '142/104', 67, 1, 1, 1, 1, 1, 0.64, 'Healthy', 1, 0, 6, 1.07, 21002, 26.78, 128, 4, 10.00, 'Colombia', 'South America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('JKE5424', 75, 'Male', 339, '153/89', 88, 1, 1, 1, 1, 0, 8.78, 'Healthy', 0, 0, 9, 6.93, 62142, 32.33, 331, 7, 10.00, 'United Kingdom', 'Europe', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('XGF9824', 60, 'Female', 377, '125/95', 49, 0, 0, 1, 0, 1, 11.61, 'Average', 0, 1, 3, 9.16, 109194, 25.25, 327, 6, 8.00, 'Colombia', 'South America', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('KLT7600', 53, 'Male', 136, '135/92', 65, 1, 1, 1, 1, 0, 5.87, 'Healthy', 0, 1, 2, 11.21, 101399, 35.14, 52, 3, 9.00, 'Argentina', 'South America', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('GFT1011', 66, 'Male', 200, '143/83', 93, 1, 1, 1, 1, 0, 14.94, 'Unhealthy', 0, 1, 7, 8.66, 139451, 32.16, 394, 5, 8.00, 'Argentina', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('GBX5187', 75, 'Female', 234, '149/73', 41, 0, 1, 1, 1, 1, 16.20, 'Average', 0, 0, 3, 0.69, 43227, 26.11, 54, 6, 9.00, 'Nigeria', 'Africa', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('OVC8311', 58, 'Male', 364, '96/66', 50, 0, 1, 1, 1, 1, 7.26, 'Unhealthy', 1, 0, 2, 6.89, 282291, 20.88, 739, 4, 9.00, 'Spain', 'Europe', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('NCR3052', 25, 'Female', 353, '157/98', 83, 1, 1, 0, 0, 0, 16.96, 'Healthy', 1, 0, 7, 8.32, 53756, 32.92, 407, 6, 7.00, 'Italy', 'Europe', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('YJO3659', 29, 'Male', 252, '120/109', 79, 1, 0, 1, 0, 0, 7.61, 'Average', 0, 1, 7, 3.82, 96158, 24.80, 751, 2, 10.00, 'South Africa', 'Africa', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('LTG3105', 85, 'Female', 232, '171/69', 102, 1, 0, 1, 1, 0, 12.59, 'Healthy', 1, 1, 8, 0.19, 266549, 22.18, 436, 6, 8.00, 'Canada', 'North America', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('OEI6632', 24, 'Female', 387, '106/101', 78, 1, 0, 0, 0, 0, 9.43, 'Average', 1, 1, 10, 3.45, 137445, 28.33, 473, 3, 8.00, 'China', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('JTS2700', 78, 'Male', 299, '90/105', 66, 0, 1, 1, 0, 1, 2.17, 'Unhealthy', 1, 0, 6, 2.65, 280881, 18.33, 218, 5, 6.00, 'Australia', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('FXR0426', 32, 'Male', 357, '133/77', 89, 1, 0, 1, 0, 0, 5.67, 'Average', 1, 1, 2, 10.78, 177090, 36.25, 654, 6, 9.00, 'South Korea', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('LGH0316', 18, 'Female', 214, '179/88', 68, 0, 0, 0, 0, 1, 15.01, 'Healthy', 1, 1, 2, 5.71, 96215, 18.31, 129, 6, 9.00, 'Colombia', 'South America', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('ZZQ4895', 49, 'Male', 279, '177/70', 86, 1, 0, 1, 1, 0, 15.55, 'Average', 1, 1, 8, 9.30, 45680, 23.68, 579, 1, 6.00, 'Vietnam', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('CJV4418', 42, 'Male', 370, '98/73', 68, 0, 1, 1, 0, 1, 8.70, 'Unhealthy', 0, 0, 2, 10.98, 51439, 22.48, 492, 0, 8.00, 'United Kingdom', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('ZUN7568', 83, 'Female', 345, '174/61', 104, 1, 0, 1, 1, 1, 10.37, 'Average', 1, 1, 6, 5.96, 196638, 20.09, 696, 6, 9.00, 'Australia', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('IED0019', 58, 'Female', 351, '176/110', 89, 1, 0, 1, 0, 1, 19.31, 'Healthy', 0, 1, 2, 5.95, 257788, 39.99, 202, 4, 8.00, 'New Zealand', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('DKF5216', 33, 'Male', 344, '167/62', 92, 0, 1, 1, 1, 0, 9.72, 'Healthy', 1, 0, 1, 9.91, 291028, 19.96, 197, 6, 6.00, 'South Africa', 'Africa', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('HLK1794', 24, 'Female', 152, '103/82', 44, 1, 1, 0, 0, 1, 15.48, 'Healthy', 1, 0, 9, 6.82, 50437, 37.57, 521, 5, 8.00, 'Canada', 'North America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('OUM0988', 22, 'Male', 303, '171/75', 105, 1, 1, 1, 0, 1, 13.78, 'Healthy', 0, 1, 8, 6.14, 29666, 39.10, 325, 5, 8.00, 'Vietnam', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('KBN1743', 50, 'Male', 193, '158/87', 73, 0, 1, 1, 1, 1, 2.22, 'Unhealthy', 0, 0, 8, 9.69, 31206, 24.04, 35, 6, 8.00, 'United Kingdom', 'Europe', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('WSF0425', 73, 'Male', 150, '131/109', 57, 1, 1, 1, 0, 0, 17.75, 'Average', 0, 1, 4, 7.73, 213403, 25.97, 123, 1, 8.00, 'France', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('XSS0940', 63, 'Male', 131, '124/94', 83, 0, 0, 1, 0, 0, 3.41, 'Average', 0, 1, 5, 4.68, 227989, 22.66, 694, 1, 4.00, 'Vietnam', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('PXI9906', 24, 'Male', 334, '164/71', 107, 1, 1, 1, 1, 1, 3.91, 'Average', 0, 0, 10, 1.26, 122258, 36.94, 434, 6, 8.00, 'Brazil', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('FPC1521', 72, 'Female', 202, '100/81', 92, 0, 0, 1, 1, 0, 12.77, 'Average', 0, 0, 2, 9.74, 81973, 33.51, 131, 4, 6.00, 'New Zealand', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('LPN6836', 58, 'Female', 276, '164/90', 109, 1, 0, 1, 0, 1, 16.83, 'Unhealthy', 1, 0, 9, 9.65, 283638, 18.07, 248, 5, 10.00, 'New Zealand', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('DZP9719', 37, 'Male', 190, '108/64', 64, 0, 1, 1, 0, 1, 6.11, 'Unhealthy', 0, 0, 6, 8.54, 80970, 38.43, 648, 4, 6.00, 'South Korea', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('WDB5143', 45, 'Male', 226, '179/63', 83, 0, 0, 1, 1, 0, 3.52, 'Average', 0, 1, 2, 7.11, 265090, 34.19, 348, 7, 6.00, 'Australia', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('XTF7566', 24, 'Male', 272, '141/75', 72, 0, 1, 1, 0, 1, 18.05, 'Unhealthy', 1, 1, 2, 1.68, 190767, 25.02, 750, 3, 9.00, 'Italy', 'Europe', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('IRJ5181', 81, 'Female', 373, '116/93', 73, 1, 1, 1, 0, 1, 9.53, 'Unhealthy', 1, 0, 7, 11.28, 49335, 26.55, 431, 0, 5.00, 'Nigeria', 'Africa', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('PVC5447', 49, 'Male', 263, '115/78', 108, 1, 0, 1, 1, 0, 8.38, 'Healthy', 1, 1, 5, 2.57, 124315, 26.64, 714, 3, 9.00, 'South Korea', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('GXA9148', 28, 'Male', 194, '146/107', 78, 1, 0, 1, 0, 1, 2.30, 'Unhealthy', 0, 1, 10, 7.50, 165452, 22.27, 649, 1, 8.00, 'South Korea', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('IAB5092', 22, 'Male', 357, '102/105', 96, 1, 0, 1, 1, 1, 7.79, 'Healthy', 1, 0, 8, 7.94, 153954, 22.44, 668, 0, 10.00, 'South Africa', 'Africa', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('ITY8640', 25, 'Female', 302, '151/95', 94, 1, 0, 0, 0, 1, 5.50, 'Unhealthy', 1, 1, 10, 7.62, 136230, 37.99, 401, 7, 8.00, 'Canada', 'North America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('LMH8932', 23, 'Female', 337, '133/82', 48, 0, 1, 0, 1, 0, 2.75, 'Average', 0, 0, 9, 4.50, 197970, 28.57, 610, 5, 8.00, 'Argentina', 'South America', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('DKF7925', 61, 'Male', 205, '134/72', 105, 0, 1, 1, 1, 1, 11.06, 'Average', 0, 1, 5, 2.47, 105580, 24.54, 244, 5, 5.00, 'China', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('TRV5341', 47, 'Male', 170, '157/104', 95, 0, 0, 1, 0, 1, 5.29, 'Healthy', 1, 0, 1, 11.84, 221301, 25.75, 691, 0, 8.00, 'South Korea', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('KCE3422', 46, 'Female', 356, '126/107', 62, 1, 1, 1, 0, 1, 18.37, 'Unhealthy', 1, 1, 4, 8.01, 132614, 19.63, 88, 2, 6.00, 'Colombia', 'South America', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('LLN6231', 82, 'Male', 297, '105/103', 90, 1, 0, 1, 0, 0, 12.06, 'Average', 1, 0, 5, 3.75, 136235, 31.62, 532, 0, 5.00, 'South Africa', 'Africa', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('GBB8361', 52, 'Male', 274, '168/110', 77, 1, 1, 1, 1, 1, 9.35, 'Unhealthy', 0, 0, 10, 10.75, 129295, 39.40, 777, 7, 5.00, 'France', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('MGP8803', 88, 'Female', 122, '162/71', 57, 0, 1, 1, 1, 0, 8.23, 'Average', 1, 0, 1, 4.22, 281058, 18.50, 121, 3, 9.00, 'Brazil', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('SDD6614', 21, 'Male', 188, '115/87', 51, 0, 1, 1, 0, 0, 9.85, 'Unhealthy', 0, 0, 10, 8.47, 26329, 38.04, 420, 5, 6.00, 'Canada', 'North America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('AOC1459', 47, 'Male', 125, '99/64', 103, 1, 1, 1, 0, 1, 0.40, 'Healthy', 1, 1, 8, 10.21, 153639, 22.58, 350, 5, 7.00, 'Australia', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('AYM4283', 82, 'Male', 200, '126/109', 80, 0, 0, 1, 1, 1, 3.97, 'Unhealthy', 0, 0, 2, 2.44, 131867, 29.72, 652, 6, 7.00, 'New Zealand', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('MYI3162', 45, 'Male', 328, '99/90', 78, 1, 1, 1, 1, 1, 0.00, 'Average', 0, 0, 9, 3.57, 196560, 37.49, 413, 7, 4.00, 'France', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('KZY7247', 75, 'Female', 389, '123/107', 51, 0, 1, 1, 0, 0, 11.78, 'Healthy', 0, 1, 2, 6.08, 202561, 39.46, 779, 1, 5.00, 'Brazil', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('EAB3469', 86, 'Male', 225, '165/71', 48, 1, 1, 1, 0, 0, 18.21, 'Unhealthy', 0, 1, 5, 5.94, 149205, 35.28, 558, 3, 4.00, 'Nigeria', 'Africa', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('PLA0781', 20, 'Male', 201, '127/89', 55, 1, 0, 1, 0, 1, 18.26, 'Healthy', 1, 1, 9, 5.75, 185582, 20.78, 109, 5, 10.00, 'South Korea', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('VGQ3461', 31, 'Female', 205, '121/66', 110, 1, 0, 0, 0, 0, 16.59, 'Unhealthy', 0, 0, 1, 1.90, 60746, 18.20, 754, 5, 4.00, 'France', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('QZH6722', 60, 'Male', 138, '159/98', 101, 1, 1, 1, 0, 0, 17.80, 'Unhealthy', 0, 0, 8, 8.40, 88117, 24.31, 760, 2, 9.00, 'United Kingdom', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('WPO9038', 65, 'Male', 376, '165/70', 89, 1, 1, 1, 1, 1, 17.82, 'Unhealthy', 0, 0, 7, 8.40, 226407, 20.96, 753, 2, 10.00, 'Argentina', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('DTV5850', 84, 'Female', 181, '138/89', 59, 0, 0, 1, 1, 0, 10.27, 'Unhealthy', 0, 1, 7, 2.51, 281179, 38.05, 457, 0, 4.00, 'Argentina', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('HPS8287', 42, 'Male', 277, '119/91', 107, 1, 1, 1, 1, 1, 8.79, 'Average', 1, 0, 9, 5.18, 62873, 20.71, 122, 3, 7.00, 'Argentina', 'South America', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('PSY8110', 62, 'Male', 138, '102/107', 55, 1, 1, 1, 0, 1, 6.04, 'Average', 0, 1, 5, 0.92, 133245, 32.65, 312, 5, 8.00, 'South Korea', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('VEC6403', 56, 'Female', 230, '97/93', 76, 1, 0, 1, 1, 1, 12.90, 'Unhealthy', 1, 0, 6, 11.20, 280909, 29.64, 778, 6, 9.00, 'Japan', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('DWZ6826', 56, 'Male', 263, '120/65', 64, 0, 1, 1, 1, 0, 9.32, 'Healthy', 0, 0, 1, 4.97, 46221, 23.55, 676, 6, 10.00, 'Japan', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('RFT4958', 50, 'Female', 184, '118/82', 74, 0, 1, 1, 1, 1, 10.49, 'Average', 0, 0, 5, 6.11, 112620, 37.80, 775, 1, 10.00, 'Australia', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('RMZ5516', 58, 'Female', 275, '178/86', 98, 0, 0, 1, 1, 1, 17.98, 'Unhealthy', 1, 1, 5, 0.81, 230081, 25.69, 183, 6, 9.00, 'United States', 'North America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('CPC7799', 30, 'Male', 163, '92/82', 86, 1, 1, 1, 0, 1, 7.13, 'Unhealthy', 1, 1, 9, 11.39, 80512, 29.68, 601, 1, 5.00, 'Spain', 'Europe', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('YBZ4650', 32, 'Male', 243, '111/69', 95, 1, 0, 1, 0, 1, 8.51, 'Healthy', 0, 0, 9, 2.64, 89938, 36.39, 317, 3, 10.00, 'France', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('XZE0584', 69, 'Male', 370, '164/92', 105, 0, 1, 1, 1, 1, 0.15, 'Healthy', 0, 1, 2, 8.44, 51970, 37.20, 592, 0, 9.00, 'United States', 'North America', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('YCH0527', 43, 'Male', 394, '137/109', 79, 0, 0, 1, 0, 1, 11.72, 'Unhealthy', 0, 1, 2, 4.18, 198613, 34.01, 113, 7, 6.00, 'India', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('IUH2759', 56, 'Female', 155, '154/92', 72, 1, 1, 1, 1, 1, 5.56, 'Healthy', 0, 0, 10, 2.01, 235004, 26.31, 191, 1, 6.00, 'China', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('CJP0345', 39, 'Male', 190, '91/62', 60, 0, 0, 1, 1, 1, 13.88, 'Average', 1, 1, 8, 4.40, 117045, 35.03, 83, 7, 4.00, 'United Kingdom', 'Europe', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('NNR3835', 86, 'Female', 128, '155/104', 104, 0, 1, 1, 1, 1, 13.21, 'Healthy', 1, 0, 9, 2.57, 267462, 38.21, 32, 5, 10.00, 'Germany', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('KAE4264', 77, 'Male', 217, '124/91', 52, 0, 1, 1, 1, 1, 13.28, 'Healthy', 0, 0, 10, 9.29, 290828, 34.05, 453, 2, 7.00, 'India', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('XJQ7283', 77, 'Female', 220, '125/72', 57, 0, 0, 1, 1, 1, 6.21, 'Healthy', 1, 1, 7, 2.12, 296118, 39.17, 423, 2, 8.00, 'Nigeria', 'Africa', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('CSV3638', 18, 'Female', 353, '159/108', 46, 0, 0, 0, 1, 0, 15.24, 'Average', 0, 0, 9, 2.06, 82682, 21.91, 455, 0, 8.00, 'France', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('HTW2151', 26, 'Male', 225, '106/64', 58, 1, 1, 1, 0, 1, 0.38, 'Average', 1, 0, 2, 11.55, 30974, 18.84, 234, 6, 5.00, 'Vietnam', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('KKR6535', 52, 'Male', 396, '103/106', 84, 0, 0, 1, 0, 1, 9.79, 'Healthy', 0, 0, 5, 4.10, 266611, 22.58, 650, 0, 10.00, 'India', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('PUN6734', 37, 'Male', 399, '162/62', 70, 0, 1, 1, 1, 0, 7.86, 'Healthy', 1, 0, 1, 11.98, 206564, 20.87, 565, 5, 10.00, 'Japan', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('UIB5375', 67, 'Male', 378, '105/80', 57, 0, 0, 1, 0, 1, 14.27, 'Unhealthy', 0, 1, 3, 10.34, 37631, 29.75, 798, 5, 8.00, 'South Africa', 'Africa', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('NQS1727', 60, 'Male', 283, '175/70', 55, 1, 0, 1, 0, 0, 19.86, 'Average', 0, 1, 9, 3.08, 193069, 35.04, 769, 0, 4.00, 'Italy', 'Europe', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('NSF4755', 28, 'Female', 289, '125/93', 44, 1, 0, 0, 0, 1, 1.17, 'Unhealthy', 1, 0, 5, 5.45, 250406, 23.11, 412, 1, 4.00, 'China', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('WXM0274', 81, 'Male', 120, '98/108', 78, 0, 0, 1, 0, 0, 12.95, 'Unhealthy', 1, 1, 6, 8.74, 81743, 31.88, 455, 2, 8.00, 'Nigeria', 'Africa', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('AIW4911', 87, 'Male', 138, '123/95', 83, 0, 1, 1, 0, 0, 7.17, 'Average', 1, 0, 7, 6.96, 50675, 19.50, 63, 1, 6.00, 'Colombia', 'South America', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('RKM6961', 50, 'Male', 131, '133/102', 40, 0, 0, 1, 1, 0, 3.09, 'Unhealthy', 1, 0, 9, 6.11, 261735, 33.90, 576, 1, 8.00, 'Australia', 'Australia', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('ZVX8100', 62, 'Male', 284, '157/100', 109, 1, 1, 1, 1, 1, 2.86, 'Healthy', 0, 1, 8, 8.31, 191267, 37.23, 198, 2, 9.00, 'France', 'Europe', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('JDK0538', 68, 'Male', 270, '110/67', 106, 1, 1, 1, 1, 1, 15.99, 'Unhealthy', 0, 1, 1, 2.34, 113458, 25.06, 93, 4, 6.00, 'Germany', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('XPP2301', 21, 'Female', 321, '142/96', 102, 1, 1, 0, 0, 1, 16.25, 'Unhealthy', 1, 1, 9, 11.16, 176010, 21.80, 764, 7, 7.00, 'Japan', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('OKR6669', 24, 'Male', 327, '133/91', 82, 1, 1, 1, 0, 0, 9.81, 'Unhealthy', 0, 0, 6, 1.19, 172355, 36.35, 82, 2, 7.00, 'Thailand', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('FUD7151', 44, 'Female', 262, '128/94', 42, 1, 1, 1, 1, 1, 6.58, 'Healthy', 0, 1, 1, 10.89, 297991, 21.94, 737, 3, 9.00, 'South Africa', 'Africa', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('IAC2550', 25, 'Male', 212, '115/109', 54, 0, 0, 1, 0, 1, 9.05, 'Healthy', 0, 0, 8, 4.55, 43792, 28.26, 94, 5, 9.00, 'Australia', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('ZXA5748', 76, 'Male', 153, '175/62', 87, 0, 0, 1, 0, 0, 16.71, 'Unhealthy', 1, 1, 8, 7.28, 279967, 28.36, 211, 5, 7.00, 'Australia', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('AMH0692', 83, 'Female', 216, '155/110', 85, 0, 1, 1, 0, 1, 5.16, 'Average', 0, 1, 3, 3.80, 261285, 21.50, 298, 0, 5.00, 'France', 'Europe', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('IWI0601', 43, 'Male', 152, '95/63', 62, 1, 1, 1, 0, 0, 14.91, 'Healthy', 0, 1, 8, 3.01, 291544, 33.82, 288, 0, 10.00, 'Canada', 'North America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('IRX7433', 44, 'Female', 350, '161/94', 104, 1, 1, 1, 0, 0, 5.58, 'Healthy', 0, 0, 5, 6.02, 256161, 31.36, 735, 0, 7.00, 'Australia', 'Australia', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('EJU5290', 43, 'Male', 192, '117/76', 66, 1, 0, 1, 1, 0, 0.73, 'Healthy', 1, 0, 10, 0.11, 122282, 29.06, 190, 6, 4.00, 'Germany', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('HZU0037', 22, 'Female', 345, '179/82', 72, 0, 1, 0, 1, 0, 17.05, 'Average', 1, 1, 4, 2.65, 147795, 38.45, 281, 5, 9.00, 'Nigeria', 'Africa', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('LEE8234', 38, 'Male', 128, '179/65', 56, 1, 1, 1, 1, 0, 6.03, 'Average', 0, 0, 7, 10.29, 202662, 34.36, 146, 6, 4.00, 'South Africa', 'Africa', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('IPH2474', 53, 'Male', 311, '96/77', 69, 1, 1, 1, 1, 0, 5.15, 'Average', 1, 1, 7, 3.56, 27409, 20.14, 574, 0, 4.00, 'South Korea', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('OUS8176', 86, 'Female', 206, '167/64', 57, 1, 0, 1, 0, 1, 20.00, 'Healthy', 1, 1, 8, 8.17, 45443, 38.04, 359, 5, 4.00, 'Thailand', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('MSP7682', 68, 'Female', 125, '142/68', 57, 1, 1, 1, 1, 0, 5.90, 'Unhealthy', 1, 0, 8, 1.43, 290957, 21.53, 155, 6, 7.00, 'Canada', 'North America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('VDU1518', 47, 'Male', 385, '138/66', 42, 1, 1, 1, 0, 0, 12.87, 'Average', 0, 0, 8, 5.77, 112844, 19.62, 719, 3, 8.00, 'United States', 'North America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('QSQ1337', 75, 'Male', 121, '180/103', 49, 1, 0, 1, 1, 1, 11.06, 'Unhealthy', 0, 1, 9, 8.63, 299050, 34.09, 466, 2, 5.00, 'China', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('NZU5544', 44, 'Male', 330, '90/62', 85, 1, 1, 1, 0, 1, 16.64, 'Healthy', 1, 0, 10, 3.22, 120152, 21.81, 106, 7, 9.00, 'Thailand', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('ZMF2605', 18, 'Female', 356, '137/64', 48, 0, 0, 0, 0, 1, 7.36, 'Healthy', 0, 0, 9, 0.17, 249273, 22.62, 492, 6, 6.00, 'South Korea', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('VQD2926', 51, 'Male', 321, '163/84', 86, 0, 1, 1, 1, 1, 0.51, 'Healthy', 1, 1, 4, 2.29, 215460, 35.62, 275, 7, 5.00, 'Italy', 'Europe', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('TJD3106', 81, 'Male', 283, '158/108', 85, 1, 0, 1, 1, 0, 0.70, 'Healthy', 0, 0, 6, 8.13, 262885, 22.60, 517, 3, 5.00, 'Colombia', 'South America', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('FXR8774', 75, 'Male', 155, '151/68', 103, 1, 1, 1, 1, 1, 2.23, 'Unhealthy', 0, 1, 6, 2.61, 294591, 37.55, 788, 7, 5.00, 'China', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('LMZ2207', 60, 'Male', 162, '168/97', 91, 1, 0, 1, 0, 1, 9.97, 'Average', 1, 1, 6, 4.34, 98373, 36.72, 273, 1, 9.00, 'Australia', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('HKW6197', 45, 'Female', 203, '156/106', 72, 1, 1, 1, 1, 0, 12.71, 'Unhealthy', 1, 0, 2, 1.08, 150259, 26.02, 515, 2, 6.00, 'India', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('RCB7108', 63, 'Male', 141, '103/75', 107, 1, 0, 1, 1, 1, 3.75, 'Unhealthy', 1, 1, 4, 9.70, 258559, 33.52, 187, 4, 8.00, 'Australia', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('ISA3150', 50, 'Male', 283, '103/61', 105, 1, 0, 1, 0, 0, 16.52, 'Average', 0, 1, 8, 10.71, 277215, 28.92, 544, 7, 6.00, 'New Zealand', 'Australia', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('UHW7173', 74, 'Female', 361, '105/103', 51, 0, 1, 1, 0, 1, 3.57, 'Unhealthy', 0, 1, 9, 5.03, 150064, 20.57, 784, 3, 8.00, 'Colombia', 'South America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('NBD0612', 29, 'Female', 200, '173/65', 109, 1, 1, 0, 1, 0, 11.32, 'Healthy', 1, 0, 8, 8.53, 220053, 21.54, 103, 6, 10.00, 'Australia', 'Australia', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('VTL9882', 73, 'Female', 220, '116/74', 68, 0, 0, 1, 1, 1, 14.99, 'Average', 1, 0, 9, 5.63, 212803, 33.60, 132, 6, 4.00, 'New Zealand', 'Australia', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('UTK7966', 85, 'Male', 201, '131/96', 82, 1, 1, 1, 0, 0, 16.64, 'Average', 0, 0, 10, 11.42, 21717, 23.20, 118, 4, 5.00, 'India', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('QMA7405', 78, 'Male', 244, '141/68', 64, 1, 0, 1, 0, 1, 3.31, 'Unhealthy', 1, 0, 5, 10.20, 213849, 18.41, 115, 3, 10.00, 'Colombia', 'South America', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('TWJ6230', 76, 'Male', 150, '99/108', 99, 1, 1, 1, 1, 1, 14.14, 'Unhealthy', 1, 1, 1, 4.62, 37467, 23.95, 544, 3, 4.00, 'Argentina', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('YMO9545', 46, 'Male', 295, '121/96', 90, 0, 1, 1, 1, 1, 15.51, 'Healthy', 1, 1, 9, 8.98, 59552, 39.62, 709, 0, 4.00, 'Canada', 'North America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('EDK0937', 56, 'Female', 287, '110/96', 95, 0, 0, 1, 0, 1, 7.51, 'Healthy', 1, 1, 9, 1.96, 68601, 23.77, 85, 1, 8.00, 'India', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('PMI1491', 74, 'Female', 339, '112/66', 58, 1, 1, 1, 1, 0, 18.75, 'Unhealthy', 1, 1, 4, 8.73, 26246, 29.41, 38, 4, 5.00, 'United States', 'North America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('YZE4908', 64, 'Male', 144, '133/70', 67, 1, 0, 1, 1, 0, 10.17, 'Average', 1, 1, 6, 10.89, 279143, 22.95, 117, 4, 10.00, 'Thailand', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('GLV2486', 26, 'Male', 382, '171/99', 67, 1, 1, 1, 0, 1, 7.04, 'Unhealthy', 1, 1, 9, 2.79, 77329, 39.92, 223, 4, 6.00, 'Italy', 'Europe', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('BRG9907', 40, 'Male', 354, '96/100', 79, 0, 0, 1, 0, 0, 0.27, 'Healthy', 0, 1, 7, 2.75, 270213, 31.96, 362, 7, 10.00, 'Colombia', 'South America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('YJN3447', 19, 'Female', 153, '180/92', 48, 1, 0, 0, 1, 1, 5.32, 'Average', 1, 0, 3, 6.69, 209450, 35.24, 411, 4, 8.00, 'France', 'Europe', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('VUW1193', 18, 'Male', 163, '142/67', 51, 1, 0, 1, 0, 0, 3.67, 'Unhealthy', 1, 1, 1, 1.04, 186141, 23.43, 614, 2, 4.00, 'Colombia', 'South America', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('IIR4559', 53, 'Female', 122, '156/75', 64, 1, 0, 1, 0, 0, 16.47, 'Average', 1, 1, 6, 4.41, 104654, 26.86, 133, 0, 8.00, 'France', 'Europe', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('PLH7490', 63, 'Male', 230, '162/67', 94, 1, 1, 1, 1, 1, 15.40, 'Healthy', 1, 1, 9, 9.49, 51289, 33.99, 547, 1, 9.00, 'Argentina', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('OMY0486', 36, 'Male', 225, '90/100', 91, 1, 0, 1, 0, 1, 3.45, 'Healthy', 1, 0, 1, 1.56, 54373, 37.49, 498, 6, 5.00, 'Vietnam', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('IYH1719', 67, 'Male', 363, '109/107', 60, 1, 0, 1, 0, 1, 12.39, 'Unhealthy', 0, 1, 7, 5.63, 134915, 21.69, 645, 3, 10.00, 'Germany', 'Europe', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('RCM4245', 50, 'Male', 173, '168/68', 72, 0, 1, 1, 1, 1, 19.01, 'Healthy', 1, 1, 8, 10.44, 151785, 36.93, 492, 6, 7.00, 'Italy', 'Europe', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('FXK2707', 64, 'Female', 265, '146/100', 41, 0, 1, 1, 0, 1, 8.15, 'Average', 0, 1, 7, 2.54, 52233, 27.11, 339, 3, 9.00, 'Japan', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('SXP6277', 75, 'Male', 352, '108/75', 55, 1, 1, 1, 1, 0, 0.39, 'Healthy', 1, 0, 6, 11.26, 171482, 32.27, 787, 7, 5.00, 'Argentina', 'South America', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('YTR7765', 26, 'Female', 228, '145/62', 108, 1, 0, 0, 0, 0, 0.80, 'Healthy', 1, 1, 9, 5.90, 169454, 22.86, 558, 7, 10.00, 'United Kingdom', 'Europe', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('VCB3963', 90, 'Male', 136, '168/68', 100, 0, 1, 1, 1, 0, 13.84, 'Unhealthy', 1, 1, 3, 9.05, 137071, 23.55, 733, 0, 8.00, 'India', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('JJP8674', 70, 'Male', 140, '112/108', 76, 0, 1, 1, 0, 1, 11.66, 'Average', 0, 0, 4, 1.10, 233933, 24.53, 697, 0, 8.00, 'South Korea', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('TLC3781', 24, 'Female', 196, '150/95', 50, 0, 1, 0, 0, 0, 6.23, 'Average', 1, 0, 4, 3.20, 223931, 19.93, 648, 1, 7.00, 'Japan', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('SIO9750', 77, 'Male', 172, '122/97', 76, 0, 1, 1, 1, 0, 4.54, 'Average', 0, 1, 4, 11.16, 32763, 27.36, 663, 2, 6.00, 'Nigeria', 'Africa', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('LUQ7573', 82, 'Female', 319, '161/77', 102, 0, 0, 1, 1, 0, 1.53, 'Average', 1, 1, 2, 3.29, 136486, 30.34, 291, 2, 4.00, 'Argentina', 'South America', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('ALW1741', 85, 'Female', 325, '115/61', 87, 0, 0, 1, 0, 1, 19.28, 'Average', 1, 0, 4, 11.72, 151317, 34.09, 502, 4, 10.00, 'United Kingdom', 'Europe', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('VAE5681', 25, 'Male', 162, '92/105', 93, 1, 1, 1, 1, 1, 12.46, 'Average', 0, 1, 5, 1.52, 157825, 27.59, 569, 6, 7.00, 'China', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('DSD1356', 67, 'Male', 331, '100/89', 102, 1, 1, 1, 1, 0, 12.70, 'Average', 0, 1, 2, 8.20, 152146, 26.67, 341, 7, 7.00, 'Australia', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('SCA4405', 77, 'Male', 392, '96/60', 94, 1, 1, 1, 1, 0, 16.04, 'Unhealthy', 1, 1, 3, 9.52, 180235, 19.99, 78, 7, 6.00, 'Vietnam', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('RXN2426', 39, 'Female', 220, '137/100', 75, 0, 1, 0, 1, 1, 16.35, 'Healthy', 1, 1, 4, 5.83, 62515, 19.01, 35, 7, 4.00, 'United Kingdom', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('MGU4677', 60, 'Female', 308, '94/109', 73, 1, 1, 1, 1, 1, 8.48, 'Average', 0, 0, 7, 11.05, 131723, 20.54, 81, 6, 8.00, 'India', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('VEL6785', 54, 'Female', 284, '93/102', 101, 0, 1, 1, 1, 0, 8.14, 'Healthy', 1, 0, 3, 0.61, 205263, 32.29, 257, 5, 5.00, 'Colombia', 'South America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('Jan-49', 60, 'Male', 147, '114/103', 101, 1, 1, 1, 0, 1, 17.14, 'Unhealthy', 0, 1, 4, 11.62, 140911, 26.32, 624, 3, 5.00, 'France', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('FUM7288', 36, 'Male', 193, '105/90', 61, 0, 1, 1, 1, 0, 10.50, 'Healthy', 0, 1, 3, 9.89, 203019, 26.00, 91, 6, 10.00, 'South Korea', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('BEG2015', 41, 'Female', 250, '90/78', 51, 0, 0, 1, 0, 1, 11.13, 'Unhealthy', 0, 1, 5, 3.44, 106922, 29.77, 374, 6, 8.00, 'South Africa', 'Africa', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('FPA6845', 87, 'Male', 122, '126/74', 108, 1, 0, 1, 1, 0, 1.43, 'Average', 0, 0, 3, 2.67, 30371, 25.05, 767, 2, 4.00, 'South Korea', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('XJI2791', 32, 'Male', 299, '177/75', 96, 0, 1, 1, 1, 0, 9.74, 'Average', 0, 0, 1, 2.13, 236984, 20.95, 270, 3, 7.00, 'France', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('NHU7732', 85, 'Male', 261, '179/104', 93, 1, 0, 1, 0, 0, 14.55, 'Healthy', 1, 0, 1, 10.53, 162314, 28.25, 797, 7, 9.00, 'South Korea', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('MLA0112', 46, 'Male', 187, '101/75', 95, 0, 0, 1, 0, 0, 19.61, 'Average', 0, 1, 3, 3.80, 183757, 29.12, 306, 3, 8.00, 'South Korea', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('XGD7682', 48, 'Female', 368, '172/86', 91, 0, 0, 1, 1, 1, 6.12, 'Average', 0, 1, 10, 1.57, 239320, 38.32, 446, 2, 7.00, 'Spain', 'Europe', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('NQJ4259', 79, 'Male', 346, '173/63', 85, 0, 1, 1, 0, 1, 19.85, 'Average', 0, 1, 2, 8.48, 139789, 29.79, 778, 0, 9.00, 'India', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('BGQ6260', 23, 'Female', 243, '177/95', 67, 0, 0, 0, 1, 1, 17.12, 'Unhealthy', 0, 0, 7, 3.43, 150608, 39.63, 464, 1, 9.00, 'Canada', 'North America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('WQL5946', 48, 'Female', 122, '93/62', 62, 1, 1, 1, 1, 0, 6.80, 'Healthy', 1, 0, 9, 7.16, 161237, 30.89, 164, 5, 7.00, 'United Kingdom', 'Europe', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('UOI8257', 61, 'Male', 338, '171/65', 82, 1, 1, 1, 1, 1, 6.92, 'Healthy', 1, 0, 5, 4.44, 53735, 21.46, 103, 3, 6.00, 'Vietnam', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('IHY0559', 69, 'Male', 234, '91/68', 96, 1, 0, 1, 1, 1, 4.20, 'Unhealthy', 1, 1, 6, 5.04, 202813, 34.39, 502, 3, 10.00, 'Canada', 'North America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('BAL8838', 59, 'Male', 294, '175/77', 51, 1, 1, 1, 0, 1, 0.02, 'Average', 1, 1, 4, 5.09, 21365, 37.93, 92, 7, 8.00, 'Thailand', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('YBI6619', 42, 'Female', 218, '143/83', 79, 1, 0, 1, 1, 1, 4.35, 'Average', 0, 1, 3, 9.47, 171299, 35.21, 450, 5, 6.00, 'Thailand', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('MSW1926', 18, 'Male', 304, '165/78', 95, 1, 1, 1, 0, 1, 12.71, 'Average', 1, 0, 6, 11.63, 298786, 20.05, 722, 4, 7.00, 'United Kingdom', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('VHL1612', 62, 'Female', 173, '163/63', 64, 1, 0, 1, 1, 1, 11.05, 'Average', 0, 1, 7, 5.14, 89349, 20.23, 556, 7, 5.00, 'South Africa', 'Africa', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('FKI0908', 77, 'Female', 286, '124/88', 64, 1, 0, 1, 0, 1, 1.21, 'Unhealthy', 0, 1, 1, 2.55, 121329, 37.56, 184, 2, 8.00, 'Italy', 'Europe', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('XUO9577', 69, 'Female', 359, '99/82', 110, 1, 0, 1, 0, 1, 15.85, 'Average', 0, 1, 9, 1.80, 197644, 25.32, 428, 7, 4.00, 'Nigeria', 'Africa', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('TEE0405', 78, 'Male', 273, '166/86', 67, 1, 0, 1, 1, 1, 19.90, 'Average', 0, 1, 6, 8.69, 171126, 22.61, 273, 4, 5.00, 'New Zealand', 'Australia', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('IDQ6872', 82, 'Female', 123, '165/78', 84, 1, 0, 1, 0, 0, 15.76, 'Unhealthy', 1, 1, 8, 10.33, 137246, 28.29, 796, 1, 5.00, 'Vietnam', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('XBZ9674', 36, 'Male', 124, '145/65', 43, 1, 1, 1, 0, 1, 4.10, 'Average', 1, 0, 4, 9.24, 59049, 35.74, 174, 2, 4.00, 'Colombia', 'South America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('OIV0569', 29, 'Male', 139, '158/76', 54, 1, 1, 1, 0, 1, 18.50, 'Unhealthy', 1, 0, 9, 5.90, 109419, 33.89, 656, 4, 9.00, 'Canada', 'North America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('MWZ5398', 25, 'Male', 244, '132/76', 103, 1, 0, 1, 1, 1, 8.10, 'Unhealthy', 0, 0, 6, 8.70, 38665, 27.61, 134, 1, 10.00, 'Germany', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('YRQ9870', 84, 'Female', 321, '163/106', 99, 1, 0, 1, 0, 1, 10.44, 'Unhealthy', 0, 1, 6, 5.08, 253943, 26.77, 196, 3, 10.00, 'South Africa', 'Africa', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('VCY3069', 80, 'Female', 263, '126/84', 59, 1, 0, 1, 0, 1, 14.80, 'Average', 1, 0, 10, 7.04, 277985, 21.93, 121, 4, 9.00, 'Australia', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('QDJ7359', 76, 'Male', 291, '107/83', 66, 1, 0, 1, 0, 1, 0.50, 'Healthy', 1, 1, 5, 5.92, 91055, 38.65, 744, 2, 5.00, 'Vietnam', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('ZJI5100', 66, 'Female', 318, '137/72', 43, 1, 1, 1, 0, 0, 11.94, 'Unhealthy', 1, 0, 8, 10.35, 203637, 19.60, 733, 7, 4.00, 'France', 'Europe', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('QYD6811', 18, 'Male', 399, '111/109', 63, 0, 1, 1, 0, 0, 7.57, 'Healthy', 0, 1, 5, 10.02, 261988, 27.35, 623, 1, 4.00, 'Colombia', 'South America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('OYV6908', 76, 'Male', 185, '114/80', 68, 1, 1, 1, 0, 1, 17.92, 'Average', 0, 0, 8, 5.67, 275954, 19.74, 522, 6, 8.00, 'India', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('KTY9107', 71, 'Male', 183, '160/61', 86, 0, 0, 1, 0, 0, 15.66, 'Average', 1, 0, 2, 7.85, 112462, 26.22, 376, 7, 8.00, 'South Africa', 'Africa', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('BXW5852', 22, 'Male', 151, '169/60', 43, 1, 1, 1, 1, 1, 12.92, 'Average', 1, 0, 9, 2.48, 167478, 32.08, 730, 4, 4.00, 'India', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('WPW0617', 56, 'Male', 300, '111/76', 95, 0, 1, 1, 1, 0, 8.27, 'Healthy', 0, 0, 7, 11.31, 153711, 28.28, 410, 1, 4.00, 'Nigeria', 'Africa', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('TYI7747', 35, 'Male', 358, '151/69', 53, 0, 1, 1, 1, 0, 6.77, 'Healthy', 1, 1, 9, 10.48, 105068, 31.38, 463, 6, 6.00, 'Brazil', 'South America', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('WAY4212', 42, 'Female', 165, '146/84', 109, 0, 0, 1, 0, 1, 6.18, 'Average', 0, 0, 8, 6.64, 279489, 34.05, 97, 4, 10.00, 'South Africa', 'Africa', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('NVB1072', 23, 'Female', 126, '139/99', 61, 1, 0, 0, 0, 0, 4.89, 'Healthy', 1, 0, 6, 11.08, 111047, 21.29, 99, 0, 7.00, 'United Kingdom', 'Europe', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('VSV3386', 90, 'Male', 203, '162/79', 71, 1, 0, 1, 0, 1, 9.33, 'Unhealthy', 0, 0, 4, 11.84, 283904, 21.21, 464, 2, 10.00, 'Spain', 'Europe', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('YNQ3329', 83, 'Male', 275, '95/74', 102, 1, 1, 1, 0, 0, 14.30, 'Average', 0, 0, 3, 9.82, 250467, 36.55, 593, 2, 10.00, 'South Africa', 'Africa', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('TBH2833', 67, 'Female', 343, '148/87', 46, 1, 0, 1, 1, 1, 17.99, 'Average', 1, 0, 8, 7.60, 156241, 39.16, 719, 7, 4.00, 'Argentina', 'South America', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('ROF8089', 67, 'Female', 366, '114/88', 107, 1, 1, 1, 1, 0, 10.74, 'Healthy', 1, 1, 4, 1.70, 143070, 18.34, 549, 3, 7.00, 'Colombia', 'South America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('NWW5751', 86, 'Male', 317, '117/64', 45, 0, 1, 1, 0, 1, 17.69, 'Unhealthy', 1, 0, 7, 6.53, 245266, 25.22, 47, 0, 5.00, 'Italy', 'Europe', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('CEY4537', 44, 'Female', 135, '90/103', 70, 1, 0, 1, 0, 1, 10.22, 'Unhealthy', 1, 0, 4, 9.15, 157088, 21.98, 148, 5, 8.00, 'United Kingdom', 'Europe', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('JOQ3887', 26, 'Female', 386, '159/87', 57, 1, 0, 0, 0, 0, 19.85, 'Average', 1, 0, 10, 9.16, 260829, 34.52, 302, 7, 10.00, 'Brazil', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('YZU1958', 80, 'Male', 259, '114/60', 98, 1, 1, 1, 1, 0, 3.59, 'Healthy', 1, 0, 4, 4.47, 203014, 33.75, 57, 4, 10.00, 'Argentina', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('EGC7479', 34, 'Male', 158, '147/91', 77, 1, 1, 1, 0, 0, 2.68, 'Healthy', 1, 1, 8, 9.49, 257229, 30.62, 280, 0, 5.00, 'Australia', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('YLM6170', 57, 'Male', 157, '178/106', 42, 1, 0, 1, 1, 0, 6.04, 'Healthy', 0, 0, 3, 11.61, 190120, 24.39, 389, 0, 9.00, 'New Zealand', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('EHN8840', 83, 'Female', 326, '99/83', 89, 1, 0, 1, 0, 0, 18.01, 'Healthy', 0, 0, 9, 10.73, 24274, 35.44, 180, 0, 4.00, 'China', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('NXO7861', 67, 'Male', 120, '139/106', 102, 0, 1, 1, 0, 1, 7.44, 'Unhealthy', 0, 0, 9, 10.57, 175221, 28.92, 717, 4, 7.00, 'Australia', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('UMW1846', 19, 'Male', 206, '165/103', 45, 1, 1, 1, 0, 0, 16.12, 'Healthy', 0, 0, 2, 5.39, 193418, 36.42, 239, 7, 5.00, 'Spain', 'Europe', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('KMG9748', 26, 'Male', 242, '178/104', 47, 1, 0, 1, 0, 0, 15.63, 'Healthy', 0, 1, 3, 10.08, 127291, 34.09, 629, 4, 10.00, 'Nigeria', 'Africa', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('GBU1842', 88, 'Male', 151, '162/66', 83, 1, 1, 1, 1, 1, 0.09, 'Unhealthy', 0, 0, 8, 0.27, 95608, 34.17, 294, 7, 5.00, 'China', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('FVR1432', 21, 'Male', 370, '162/73', 61, 1, 1, 1, 1, 0, 3.51, 'Healthy', 0, 1, 7, 11.46, 21679, 24.62, 186, 2, 8.00, 'Argentina', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('EML6491', 65, 'Male', 241, '161/79', 66, 1, 1, 1, 1, 1, 15.88, 'Average', 0, 1, 1, 11.55, 62935, 35.69, 700, 4, 10.00, 'United Kingdom', 'Europe', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('GOM4176', 28, 'Male', 311, '148/82', 62, 0, 0, 1, 1, 0, 15.40, 'Unhealthy', 0, 0, 8, 10.36, 33123, 21.04, 592, 3, 7.00, 'Spain', 'Europe', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('QWU3141', 50, 'Male', 365, '155/65', 110, 1, 1, 1, 1, 1, 1.42, 'Average', 1, 0, 9, 8.43, 199774, 33.78, 774, 5, 7.00, 'Canada', 'North America', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('WCW0650', 35, 'Male', 155, '171/67', 41, 0, 0, 1, 1, 1, 18.40, 'Healthy', 0, 1, 9, 6.18, 72569, 23.39, 181, 4, 9.00, 'United Kingdom', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('MFC2532', 74, 'Male', 237, '162/101', 58, 1, 0, 1, 1, 0, 0.07, 'Healthy', 1, 0, 5, 11.19, 289933, 29.91, 471, 1, 4.00, 'China', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('VNW7565', 84, 'Male', 195, '160/107', 78, 1, 0, 1, 1, 0, 4.85, 'Average', 1, 1, 7, 10.17, 50176, 28.05, 375, 6, 8.00, 'South Korea', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('AGS2988', 21, 'Male', 284, '158/92', 110, 1, 0, 1, 0, 1, 5.33, 'Healthy', 0, 0, 4, 1.87, 91485, 22.33, 388, 7, 8.00, 'Spain', 'Europe', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('IUI9926', 38, 'Female', 354, '139/69', 74, 1, 1, 0, 0, 0, 16.19, 'Healthy', 0, 1, 6, 3.92, 281484, 35.17, 155, 0, 5.00, 'China', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('ULO8651', 72, 'Female', 257, '167/74', 54, 1, 1, 1, 0, 1, 4.10, 'Unhealthy', 1, 0, 3, 2.74, 264511, 30.25, 467, 7, 10.00, 'Spain', 'Europe', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('KEM8350', 85, 'Female', 376, '101/67', 87, 1, 0, 1, 0, 1, 14.38, 'Healthy', 1, 1, 9, 4.34, 201076, 35.27, 603, 6, 4.00, 'New Zealand', 'Australia', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('SCF7137', 26, 'Male', 399, '112/109', 98, 0, 1, 1, 1, 1, 14.48, 'Average', 0, 0, 6, 0.85, 194384, 24.89, 616, 6, 6.00, 'Brazil', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('RGF8556', 32, 'Male', 348, '165/91', 104, 1, 0, 1, 1, 0, 17.03, 'Unhealthy', 0, 1, 9, 8.51, 86689, 19.60, 331, 5, 7.00, 'South Africa', 'Africa', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('XGC0081', 60, 'Female', 347, '97/78', 83, 0, 1, 1, 1, 0, 10.78, 'Healthy', 1, 0, 1, 11.81, 214528, 22.45, 521, 5, 10.00, 'Vietnam', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('KSR1075', 58, 'Male', 321, '141/104', 93, 0, 1, 1, 0, 1, 15.05, 'Unhealthy', 1, 0, 4, 9.83, 97233, 22.93, 380, 2, 10.00, 'New Zealand', 'Australia', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('JSV9471', 74, 'Male', 159, '103/72', 70, 0, 0, 1, 1, 0, 15.49, 'Average', 0, 1, 7, 10.93, 48943, 36.99, 778, 6, 5.00, 'Canada', 'North America', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('EFR0340', 77, 'Male', 321, '132/103', 41, 1, 1, 1, 0, 1, 12.40, 'Average', 1, 1, 8, 5.40, 72920, 38.21, 495, 1, 5.00, 'Thailand', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('NKF4625', 32, 'Female', 175, '141/78', 49, 0, 0, 0, 1, 1, 11.38, 'Average', 0, 0, 7, 0.46, 160680, 20.33, 267, 1, 7.00, 'Thailand', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('XCL5519', 80, 'Male', 316, '146/90', 51, 1, 0, 1, 1, 1, 13.58, 'Unhealthy', 0, 1, 1, 9.05, 210852, 24.10, 698, 7, 5.00, 'Argentina', 'South America', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('GMZ7138', 33, 'Female', 138, '177/66', 90, 1, 0, 0, 1, 0, 19.62, 'Average', 0, 0, 9, 8.27, 149575, 23.26, 318, 1, 6.00, 'Australia', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('IZV0688', 64, 'Male', 230, '120/84', 49, 1, 0, 1, 1, 0, 10.61, 'Average', 0, 0, 5, 5.50, 207208, 21.79, 410, 1, 7.00, 'Canada', 'North America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('NEY6909', 43, 'Male', 356, '119/72', 67, 1, 1, 1, 0, 1, 18.11, 'Unhealthy', 1, 0, 5, 7.00, 190006, 28.68, 207, 7, 10.00, 'New Zealand', 'Australia', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('KEC9602', 65, 'Male', 124, '101/87', 105, 0, 0, 1, 0, 1, 16.56, 'Healthy', 1, 1, 3, 6.11, 194568, 20.51, 780, 1, 6.00, 'Canada', 'North America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('PYL5477', 50, 'Male', 308, '140/80', 105, 1, 0, 1, 1, 0, 2.65, 'Healthy', 1, 1, 10, 10.59, 246809, 25.42, 579, 5, 6.00, 'Germany', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('VKY0282', 72, 'Male', 252, '157/101', 44, 1, 1, 1, 1, 1, 17.71, 'Average', 1, 0, 7, 0.87, 240018, 27.22, 51, 5, 6.00, 'United States', 'North America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('AOF0204', 71, 'Female', 213, '91/61', 110, 0, 0, 1, 1, 0, 3.21, 'Average', 0, 1, 3, 10.69, 174378, 34.48, 84, 4, 7.00, 'South Africa', 'Africa', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('THX6401', 61, 'Male', 261, '121/73', 103, 0, 1, 1, 1, 1, 7.66, 'Unhealthy', 1, 0, 7, 11.85, 147936, 32.91, 675, 3, 4.00, 'South Africa', 'Africa', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('STU6861', 38, 'Female', 190, '172/80', 98, 0, 0, 0, 0, 1, 8.63, 'Healthy', 0, 0, 1, 7.68, 144954, 18.63, 735, 1, 10.00, 'Argentina', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('VLD1162', 75, 'Male', 392, '131/67', 71, 1, 1, 1, 0, 1, 16.50, 'Average', 0, 0, 6, 1.27, 50029, 30.68, 425, 4, 10.00, 'Brazil', 'South America', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('PQL7102', 39, 'Male', 298, '125/64', 104, 1, 0, 1, 0, 1, 8.53, 'Average', 1, 1, 1, 0.96, 298655, 18.76, 310, 0, 8.00, 'New Zealand', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('MYN6230', 81, 'Male', 170, '100/104', 81, 1, 1, 1, 1, 1, 8.97, 'Healthy', 0, 0, 9, 6.45, 286374, 18.51, 126, 7, 9.00, 'Vietnam', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('UNR0089', 29, 'Female', 373, '101/106', 48, 0, 1, 0, 0, 1, 9.45, 'Healthy', 0, 1, 1, 2.33, 108812, 36.68, 56, 1, 10.00, 'Australia', 'Australia', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('YLI3019', 51, 'Male', 244, '140/89', 43, 0, 1, 1, 1, 1, 15.85, 'Healthy', 0, 1, 2, 3.45, 20375, 32.58, 394, 0, 7.00, 'India', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('UTO3905', 59, 'Male', 269, '108/104', 84, 1, 0, 1, 0, 0, 18.86, 'Healthy', 1, 1, 2, 5.37, 63242, 35.09, 472, 1, 7.00, 'China', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('WLY3711', 76, 'Male', 377, '98/96', 100, 0, 0, 1, 0, 1, 10.18, 'Average', 1, 1, 2, 2.38, 188946, 37.06, 669, 5, 8.00, 'South Africa', 'Africa', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('BCR8001', 21, 'Female', 202, '133/64', 43, 1, 0, 0, 0, 0, 2.84, 'Healthy', 0, 1, 10, 3.62, 122051, 34.70, 688, 3, 8.00, 'South Korea', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('AUW6865', 75, 'Male', 203, '116/82', 108, 1, 0, 1, 1, 0, 11.17, 'Healthy', 0, 0, 8, 10.41, 211915, 23.93, 655, 0, 10.00, 'Brazil', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('DTO8732', 22, 'Male', 370, '168/69', 110, 1, 1, 1, 0, 1, 9.04, 'Unhealthy', 1, 0, 6, 3.63, 200491, 24.96, 39, 7, 10.00, 'China', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('VCC8420', 76, 'Male', 296, '177/87', 79, 1, 1, 1, 1, 1, 15.21, 'Healthy', 0, 1, 9, 7.79, 239402, 27.22, 333, 5, 8.00, 'Japan', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('BTO2579', 62, 'Male', 202, '153/81', 65, 1, 1, 1, 1, 0, 10.94, 'Healthy', 1, 1, 1, 6.11, 167376, 38.94, 501, 2, 4.00, 'Brazil', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('FKE2991', 56, 'Male', 153, '103/96', 55, 1, 0, 1, 0, 0, 12.93, 'Healthy', 0, 1, 1, 4.57, 115503, 24.68, 232, 7, 8.00, 'Thailand', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('TNT2035', 29, 'Female', 394, '114/62', 95, 0, 1, 0, 0, 0, 3.48, 'Unhealthy', 1, 0, 7, 10.17, 292302, 26.02, 479, 7, 4.00, 'New Zealand', 'Australia', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('YAV3073', 67, 'Female', 359, '95/64', 63, 1, 0, 1, 1, 0, 10.14, 'Unhealthy', 0, 0, 2, 11.77, 76582, 36.06, 211, 1, 8.00, 'Colombia', 'South America', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('WYS5546', 45, 'Male', 129, '99/60', 100, 1, 1, 1, 0, 1, 2.85, 'Healthy', 0, 1, 5, 5.11, 220491, 23.74, 197, 1, 6.00, 'United States', 'North America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('FYQ1629', 54, 'Female', 212, '169/67', 66, 0, 0, 1, 1, 0, 19.30, 'Average', 0, 0, 7, 4.40, 51539, 28.79, 540, 1, 4.00, 'France', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('EPM2146', 23, 'Male', 267, '92/107', 64, 0, 1, 1, 1, 0, 14.23, 'Average', 0, 0, 3, 1.06, 276765, 38.32, 433, 5, 8.00, 'France', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('RVJ3813', 79, 'Male', 397, '175/67', 64, 1, 1, 1, 0, 1, 8.87, 'Average', 1, 1, 7, 3.10, 110048, 34.89, 179, 1, 5.00, 'Brazil', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('XBY2113', 28, 'Male', 352, '131/67', 43, 1, 0, 1, 0, 0, 12.69, 'Unhealthy', 0, 0, 3, 6.36, 226181, 32.51, 223, 3, 9.00, 'Colombia', 'South America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('NBU0726', 25, 'Male', 291, '123/106', 88, 1, 0, 1, 1, 0, 0.98, 'Average', 0, 1, 7, 6.24, 259397, 27.70, 551, 7, 7.00, 'Thailand', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('AVV5863', 83, 'Female', 368, '171/75', 95, 1, 1, 1, 1, 1, 7.28, 'Average', 0, 1, 2, 9.05, 296988, 26.12, 490, 5, 10.00, 'Colombia', 'South America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('LWB8244', 41, 'Female', 129, '92/108', 81, 1, 0, 1, 0, 1, 11.19, 'Average', 1, 1, 4, 2.42, 271326, 31.77, 204, 0, 10.00, 'South Korea', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('DBA0284', 89, 'Male', 229, '162/75', 57, 0, 1, 1, 1, 1, 18.53, 'Average', 1, 1, 9, 8.56, 264172, 33.74, 795, 2, 5.00, 'South Korea', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('YGC6271', 85, 'Male', 310, '163/96', 66, 1, 0, 1, 0, 1, 16.98, 'Healthy', 0, 1, 5, 9.87, 223172, 32.04, 267, 1, 8.00, 'Canada', 'North America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('DWI7052', 34, 'Male', 360, '158/60', 50, 1, 1, 1, 1, 1, 6.08, 'Average', 0, 0, 4, 5.25, 202637, 32.64, 644, 7, 4.00, 'United States', 'North America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('MMW1532', 80, 'Male', 341, '118/72', 84, 1, 0, 1, 1, 1, 17.66, 'Unhealthy', 1, 1, 1, 8.27, 235115, 21.85, 525, 6, 9.00, 'India', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('KQB2627', 27, 'Male', 253, '113/108', 65, 1, 0, 1, 0, 0, 14.03, 'Healthy', 0, 0, 10, 6.78, 175078, 34.64, 88, 6, 8.00, 'Italy', 'Europe', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('WMO3684', 26, 'Male', 183, '177/103', 93, 0, 0, 1, 0, 1, 15.97, 'Healthy', 0, 1, 6, 10.18, 249377, 22.01, 255, 1, 10.00, 'India', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('BCC7629', 36, 'Female', 319, '124/81', 45, 1, 0, 0, 0, 0, 3.92, 'Healthy', 1, 0, 1, 10.25, 138838, 28.04, 244, 7, 4.00, 'India', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('GAZ0067', 20, 'Male', 259, '104/108', 108, 0, 0, 1, 1, 1, 17.48, 'Average', 1, 1, 3, 10.81, 175627, 27.36, 546, 2, 6.00, 'Canada', 'North America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('CJA3176', 87, 'Male', 328, '147/97', 77, 0, 1, 1, 1, 0, 4.48, 'Average', 1, 0, 8, 2.60, 201510, 21.39, 486, 1, 4.00, 'Japan', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('HGA9732', 70, 'Female', 276, '160/69', 67, 1, 0, 1, 0, 1, 14.01, 'Average', 1, 0, 9, 4.40, 202088, 29.10, 320, 5, 9.00, 'United Kingdom', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('GPC7174', 49, 'Male', 384, '175/72', 65, 0, 0, 1, 1, 1, 4.63, 'Unhealthy', 0, 0, 2, 0.69, 140406, 37.55, 319, 5, 4.00, 'Germany', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('CQG3050', 21, 'Male', 253, '159/82', 40, 1, 0, 1, 1, 0, 5.27, 'Healthy', 0, 1, 3, 10.59, 236723, 21.25, 58, 0, 6.00, 'Vietnam', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('VAY6611', 27, 'Female', 296, '163/98', 78, 1, 1, 0, 1, 1, 7.10, 'Healthy', 0, 1, 6, 11.64, 207906, 29.33, 591, 0, 4.00, 'Italy', 'Europe', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('FEQ1964', 76, 'Male', 201, '108/104', 70, 1, 1, 1, 1, 0, 4.52, 'Healthy', 1, 0, 5, 7.96, 194461, 21.36, 165, 2, 4.00, 'United States', 'North America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('KTW5157', 72, 'Male', 145, '179/81', 47, 1, 1, 1, 0, 1, 4.65, 'Unhealthy', 0, 0, 3, 10.52, 176507, 36.34, 732, 3, 8.00, 'India', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('PDA0257', 77, 'Female', 303, '152/75', 109, 1, 1, 1, 0, 1, 2.28, 'Average', 1, 1, 1, 1.72, 123697, 28.04, 195, 1, 4.00, 'South Africa', 'Africa', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('EML8897', 31, 'Male', 314, '138/82', 102, 1, 0, 1, 0, 1, 2.18, 'Average', 0, 0, 1, 2.97, 102674, 36.70, 478, 3, 5.00, 'South Korea', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('UCE0281', 76, 'Male', 180, '101/64', 68, 1, 1, 1, 0, 0, 19.76, 'Unhealthy', 0, 1, 8, 9.33, 75901, 32.28, 461, 2, 5.00, 'India', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('NWZ9873', 69, 'Male', 190, '115/100', 85, 1, 0, 1, 1, 1, 9.20, 'Average', 1, 1, 7, 3.96, 231394, 18.00, 458, 6, 9.00, 'Canada', 'North America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('LHF7235', 61, 'Male', 250, '108/103', 97, 1, 1, 1, 1, 1, 3.68, 'Healthy', 1, 1, 9, 4.37, 137974, 21.09, 631, 4, 6.00, 'Nigeria', 'Africa', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('PSU2093', 88, 'Female', 209, '140/88', 76, 1, 0, 1, 0, 1, 1.86, 'Unhealthy', 0, 0, 6, 7.14, 105028, 24.79, 717, 2, 8.00, 'Colombia', 'South America', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('GAG2896', 26, 'Female', 194, '164/96', 110, 1, 0, 0, 0, 1, 4.29, 'Average', 1, 0, 7, 9.39, 43076, 36.03, 741, 7, 5.00, 'Japan', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('YVI8512', 53, 'Female', 294, '175/104', 45, 1, 0, 1, 0, 1, 7.81, 'Average', 1, 0, 2, 10.75, 284801, 29.07, 301, 3, 6.00, 'Argentina', 'South America', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('YBH3172', 70, 'Male', 265, '111/108', 60, 0, 1, 1, 0, 1, 17.86, 'Healthy', 1, 0, 3, 6.26, 291894, 19.54, 574, 4, 8.00, 'New Zealand', 'Australia', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('VHJ9494', 45, 'Female', 148, '160/98', 93, 0, 0, 1, 1, 1, 15.51, 'Healthy', 1, 1, 8, 3.40, 176112, 37.85, 50, 5, 8.00, 'Spain', 'Europe', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('OBX7266', 89, 'Female', 166, '152/107', 46, 1, 0, 1, 0, 1, 18.52, 'Healthy', 0, 0, 9, 1.19, 169933, 33.15, 315, 1, 6.00, 'Thailand', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('WXS2566', 41, 'Male', 204, '142/63', 54, 1, 1, 1, 1, 0, 8.78, 'Unhealthy', 0, 1, 9, 1.98, 118069, 31.35, 314, 3, 4.00, 'Italy', 'Europe', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('CSF6016', 18, 'Male', 159, '158/67', 58, 1, 1, 1, 1, 1, 11.44, 'Average', 1, 0, 2, 9.22, 278606, 22.57, 194, 7, 4.00, 'Colombia', 'South America', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('XYT8290', 67, 'Female', 200, '96/96', 91, 1, 1, 1, 1, 0, 18.09, 'Average', 1, 1, 7, 3.27, 241188, 28.95, 292, 1, 7.00, 'Colombia', 'South America', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('ZTA1405', 85, 'Female', 127, '122/89', 78, 1, 1, 1, 0, 1, 18.53, 'Healthy', 0, 0, 10, 2.62, 25496, 27.53, 555, 3, 10.00, 'South Africa', 'Africa', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('VYB5146', 23, 'Female', 201, '145/63', 79, 1, 1, 0, 1, 1, 14.78, 'Unhealthy', 0, 1, 8, 1.59, 99373, 20.79, 286, 6, 7.00, 'Germany', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('ZML0212', 61, 'Female', 344, '143/108', 79, 1, 1, 1, 0, 0, 17.07, 'Healthy', 0, 1, 4, 11.00, 107666, 36.98, 199, 4, 10.00, 'United Kingdom', 'Europe', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('JQO6134', 76, 'Female', 290, '131/91', 66, 1, 0, 1, 0, 1, 16.54, 'Healthy', 1, 1, 9, 11.09, 224877, 23.64, 160, 4, 6.00, 'Thailand', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('TOE8211', 52, 'Male', 205, '132/103', 76, 0, 1, 1, 1, 1, 8.80, 'Average', 1, 1, 2, 7.89, 238370, 30.94, 149, 3, 10.00, 'India', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('CVD9526', 46, 'Male', 295, '140/82', 91, 1, 1, 1, 0, 1, 4.10, 'Healthy', 0, 1, 4, 6.32, 246774, 29.63, 527, 4, 7.00, 'Colombia', 'South America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('BBF7318', 75, 'Male', 161, '134/100', 102, 0, 0, 1, 1, 0, 5.02, 'Average', 0, 0, 3, 2.44, 182515, 22.09, 115, 1, 10.00, 'France', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('JOE7050', 86, 'Male', 280, '129/94', 105, 1, 1, 1, 1, 1, 4.98, 'Average', 1, 1, 6, 9.26, 201645, 24.33, 406, 0, 10.00, 'Australia', 'Australia', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('WKQ4013', 34, 'Female', 269, '138/79', 65, 0, 0, 0, 1, 0, 18.90, 'Average', 0, 1, 4, 5.94, 80379, 20.38, 161, 4, 4.00, 'Spain', 'Europe', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('KQK7643', 34, 'Male', 185, '167/108', 47, 1, 0, 1, 1, 0, 9.51, 'Unhealthy', 1, 0, 8, 5.55, 38814, 24.87, 125, 7, 9.00, 'France', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('KTW5072', 86, 'Male', 295, '117/89', 52, 0, 1, 1, 1, 1, 6.32, 'Healthy', 0, 0, 5, 3.60, 168404, 36.59, 200, 0, 7.00, 'Thailand', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('TFX1105', 83, 'Male', 243, '93/108', 100, 1, 0, 1, 0, 1, 12.19, 'Average', 1, 0, 10, 5.01, 47175, 31.38, 277, 4, 6.00, 'Germany', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('WMA0365', 30, 'Male', 140, '131/101', 58, 0, 0, 1, 1, 1, 8.92, 'Healthy', 0, 0, 10, 3.08, 28797, 22.13, 308, 3, 9.00, 'Canada', 'North America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('BNQ1608', 80, 'Male', 132, '142/107', 51, 1, 0, 1, 0, 0, 12.79, 'Healthy', 0, 1, 6, 6.71, 103777, 35.01, 784, 4, 6.00, 'Colombia', 'South America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('WFR1570', 41, 'Male', 335, '112/75', 43, 1, 1, 1, 0, 0, 6.98, 'Unhealthy', 1, 1, 9, 11.84, 126596, 35.75, 51, 6, 6.00, 'Brazil', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('EMG4617', 69, 'Male', 132, '128/92', 60, 0, 0, 1, 1, 1, 10.28, 'Unhealthy', 1, 0, 9, 10.22, 161549, 26.41, 69, 0, 7.00, 'United Kingdom', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('OQD2740', 41, 'Male', 374, '117/98', 83, 0, 0, 1, 1, 0, 18.55, 'Healthy', 1, 1, 7, 9.98, 273899, 20.96, 286, 2, 6.00, 'India', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('RPJ7752', 18, 'Male', 356, '156/103', 54, 1, 1, 1, 1, 1, 3.50, 'Unhealthy', 0, 0, 6, 9.12, 56227, 37.41, 427, 4, 4.00, 'South Korea', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('AHF8900', 79, 'Male', 301, '96/66', 101, 1, 1, 1, 0, 1, 1.09, 'Healthy', 0, 0, 2, 7.55, 132271, 38.03, 779, 6, 6.00, 'South Africa', 'Africa', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('OSV3898', 55, 'Female', 126, '104/102', 59, 0, 1, 1, 1, 0, 19.71, 'Healthy', 0, 0, 5, 11.18, 297321, 39.29, 236, 3, 8.00, 'Brazil', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('BZA4960', 19, 'Male', 193, '145/96', 89, 0, 0, 1, 0, 0, 14.55, 'Unhealthy', 0, 0, 7, 7.54, 211414, 24.58, 202, 4, 10.00, 'New Zealand', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('PNK2263', 75, 'Female', 319, '94/62', 85, 1, 1, 1, 0, 1, 7.74, 'Average', 1, 1, 6, 2.61, 232143, 36.77, 77, 3, 9.00, 'France', 'Europe', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('RSF4019', 31, 'Female', 277, '176/97', 63, 1, 1, 0, 1, 0, 19.75, 'Healthy', 0, 1, 1, 9.17, 78445, 28.44, 500, 2, 6.00, 'China', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('ZOY4018', 50, 'Male', 198, '112/71', 57, 1, 0, 1, 1, 1, 12.03, 'Healthy', 0, 1, 8, 1.96, 95865, 23.36, 601, 2, 8.00, 'Nigeria', 'Africa', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('OEZ7393', 70, 'Male', 213, '153/83', 50, 1, 0, 1, 0, 0, 7.78, 'Unhealthy', 1, 0, 4, 2.80, 56378, 30.84, 255, 4, 4.00, 'United Kingdom', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('DVE3895', 33, 'Female', 267, '94/86', 100, 0, 1, 0, 0, 0, 0.72, 'Average', 0, 0, 8, 7.86, 166848, 23.68, 269, 7, 10.00, 'Nigeria', 'Africa', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('AFU8750', 49, 'Female', 335, '136/83', 95, 1, 1, 1, 1, 1, 7.24, 'Unhealthy', 0, 0, 7, 6.51, 168024, 33.11, 425, 3, 4.00, 'Colombia', 'South America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('UCU0940', 26, 'Female', 213, '125/78', 44, 1, 0, 0, 0, 0, 8.92, 'Unhealthy', 1, 1, 1, 11.66, 110616, 23.16, 191, 2, 5.00, 'New Zealand', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('AIY9747', 65, 'Female', 308, '105/96', 105, 1, 1, 1, 1, 0, 18.76, 'Unhealthy', 0, 0, 4, 8.67, 43556, 21.90, 479, 7, 8.00, 'China', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('CXO1479', 21, 'Male', 196, '168/105', 48, 0, 1, 1, 0, 1, 11.58, 'Unhealthy', 1, 1, 5, 8.11, 184318, 26.16, 79, 5, 6.00, 'Thailand', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('LKE3475', 20, 'Male', 206, '142/93', 80, 0, 0, 1, 0, 1, 9.82, 'Average', 1, 0, 8, 4.59, 269569, 36.71, 231, 0, 5.00, 'Nigeria', 'Africa', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('TFV1722', 52, 'Female', 322, '157/62', 66, 1, 0, 1, 1, 1, 8.76, 'Unhealthy', 0, 0, 1, 0.50, 285490, 25.26, 168, 7, 8.00, 'South Africa', 'Africa', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('VHY7394', 25, 'Male', 291, '141/102', 75, 1, 0, 1, 1, 1, 19.39, 'Average', 0, 0, 1, 7.38, 95625, 24.36, 709, 4, 6.00, 'China', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('KTF7352', 51, 'Female', 179, '161/63', 67, 1, 0, 1, 1, 1, 2.77, 'Average', 1, 1, 4, 3.43, 23985, 32.10, 398, 7, 10.00, 'Argentina', 'South America', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('QXI7953', 68, 'Male', 380, '176/77', 72, 1, 1, 1, 1, 1, 0.39, 'Average', 0, 1, 7, 11.79, 152688, 29.24, 575, 2, 4.00, 'Canada', 'North America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('NBT8626', 45, 'Male', 128, '162/91', 40, 1, 1, 1, 0, 1, 1.86, 'Average', 1, 1, 4, 3.75, 132314, 27.39, 319, 0, 4.00, 'Thailand', 'Asia', 'Northern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('ZOF8895', 82, 'Male', 266, '167/103', 102, 0, 1, 1, 0, 1, 3.37, 'Average', 1, 1, 4, 10.58, 233769, 24.22, 606, 7, 8.00, 'United States', 'North America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('AWU6228', 69, 'Female', 346, '101/84', 45, 1, 1, 1, 0, 0, 1.74, 'Healthy', 1, 0, 4, 3.91, 66662, 37.68, 355, 4, 5.00, 'Germany', 'Europe', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('ING6106', 69, 'Female', 199, '116/80', 85, 1, 1, 1, 0, 0, 0.05, 'Average', 1, 0, 10, 7.23, 285955, 25.51, 55, 1, 10.00, 'New Zealand', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('CIV0067', 22, 'Male', 399, '141/85', 99, 1, 0, 1, 0, 0, 17.49, 'Average', 1, 0, 8, 9.66, 26329, 35.76, 636, 0, 5.00, 'Nigeria', 'Africa', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('ZQC1238', 19, 'Female', 143, '151/60', 42, 0, 0, 0, 1, 1, 5.09, 'Average', 0, 1, 7, 3.76, 287151, 37.18, 64, 4, 5.00, 'Vietnam', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('RQS7383', 48, 'Male', 312, '121/95', 95, 1, 0, 1, 1, 1, 9.02, 'Average', 0, 0, 4, 5.79, 250386, 23.19, 780, 4, 9.00, 'China', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('FJG4009', 66, 'Male', 288, '90/72', 99, 1, 0, 1, 0, 1, 17.35, 'Healthy', 1, 1, 8, 0.40, 201188, 32.00, 575, 7, 10.00, 'Australia', 'Australia', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('SHO0718', 27, 'Male', 395, '99/94', 81, 1, 1, 1, 0, 1, 8.06, 'Unhealthy', 1, 0, 10, 11.86, 91890, 26.95, 515, 0, 6.00, 'Argentina', 'South America', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('GMP5640', 59, 'Male', 149, '143/67', 104, 1, 1, 1, 1, 1, 5.35, 'Average', 0, 1, 8, 7.03, 220645, 24.20, 97, 7, 6.00, 'Japan', 'Asia', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('DFW2933', 56, 'Female', 273, '171/70', 90, 1, 1, 1, 0, 0, 8.90, 'Average', 1, 1, 2, 1.36, 55412, 30.51, 251, 2, 4.00, 'Colombia', 'South America', 'Northern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('XFP2219', 81, 'Female', 163, '178/105', 74, 1, 0, 1, 1, 0, 9.51, 'Unhealthy', 0, 0, 1, 8.73, 20858, 39.32, 245, 5, 10.00, 'New Zealand', 'Australia', 'Southern Hemisphere', 0);
INSERT INTO public.staging_table VALUES ('KFX0233', 43, 'Female', 247, '139/100', 74, 1, 1, 1, 1, 1, 15.68, 'Average', 1, 1, 10, 1.99, 108436, 33.19, 228, 6, 5.00, 'New Zealand', 'Australia', 'Southern Hemisphere', 1);
INSERT INTO public.staging_table VALUES ('SXI5502', 25, 'Male', 337, '170/89', 104, 1, 0, 1, 0, 1, 16.02, 'Average', 0, 0, 4, 2.26, 168088, 18.52, 719, 1, 7.00, 'United Kingdom', 'Europe', 'Northern Hemisphere', 1);


--
-- Name: bridgepatientriskfactor_bridgekey_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bridgepatientriskfactor_bridgekey_seq', 1044, true);


--
-- Name: dimcountry_countrykey_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dimcountry_countrykey_seq', 120, true);


--
-- Name: dimdiet_dietkey_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dimdiet_dietkey_seq', 18, true);


--
-- Name: dimpatient_patientkey_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dimpatient_patientkey_seq', 3048, true);


--
-- Name: dimriskfactor_riskfactorkey_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dimriskfactor_riskfactorkey_seq', 18, true);


--
-- Name: dimtime_timekey_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dimtime_timekey_seq', 1, false);


--
-- Name: factheartattackrisk_factkey_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.factheartattackrisk_factkey_seq', 508, true);


--
-- Name: bridgepatientriskfactor bridgepatientriskfactor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bridgepatientriskfactor
    ADD CONSTRAINT bridgepatientriskfactor_pkey PRIMARY KEY (bridgekey);


--
-- Name: dimcountry dimcountry_countryname_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dimcountry
    ADD CONSTRAINT dimcountry_countryname_key UNIQUE (countryname);


--
-- Name: dimcountry dimcountry_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dimcountry
    ADD CONSTRAINT dimcountry_pkey PRIMARY KEY (countrykey);


--
-- Name: dimdiet dimdiet_diettype_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dimdiet
    ADD CONSTRAINT dimdiet_diettype_key UNIQUE (diettype);


--
-- Name: dimdiet dimdiet_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dimdiet
    ADD CONSTRAINT dimdiet_pkey PRIMARY KEY (dietkey);


--
-- Name: dimpatient dimpatient_patientid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dimpatient
    ADD CONSTRAINT dimpatient_patientid_key UNIQUE (patientid);


--
-- Name: dimpatient dimpatient_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dimpatient
    ADD CONSTRAINT dimpatient_pkey PRIMARY KEY (patientkey);


--
-- Name: dimriskfactor dimriskfactor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dimriskfactor
    ADD CONSTRAINT dimriskfactor_pkey PRIMARY KEY (riskfactorkey);


--
-- Name: dimriskfactor dimriskfactor_riskfactorname_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dimriskfactor
    ADD CONSTRAINT dimriskfactor_riskfactorname_key UNIQUE (riskfactorname);


--
-- Name: dimtime dimtime_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dimtime
    ADD CONSTRAINT dimtime_pkey PRIMARY KEY (timekey);


--
-- Name: factheartattackrisk factheartattackrisk_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factheartattackrisk
    ADD CONSTRAINT factheartattackrisk_pkey PRIMARY KEY (factkey);


--
-- Name: bridgepatientriskfactor uc_patient_risk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bridgepatientriskfactor
    ADD CONSTRAINT uc_patient_risk UNIQUE (patientkey, riskfactorkey);


--
-- Name: factheartattackrisk fk_dimcountry; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factheartattackrisk
    ADD CONSTRAINT fk_dimcountry FOREIGN KEY (countrykey) REFERENCES public.dimcountry(countrykey) ON DELETE CASCADE;


--
-- Name: factheartattackrisk fk_dimdiet; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factheartattackrisk
    ADD CONSTRAINT fk_dimdiet FOREIGN KEY (dietkey) REFERENCES public.dimdiet(dietkey) ON DELETE CASCADE;


--
-- Name: factheartattackrisk fk_dimpatient; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factheartattackrisk
    ADD CONSTRAINT fk_dimpatient FOREIGN KEY (patientkey) REFERENCES public.dimpatient(patientkey) ON DELETE CASCADE;


--
-- Name: factheartattackrisk fk_dimtime; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factheartattackrisk
    ADD CONSTRAINT fk_dimtime FOREIGN KEY (timekey) REFERENCES public.dimtime(timekey) ON DELETE SET NULL;


--
-- Name: bridgepatientriskfactor fk_patient_bridge; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bridgepatientriskfactor
    ADD CONSTRAINT fk_patient_bridge FOREIGN KEY (patientkey) REFERENCES public.dimpatient(patientkey) ON DELETE CASCADE;


--
-- Name: bridgepatientriskfactor fk_riskfactor_bridge; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bridgepatientriskfactor
    ADD CONSTRAINT fk_riskfactor_bridge FOREIGN KEY (riskfactorkey) REFERENCES public.dimriskfactor(riskfactorkey) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

