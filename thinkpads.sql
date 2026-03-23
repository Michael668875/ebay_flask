--
-- PostgreSQL database dump
--

\restrict GJQUjOuPLO201eHWLJZU7pWoFKm1kPYaQuTebpb1dkej0E3lbPjL32vQkGf8TY3

-- Dumped from database version 18.2
-- Dumped by pg_dump version 18.2

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
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: thinkpaduser
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO thinkpaduser;

--
-- Name: cpu; Type: TABLE; Schema: public; Owner: thinkpaduser
--

CREATE TABLE public.cpu (
    id integer NOT NULL,
    name character varying(120) NOT NULL
);


ALTER TABLE public.cpu OWNER TO thinkpaduser;

--
-- Name: cpu_id_seq; Type: SEQUENCE; Schema: public; Owner: thinkpaduser
--

CREATE SEQUENCE public.cpu_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cpu_id_seq OWNER TO thinkpaduser;

--
-- Name: cpu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thinkpaduser
--

ALTER SEQUENCE public.cpu_id_seq OWNED BY public.cpu.id;


--
-- Name: listings; Type: TABLE; Schema: public; Owner: thinkpaduser
--

CREATE TABLE public.listings (
    id integer NOT NULL,
    category_id character varying(20),
    ebay_item_id character varying NOT NULL,
    title character varying,
    price numeric(10,2),
    currency character varying(10) NOT NULL,
    condition character varying,
    listing_type character varying(50),
    marketplace character varying,
    item_url text,
    status character varying,
    first_seen timestamp with time zone,
    last_seen timestamp with time zone,
    last_updated timestamp with time zone,
    item_country character varying(2),
    miss_count integer DEFAULT 0 NOT NULL,
    ended_at timestamp without time zone
);


ALTER TABLE public.listings OWNER TO thinkpaduser;

--
-- Name: listings_id_seq; Type: SEQUENCE; Schema: public; Owner: thinkpaduser
--

CREATE SEQUENCE public.listings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.listings_id_seq OWNER TO thinkpaduser;

--
-- Name: listings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thinkpaduser
--

ALTER SEQUENCE public.listings_id_seq OWNED BY public.listings.id;


--
-- Name: marketplaces; Type: TABLE; Schema: public; Owner: thinkpaduser
--

CREATE TABLE public.marketplaces (
    id integer NOT NULL,
    country_code character varying(10) NOT NULL,
    marketplace_id character varying(20) NOT NULL,
    enabled boolean
);


ALTER TABLE public.marketplaces OWNER TO thinkpaduser;

--
-- Name: marketplaces_id_seq; Type: SEQUENCE; Schema: public; Owner: thinkpaduser
--

CREATE SEQUENCE public.marketplaces_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.marketplaces_id_seq OWNER TO thinkpaduser;

--
-- Name: marketplaces_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thinkpaduser
--

ALTER SEQUENCE public.marketplaces_id_seq OWNED BY public.marketplaces.id;


--
-- Name: model_list; Type: TABLE; Schema: public; Owner: thinkpaduser
--

CREATE TABLE public.model_list (
    id integer NOT NULL,
    name character varying(120) NOT NULL,
    slug character varying NOT NULL
);


ALTER TABLE public.model_list OWNER TO thinkpaduser;

--
-- Name: model_list_id_seq; Type: SEQUENCE; Schema: public; Owner: thinkpaduser
--

CREATE SEQUENCE public.model_list_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.model_list_id_seq OWNER TO thinkpaduser;

--
-- Name: model_list_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thinkpaduser
--

ALTER SEQUENCE public.model_list_id_seq OWNED BY public.model_list.id;


--
-- Name: model_price_stats; Type: TABLE; Schema: public; Owner: thinkpaduser
--

CREATE TABLE public.model_price_stats (
    id integer NOT NULL,
    model_id integer,
    avg_price numeric(10,2),
    min_price numeric(10,2),
    max_price numeric(10,2),
    listing_count integer,
    updated_at timestamp with time zone,
    marketplace character varying
);


ALTER TABLE public.model_price_stats OWNER TO thinkpaduser;

--
-- Name: model_price_stats_id_seq; Type: SEQUENCE; Schema: public; Owner: thinkpaduser
--

CREATE SEQUENCE public.model_price_stats_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.model_price_stats_id_seq OWNER TO thinkpaduser;

--
-- Name: model_price_stats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thinkpaduser
--

ALTER SEQUENCE public.model_price_stats_id_seq OWNED BY public.model_price_stats.id;


--
-- Name: models; Type: TABLE; Schema: public; Owner: thinkpaduser
--

CREATE TABLE public.models (
    id integer NOT NULL,
    name character varying,
    canon_model_id integer,
    raw_model character varying,
    raw_mpn character varying,
    parsed_aspect character varying,
    parsed_title character varying,
    parsed_mpn character varying,
    model_source character varying,
    listing_id integer NOT NULL
);


ALTER TABLE public.models OWNER TO thinkpaduser;

--
-- Name: models_id_seq; Type: SEQUENCE; Schema: public; Owner: thinkpaduser
--

CREATE SEQUENCE public.models_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.models_id_seq OWNER TO thinkpaduser;

--
-- Name: models_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thinkpaduser
--

ALTER SEQUENCE public.models_id_seq OWNED BY public.models.id;


--
-- Name: price_history; Type: TABLE; Schema: public; Owner: thinkpaduser
--

CREATE TABLE public.price_history (
    id integer NOT NULL,
    listing_id integer,
    price numeric(10,2),
    currency character varying(10) NOT NULL,
    recorded_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.price_history OWNER TO thinkpaduser;

--
-- Name: price_history_id_seq; Type: SEQUENCE; Schema: public; Owner: thinkpaduser
--

CREATE SEQUENCE public.price_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.price_history_id_seq OWNER TO thinkpaduser;

--
-- Name: price_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thinkpaduser
--

ALTER SEQUENCE public.price_history_id_seq OWNED BY public.price_history.id;


--
-- Name: ram; Type: TABLE; Schema: public; Owner: thinkpaduser
--

CREATE TABLE public.ram (
    id integer NOT NULL,
    size character varying(20) NOT NULL
);


ALTER TABLE public.ram OWNER TO thinkpaduser;

--
-- Name: ram_id_seq; Type: SEQUENCE; Schema: public; Owner: thinkpaduser
--

CREATE SEQUENCE public.ram_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ram_id_seq OWNER TO thinkpaduser;

--
-- Name: ram_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thinkpaduser
--

ALTER SEQUENCE public.ram_id_seq OWNED BY public.ram.id;


--
-- Name: specs; Type: TABLE; Schema: public; Owner: thinkpaduser
--

CREATE TABLE public.specs (
    id integer NOT NULL,
    cpu character varying,
    cpu_freq character varying(50),
    ram double precision,
    storage double precision,
    storage_type character varying,
    screen_size character varying,
    display character varying,
    gpu character varying,
    os character varying,
    listing_id integer,
    raw_ram character varying,
    raw_storage character varying,
    raw_storage_type character varying,
    ram_processed boolean DEFAULT false NOT NULL,
    storage_processed boolean DEFAULT false NOT NULL,
    storage_type_processed boolean DEFAULT false NOT NULL
);


ALTER TABLE public.specs OWNER TO thinkpaduser;

--
-- Name: specs_id_seq; Type: SEQUENCE; Schema: public; Owner: thinkpaduser
--

CREATE SEQUENCE public.specs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.specs_id_seq OWNER TO thinkpaduser;

--
-- Name: specs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thinkpaduser
--

ALTER SEQUENCE public.specs_id_seq OWNED BY public.specs.id;


--
-- Name: storage; Type: TABLE; Schema: public; Owner: thinkpaduser
--

CREATE TABLE public.storage (
    id integer NOT NULL,
    size character varying(20) NOT NULL
);


ALTER TABLE public.storage OWNER TO thinkpaduser;

--
-- Name: storage_id_seq; Type: SEQUENCE; Schema: public; Owner: thinkpaduser
--

CREATE SEQUENCE public.storage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.storage_id_seq OWNER TO thinkpaduser;

--
-- Name: storage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thinkpaduser
--

ALTER SEQUENCE public.storage_id_seq OWNED BY public.storage.id;


--
-- Name: temp_details; Type: TABLE; Schema: public; Owner: thinkpaduser
--

CREATE TABLE public.temp_details (
    id integer NOT NULL,
    cpu character varying,
    cpu_freq character varying(50),
    ram character varying,
    storage character varying,
    storage_type character varying,
    screen_size character varying,
    display character varying,
    gpu character varying,
    os character varying,
    model character varying,
    seller_username character varying,
    seller_feedback_score integer,
    seller_feedback_percent numeric(5,2),
    ebay_item_id character varying NOT NULL,
    mpn character varying
);


ALTER TABLE public.temp_details OWNER TO thinkpaduser;

--
-- Name: temp_details_id_seq; Type: SEQUENCE; Schema: public; Owner: thinkpaduser
--

CREATE SEQUENCE public.temp_details_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.temp_details_id_seq OWNER TO thinkpaduser;

--
-- Name: temp_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thinkpaduser
--

ALTER SEQUENCE public.temp_details_id_seq OWNED BY public.temp_details.id;


--
-- Name: temp_summaries; Type: TABLE; Schema: public; Owner: thinkpaduser
--

CREATE TABLE public.temp_summaries (
    id integer NOT NULL,
    category_id character varying(20),
    ebay_item_id character varying NOT NULL,
    title character varying,
    price numeric(10,2),
    currency character varying(10) NOT NULL,
    condition character varying,
    listing_type character varying(50),
    marketplace character varying,
    item_url text,
    creation_date timestamp with time zone,
    first_seen timestamp with time zone,
    last_seen timestamp with time zone,
    sold_at timestamp with time zone,
    last_updated timestamp with time zone,
    item_country character varying(2)
);


ALTER TABLE public.temp_summaries OWNER TO thinkpaduser;

--
-- Name: temp_summaries_id_seq; Type: SEQUENCE; Schema: public; Owner: thinkpaduser
--

CREATE SEQUENCE public.temp_summaries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.temp_summaries_id_seq OWNER TO thinkpaduser;

--
-- Name: temp_summaries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thinkpaduser
--

ALTER SEQUENCE public.temp_summaries_id_seq OWNED BY public.temp_summaries.id;


--
-- Name: cpu id; Type: DEFAULT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.cpu ALTER COLUMN id SET DEFAULT nextval('public.cpu_id_seq'::regclass);


--
-- Name: listings id; Type: DEFAULT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.listings ALTER COLUMN id SET DEFAULT nextval('public.listings_id_seq'::regclass);


--
-- Name: marketplaces id; Type: DEFAULT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.marketplaces ALTER COLUMN id SET DEFAULT nextval('public.marketplaces_id_seq'::regclass);


--
-- Name: model_list id; Type: DEFAULT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.model_list ALTER COLUMN id SET DEFAULT nextval('public.model_list_id_seq'::regclass);


--
-- Name: model_price_stats id; Type: DEFAULT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.model_price_stats ALTER COLUMN id SET DEFAULT nextval('public.model_price_stats_id_seq'::regclass);


--
-- Name: models id; Type: DEFAULT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.models ALTER COLUMN id SET DEFAULT nextval('public.models_id_seq'::regclass);


--
-- Name: price_history id; Type: DEFAULT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.price_history ALTER COLUMN id SET DEFAULT nextval('public.price_history_id_seq'::regclass);


--
-- Name: ram id; Type: DEFAULT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.ram ALTER COLUMN id SET DEFAULT nextval('public.ram_id_seq'::regclass);


--
-- Name: specs id; Type: DEFAULT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.specs ALTER COLUMN id SET DEFAULT nextval('public.specs_id_seq'::regclass);


--
-- Name: storage id; Type: DEFAULT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.storage ALTER COLUMN id SET DEFAULT nextval('public.storage_id_seq'::regclass);


--
-- Name: temp_details id; Type: DEFAULT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.temp_details ALTER COLUMN id SET DEFAULT nextval('public.temp_details_id_seq'::regclass);


--
-- Name: temp_summaries id; Type: DEFAULT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.temp_summaries ALTER COLUMN id SET DEFAULT nextval('public.temp_summaries_id_seq'::regclass);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: thinkpaduser
--

COPY public.alembic_version (version_num) FROM stdin;
8f58b1c402c1
\.


--
-- Data for Name: cpu; Type: TABLE DATA; Schema: public; Owner: thinkpaduser
--

COPY public.cpu (id, name) FROM stdin;
1	i3
2	i5
3	i7
4	i9
5	Xeon
6	Pentium
7	Celeron
8	Core M
9	Atom
10	Ryzen 3
11	Ryzen 5
12	Ryzen 7
13	Ryzen 9
14	Athlon
15	A-series
16	Core 2 Duo
17	Core 2 Quad
18	Intel Core i7 10th Gen
19	11th Gen Intel(R) Core(TM) i5-1135G7 @ 2.40GHz
20	Intel Core i5 11th Gen.
21	Intel® Celeron® 1007U
22	intel Core i5-10210U
23	Intel® Core™ i5 i5-8250U
24	Intel Core i5 8th Gen.
25	i7-4600U
26	i7-5600U
27	Intel Core i7 10th Gen.
28	intel core i5 8th gen
29	Intel Core i5
30	AMD Ryzen 5 4500U
31	Intel Core i7 10th Generation
32	Intel Core i7 8th Gen.
33	i7-7600u
34	AMD Ryzen 5 PRO 3500U w/ Radeon Vega Mobile Graphics
35	Intel Core i5 10th Gen.
36	Intel Core i7 1165G7
37	Intel I5 11th Gen
38	Intel Core i5 4th Gen.
39	Intel Core i5-8350U
40	i7-1165G7
41	intel Core i5-8265U
42	Intel Core i5-1135G7
43	Intel Core i7-6600U
44	Intel Core i5 2nd Gen.
45	Intel Core i7-7500U
46	Intel Core i7-8565U
47	Intel Core i5-1145G7
\.


--
-- Data for Name: listings; Type: TABLE DATA; Schema: public; Owner: thinkpaduser
--

COPY public.listings (id, category_id, ebay_item_id, title, price, currency, condition, listing_type, marketplace, item_url, status, first_seen, last_seen, last_updated, item_country, miss_count, ended_at) FROM stdin;
35414	177	v1|227266548359|0	ThinkPad X230/8GB/Windows10LTSC/	135.90	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/227266548359?_skw=thinkpad&hash=item34ea245287:g:zvgAAeSwpyZpvoDq	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35241	177	v1|117100719751|0	Lenovo 14" ThinkPad X1 Carbon Gen 12	1487.97	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/117100719751?_skw=thinkpad&hash=item1b43bf2e87:g:2YQAAeSwEvxpvzsP	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35812	177	v1|389778637303|0	thinkpad t14 gen 1	719.05	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/389778637303?_skw=thinkpad&hash=item5ac09e01f7:g:rc4AAeSwfKJpvpmt	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	CA	0	\N
35839	177	v1|198210349824|0	Lenovo ThinkPad T480S i7-8650U  16GB Ram 512 GB SSD Win 11 Pro	482.06	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/198210349824?_skw=thinkpad&hash=item2e2641eb00:g:7i8AAeSwQ6lpvewb	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35167	177	v1|389781630846|0	Lenovo ThinkPad E16 G2 16 inch FHD+ Ryzen 7 7735HS 32GB DDR5 1TB SSD WiFi 6E Win	349.00	USD	New	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/389781630846?_skw=thinkpad&hash=item5ac0cbaf7e:g:nokAAeSwfcVpv5iz	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35168	177	v1|227267632017|0	Lenovo ThinkPad T14s Gen 1 Ryzen 7 PRO 4750U 16GB 512GB SSD Touch 14" Win11 Pro	259.99	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/227267632017?_skw=thinkpad&hash=item34ea34db91:g:Gz8AAeSwJFBpv5Yk	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35169	177	v1|389781610723|0	Lenovo ThinkPad E550 (LOT OF 6) 14" Intel Core i3-5005U 2GHz 4GB RAM Working*	359.00	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/389781610723?_skw=thinkpad&hash=item5ac0cb60e3:g:J3gAAeSwLW1pv5Zk	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35170	177	v1|389781573235|0	Lenovo ThinkPad E550 (LOT OF 5) 14" Intel Core i3-5005U 2GHz 4GB RAM Working*	295.00	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/389781573235?_skw=thinkpad&hash=item5ac0cace73:g:GZEAAeSwGBxpv5UQ	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35171	177	v1|127762905661|0	Lenovo - 21JN003YUS - Lenovo ThinkPad E16 Gen 1 21JN003YUS 16 Notebook - WUXGA	1005.03	USD	New	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/127762905661?_skw=thinkpad&hash=item1dbf433a3d:g:BzcAAeSwLW1pv5Js	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35172	177	v1|198213963251|0	Lenovo ThinkPad P17 Gen 2 Intel Laptop, 17.3" FHD IPS LED , 11th Generation Inte	599.99	USD	New	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/198213963251?_skw=thinkpad&hash=item2e26790df3:g:v2QAAeSwNF1pv5Cj	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35173	177	v1|227267597031|0	Lenovo ThinkPad P14s Gen 1 i7-10510U 16GB 512GB SSD Quadro P520 Touch Win11 Pro	279.99	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/227267597031?_skw=thinkpad&hash=item34ea3452e7:g:s0AAAeSwZUtpv4x0	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35174	177	v1|298149004893|0	Lenovo ThinkPad P14S Gen 1 AMD Ryzen 7 Pro 4750U, 16GB RAM 512GB SSD 14" Touch	275.00	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/298149004893?_skw=thinkpad&hash=item456b10c65d:g:2XUAAeSwsTFpv408	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35175	177	v1|227267574399|0	Lenovo ThinkPad T15 Gen 2 15.6" i5 11th - 16GB Ram - 512GB SSD	468.32	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/227267574399?_skw=thinkpad&hash=item34ea33fa7f:g:OPQAAeSwZdFpv4ri	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35176	177	v1|157775688634|0	Lenovo ThinkPad E14 Gen 6 /14"/ AMD Ryzen 7- 7735U/ 16 GB RAM /512 GB SSD/ Win11	861.44	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/157775688634?_skw=thinkpad&hash=item24bc29f3ba:g:XcEAAeSwCBdpYwdW	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35177	177	v1|298148964840|0	Lenovo ThinkPad P14S Gen 1- Intel i7-10610U, 48GB RAM, 1TB SSD NVIDIA P520 Touch	345.00	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/298148964840?_skw=thinkpad&hash=item456b1029e8:g:8UUAAeSw1yRpv4pR	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35178	177	v1|298148963865|0	Lenovo ThinkPad P14S Gen 2 Intel i7-1185G7, 48GB RAM, 1TB SSD NVIDIA T500 Touch	450.00	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/298148963865?_skw=thinkpad&hash=item456b102619:g:MSEAAeSwZdFpv4mn	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35179	177	v1|227267562478|0	Lenovo ThinkPad T15 Gen 2 15.6" i5 11th 16GB Ram 256GB SSD	468.32	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/227267562478?_skw=thinkpad&hash=item34ea33cbee:g:GdUAAeSwo41pv4a3	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35180	177	v1|147217193867|0	Lenovo ThinkPad X1 Yoga Gen 6 (i7-1185G7 CPU, 32 GB RAM 1 TB SSD) 14" 4K Touch	939.77	AUD	Open box	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/147217193867?_skw=thinkpad&hash=item2246d41b8b:g:PkQAAeSwsgtpv4Q4	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35181	177	v1|147217191327|0	Lenovo ThinkPad X1 Yoga Gen 6 (i7-1185G7 CPU, 16 GB RAM 1 TB SSD) 14" 4K Touch	900.61	AUD	Open box	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/147217191327?_skw=thinkpad&hash=item2246d4119f:g:Ag8AAeSwo41pv4KC	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35182	177	v1|227267542622|0	Lenovo ThinkPad T15 Gen 2 15.6" i5 11th - 16GB Ram - 512GB SSD	468.32	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/227267542622?_skw=thinkpad&hash=item34ea337e5e:g:jMQAAeSw-Ehpv4Eo	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35183	177	v1|147217178571|0	Lenovo ThinkPad X1 Yoga Gen 6 (i7-1185G7 CPU, 32 GB RAM 1 TB SSD) 14" 4K Touch	939.77	AUD	Open box	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/147217178571?_skw=thinkpad&hash=item2246d3dfcb:g:NLUAAeSwS5Zpv4G-	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35184	177	v1|147217177384|0	Lenovo ThinkPad T480 (i7-8th 32GB RAM 1TB SSD) 14" Touch NVIDIA GeForce 2GB GPU	783.14	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/147217177384?_skw=thinkpad&hash=item2246d3db28:g:~D4AAeSwyw5pv4DK	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35185	177	v1|318041580966|0	Thinkpad T430, 8gb ram 128gb ssd	125.00	USD	Used	FIXED_PRICE,AUCTION	EBAY_US	https://www.ebay.com/itm/318041580966?_skw=thinkpad&hash=item4a0cc165a6:g:aoIAAeSwPKtpv36d	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35186	177	v1|236704994677|0	Libreboot T580 Thinkpad +UPGRADED: Great New Battery | +NEW Backlit Keyboard	499.79	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/236704994677?_skw=thinkpad&hash=item371cb79575:g:DXoAAeSwEE5pv32v	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35187	177	v1|227267528819|0	Lenovo ThinkPad X1 Carbon Gen 9 i7-1165G7 16GB 512GB SSD 14" WUXGA Win11 Pro	379.99	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/227267528819?_skw=thinkpad&hash=item34ea334873:g:9HEAAeSwkBlpv3jK	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35188	177	v1|127762804407|0	LENOVO ThinkPad X1 Carbon 1st Gen 14" I5-3427U 4GB  128 SSD  *READ*	145.00	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/127762804407?_skw=thinkpad&hash=item1dbf41aeb7:g:XMsAAeSwzONpv3mW	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35189	177	v1|188193653651|0	Lenovo ThinkPad P14s Gen 5 Ryzen 7 Pro 8840HS Radeon 780M 1TB 32GB 1920 x 1200	2364.72	USD	New	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193653651?_skw=thinkpad&hash=item2bd1374393:g:3n0AAeSws~Jpv3NW	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35190	177	v1|188193651206|0	Lenovo ThinkPad X13 2-in-1 Gen 5 Core Ultra 13th Gen 135U 262GB 16GB 1920 x 1200	1424.37	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193651206?_skw=thinkpad&hash=item2bd1373a06:g:rp0AAeSw3x1pv3NZ	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35191	177	v1|358360507474|0	Lenovo ThinkPad L14 Gen 1 Laptop | I5-10210U | 16gb RAM | 256gb SSD | Black	189.99	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/358360507474?_skw=thinkpad&hash=item536ff36452:g:JLoAAeSw3rtpv25~	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35192	177	v1|188193635973|0	Lenovo ThinkPad T14 G5 Core Ultra U5-135U 512GB 16GB 1920 x 1200 14.0" inch	1702.84	USD	New	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193635973?_skw=thinkpad&hash=item2bd136fe85:g:TKwAAeSw95tpv24b	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35193	177	v1|127762723300|0	Lenovo ThinkPad P16 Gen 2 21FA002TUS 16  Mobile Workstation - WQXGA - 165 Hz - I	3108.14	USD	New	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/127762723300?_skw=thinkpad&hash=item1dbf4071e4:g:EDMAAeSwIKBpv2rv	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35194	177	v1|127762723301|0	Lenovo ThinkPad 21FA002TUS EDGE 16  Mobile Workstation - WQX + Microsoft 365 Bun	3138.14	USD	New	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/127762723301?_skw=thinkpad&hash=item1dbf4071e5:g:CzgAAeSweh9pv2su	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35195	177	v1|298148739828|0	Lenovo ThinkPad E14 Gen 7 21SX0038US 14  Touchscreen Notebook - WUXGA - 60 Hz -	2789.04	AUD	New	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/298148739828?_skw=thinkpad&hash=item456b0cbaf4:g:8uAAAeSwAu9pv2tg	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35196	177	v1|127762723287|0	Lenovo ThinkPad T14 Gen 5 21MC000KUS 14  Touchscreen Notebook - WUXGA - 60 Hz -	3853.95	AUD	New	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/127762723287?_skw=thinkpad&hash=item1dbf4071d7:g:ir0AAeSw4R1pv2uj	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35197	177	v1|318041142340|0	Lenovo  ThinkPad T480s 14" Touch i5-8350U 1.70GHz 8GB RAM 256GB SSD WIN 11 PRO	189.00	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/318041142340?_skw=thinkpad&hash=item4a0cbab444:g:210AAeSw6JZpv14n	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35198	177	v1|177980860292|477507823154	NEW Lenovo ThinkPad P14s Gen 6 Touch Ryzen AI 7 350 96GB 4TB Win 11 Pro	1644.60	AUD	New	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/177980860292?_skw=thinkpad&hash=item29707c6784:g:41UAAeSwOvZpv15j	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35199	177	v1|306835792090|0	Lenovo Yoga 7 2-in-1 14" 2K OLED Touch Laptop Ryzen AI 5 340 16GB 512GB	539.99	USD	Open box	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/306835792090?_skw=thinkpad&hash=item4770d6a0da:g:fIwAAeSwr1Zpv1ki	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35200	177	v1|318041087990|0	Lenovo  ThinkPad T480s 14" Touch i5-8350U 1.70GHz 8GB RAM 256GB SSD WIN 11 PRO	199.00	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/318041087990?_skw=thinkpad&hash=item4a0cb9dff6:g:RWUAAeSwBfhpv1wV	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35201	177	v1|306835784773|0	Lenovo V15 G2 ITL 15.6" (256GB SSD, Intel Core i5 11th Gen., 2.40 GHz, 8GB)...	479.99	USD	New	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/306835784773?_skw=thinkpad&hash=item4770d68445:g:3kwAAeSwLoxpv1pJ	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35202	177	v1|127762634228|0	Lenovo ThinkPad X1 Tablet Gen 3 i5-8250U 1.6GHz 8GB RAM 500GB - BAD TOUCH SCREEN	149.95	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/127762634228?_skw=thinkpad&hash=item1dbf3f15f4:g:XRAAAeSwwThpv1qd	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35203	177	v1|397745316739|0	Lenovo ThinkPad X1 Carbon Gen 8 14" Touch (i7-10610U 16GB RAM 256GB SSD) Win11	388.44	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397745316739?_skw=thinkpad&hash=item5c9b77e383:g:q40AAeSwkk9pv1Rh	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35204	177	v1|188193374585|0	Lenovo ThinkPad X12 Detachable Core i5 11th Gen 1140G7 262GB 16GB 1920 x 1280	1037.59	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193374585?_skw=thinkpad&hash=item2bd1330179:g:Q0UAAeSwLTlpv1Tj	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35205	177	v1|406790122859|0	Lenovo Yoga 710-15ikb	159.99	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/406790122859?_skw=thinkpad&hash=item5eb694ad6b:g:BEwAAeSwVxhpv1Kr	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35206	177	v1|198213384781|0	NEW Lenovo ThinkPad X1 2-in-1 Gen 10 14 Touch Ultra 5 226V 16GB 512GB W11 Pen	1722.91	AUD	Open box	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/198213384781?_skw=thinkpad&hash=item2e26703a4d:g:NYoAAeSw4rppsdkY	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35207	177	v1|267616103851|0	Lenovo ThinkPad X1 Carbon Gen 9 i7-1185G7 32GB RAM 512GB SSD Battery 99%	354.95	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/267616103851?_skw=thinkpad&hash=item3e4f29adab:g:ZJMAAeSwAu9pv1H2	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35208	177	v1|188193336224|0	Lenovo Thinkpad T15 G1 Core i5 10th Gen i5-10210U 262GB 16GB 1920 x 1080 (FHD)	1009.71	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193336224?_skw=thinkpad&hash=item2bd1326ba0:g:rxwAAeSwDz9pv1KW	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35209	177	v1|188193336093|0	Lenovo ThinkPad T14 G3 Core i5 12th Gen i5-1245U 262GB 16GB 1920 x 1200 WUXGA	1206.40	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193336093?_skw=thinkpad&hash=item2bd1326b1d:g:d-sAAeSwtnBpv1IV	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35210	177	v1|188193336025|0	Lenovo Thinkpad T14 G1 Ryzen 5 PRO 4650U 262GB 16GB 1920 x 1080 (FHD) 14.0" inch	760.98	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193336025?_skw=thinkpad&hash=item2bd1326ad9:g:h2gAAeSwSIxpv1MA	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35211	177	v1|188193335394|0	Lenovo Thinkpad T14 G1 Ryzen 5 Pro 4650U 512GB 16GB 1920 x 1080 14.0" inch	791.64	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193335394?_skw=thinkpad&hash=item2bd1326862:g:-vwAAeSw3x1pv1Iu	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35212	177	v1|267616099793|0	Lenovo ThinkPad X1 Carbon Gen 9 i7-1185G7 32GB RAM 512GB SSD Battery 99%	384.95	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/267616099793?_skw=thinkpad&hash=item3e4f299dd1:g:mcQAAeSwfKJpv1Dx	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35213	177	v1|227267371002|0	Lenovo ThinkPad T14 Gen 2 Ryzen 5 PRO 16GB RAM 512GB SSD 14" Win11 Pro Grade A	279.99	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/227267371002?_skw=thinkpad&hash=item34ea30dffa:g:VUQAAeSwl~dpv0vF	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35214	177	v1|198213341786|0	black lenovo thinkpad t410	52.00	USD	Used	FIXED_PRICE,AUCTION	EBAY_US	https://www.ebay.com/itm/198213341786?_skw=thinkpad&hash=item2e266f925a:g:jNoAAeSwW0Vpv01H	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35215	177	v1|397745236967|0	Lenovo ThinkPad X1 Carbon Gen 10 14" (256GB, Intel Core i7 1265U Gen 16GB DDR5..	626.51	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397745236967?_skw=thinkpad&hash=item5c9b76abe7:g:lnkAAeSwWNVpv00q	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35216	177	v1|327061597907|0	Lenovo ThinkPad X1 Yoga 3rd Gen Laptop i7  16GB 1TB i5 14" Touchscreen + Pen	548.18	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/327061597907?_skw=thinkpad&hash=item4c2663eed3:g:PeQAAeSwt0Npv0br	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35217	177	v1|117100797060|0	Lenovo ThinkPad E14 Gen 2, Intel i5-1135G7, 256GB SSD, 8GB RAM, Windows 11 Pro	266.25	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/117100797060?_skw=thinkpad&hash=item1b43c05c84:g:TzkAAeSwU0Zpv0qg	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35218	177	v1|267616086624|0	Lenovo ThinkPad T470 Dual Battery 14" Touch, 16 GB RAM i7, 512 GB SSD Win 11 Pro	249.00	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/267616086624?_skw=thinkpad&hash=item3e4f296a60:g:TssAAeSwQQ9pv0pf	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35219	177	v1|318040858741|0	Lenovo  ThinkPad T480s 14" Touch i5-8350U 1.70GHz 8GB RAM 256GB SSD WIN 11 PRO	199.00	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/318040858741?_skw=thinkpad&hash=item4a0cb66075:g:0WYAAeSw3x1pv0mR	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35220	177	v1|318040845089|0	Lenovo  ThinkPad T480s 14" Touch i5-8350U 1.70GHz 8GB RAM 256GB SSD WIN 11 PRO	199.00	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/318040845089?_skw=thinkpad&hash=item4a0cb62b21:g:al0AAeSwMbVpv0d7	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35221	177	v1|318040807713|0	Lenovo  ThinkPad T480s 14" Touch i5-8350U 1.70GHz 8GB RAM 256GB SSD WIN 11 PRO	199.00	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/318040807713?_skw=thinkpad&hash=item4a0cb59921:g:ysMAAeSwY0ppv0Sp	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35222	177	v1|318040796055|0	Lenovo ThinkPad X1 16GB RAM, i7-1185G7, 3.0GHz, 512GB SSD Windows 10 Pro	299.99	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/318040796055?_skw=thinkpad&hash=item4a0cb56b97:g:33wAAeSwXslpv0NC	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35223	177	v1|188193172781|0	Lenovo ThinkPad X1 Carbon G9 Core i5 11th Gen i5-1135G7 262GB 16GB	1071.63	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193172781?_skw=thinkpad&hash=item2bd12fed2d:g:KOwAAeSwSO9pv0QV	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35224	177	v1|188193172836|0	Lenovo Thinkpad T14 G1 Core i5 10th Gen i5-10310U 512GB 16GB 1920 x 1080	885.98	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193172836?_skw=thinkpad&hash=item2bd12fed64:g:L-cAAeSw8otpv0Ng	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35225	177	v1|188193172759|0	Lenovo ThinkPad X9-14 G1 Core Ultra 5 228V 130V 1TB 32GB 2880 x 1800 14.0" inch	1541.93	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193172759?_skw=thinkpad&hash=item2bd12fed17:g:1HoAAeSwiAFpv0RN	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35226	177	v1|188193172579|0	Lenovo Thinkpad T15 G1 Core i5 10th Gen i5-10310U 262GB 8GB 1920 x 1080 (FHD)	799.21	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193172579?_skw=thinkpad&hash=item2bd12fec63:g:3doAAeSwF8Rpv0OZ	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35227	177	v1|188193172490|0	Lenovo ThinkPad T14s Gen 1 Ryzen 7 Pro 4th Gen 4750U 512GB 16GB 1920 x 1080	997.99	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193172490?_skw=thinkpad&hash=item2bd12fec0a:g:4moAAeSw8rRpv0RL	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35228	177	v1|188193172322|0	Lenovo ThinkPad T14 G1 Core i5 10th Gen 10210U 512GB 16GB 1920 x 1080 14.0" inch	882.47	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193172322?_skw=thinkpad&hash=item2bd12feb62:g:mFwAAeSws~Jpvw6i	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35229	177	v1|188193172263|0	Lenovo ThinkPad T14 G1 Ryzen 5 PRO 4650U 262GB 16GB 1920 x 1080 (FHD) 14.0" inch	895.27	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193172263?_skw=thinkpad&hash=item2bd12feb27:g:aCgAAeSwXbFpv0QN	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35230	177	v1|188193172175|0	Lenovo ThinkPad T14 G1 Ryzen 5 Pro 4650U Radeon Graphics 262GB 16GB 1920 x 1080	760.98	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193172175?_skw=thinkpad&hash=item2bd12feacf:g:YjYAAeSwK9Rpv0QM	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35231	177	v1|188193172204|0	Lenovo ThinkPad X1 Carbon G13 Core Ultra 7 258V Arc 140V 32GB 1920 x 1200	3097.30	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193172204?_skw=thinkpad&hash=item2bd12feaec:g:wYIAAeSwIRVpv0OU	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35232	177	v1|188193172162|0	Lenovo ThinkPad L13 Yoga Gen 4 Core i5 13th Gen 1335U 512GB 8GB 1920 x 1200	1022.14	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193172162?_skw=thinkpad&hash=item2bd12feac2:g:tg8AAeSw6Ytpv0QH	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35233	177	v1|188193172170|0	Lenovo ThinkPad L13 G4 Ryzen 7 Pro 7730U 1TB 32GB 1920 x 1200 13.0" inch touch	1419.72	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193172170?_skw=thinkpad&hash=item2bd12feaca:g:6mcAAeSwcoBpv0PL	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35234	177	v1|188193171585|0	Lenovo ThinkPad X13 G4 Core i5 13th Gen i5-1335U 512GB 16GB 1920 x 1200 WUXGA	1302.25	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193171585?_skw=thinkpad&hash=item2bd12fe881:g:JuQAAeSwSO9pv0PA	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35235	177	v1|188193171496|0	Lenovo 14W G2 DualCore AMD DualCore 3015e 131GB 8GB 1366 x 768 (HD) 14.0" inch	583.91	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193171496?_skw=thinkpad&hash=item2bd12fe828:g:YtgAAeSwLoxpv0NK	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35236	177	v1|188193171387|0	Lenovo ThinkPad X1 Carbon G13 Core Ultra 7 268V 140V 2TB 32GB 2880 x 1800	3388.97	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193171387?_skw=thinkpad&hash=item2bd12fe7bb:g:WqUAAeSw1yRpv0Q4	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35237	177	v1|318040775053|0	Lenovo IdeaPad 3 17.3” Laptop Intel Inside 17ITL6 / 17ALC6 w/ Charger	220.00	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/318040775053?_skw=thinkpad&hash=item4a0cb5198d:g:TZkAAeSwIIFpv0Bb	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35238	177	v1|206157161837|0	Lenovo Ideapad 330S-15IKB 81F5 15.6" FHD - i5-8250U CPU✔8GB RAM✔256GB SSD 91130	175.00	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/206157161837?_skw=thinkpad&hash=item2fffeca56d:g:OQYAAeSwm7Jpvz7D	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35239	177	v1|358359838782|0	Lenovo IdeaPad Slim 3 Laptop Windows 11 15 .8 Inch I3	275.00	USD	Open box	FIXED_PRICE,AUCTION	EBAY_US	https://www.ebay.com/itm/358359838782?_skw=thinkpad&hash=item536fe9303e:g:3cEAAeSwdVJpvzrD	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35240	177	v1|318040666191|0	Lenovo ThinkPad X13 32GB RAM, i7-10510U, 1.80GHz, 1TB SSD Windows 11 Pro	399.99	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/318040666191?_skw=thinkpad&hash=item4a0cb3704f:g:-mAAAeSwsTFpvzwN	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35242	177	v1|137155218530|0	Lenovo ThinkPad L13 Gen 2 13.3" FHD i5-1135G7 8GB 256GB SSD Windows 11 Pro Touch	225.53	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/137155218530?_skw=thinkpad&hash=item1fef168c62:g:AbcAAeSwIIFpvzS5	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35243	177	v1|318040590232|0	Lenovo ThinkPad P1 Gen 7 165H Intel Core Ultra 7 155H, 32GB, 1TB, RTX 2000 ADA	1500.00	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/318040590232?_skw=thinkpad&hash=item4a0cb24798:g:WaYAAeSw4whpvzLf	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35244	177	v1|236704529426|0	Lenovo ThinkPad Twist S230u  Intel Core i5 #38 Blocked	62.65	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/236704529426?_skw=thinkpad&hash=item371cb07c12:g:gosAAeSwHPBpvzM2	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35245	177	v1|198213057265|0	Lenovo ThinkPad T14s Gen 1 – AMD Ryzen 5 PRO 4650U, 16GB, 256GB NVMe, W11P	311.69	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/198213057265?_skw=thinkpad&hash=item2e266b3af1:g:eTEAAeSw5RBpvzLd	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35246	177	v1|127762366351|0	Lenovo ThinkPad Black Laptop Built-in Webcam Casual Computing Workstation	200.00	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/127762366351?_skw=thinkpad&hash=item1dbf3aff8f:g:s3cAAeSwTGBpvzAg	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35247	177	v1|198213597767|0	Lenovo ThinkPad T14s Gen 1 – AMD Ryzen 7 PRO 4750U, 16GB, 512GB NVMe, W11P Hello	368.08	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/198213597767?_skw=thinkpad&hash=item2e26737a47:g:rIsAAeSwJFBpvzGM	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35248	177	v1|306835563225|0	ThinkPad P1 15.6-inch W73 CPU Intel Core i7 @ 2.6GHz RAM 32.0GB DDR4 1TB M.2	2885.95	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/306835563225?_skw=thinkpad&hash=item4770d322d9:g:QagAAeSwBkhpvzG3	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35249	177	v1|358359698817|0	Lenovo ThinkPad 14" E14 G2 i5-1135G7 8GB 256GB NVMe Windows 11 Pro	264.70	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/358359698817?_skw=thinkpad&hash=item536fe70d81:g:sxkAAeSw~U5pvzBI	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35250	177	v1|327061450827|0	Lenovo ThinkPad T16 P16s 16" Touch Ryzen AI 7 PRO 350 32GB 512GB 21QR0024US	2144.24	AUD	Open box	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/327061450827?_skw=thinkpad&hash=item4c2661b04b:g:nM4AAeSww8ppvy51	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35251	177	v1|177980411835|0	Lenovo ThinkPad T14s Gen 2 14" Touch | i7-1185G7 | 32GB RAM | 512GB SSD | Win 11	524.69	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/177980411835?_skw=thinkpad&hash=item2970758fbb:g:VckAAeSwrw5pvy2R	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35252	177	v1|236704480417|0	Lenovo ThinkPad E14 Gen 7 21SX0038US 14" Touchscreen Notebook - WUXGA - 60 Hz -	2831.23	AUD	New	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/236704480417?_skw=thinkpad&hash=item371cafbca1:g:yBAAAeSwjKxpvywr	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35253	177	v1|358359646277|0	Lenovo ThinkPad 14" E14 G2 i5-1135G7 8GB 256GB NVMe Windows 11 Pro	264.70	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/358359646277?_skw=thinkpad&hash=item536fe64045:g:kgQAAeSwOFhpvyuc	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35254	177	v1|327061436083|0	Lenovo ThinkPad T16 Gen 4 16" Touch Ultra 7 265U 32GB 1TB 21QE007TUS	2582.80	AUD	Open box	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/327061436083?_skw=thinkpad&hash=item4c266176b3:g:pb8AAeSwWB5pvynu	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35255	177	v1|188192882731|0	ThinkPad T420 Core i7-2620M 14"/ 16GB RAM/ 256GB SSD+1TB HDD/Win 11P+Linux	501.21	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/188192882731?_skw=thinkpad&hash=item2bd12b802b:g:LUkAAeSws~JpvycX	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35256	177	v1|318040449894|0	Lenovo ThinkPad T14 Gen 2 FHD Laptop Intel Core i5-1135G7 16 GB RAM 256 GB SSD	459.00	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/318040449894?_skw=thinkpad&hash=item4a0cb02366:g:e~kAAeSwpHtpvyec	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35257	177	v1|188192847597|0	Lenovo ThinkPad P1 Gen 7 21KV Core Ultra 9 185H GeForce RTX 4070 2TB 64GB	3077.61	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192847597?_skw=thinkpad&hash=item2bd12af6ed:g:NLIAAeSwykZpvymd	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35258	177	v1|188192846645|0	Lenovo ThinkPad X12 Detachable 20UW Core i5 label 1140G7 256GB 16GB 1920 x 1280	1170.73	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192846645?_skw=thinkpad&hash=item2bd12af335:g:FTIAAeSwqLFpvym5	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35259	177	v1|397744623758|0	Lenovo ThinkPad T14 Gen 5 Black FHD 1.6GHz Ultra 5 135U 16GB 512GB SSD Excellent	540.00	USD	Open box	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/397744623758?_skw=thinkpad&hash=item5c9b6d508e:g:--gAAeSwkGZpvybq	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35260	177	v1|188192843392|0	Lenovo ThinkPad L14 Gen 5 Core Ultra 5 125U 262GB 16GB 1920 x 1200 14.0" inch	1495.69	USD	New	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192843392?_skw=thinkpad&hash=item2bd12ae680:g:qzwAAeSwrmFpvykA	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35261	177	v1|188192843256|0	Lenovo ThinkPad P14s Gen 5 Ryzen 7 Pro 8840HS Radeon 780M 1TB 32GB 1920 x 1200	2085.88	USD	New	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192843256?_skw=thinkpad&hash=item2bd12ae5f8:g:nT0AAeSwFWxpvymx	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35262	177	v1|188192841603|0	Lenovo ThinkPad T14 G1 Core i5 10th Gen i5-10310U 512GB 16GB 1920 x 1080 (FHD)	885.98	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192841603?_skw=thinkpad&hash=item2bd12adf83:g:gB0AAeSwTGBpvylR	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35263	177	v1|188192840972|0	Lenovo Thinkpad T14 G1 Ryzen 5 PRO 4650U 262GB 16GB 1920 x 1080 (FHD) 14.0" inch	895.27	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192840972?_skw=thinkpad&hash=item2bd12add0c:g:dHcAAeSwAu9pvylD	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35264	177	v1|188192840452|0	Lenovo Thinkpad T14 G1 Core i5 10th Gen i5-10310U 512GB 16GB 1920 x 1080	947.90	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192840452?_skw=thinkpad&hash=item2bd12adb04:g:plAAAeSwdAJpvyj5	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35265	177	v1|188192839865|0	Lenovo ThinkPad X1 Carbon G9 Core i7 11th Gen i7-1185G7 1TB 16GB	1180.03	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192839865?_skw=thinkpad&hash=item2bd12ad8b9:g:CBYAAeSw8y5pvylk	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35266	177	v1|188192838945|0	Lenovo Thinkpad T14s G1 Ryzen 5 PRO 4650U 262GB 16GB 1920 x 1080 (FHD)	760.98	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192838945?_skw=thinkpad&hash=item2bd12ad521:g:nwEAAeSwPOhpvyke	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35267	177	v1|306835512097|0	3PCS Trackpoint Caps 3.0mm Red for Lenovo Thinkpad T14s Gen 2,3,4|T14 Gen 4,3|T1	16.49	USD	New	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/306835512097?_skw=thinkpad&hash=item4770d25b21:g:fJMAAeSw591pvyif	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35268	177	v1|188192837718|0	Lenovo Thinkpad T14 G1 Core i5 10th Gen 10310U 262GB 16GB 1920 x 1080 14.0" inch	864.25	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192837718?_skw=thinkpad&hash=item2bd12ad056:g:oWYAAeSw7-tpvyl7	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35269	177	v1|188192836919|0	Lenovo ThinkPad X9-14 G1 Core Ultra 5 Intel 226V 130V 512GB 16GB	1538.91	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192836919?_skw=thinkpad&hash=item2bd12acd37:g:fi0AAeSwVhJpvyjX	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35270	177	v1|188192836415|0	Lenovo Thinkpad T14 G1 Core i5 10th Gen i5-10310U 262GB 8GB 1920 x 1080 (FHD)	619.69	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192836415?_skw=thinkpad&hash=item2bd12acb3f:g:cI0AAeSwPKtpvyiG	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35271	177	v1|188192809698|0	Lenovo ThinkPad E15 TP0117A 8GB SSD256GB Laptop	1011.23	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/188192809698?_skw=thinkpad&hash=item2bd12a62e2:g:BbQAAeSwMBxpvyYN	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	KR	0	\N
35272	177	v1|188192809313|0	Lenovo ThinkPad E15 TP0117A Laptop with 8GB RAM and SSD 128GB	1011.23	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/188192809313?_skw=thinkpad&hash=item2bd12a6161:g:RVkAAeSwXzBpvyZ8	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	KR	0	\N
35273	177	v1|397744540124|0	Lenovo ThinkPad X280 Core i5 8GB RAM SSD256GB Windows 11 Lightweight Used Japan	432.28	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540124?_skw=thinkpad&hash=item5c9b6c09dc:g:S7wAAeSweFppvyTP	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	JP	0	\N
35274	177	v1|397744540131|0	Lenovo ThinkPad X280 Core i5 8GB RAM SSD256GB Windows 11 Lightweight Used Japan	471.44	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540131?_skw=thinkpad&hash=item5c9b6c09e3:g:WR8AAeSwIKBpvyRS	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	JP	0	\N
35275	177	v1|397744540147|0	Lenovo ThinkPad X270 Laptop i5 SSD 256GB Used Japan Genuine	471.44	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540147?_skw=thinkpad&hash=item5c9b6c09f3:g:D0YAAeSwcOdpvyPW	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	JP	0	\N
35276	177	v1|397744540149|0	Lenovo ThinkPad X280 i5 8GB SSD256GB Windows 11 Used Japan Genuine	529.39	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540149?_skw=thinkpad&hash=item5c9b6c09f5:g:RzAAAeSwr1ZpvyRR	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	JP	0	\N
35277	177	v1|397744540161|0	Lenovo ThinkPad L13 i3 10th Gen 8GB 128GB SSD Used Japan Genuine	371.19	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540161?_skw=thinkpad&hash=item5c9b6c0a01:g:VGYAAeSwbKlpvySO	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	JP	0	\N
35278	177	v1|397744540176|0	Lenovo ThinkPad T430s Core i7-3520M 8GB SSD 500GB Used Japan Genuine	355.53	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540176?_skw=thinkpad&hash=item5c9b6c0a10:g:-i4AAeSw1pFpvyQS	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	JP	0	\N
35279	177	v1|397744540177|0	Lenovo ThinkPad X13 Gen 2a Ryzen 3 PRO 5450U 16GB 256GB SSD Used Japan Genuine	718.91	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540177?_skw=thinkpad&hash=item5c9b6c0a11:g:kRUAAeSwUMZpvyQS	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	JP	0	\N
35280	177	v1|397744540180|0	Lenovo ThinkPad E480 Laptop i5 8GB RAM 128GB SSD Windows 10 Genuine	375.89	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540180?_skw=thinkpad&hash=item5c9b6c0a14:g:UQkAAeSwdVJpvyS9	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	JP	0	\N
35281	177	v1|397744540183|0	Lenovo ThinkPad T14 11th Gen i7 Used Japan Genuine	969.51	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540183?_skw=thinkpad&hash=item5c9b6c0a17:g:FckAAeSws~lpvyRR	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	JP	0	\N
35282	177	v1|397744540189|0	Lenovo ThinkPad X250 i5-5300U 8GB RAM 128GB SSD + 32GB Used Japan Genuine	336.74	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540189?_skw=thinkpad&hash=item5c9b6c0a1d:g:jv4AAeSwZcNpvyTA	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	JP	0	\N
35283	177	v1|397744540195|0	Lenovo ThinkPad E590 i5-8265U 8GB SSD256GB 15.6" HD Used Japan Genuine	566.98	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540195?_skw=thinkpad&hash=item5c9b6c0a23:g:4EMAAeSw17hpvyQg	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	JP	0	\N
35284	177	v1|397744540206|0	Lenovo ThinkPad L15 Gen1 10th Gen Used Japan Genuine	557.58	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540206?_skw=thinkpad&hash=item5c9b6c0a2e:g:FA8AAeSws~lpvyQV	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	JP	0	\N
35285	177	v1|397744540080|0	Lenovo ThinkPad T14s Gen1 i5-10310U 16GB RAM 256GB NVMe SSD Used Japan Genuine	701.68	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540080?_skw=thinkpad&hash=item5c9b6c09b0:g:TU8AAeSwJFBpvyRM	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	JP	0	\N
35286	177	v1|397744540086|0	Lenovo ThinkPad E15 i5-10210U 15.6" Full HD Used Japan Genuine	374.33	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540086?_skw=thinkpad&hash=item5c9b6c09b6:g:VjUAAeSw7s5pvyRU	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	JP	0	\N
35287	177	v1|397744540092|0	ThinkPad P1 Gen4 Xeon W-11855M 32GB 512GB RTX A2000 16" WQXGA Used Japan	1769.88	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540092?_skw=thinkpad&hash=item5c9b6c09bc:g:EocAAeSwH~dpvyRP	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	JP	0	\N
35288	177	v1|397744540099|0	Lenovo ThinkPad L14 Gen3 Core i5-1245U 16GB 512GB SSD 14" Windows 11 Used Japan	1046.26	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540099?_skw=thinkpad&hash=item5c9b6c09c3:g:-BkAAeSwGMNpvyRY	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	JP	0	\N
35289	177	v1|397744540101|0	Lenovo ThinkPad L13 Gen4 Core i5-1335U 16GB 512GB Win11 Used Japan Genuine	1351.26	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540101?_skw=thinkpad&hash=item5c9b6c09c5:g:YvgAAeSwP5NpvySG	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	JP	0	\N
35290	177	v1|397744540102|0	Lenovo ThinkPad X1 Carbon Gen9 Core i5 2.6GHz 8GB SSD256GB 14" Wi-Fi6 Used	1057.94	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540102?_skw=thinkpad&hash=item5c9b6c09c6:g:VA8AAeSw9nRpvyTC	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	JP	0	\N
35291	177	v1|397744540105|0	Lenovo ThinkPad L590 Core i5 8GB RAM SSD256GB Web Camera 15.6" Used Japan	447.94	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540105?_skw=thinkpad&hash=item5c9b6c09c9:g:WDwAAeSwWv5pvyRQ	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	JP	0	\N
35292	177	v1|397744540106|0	Lenovo ThinkPad T14 Gen2 14" Laptop Core i5 11th Gen 16GB SSD Windows11 Used	969.51	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540106?_skw=thinkpad&hash=item5c9b6c09ca:g:jZ0AAeSw6zhpvyTG	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	JP	0	\N
35293	177	v1|397744540112|0	Lenovo ThinkPad L13 Gen 2 Core i5-1145G7 RAM 16GB SSD 512GB Wi-Fi 6 Used Japan	1014.94	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540112?_skw=thinkpad&hash=item5c9b6c09d0:g:j4UAAeSwo3VpvyQU	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	JP	0	\N
35294	177	v1|397744540113|0	Lenovo ThinkPad L13 Core i3 10110U 256GB SSD 4GB Bluetooth Used Japan Genuine	404.09	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540113?_skw=thinkpad&hash=item5c9b6c09d1:g:SxEAAeSwJqhpvyPZ	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	JP	0	\N
35295	177	v1|397744540122|0	Lenovo ThinkPad L570 Laptop i5-6th Gen 8GB SSD Windows 11 Pro Used Japan	375.89	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540122?_skw=thinkpad&hash=item5c9b6c09da:g:kWoAAeSw4XJpvyPZ	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	JP	0	\N
35296	177	v1|177976501588|0	Lenovo T14 Ryzen 7 Pro	567.70	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/177976501588?_skw=thinkpad&hash=item297039e554:g:5HsAAeSw95tpvSNR	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35297	177	v1|397744540139|0	Lenovo ThinkPad L13 GEN3 Core i5 1245U 16GB 256GB NVMe Used Japan Genuine	850.48	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540139?_skw=thinkpad&hash=item5c9b6c09eb:g:SzcAAeSwPZBpvyRP	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	JP	0	\N
35298	177	v1|397744540144|0	Lenovo ThinkPad X280 i5 8GB SSD256GB Windows 11 Used Lightweight Compact Camera	529.39	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540144?_skw=thinkpad&hash=item5c9b6c09f0:g:SnUAAeSwNF1pvySO	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	JP	0	\N
35299	177	v1|397744540153|0	Lenovo Thinkpad E14 Gen 2 11th Gen i5 NVMe 512GB Used Japan Genuine	830.12	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540153?_skw=thinkpad&hash=item5c9b6c09f9:g:XrsAAeSwHXlpvyS-	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	JP	0	\N
35300	177	v1|397744540155|0	Lenovo ThinkPad L390 Laptop Black 8GB RAM 256GB SSD Used Japan Genuine	432.28	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540155?_skw=thinkpad&hash=item5c9b6c09fb:g:k1sAAeSwihRpvyTB	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	JP	0	\N
35301	177	v1|397744540170|0	Lenovo ThinkPad X13 10th Gen i5 8GB RAM 256GB SSD Lightweight Used Japan	839.51	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540170?_skw=thinkpad&hash=item5c9b6c0a0a:g:-ZMAAeSwfg1pvyRQ	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	JP	0	\N
35302	177	v1|168252336312|0	Lenovo Yoga C940-14iiL i5-1035G4 256GB SSD, 8GB Ram Windows 11	189.99	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/168252336312?_skw=thinkpad&hash=item272c9ee8b8:g:L0MAAeSwU0Zpvx2Q	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35303	177	v1|327061377748|0	Lenovo Thinkpad P1 Gen 7 - 16" Intel Ultra 7-155H NVIDIA RTX 2000 32GB/1TB SSD	2191.23	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/327061377748?_skw=thinkpad&hash=item4c266092d4:g:4SYAAeSwLlxpvx99	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35304	177	v1|188192739843|0	ThinkPad T420 Core i7-2640M 14"/ 16GB RAM/ 128GB SSD+500GB HDD/Win 11P/1600x900	374.34	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/188192739843?_skw=thinkpad&hash=item2bd1295203:g:FnkAAeSw7s5pvxqz	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35305	177	v1|137155000309|0	Lenovo ThinkPad E14 Gen 2 I5 11th GEN 16GB 256GB SSD Black - Used	331.27	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/137155000309?_skw=thinkpad&hash=item1fef1337f5:g:UdYAAeSwYQdpvx4z	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35306	177	v1|177980258926|0	IBM ThinkPad T43 14" 1.86ghz Pentium 1400x1050 ATI X300 Windows XP PRO LAPTOP	156.63	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/177980258926?_skw=thinkpad&hash=item2970733a6e:g:uroAAeSw3x1pvx3W	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35307	177	v1|188192710030|0	Lenovo ThinkPad E15 G4 i5 12th Gen Laptop 16GB RAM 512GB SSD Windows 11	1378.88	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/188192710030?_skw=thinkpad&hash=item2bd128dd8e:g:t68AAeSwBkhpvx0y	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	KR	0	\N
35308	177	v1|177980195034|0	Lenovo Thinkpad T490 i7-8565U 1.80GHz 16GB 256SSD Win 11 Pro	313.24	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/177980195034?_skw=thinkpad&hash=item29707240da:g:y8oAAeSwM29pveGf	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35309	177	v1|287222769974|0	Lenovo ThinkPad X1 Carbon Gen 13 Aura 14" Ultra 7 32GB 512GB OLED Win11 Pro	2427.74	AUD	New	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/287222769974?_skw=thinkpad&hash=item42dfcfa936:g:AjYAAeSwKeRpvxO-	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35310	177	v1|177980184657|0	Lenovo Thinkbook 15 i5-1035G1 1.00Ghz 8GB 256 SSD  Win 11 Pro	149.99	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/177980184657?_skw=thinkpad&hash=item2970721851:g:sBAAAeSwMWJpudIC	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35311	177	v1|206156844593|0	Lenovo ThinkPad T14s Gen 1 i5 10th Gen Laptop with 16GB RAM 250GB SSD Windows 11	1117.80	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/206156844593?_skw=thinkpad&hash=item2fffe7ce31:g:KgEAAeSwrIBpvxfI	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	KR	0	\N
35312	177	v1|188192646769|0	Lenovo ThinkPad T420 Core i5-2520M 14"/ 8GB RAM/ 120GB SSD/Win 11P/GRADE D+	139.40	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/188192646769?_skw=thinkpad&hash=item2bd127e671:g:3ccAAeSwV2Fpvw9l	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35313	177	v1|188192646316|0	Lenovo Thinkpad T14 G1 Ryzen 5 PRO 4th Gen 4650U 512GB 16GB 1920 x 1080 (FHD)	910.72	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192646316?_skw=thinkpad&hash=item2bd127e4ac:g:~2gAAeSw-Qxpvxd3	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35314	177	v1|188192644676|0	Lenovo Chromebook Duet 11M889 Kompanio 838 131GB 8GB 1920 x 1200 11.0" inch	697.02	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192644676?_skw=thinkpad&hash=item2bd127de44:g:GH4AAeSwOp1pvxbZ	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35315	177	v1|188192644250|0	Lenovo ThinkPad L13 Yoga Gen 4 Ryzen 5 7530U 512GB 16GB 1920 x 1200 13.0" inch	1197.00	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192644250?_skw=thinkpad&hash=item2bd127dc9a:g:Lq0AAeSwxnBpvwMN	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35316	177	v1|188192644254|0	Lenovo IdeaPad 5 2-in-1 16IRU9 Core 5 120U 512GB 8GB 1920 x 1200 16.0" inch	896.78	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192644254?_skw=thinkpad&hash=item2bd127dc9e:g:oCkAAeSwDXtpvxaL	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35317	177	v1|188192644076|0	Lenovo IdeaPad Slim 3 14IRU8 Core i7 1355U 512GB 16GB 1920 x 1080 14.0" inch	844.15	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192644076?_skw=thinkpad&hash=item2bd127dbec:g:-I4AAeSw9-9pvxcs	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35318	177	v1|188192644031|0	Lenovo ThinkPad P14s G4 Ryzen 7 Pro 7840U Radeon 780M 512GB 16GB	1634.76	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192644031?_skw=thinkpad&hash=item2bd127dbbf:g:JuIAAeSwDz9pvxZ~	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35319	177	v1|188192643977|0	Lenovo ThinkPad P16 Gen 2 Core i7 13th Gen 13850HX RTX 3500 Ada 1TB 32GB	3986.59	USD	New	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192643977?_skw=thinkpad&hash=item2bd127db89:g:9mQAAeSwEvxpvxb0	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35320	177	v1|188192643968|0	Lenovo ThinkPad P16 G1 Core i9 12th Gen i9-12950HX 1TB 16GB 3840 x 2400 WQUXGA	2246.82	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192643968?_skw=thinkpad&hash=item2bd127db80:g:CsYAAeSwGkFpvxa3	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35321	177	v1|188192643654|0	Lenovo ThinkPad L16 Gen 1 Ryzen 5 Pro 7535U Radeon 660M 512GB 16GB 1920 x 1200	1557.50	USD	New	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192643654?_skw=thinkpad&hash=item2bd127da46:g:BbQAAeSwGkFpvxX4	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35322	177	v1|188192643608|0	Lenovo ThinkPad L16 Gen 1 Ryzen 5 Pro 7535U AMD Radeon 660M 512GB 16GB	1557.50	USD	New	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192643608?_skw=thinkpad&hash=item2bd127da18:g:AboAAeSwtgZpvxYv	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35323	177	v1|188192643580|0	Lenovo ThinkPad X1 Yoga G6 Core i7 11th Gen 1185G7 512GB 32GB 1920 x 1200	1193.85	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192643580?_skw=thinkpad&hash=item2bd127d9fc:g:L6MAAeSwH8RpvxYw	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35324	177	v1|188192643492|0	Lenovo Thinkpad T14 G2 Core i7 11th Gen 1185G7 256GB 16GB 1920 x 1080 14.0" inch	1051.53	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192643492?_skw=thinkpad&hash=item2bd127d9a4:g:-hIAAeSw2FppvxYn	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35325	177	v1|188192643148|0	Lenovo ThinkPad T16 Gen 4 Core Ultra 5 225U 512GB 16GB 1920 x 1200 16.0" inch	2201.83	USD	New	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192643148?_skw=thinkpad&hash=item2bd127d84c:g:vboAAeSwQBFpvxbJ	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35326	177	v1|188192642586|0	Lenovo ThinkPad T14 G1 Ryzen 5 Pro 4650U Radeon Graphics 512GB 16GB 1920 x 1080	812.10	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192642586?_skw=thinkpad&hash=item2bd127d61a:g:87AAAeSwNF1pvxZr	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35327	177	v1|188192642357|0	Lenovo Thinkpad T14 G1 Ryzen 7 Pro 4750U 512GB 32GB 1920 x 1080 14.0" inch	906.08	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192642357?_skw=thinkpad&hash=item2bd127d535:g:HdAAAeSw95tpvxZc	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35328	177	v1|206156827418|0	Lenovo ThinkPad T14 Gen 3 i5-1250P CPU|16GB DDR4|256GB W/AC	569.52	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/206156827418?_skw=thinkpad&hash=item2fffe78b1a:g:9U4AAeSw5JVpvxYV	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	CA	0	\N
35329	177	v1|358359393624|0	Lenovo ThinkPad 14" E14 G2 i5-1135G7 8GB 256GB NVMe Windows 11 Pro Screen issue	217.71	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/358359393624?_skw=thinkpad&hash=item536fe26558:g:yPAAAeSwQQ9pvw9Z	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35330	177	v1|188192638675|0	Lenovo Thinkpad T14 G1 Core i5 10th Gen 10210U 262GB 16GB 1920 x 1080 14.0" inch	926.18	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192638675?_skw=thinkpad&hash=item2bd127c6d3:g:j-QAAeSw6YtpvxX1	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35331	177	v1|188192638350|0	Lenovo Thinkpad T14 G1 Core i5 10th Gen i5-10310U 262GB 16GB 1920 x 1080 (FHD)	864.25	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192638350?_skw=thinkpad&hash=item2bd127c58e:g:BfcAAeSwGVBpvxXq	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35332	177	v1|168252254155|0	Lenovo Yoga Slim 7i Aura Edition 14" Laptop 2025	760.00	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/168252254155?_skw=thinkpad&hash=item272c9da7cb:g:YcgAAeSwHVhpvw2d	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35333	177	v1|188192638232|0	Lenovo ThinkPad T14 G1 Ryzen 5 PRO 4650U 262GB 16GB 1920 x 1080 (FHD) 14.0" inch	760.98	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192638232?_skw=thinkpad&hash=item2bd127c518:g:tOwAAeSweElpvxXy	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35334	177	v1|188192638219|0	Lenovo Thinkpad T14 G2 Core i5 value not present 1145G7 256GB 16GB 1920 x 1080	926.18	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192638219?_skw=thinkpad&hash=item2bd127c50b:g:xW0AAeSwUrVpvxWz	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35335	177	v1|188192638180|0	Lenovo ThinkPad X1 Carbon G9 Core i7 11th Gen i7-1165G7 512GB 16GB	1101.03	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192638180?_skw=thinkpad&hash=item2bd127c4e4:g:NPgAAeSwfyxpvxXr	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35336	177	v1|188192638039|0	Lenovo Thinkpad T14 G1 Core i5 10th Gen i5-10310U 262GB 24GB 1920 x 1080 (FHD)	663.03	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192638039?_skw=thinkpad&hash=item2bd127c457:g:6UcAAeSwdLdpvxWm	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35337	177	v1|188192638032|0	Lenovo ThinkPad T14 G1 Core i5 10th Gen i5-10210U 512GB 16GB 1920 x 1080 (FHD)	885.98	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192638032?_skw=thinkpad&hash=item2bd127c450:g:FTwAAeSwkk9pvxXi	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35338	177	v1|188192637723|0	Lenovo Thinkpad T15 G1 Core i5 10th Gen i5-10210U 262GB 16GB 1920 x 1080 (FHD)	1071.63	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192637723?_skw=thinkpad&hash=item2bd127c31b:g:-1QAAeSwAu9pvxYM	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35339	177	v1|188192637675|0	Lenovo Thinkpad T14 G1 Core i5 10th Gen i5-10310U 262GB 16GB 1920 x 1080 (FHD)	663.03	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192637675?_skw=thinkpad&hash=item2bd127c2eb:g:vd8AAeSwcoBpvxXO	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35340	177	v1|188192637558|0	Lenovo Thinkpad T15 G1 Core i5 10th Gen i5-10310U 262GB 8GB 1920 x 1080 (FHD)	799.21	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192637558?_skw=thinkpad&hash=item2bd127c276:g:63gAAeSwQiVpvxXL	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35341	177	v1|188192637497|0	Lenovo ThinkPad T14 G1 Core i5 10th Gen i5-10210U 262GB 16GB 1920 x 1080 (FHD)	663.03	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192637497?_skw=thinkpad&hash=item2bd127c239:g:~wQAAeSw5wdpvxYA	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35342	177	v1|188192637329|0	Lenovo Chromebook Duet 11M889 Kompanio 838 131GB 8GB 1920 x 1200 11.0" inch	697.02	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192637329?_skw=thinkpad&hash=item2bd127c191:g:8KwAAeSwPZBpvxV7	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35343	177	v1|188192637260|0	Lenovo ThinkPad L13 Yoga Gen 2 Core i5 11th Gen 1135G7 262GB 8GB 1920 x 1080	864.25	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192637260?_skw=thinkpad&hash=item2bd127c14c:g:n4sAAeSwfg1pvxXx	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35344	177	v1|366294054053|0	Lot of 8 LENOVO THINKPAD T560 Intel Core i5 6th Gen 2.40 GHZ + 4 GB/8GB | No HD	560.00	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/366294054053?_skw=thinkpad&hash=item5548d3b4a5:g:59gAAeSwV2FpvxD7	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35345	177	v1|366294050070|0	Lenovo ThinkPad X1 Carbon 12th Gen Laptop – Intel Core Ultra 7, 32GB RAM, 512GB	1300.00	USD	Used	FIXED_PRICE,AUCTION	EBAY_US	https://www.ebay.com/itm/366294050070?_skw=thinkpad&hash=item5548d3a516:g:Db8AAeSwo3Vpvci9	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35346	177	v1|306835407914|0	Lenovo Gaming Laptop Y40-80 (14.0" FHD-Intel Core i7 5500U-8GB RAM- 512GB SSD)	135.00	USD	Used	FIXED_PRICE,AUCTION	EBAY_US	https://www.ebay.com/itm/306835407914?_skw=thinkpad&hash=item4770d0c42a:g:4tMAAeSwpAtpvxID	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35347	177	v1|327061308252|0	Lenovo ThinkPad T460s i7 12GB QHD + Ultra Dock 40A2 & Charger Bundle	269.99	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/327061308252?_skw=thinkpad&hash=item4c265f835c:g:iB0AAeSwIRVpvxD-	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35348	177	v1|127762208297|0	Lenovo - 21KS0027US - Lenovo ThinkPad P16s Gen 3 21KS0027US 16 Mobile	3155.49	USD	New	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/127762208297?_skw=thinkpad&hash=item1dbf389629:g:sJIAAeSwUrVpvxGU	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35349	177	v1|127762207389|0	Lenovo - 21RS0024US - P16v G3 4.50 GHz W11P64 32.0GB 1TB G5Perf 16 - ThinkPad	5100.03	USD	New	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/127762207389?_skw=thinkpad&hash=item1dbf38929d:g:49QAAeSww8ppvxED	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35350	177	v1|188192577595|0	Lenovo Thinkpad T14s G2 Core i5 11th Gen i5-1135G7 262GB 16GB 1920 x 1080 (FHD)	926.18	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192577595?_skw=thinkpad&hash=item2bd126d83b:g:BnwAAeSwK6Vpvw57	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35351	177	v1|188192577275|0	Lenovo Thinkpad T14s G2 Ryzen 7 Pro 5850U 512GB 16GB 1920 x 1080 (FHD)	961.84	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192577275?_skw=thinkpad&hash=item2bd126d6fb:g:xY0AAeSw3YRpvw8o	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35352	177	v1|188192576972|0	Lenovo ThinkPad T14 G1 Core i5 10th Gen i5-10210U 262GB 24GB 1920 x 1080 (FHD)	663.03	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192576972?_skw=thinkpad&hash=item2bd126d5cc:g:2MQAAeSw5wdpvw7i	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35353	177	v1|287222689703|0	Legion S7-15ACH6 Laptop (Lenovo) - Type 82K8 - HIGH SPEC GAMING LAPTOP	650.00	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/287222689703?_skw=thinkpad&hash=item42dfce6fa7:g:nVMAAeSwGSRpsG31	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35354	177	v1|336493662601|0	Lenovo ThinkPad 11e Yoga Gen 6 Laptop Intel Core m3 11" Black Touch Win Edu	100.00	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/336493662601?_skw=thinkpad&hash=item4e5895d189:g:kyMAAeSweFppvwf7	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35355	177	v1|389779930821|0	Vintage IBM ThinkPad T43 Laptop Win XP	140.97	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/389779930821?_skw=thinkpad&hash=item5ac0b1bec5:g:dQ0AAeSw2SVpvv6y	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35356	177	v1|277823239569|0	ThinkPad T14 Gen 3 Ryzen 5 Pro 6650U|16GB DDR5|256GB NVME W/AC	467.96	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/277823239569?_skw=thinkpad&hash=item40af8e3591:g:pgcAAeSwTGBpvwbh	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	CA	0	\N
35357	177	v1|358359276054|0	(LOT of 2) Lenovo ThinkPad T14 Gen2 i5-1135G7 16GB RAM 512GB SSD Windows 11 Pro	750.25	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/358359276054?_skw=thinkpad&hash=item536fe09a16:g:VHQAAeSwiAFpvwWc	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35358	177	v1|277823236648|0	Lenovo ThinkPad P16 Gen 2 --- i7-13850HX / 64GB Ram / 512GB SSD / RTX 2000 Ada	2661.11	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/277823236648?_skw=thinkpad&hash=item40af8e2a28:g:ybgAAeSw4XJpvwQF	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35359	177	v1|397744188051|0	Lenovo Thingkpad T480 Intel Core i5-8250U 8GB Ram 256GB SSD Windows 11 Pro	170.99	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/397744188051?_skw=thinkpad&hash=item5c9b66aa93:g:GqAAAeSwuAxpvwCA	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35360	177	v1|198212673286|0	Lenovo IdeaPad S340-81N8 i3 8145U 8GB RAM 128GB SSD	175.00	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/198212673286?_skw=thinkpad&hash=item2e26655f06:g:h5EAAeSwPZBpvwNF	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35361	177	v1|117100431690|0	Lenovo ThinkPad P15v Gen 2 i9-11950H 32GB 500GB W11 RTX A2000 UHD 12 Cycle Count	1644.60	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/117100431690?_skw=thinkpad&hash=item1b43bac94a:g:gKcAAeSwOyxpvwE8	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35362	177	v1|188192435834|0	Lenovo IdeaPad Slim 5 16IRU9 16" Touch (1TB SSD, Intel Core 7 150u 16 gb Bb	469.88	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/188192435834?_skw=thinkpad&hash=item2bd124ae7a:g:HgYAAeSw17hpvwIg	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35363	177	v1|227267077932|0	Lenovo P43S 14” laptop i7-8665U 32GB memory 512GB nvme SSD 4k display	299.99	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/227267077932?_skw=thinkpad&hash=item34ea2c672c:g:et8AAeSwuMNpvwFK	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35364	177	v1|306835346994|0	Lenovo ThinkPad P53s 15.6" i7-8565U 8GB RAM 512GB SSD Nvidia GPU |Windows 11 Pro	249.00	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/306835346994?_skw=thinkpad&hash=item4770cfd632:g:frgAAeSwNQlpvwGB	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35365	177	v1|198212651340|0	Lenovo ThinkPad E15 Gen 2 20TD-003KUS 15.6" i5-1135G7 2.4GHz 8GB RAM 256GB SSD	313.24	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/198212651340?_skw=thinkpad&hash=item2e2665094c:g:ihMAAeSw8M1pvwGS	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35366	177	v1|227267074635|0	Lenovo T440P 14” laptop 16GB memory 1tb SSD i7-4810MQ FHD 1080P display	249.99	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/227267074635?_skw=thinkpad&hash=item34ea2c5a4b:g:ohAAAeSw5m5pvv7n	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35367	177	v1|188192425233|0	Lenovo ThinkPad X1 Yoga Gen 10 G10 Core Ultra 7 258V 1TB 32GB 2880x1800	2254.97	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192425233?_skw=thinkpad&hash=item2bd1248511:g:u0EAAeSwUMZpvwGM	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35368	177	v1|147217120113|0	Lenovo THINKPAD T490s Core i5-8365U 8GB 256GB SSD 14″ FHD Windows 11 Pro	227.87	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/147217120113?_skw=thinkpad&hash=item2246d2fb71:g:wdsAAeSwmWFpvwvC	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35369	177	v1|206157479179|0	Lenovo THINKPAD L13 Core i5-10310U 13,3 " FHD, 8GB RAM,256GB SSD,Windows 11	241.35	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/206157479179?_skw=thinkpad&hash=item2ffff17d0b:g:wGcAAeSwuMNpvw0L	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35370	177	v1|127762725580|0	Lenovo THINKPAD P15 Generation 1 Core i7-10750H 32GB 512GB SSD T2000 Win11 Pro	635.83	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/127762725580?_skw=thinkpad&hash=item1dbf407acc:g:kUkAAeSwG~Rpvw0M	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35371	177	v1|318041167959|0	Lenovo ThinkPad X1 Carbon Gen 10 i5 8GB 256GB SSD 14" Laptop Used	436.54	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/318041167959?_skw=thinkpad&hash=item4a0cbb1857:g:0ygAAeSwkoppv2Fs	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	JP	0	\N
35372	177	v1|168252383038|0	Lenovo ThinkPad L13 Yoga Gen 2 13.3" 2n1 Laptop Core i5-1135G7 16GB 256GB Win 11	208.70	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/168252383038?_skw=thinkpad&hash=item272c9f9f3e:g:klEAAeSwKyRpvyQZ	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35373	177	v1|336493791529|0	Lenovo ThinkPad T440 I5-4300U	73.50	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/336493791529?_skw=thinkpad&hash=item4e5897c929:g:2VcAAeSwIRVpvx9j	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35374	177	v1|267615894517|0	Lenovo Thinkpad X1 Yoga -used 2019 Made	312.70	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/267615894517?_skw=thinkpad&hash=item3e4f267bf5:g:5j4AAeSwFWxpvw4e	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35375	177	v1|147216520949|0	Lenovo THINKPAD T480s Core i5-1, 7GHz 8GB 256GB 14 " FHD 1920x1080 Wind11	192.90	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/147216520949?_skw=thinkpad&hash=item2246c9d6f5:g:hiEAAeSw8kRpvwVr	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35376	177	v1|147216520952|0	Lenovo THINKPAD T480s Core i5-8350U 8GB 256GB 14 " FHD Touch Windows 11	220.69	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/147216520952?_skw=thinkpad&hash=item2246c9d6f8:g:jz4AAeSwJFBpvwa2	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35377	177	v1|127762163288|0	Lenovo THINKPAD T480s Core i5-8350U 8GB 256GB 14 " FHD 1920x1080 Windows 11	218.03	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/127762163288?_skw=thinkpad&hash=item1dbf37e658:g:ugcAAeSwLf5pvwV0	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35378	177	v1|206156718657|0	Lenovo THINKPAD T480s Core i5-8350U 8GB RAM 256GB SSD 14 " FHD Touch Windows 11	219.83	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/206156718657?_skw=thinkpad&hash=item2fffe5e241:g:gqIAAeSwQiVpvwQo	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35379	177	v1|127762160729|0	Lenovo THINKPAD L13 Core i5-10110U-2100 13,3 " FHD 4GB RAM 128GB SSD Windows 11	199.21	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/127762160729?_skw=thinkpad&hash=item1dbf37dc59:g:FhgAAeSw6IJpsA9l	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35380	177	v1|127762154576|0	ThinkPad T495 8GB 256GB FHD Windows 11 Pro - Great condition	161.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/127762154576?_skw=thinkpad&hash=item1dbf37c450:g:iD4AAeSwzOtpvwSb	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35381	177	v1|188192452623|0	Lenovo Thinkpad T430 Laptop	58.94	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/188192452623?_skw=thinkpad&hash=item2bd124f00f:g:Q4MAAeSwo71pvv8b	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35382	177	v1|277823188758|0	LENOVO THINKPAD T61 14" LAPTOP MX LINUX CORE2 DUO 3GB 250GB CHARGER CHEAP #2	49.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/277823188758?_skw=thinkpad&hash=item40af8d6f16:g:F5UAAeSw-BZpvQsg	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35383	177	v1|377047760667|0	Lenovo ThinkPad X1 Yoga G7 i5 16GB Ram 256GB SSD 2-in-1 Win 11 Pro Battery 100%	349.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/377047760667?_skw=thinkpad&hash=item57c9cc3f1b:g:AwQAAeSwARJpvFPl	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35384	177	v1|358359092999|0	Lenovo ThinkPad P1 Gen6, i9-13900H 32GB RAM 1TB SSD QHD+165Hz RTX™ 4090	2556.70	GBP	Opened – never used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/358359092999?_skw=thinkpad&hash=item536fddcf07:g:5KIAAeSwqGNpvFke	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35385	177	v1|127761971196|0	Lenovo ThinkPad P1 Gen 5 / 64GB RAM / RTX A4500 / 1.8TB SSD / i7-12800H	1689.70	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/127761971196?_skw=thinkpad&hash=item1dbf34f7fc:g:v8cAAeSwW9tpvt~P	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35386	177	v1|336493407479|0	Lenovo THINKPAD X240 Laptop Intel i5 4200U 1.60ghz 4gb Win 10 Pro + Charger	113.98	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/336493407479?_skw=thinkpad&hash=item4e5891ecf7:g:RRUAAeSwnVlpvtuc	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35387	177	v1|318039460078|0	Lenovo ThinkPad X13s Snapdragon 3 Processor 16Gb Ram 256Gb SSD 5G	1044.79	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/318039460078?_skw=thinkpad&hash=item4a0ca108ee:g:6cwAAeSwWD5pvtYf	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35388	177	v1|177979646279|0	Lenovo ThinkPad X13 Gen 1 Laptop Ryzen 5 Pro 16gb Ram 240gb SSD Windows 11 Pro	290.86	GBP	Used	FIXED_PRICE,AUCTION	EBAY_GB	https://www.ebay.co.uk/itm/177979646279?_skw=thinkpad&hash=item297069e147:g:XkMAAeSwK9RpvtQh	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35389	177	v1|389779310415|657069758753	Lenovo ThinkPad T490 i5-8265U 8GB 16GB RAM 256GB 512GB SSD Win 11 FHD Laptop	379.90	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/389779310415?_skw=thinkpad&hash=item5ac0a8474f:g:B9UAAeSwdVJpvsb4	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35390	177	v1|188191804080|0	Lenovo Thinkpad T460s Intel Core I5-6300U,16Gb DDR4,512Gb NMVe,win11 Pro	229.50	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/188191804080?_skw=thinkpad&hash=item2bd11b0ab0:g:z8IAAeSwCI1pvsg4	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35391	177	v1|397743494678|0	Lenovo ThinkPad L15 Laptop Core i5-10210U 8GB RAM 256GB SSD 15.6" Win 10 Japan	156.09	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/397743494678?_skw=thinkpad&hash=item5c9b5c1616:g:GTIAAeSwpAtpvslI	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	JP	0	\N
35392	177	v1|206156284725|0	Lenovo ThinkPad X13 Gen 5 13.3" Touchscreen - Intel Ultra 7 165U - 32GB -1TB SSD	999.99	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/206156284725?_skw=thinkpad&hash=item2fffdf4335:g:qrUAAeSwQA1pvsJj	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35393	177	v1|177979514495|0	Lenovo ThinkPad T14s Gen 4 AMD Ryzen 5 PRO 7540U, 16GB RAM, 256GB Touch Screen	516.70	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/177979514495?_skw=thinkpad&hash=item297067de7f:g:CEgAAeSw2nhpvsV2	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35394	177	v1|188191748674|0	Lenovo ThinkPad X13 Yoga 11 Gen  Intel Core I5-1135G7,8Gb,512Gb NVMe,Win11 Pro	168.78	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/188191748674?_skw=thinkpad&hash=item2bd11a3242:g:-ecAAeSwy6ZpvsSu	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35395	177	v1|389779169369|0	4k Lenovo p15v gen 2 -  i7-11850H - 64GB Ram - Nvidia T600 4GB	499.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/389779169369?_skw=thinkpad&hash=item5ac0a62059:g:098AAeSwfKJpvsBW	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35396	177	v1|127761819995|0	Lenovo x201 12.1" i5-M540 2.53GHz 4GB RAM 150GB HDD with Thinkpad X200 UltraBase	99.99	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/127761819995?_skw=thinkpad&hash=item1dbf32a95b:g:wnsAAeSwCnlpvsF4	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35397	177	v1|377047767451|0	Lenovo ThinkPad X1 Yoga G7 i5 16GB Ram 256GB SSD 2-in-1 Convertible Battery 88%	349.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/377047767451?_skw=thinkpad&hash=item57c9cc599b:g:PjsAAeSwdThpvFXx	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35398	177	v1|397743388443|0	Lenovo Thinkpad Yoga 460 2-in-1 14" Laptop┃Intel Core i5 6200U┃8GB RAM┃256GB SSD	89.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/397743388443?_skw=thinkpad&hash=item5c9b5a771b:g:e7IAAeSw2FBpKZYi	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35399	177	v1|168251689916|0	Lenovo ThinkPad X1 Carbon 3rd Gen core i7-5600U 14" 8GB Ram 150Gb SSD Win 10	227.04	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/168251689916?_skw=thinkpad&hash=item272c950bbc:g:xsEAAeSwdVJpvr0C	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35678	177	v1|298145828113|0	Lenovo ThinkPad P1 Gen 8 #BY834	3628.74	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/298145828113?_skw=thinkpad&hash=item456ae04d11:g:mMcAAeSwrw5pvjCi	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35400	177	v1|287222120163|0	Lenovo ThinkPad X240 i5-4300U @ 2.90GHz 240GB SSD 8GB RAM Windows 11 Pro	69.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/287222120163?_skw=thinkpad&hash=item42dfc5bee3:g:aS8AAeSwCI1pvrma	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35401	177	v1|206156188483|0	ThinkPad X1 Carbon Gen 9 | i7-1165G7 | 16GB Ram | 500GB NVME	350.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206156188483?_skw=thinkpad&hash=item2fffddcb43:g:ddsAAeSwEJppvrh5	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35402	177	v1|206156131907|0	Lenovo THINKPAD X13 i5-10210U 8GB RAM 256GB SSD Win11 pro Business Lap	236.86	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/206156131907?_skw=thinkpad&hash=item2fffdcee43:g:ICUAAeSwSZBpvmXe	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35403	177	v1|206156131909|0	Lenovo THINKPAD L380 Core i7-8550u 1,8Ghz 8GB 256Gb 13 " FHD W11	244.93	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/206156131909?_skw=thinkpad&hash=item2fffdcee45:g:8YsAAeSwGVBpvmSS	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35404	177	v1|127761742027|0	Lenovo THINKPAD P53s Core I7-8565U 16GB 512GB SSD 15 Inch FHD, Nvidia P520 Wind	378.52	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/127761742027?_skw=thinkpad&hash=item1dbf3178cb:g:HCEAAeSw7MRpvmSY	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35405	177	v1|287222001424|0	LENOVO THINPAD T450 14" i5-5200U 2.30 GHz 8GB RAM 240GB SSD Windows 10 Pro	123.25	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/287222001424?_skw=thinkpad&hash=item42dfc3ef10:g:RqAAAeSwOvZpvqyl	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35406	177	v1|406788834165|0	Lenovo ThinkPad L490 14" | Intel i5-8265U |16GB RAM | 256GB SSD | Windows 11 Pro	172.30	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/406788834165?_skw=thinkpad&hash=item5eb6810375:g:484AAeSwWNVpvp1D	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35407	177	v1|389757778621|0	Lenovo Thinkpad x131e Laptop - Chomebook, chome os. 8gb ram, 16GB SSD 500GB HD	176.66	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/389757778621?_skw=thinkpad&hash=item5abf5fbabd:g:mx0AAeSwwRlpuEH8	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35408	177	v1|137153870478|0	Lenovo ThinkPad T14 Gen 5 - Ultra 7 165U, 32GB RAM, 1TB SSD, AI, 2YR Warranty	1650.77	AUD	Opened – never used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/137153870478?_skw=thinkpad&hash=item1fef01fa8e:g:e9EAAeSwl8FpvpeS	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35409	177	v1|157773878712|0	Lenovo ThinkPad X1 Titanium Touch i7-1160G7 11th 16GB 1TB NVMe Win11 "Yoga"	562.03	GBP	Opened – never used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/157773878712?_skw=thinkpad&hash=item24bc0e55b8:g:TrkAAeSwSoJpvo63	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	NL	0	\N
35410	177	v1|188191171966|0	Lenovo ThinkPad T470s , Intel Core i5-6300U , 256GB SSD , 8GB Ram , Win 11 Pro	156.70	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/188191171966?_skw=thinkpad&hash=item2bd111657e:g:F4IAAOSwBzRnIXfV	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35411	177	v1|157773876689|0	Lenovo V14 IIL 14 inch  i5-1035G1 8GB RAM 256GB SSD  Windows 11 Pro	189.94	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/157773876689?_skw=thinkpad&hash=item24bc0e4dd1:g:IBsAAeSwu5tpvo1J	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35412	177	v1|188191065279|0	Lenovo ThinkPad L430 , 14” ,Intel Core i5-3230M, 2,6GHz, memory 8GB, Win 11 Pro	125.50	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/188191065279?_skw=thinkpad&hash=item2bd10fc4bf:g:sE0AAeSw2tNob~IS	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35413	177	v1|127761370136|0	Lenovo Thinkpad E14 Gen 2 Intel i5, 8GB RAM 256GB SSD, 2021, Win11 Pro, RRP 1100	254.21	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/127761370136?_skw=thinkpad&hash=item1dbf2bcc18:g:M84AAeSw1gJpvoO3	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35415	177	v1|236703123660|0	Lenovo ThinkPad E14 Gen 5 AMD RYZEN 7 16GB RAM 512GB SSD Win 11 Pro	759.85	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/236703123660?_skw=thinkpad&hash=item371c9b08cc:g:BCkAAeSwzntpvlqu	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35416	177	v1|236703123382|0	Lenovo ThinkPad X1 Yoga Intel Core i7-8550U - 16GB RAM - 128GB SSD	169.99	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/236703123382?_skw=thinkpad&hash=item371c9b07b6:g:x4sAAeSw5m5pvltY	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35417	177	v1|157773352089|0	Lenovo ThinkPad T14s Gen 1 Touchscreen Laptop i5  G10 256GB, 16GB Good condition	346.24	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/157773352089?_skw=thinkpad&hash=item24bc064c99:g:amYAAeSwsaBphfcx	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35418	177	v1|188189525481|0	Lenovo-Thinkpad-P53-15.6-i7-9750H+NVIDIA Q T2000-32GB-DDR4-2x256Gb-NVMe-1TB-HDD	721.85	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/188189525481?_skw=thinkpad&hash=item2bd0f845e9:g:04MAAeSw3rtpver6	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35419	177	v1|198210352937|0	Lenovo Thinkpad X1 carbon gen 13 - 64GB - 1TB - 3 years warranty - Sealed	1638.70	GBP	New	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/198210352937?_skw=thinkpad&hash=item2e2641f729:g:TUsAAeSwHPBpveyu	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35420	177	v1|198210288038|0	Lenovo X1 Carbon Gen11 Ultra7 265U 64GB RAM 1TB SSD14" FHD+  5G Warranty Laptop	771.70	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/198210288038?_skw=thinkpad&hash=item2e2640f9a6:g:nJoAAeSwSIxpveTe	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35421	177	v1|306834084724|0	Lenovo ThinkPad T450 14" i5-5300U 2.30 GHz 8GB RAM 120GB SSD Windows 10	113.98	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/306834084724?_skw=thinkpad&hash=item4770bc9374:g:stoAAeSwRqppveHq	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35422	177	v1|188189213581|0	Lenovo ThinkPad X280,i5-8350U,16GB RAM, SSD 256GB/FHD/BAT 82%/WIN 11pro/BAG	302.04	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/188189213581?_skw=thinkpad&hash=item2bd0f3838d:g:QJwAAeSwOyxpvdXN	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35423	177	v1|127760384464|0	LENOVO X270 ~i5-7th, 8GB, 256GB SSD, 2xBatteries, 12.5", Win11+Office21, Backlit	99.95	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/127760384464?_skw=thinkpad&hash=item1dbf1cc1d0:g:DqEAAeSwXzBpvbyj	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35424	177	v1|127760343087|0	Lenovo ThinkPad T430 Laptop i5 2.6GHz 8GB 238GB SSD 14" HD DVD-RW Win 10 Pro	80.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/127760343087?_skw=thinkpad&hash=item1dbf1c202f:g:1dkAAeSwIIFpvcS-	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35425	177	v1|267615072948|0	Lenovo THINKPAD T490 Core i5-8365U 1,6GHz 8GB 256GB 14 " FHD Win 11	222.66	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/267615072948?_skw=thinkpad&hash=item3e4f19f2b4:g:TmwAAeSw5A9psBPD	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35426	177	v1|267615072951|0	Lenovo THINKPAD T490 Core i5 1,60Ghz 16GBRAM 256GB SSD Win 11 14 " FHD Wind 11	231.01	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/267615072951?_skw=thinkpad&hash=item3e4f19f2b7:g:Ml0AAeSwPgVpsBPI	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35427	177	v1|318035623892|0	Lenovo ThinkPad X230 i5-3320M @  3.30GHz 128GB SSD 8GB RAM Laptop	125.50	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/318035623892?_skw=thinkpad&hash=item4a0c667fd4:g:-goAAeSw1hlpvbb8	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35428	177	v1|206154392512|0	Lenovo X1 Carbon 5 Core i7-7600u 2,80Ghz 16GB 512Gb SSD 1920x1080 Wind11 LTE	251.21	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/206154392512?_skw=thinkpad&hash=item2fffc263c0:g:XZYAAeSwSO9pvWba	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35429	177	v1|127760262653|0	Lenovo THINKPAD P1 G1 Xeon E2176M 2,7GHz 15,6 " 32GB 1TB SSD Nvidia P2000 Max-Q	568.58	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/127760262653?_skw=thinkpad&hash=item1dbf1ae5fd:g:~DsAAeSw3x1pvWbf	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35430	177	v1|127760262620|0	Lenovo THINKPAD P1 G1 Core i7-8850H 2,20GHz 15,6 " 16GB 512GB Nvidia P1000	393.76	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/127760262620?_skw=thinkpad&hash=item1dbf1ae5dc:g:NcYAAeSwFKhpvbPB	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35431	177	v1|206154390171|0	Lenovo THINKPAD T490 Core i5-8365U 16GB 256GB Touchs Win 11 FHD W11	259.27	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/206154390171?_skw=thinkpad&hash=item2fffc25a9b:g:XHcAAeSwk6RpsBYU	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35432	177	v1|127760260305|0	Lenovo THINKPAD T490 Core i5-8365U 1,6GHz 8GB 256GB 14 " FHD Win 11 LTE	253.90	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/127760260305?_skw=thinkpad&hash=item1dbf1adcd1:g:XYcAAeSwFd1pldWB	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35433	177	v1|366291853075|0	Used ThinkPad X1 Carbon Gen 8 - i5 10th Gen - 16GB - 256GB SSD - FHD	199.99	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/366291853075?_skw=thinkpad&hash=item5548b21f13:g:QF8AAeSwGkFpvbRr	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35434	177	v1|267615042590|0	Lenovo ThinkPad X13 Gen 1 Laptop FHD i5 16GB RAM 256GB SSD Windows 11 Pro	179.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/267615042590?_skw=thinkpad&hash=item3e4f197c1e:g:z3oAAeSwuMNpvana	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35435	177	v1|227265755956|0	Lenovo ThinkPad X230/8GB/Windows10LTSC/	135.90	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/227265755956?_skw=thinkpad&hash=item34ea183b34:g:z6AAAeSw9-9pvapA	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35436	177	v1|236702213908|0	Lenovo ThinkPad E14 Gen 2 - Intel Core i3-1115G4 - 8GB RAM - 256GB SSD	149.99	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/236702213908?_skw=thinkpad&hash=item371c8d2714:g:-BkAAeSwNW5pvaop	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35437	177	v1|377049980184|0	Lenovo ThinkPad X1 Yoga G7 i5 16GB Ram 256GB SSD 14" WUXGA 2-in-1 Privacy Screen	349.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/377049980184?_skw=thinkpad&hash=item57c9ee1d18:g:PEEAAeSw3nppvYmr	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35438	177	v1|287220338394|0	Lenovo ThinkPad X1 Carbon 8. Gen + UHD Display/i7/16GB/512GB + 6Monate GARANTIE	344.71	EUR	Used	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/287220338394?_skw=thinkpad&hash=item42dfaa8eda:g:MSAAAeSwySxpvaB~	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35439	177	v1|377047487637|0	Lenovo ThinkPad X13 Gen 4 - i7 32GB Ram 512GB SSD 13.3" Touch WTY 08/27 Not Yoga	579.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/377047487637?_skw=thinkpad&hash=item57c9c81495:g:9oEAAeSwmelpvCmr	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35440	177	v1|377047742761|0	Lenovo ThinkPad X1 Yoga G7 i5 16GB RAM 256GB SSD 14" Convertible battery 100%	369.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/377047742761?_skw=thinkpad&hash=item57c9cbf929:g:JkcAAeSwsH9pvFJp	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35441	177	v1|137151691569|0	Lenovo Thinkpad T430, i5 3rd Gen, 8GB RAM, 500GB SSD, Linux Mint	78.70	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/137151691569?_skw=thinkpad&hash=item1feee0bb31:g:CnIAAeSwoolpvZ16	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35442	177	v1|117098720235|0	Lenovo X230 Tablet i5 2.60Ghz | 16GB RAM | 240GB SSD | IPS Screen | Linux Mint	414.69	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/117098720235?_skw=thinkpad&hash=item1b43a0abeb:g:UDoAAeSwR09pp3NO	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35443	177	v1|117098720210|0	Lenovo ThinkPad T440p i7-4710MQ | 16GB RAM | 240GB NVMe + 1TB SSD | FHD IPS	260.69	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/117098720210?_skw=thinkpad&hash=item1b43a0abd2:g:XJ4AAeSwenpppMuB	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35444	177	v1|277820580921|0	Grade A Lenovo ThinkPad P14s Gen 2 + i7/32GB/512GB/nVidia + 6 months WARRANTY	399.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/277820580921?_skw=thinkpad&hash=item40af65a439:g:4T4AAeSw6stpvZkx	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35445	177	v1|206154181658|0	Lenovo ThinkPad E14 Gen 3 Spares: 14", Ryzen 5 5500U, 8GB RAM, 256GB SSD, W11	179.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206154181658?_skw=thinkpad&hash=item2fffbf2c1a:g:wWUAAeSw5RBpvZZf	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35446	177	v1|206154181674|0	Lenovo ThinkPad L14 Gen 2 Spares: 14" Screen i5 11th Gen 16GB RAM 256GB SSD W11	149.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206154181674?_skw=thinkpad&hash=item2fffbf2c2a:g:Q9YAAeSw8otpvZZp	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35447	177	v1|277820553291|0	Lenovo ThinkPad T14s Gen 2 - core i7/16GB/512GB/WWAN eSIM + 6 months WARRANTY	329.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/277820553291?_skw=thinkpad&hash=item40af65384b:g:9AUAAeSwM3VpvZTy	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35448	177	v1|298144543454|0	Lenovo Thinkpad X260 - Intel Core i5-6300U 2.4GHz - 8GB DDR4 - 120GB SSD	70.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/298144543454?_skw=thinkpad&hash=item456accb2de:g:VbMAAeSwgHVpn0pm	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35449	177	v1|277820517047|0	Grade A Lenovo ThinkPad T14 Gen 3 - core i5/6 core/24GB/512GB +6 months WARRANTY	449.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/277820517047?_skw=thinkpad&hash=item40af64aab7:g:Ib4AAeSw2nhpvZAd	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35450	177	v1|137151495336|0	Lenovo Thinkpad Edge E531 Laptop - i3 3rd Gen - 4GB RAM - Windows 10 pro	45.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/137151495336?_skw=thinkpad&hash=item1feeddbca8:g:YU0AAeSw3mtpvYX5	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35451	177	v1|206154096352|0	Lenovo ThinkPad L390 Yoga Spares: 13" Touch i5 8th Gen 16GB RAM 256GB SSD W11	79.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206154096352?_skw=thinkpad&hash=item2fffbddee0:g:IJAAAeSwxnBpvYlJ	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35452	177	v1|206154096331|0	Lenovo ThinkPad L390 Yoga Spares 13.3" Touch i5 8th Gen 8GB RAM 256GB SSD W11	79.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206154096331?_skw=thinkpad&hash=item2fffbddecb:g:gQUAAeSwibZpvYlI	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35453	177	v1|206154096177|0	Lenovo ThinkPad L480 | 14" | i5 8th Gen | 16GB RAM | 256GB SSD | W11 | Grade C	79.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206154096177?_skw=thinkpad&hash=item2fffbdde31:g:vjQAAeSwZgVpvYkF	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35454	177	v1|236701967417|0	Lenovo ThinkPad X13 Gen 4  13.3" 16GB RAM 256GB SSD M.2 Intel Core i5 13th Gen	311.84	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/236701967417?_skw=thinkpad&hash=item371c896439:g:uUIAAeSwMBxpvXif	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35455	177	v1|406786591265|0	Lenovo ThinkPad X1 Yoga G5 Laptop: Core i7-10610U 256GB 16GB, Warranty VAT	525.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/406786591265?_skw=thinkpad&hash=item5eb65eca21:g:qtwAAeSwKONpvXUN	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35456	177	v1|147214488738|0	Lenovo Thinkpad X230 Laptop i5 8GB RAM 320GB HDD 12.5" Win 10 Pro	79.99	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/147214488738?_skw=thinkpad&hash=item2246aad4a2:g:rTcAAeSwLTlpvXS~	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35457	177	v1|206153955060|0	Lenovo ThinkPad L480 Spares: 14" FHD, No M/B, No CPU, No RAM, No SSD, No OS	39.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206153955060?_skw=thinkpad&hash=item2fffbbb6f4:g:3J4AAeSwM3VpvXO5	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35458	177	v1|206153955071|0	Lenovo ThinkPad L490 | 14" FHD | i5 8th Gen | 16GB RAM | 256GB SSD | W11 |	89.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206153955071?_skw=thinkpad&hash=item2fffbbb6ff:g:1s8AAeSw5JVpvXO5	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35459	177	v1|206153955034|0	Lenovo ThinkPad T580 Spares: 15.6" FHD, No M/B, No CPU, No RAM, No SSD, No OS	39.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206153955034?_skw=thinkpad&hash=item2fffbbb6da:g:nW4AAeSwQBFpvXO2	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35460	177	v1|206153954974|0	Lenovo ThinkPad L480 Spares: 14" FHD, i5 8th Gen 16GB RAM, 256GB SSD, W11	79.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206153954974?_skw=thinkpad&hash=item2fffbbb69e:g:DM8AAeSwGkFpvXOx	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35461	177	v1|206153954978|0	Lenovo ThinkPad L480 Spares: 14" FHD, i5 8th Gen CPU, 16GB RAM 256GB SSD, W11	69.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206153954978?_skw=thinkpad&hash=item2fffbbb6a2:g:3JMAAeSwSO9pvXOv	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35462	177	v1|206153954980|0	Lenovo ThinkPad L380 Yoga | 13.3" | i5 8th Gen | 16GB RAM | 128GB SSD | W11 |	79.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206153954980?_skw=thinkpad&hash=item2fffbbb6a4:g:DzQAAeSwKRtpvXOz	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35463	177	v1|206153954960|0	Lenovo ThinkPad L480 Spares: 14" FHD, i5 8th Gen CPU, 16GB RAM, 256GB SSD W11	89.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206153954960?_skw=thinkpad&hash=item2fffbbb690:g:JAcAAeSwYC5pvXOu	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35464	177	v1|206153954962|0	Lenovo ThinkPad L480 | 14" FHD | i5 8th Gen | 16GB RAM | 256GB SSD | W11 |	79.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206153954962?_skw=thinkpad&hash=item2fffbbb692:g:CIAAAeSwGBxpvXOs	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35465	177	v1|206153954911|0	Lenovo ThinkPad L14 Gen 1 Spares: 14" FHD, No M/B, No CPU No RAM, No SSD, No OS	39.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206153954911?_skw=thinkpad&hash=item2fffbbb65f:g:JesAAeSw7MRpvXOm	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35466	177	v1|206153954928|0	Lenovo ThinkPad L380 Yoga | 13.3" Touch | i5 8th Gen | 8GB RAM | 256GB SSD | W11	79.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206153954928?_skw=thinkpad&hash=item2fffbbb670:g:CWAAAeSwe35pvXOp	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35467	177	v1|206153954889|0	Lenovo ThinkPad L14 Gen 1 Spares: 14" FHD, No M/B, No CPU, No RAM, No SSD, No OS	44.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206153954889?_skw=thinkpad&hash=item2fffbbb649:g:Dc4AAeSwP4ZpvXOl	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35468	177	v1|137151294630|0	Lenovo ThinkPad L13 YogaGen2, i5-2.4GHz, 8GB , 256GB, Win 11, 13.4" Touch Screen	167.10	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/137151294630?_skw=thinkpad&hash=item1feedaaca6:g:jQwAAeSwAtNpscS7	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35469	177	v1|157771975322|0	Thinkpad T430 Laptop 2.60 GHz Core i5 12GB RAM - 2 Drives - W10 Pro - Lovely!!	135.90	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/157771975322?_skw=thinkpad&hash=item24bbf14a9a:g:ipAAAeSweLNpvUr3	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35470	177	v1|406786420948|0	Lenovo ThinkPad T450 14" i5-5300U 2.30 GHz 8GB RAM 240GB SSD Windows 11 Pro	79.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/406786420948?_skw=thinkpad&hash=item5eb65c30d4:g:KGYAAeSw52Vpt~qA	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35471	177	v1|147214429623|0	Lenovo ThinkPad L14 Gen 5 (Intel) Intel Core Ultra 5 125U Laptop 35.6 cm (14i...	783.22	GBP	New	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/147214429623?_skw=thinkpad&hash=item2246a9edb7:g:CNsAAeSwbKlpv5Vx	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35472	177	v1|267614816619|0	Lenovo ThinkPad T440 / Core i5-4300U / 4GB RAM / 128GB SSD / 4G LTE / WIN 11 PRO	62.95	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/267614816619?_skw=thinkpad&hash=item3e4f16096b:g:T2QAAeSwYqFpvWHK	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35473	177	v1|147214406217|0	Lenovo ThinkPad Yoga 11e 5th Gen 11” 2-in-1 Touchscreen Laptop Windows 11	149.97	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/147214406217?_skw=thinkpad&hash=item2246a99249:g:uYoAAeSwlYJpvApH	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35474	177	v1|168249416681|0	Lenovo ThinkPad Carbon X1 Gen 9 Intel i7 1165G7 16GB RAM 256GB SSD Windows 11	350.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/168249416681?_skw=thinkpad&hash=item272c725be9:g:IQsAAeSwBfVpvUuD	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35475	177	v1|277820081064|0	Lenovo Thinkpad P14s Gen2 i7-1185G7 3.0Ghz 16GB 512SSD 14" Laptop - USB-C FAULT	150.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/277820081064?_skw=thinkpad&hash=item40af5e03a8:g:jUYAAOSwxtZm0aIK	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35476	177	v1|298144009507|0	Lenovo ThinkPad E560 - i5-6200U - 8GB Ram - No Storage	57.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/298144009507?_skw=thinkpad&hash=item456ac48d23:g:DlsAAeSwmWFpvVrx	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35477	177	v1|298143999097|0	Lenvo ThinkPad L440 - i5-4210M - 4GB Ram - 180GB SSD - No OS	54.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/298143999097?_skw=thinkpad&hash=item456ac46479:g:BK4AAeSwl2hpvVm0	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35478	177	v1|298143976733|0	Lenovo Thinkpad T460 - i5-6300U - 8GB Ram - 500GB SSD - No OS	89.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/298143976733?_skw=thinkpad&hash=item456ac40d1d:g:FyYAAeSwWNVpvViZ	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35479	177	v1|206153772302|0	Fast Lenovo ThinkPad T14s Gen 1 Core i7 10th 16GB 512GB NVme SSD 14" Win 11 Pro	299.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206153772302?_skw=thinkpad&hash=item2fffb8ed0e:g:xGQAAeSwQGJpc2if	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35480	177	v1|366291159598|0	Lenovo ThinkPad E14 Gen3 AMD Ryzen 5 5500U 16GB RAM 256GB NVME SSD 14" Full HD W	299.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/366291159598?_skw=thinkpad&hash=item5548a78a2e:g:kYAAAeSwnahpuDSM	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35481	177	v1|318034027603|0	Lenovo Thinkpad E585 15.6” AMD Ryzen 7 256GB SSD/8GB Ram Window 10 Laptop	190.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/318034027603?_skw=thinkpad&hash=item4a0c4e2453:g:NyMAAeSws~lpvUpU	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35482	177	v1|236701647219|0	Lenovo ThinkPad A275 Laptop – 12.5" – Windows 10	130.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/236701647219?_skw=thinkpad&hash=item371c848173:g:nTEAAeSw0y9pvVFb	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35483	177	v1|406786133490|0	Lenovo ThinkPad T495-Ryzen 7 Pro - Fast Business LAPTOP-GREAT Condition Veryfast	290.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/406786133490?_skw=thinkpad&hash=item5eb657cdf2:g:NjIAAeSw1sBpvUZq	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35484	177	v1|358355026597|0	Lenovo ThinkPad X1 Yoga Gen 6 14 256GB SSD Intel Core i5-1145G7, 2.6GHz 32GB Ram	300.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/358355026597?_skw=thinkpad&hash=item536f9fc2a5:g:uUwAAeSw0x5pvVrv	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35485	177	v1|117097993571|0	Lenovo ThinkPad X1 Carbon 6th Gen i7-8650U | 16GB RAM 256GB SSD | FHD  (1315)	301.26	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/117097993571?_skw=thinkpad&hash=item1b43959563:g:V~YAAeSwHVhpvTmf	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35486	177	v1|257416347214|0	Lenovo thinkpad p16s gen 3 / Ultra 7 155H / 32GB RAM / 1TB SSD / NVIDIA RTX 500	1199.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/257416347214?_skw=thinkpad&hash=item3bef35be4e:g:cpQAAeSwWNVpvTKm	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35487	177	v1|406785864955|0	Lenovo ThinkPad L16 Gen 2 Laptop: AMD Ryzen 5 Pro, 512GB SSD, 16GB RAM, Warranty	849.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/406785864955?_skw=thinkpad&hash=item5eb653b4fb:g:TXIAAeSwkoppvTIp	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35488	177	v1|206153386401|0	Lenovo ThinkPad T14s Gen 6 (AMD) Copilot+ PC AMD Ryzen AI 7 PRO 350 Laptop 35.6	1912.00	GBP	New	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/206153386401?_skw=thinkpad&hash=item2fffb309a1:g:H1IAAeSwaItpvTGy	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35489	177	v1|198208802616|0	Lenovo ThinkPad P16 Gen 3 Intel Core Ultra 9 275HX Laptop 40.6 cm (16") WUXGA 32	3855.00	GBP	New	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/198208802616?_skw=thinkpad&hash=item2e262a4f38:g:SXYAAeSwPKtpvTGM	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35490	177	v1|198208801917|0	Lenovo ThinkPad P16s Gen 4 (AMD) Copilot+ PC AMD Ryzen AI 7 PRO 350 Mobile works	2279.00	GBP	New	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/198208801917?_skw=thinkpad&hash=item2e262a4c7d:g:ZbIAAeSww8ppvTFW	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35491	177	v1|198208801283|0	Lenovo ThinkPad P16s Gen 4 (AMD) Copilot+ PC AMD Ryzen AI 7 PRO 350 Mobile works	1804.00	GBP	New	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/198208801283?_skw=thinkpad&hash=item2e262a4a03:g:SgAAAeSwnc1pvTEW	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35492	177	v1|206153383030|0	Lenovo ThinkPad P14s Gen 6 (AMD) AMD Ryzen AI 7 PRO 350 Mobile workstation 35.6	1778.00	GBP	New	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/206153383030?_skw=thinkpad&hash=item2fffb2fc76:g:PscAAeSwVhJpvTDb	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35493	177	v1|206153381316|0	Lenovo ThinkPad P14s Gen 6 (AMD) AMD Ryzen AI 7 PRO 350 Mobile workstation 35.6	2207.00	GBP	New	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/206153381316?_skw=thinkpad&hash=item2fffb2f5c4:g:ZVsAAeSwIIFpvTCa	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35494	177	v1|377049244671|0	Lenovo ThinkPad X13 Yoga Gen 2 Core i5-1135G7 8GB 256GB Touchscreen Laptop	219.99	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/377049244671?_skw=thinkpad&hash=item57c9e2e3ff:g:dXkAAOSwu0hnUbQN	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35495	177	v1|127759229682|0	Lenovo ThinkPad L450 i5-5200U 2.30GHz 8GB Ram 256GB SSD Win11Pro(J204)	74.99	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/127759229682?_skw=thinkpad&hash=item1dbf0b22f2:g:KEcAAeSw-EhpvS7g	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35496	177	v1|206153360860|0	Lenovo ThinkPad L14 Gen 6 (AMD) AMD Ryzen™ 5 PRO 215 Laptop 35.6 cm (14") WUXGA	1270.00	GBP	New	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/206153360860?_skw=thinkpad&hash=item2fffb2a5dc:g:BeMAAeSwmsVpvS6v	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35497	177	v1|257416267307|0	Lenovo X1 Yoga Intel i5 Windows 11 2 in 1 Touch Laptop 14 in 16GB RAM 512GB SSD	219.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/257416267307?_skw=thinkpad&hash=item3bef34862b:g:y8QAAeSw0y9pvSbk	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35498	177	v1|406785778773|0	Lenovo ThinkPad X1 Yoga G6 Laptop: i7-1185G7 Touch 32GB 512GB Warranty VAT	589.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/406785778773?_skw=thinkpad&hash=item5eb6526455:g:6koAAeSw5tRpvSZC	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35499	177	v1|406785777798|0	Lenovo ThinkPad P1 Gen 6 Laptop: i7-13700H 16GB RAM NVIDIA RTX A1000 Warranty	1489.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/406785777798?_skw=thinkpad&hash=item5eb6526086:g:zIoAAeSwuMNpvSYe	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35500	177	v1|406785756464|0	Lenovo ThinkPad P52 Laptop i7-8750H 512GB SSD 16GB RAM Quadro P1000 Warranty VAT	489.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/406785756464?_skw=thinkpad&hash=item5eb6520d30:g:pQcAAeSwHVhpvSRe	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35501	177	v1|406785753117|0	Lenovo ThinkPad T14 Gen 2 Laptop: Intel i5 11th Gen, 512GB 16GB RAM Warranty VAT	539.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/406785753117?_skw=thinkpad&hash=item5eb652001d:g:8FcAAeSwR0tpvSN~	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35502	177	v1|406785745553|0	Lenovo ThinkPad X1 Yoga G6 Laptop: i7-1185G7 32GB RAM 512GB SSD Warranty VAT	639.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/406785745553?_skw=thinkpad&hash=item5eb651e291:g:6RAAAeSwXERpvSHD	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35503	177	v1|257416231422|0	Lenovo Thinkpad X1 YOGA Gen 4 i7 2 in 1 Windows 11 Intel 8665u 16GB 256GB SSD	189.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/257416231422?_skw=thinkpad&hash=item3bef33f9fe:g:wlEAAeSw7MRpvR8o	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35504	177	v1|366290737625|0	Lenovo Thinkpad T470S Laptop i7-6600u 20GB RAM 256GB SSD Win11Pro(J201)	149.99	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/366290737625?_skw=thinkpad&hash=item5548a119d9:g:obwAAeSwkk9pvR3x	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35505	177	v1|127759135968|0	Lenovo ThinkPad T570, Intel Core i5 7200u  256GB SSD 8GB RAM Win11Pro(J200)	79.99	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/127759135968?_skw=thinkpad&hash=item1dbf09b4e0:g:lkoAAeSwyKBpvRzH	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35506	177	v1|389773907226|0	Lenovo ThinkPad T480 Laptop i5-8350U 8GB 256GB Windows 11 Pro- READ DESCRIPTION	149.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/389773907226?_skw=thinkpad&hash=item5ac055d51a:g:hqkAAeSwj0RpvRs3	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35507	177	v1|287219145939|0	Lenovo Thinkpad T490 core i5-8365U 16GB 256GB 14ins FHD Touch Win 11 Pro	199.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/287219145939?_skw=thinkpad&hash=item42df985cd3:g:PjMAAeSw5m5pvZNN	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35508	177	v1|298143087735|0	Lenovo X13 Yoga Gen 2 i5-1145G7 16GB 512GB 2.5K 2560x1600 Touch Win 11 Pro B	359.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/298143087735?_skw=thinkpad&hash=item456ab67c77:g:Ej8AAeSwbKlpvRJq	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35509	177	v1|298143008304|0	Lenovo ThinkPad T14 Laptop Gen 1 Ryzen 5 Pro 4650U 4 Ghz 14" 24GB 256GB	247.99	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/298143008304?_skw=thinkpad&hash=item456ab54630:g:-vsAAeSwCI1pvS3c	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35510	177	v1|336491476565|0	Lenovo ThinkPad T14 Gen 1 Core i5-10310U 1.70 GHz 16GB RAM 256GB SSD (read desc)	180.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/336491476565?_skw=thinkpad&hash=item4e58747655:g:A~0AAeSwNF1pvQ1m	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35511	177	v1|127759046758|0	Lenovo ThinkPad T14 Gen  i5-10210U 16GB RAM 256GB SSD 14” FHD Win 11 Pro(J197)	144.99	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/127759046758?_skw=thinkpad&hash=item1dbf085866:g:550AAeSwqLFpvQv5	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35512	177	v1|287219062822|0	Lenovo THINKPAD C13 YOGA GEN1 CHROMEBOOK AMD 8 GB RAM 128 GB ENGLISH US	163.70	GBP	Used	FIXED_PRICE,AUCTION	EBAY_GB	https://www.ebay.co.uk/itm/287219062822?_skw=thinkpad&hash=item42df971826:g:5UEAAeSwMoRpvQnr	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	IE	0	\N
35513	177	v1|366290582553|0	Lenovo ThinkPad T570, Intel Core i5 7200u  256GB SSD 16GB RAM Win11Pro(J196)	129.99	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/366290582553?_skw=thinkpad&hash=item55489ebc19:g:0hoAAeSwGMhpvQeE	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35514	177	v1|336491424058|0	HP ZBook Studio G11 16" 4K+ Screen Ultra 7-165H 32GB RAM 1TB SSD RTX 2000 Ada	1699.90	GBP	New	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/336491424058?_skw=thinkpad&hash=item4e5873a93a:g:0CkAAOSwrdRnqw2Z	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35515	177	v1|287218956322|0	Lenovo ThinkPad X250 Laptop / Intel Core i5-4300 / 8GB-RAM / 256GB-SSD / Win 10	59.95	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/287218956322?_skw=thinkpad&hash=item42df957822:g:hDAAAeSwOjppvPxe	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35516	177	v1|318032669933|0	The Lenovo ThinkPad 13 (2nd Gen) laptop (Type 20J1-004DUK).	98.46	GBP	Used	FIXED_PRICE,AUCTION	EBAY_GB	https://www.ebay.co.uk/itm/318032669933?_skw=thinkpad&hash=item4a0c396ced:g:41kAAeSwCexpvO5p	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35517	177	v1|406785185232|0	Lenovo Thinkpad P15 Gen 1 Core i7 9th gen 32gb RAM 512gb SSD - Grade A	499.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/406785185232?_skw=thinkpad&hash=item5eb64955d0:g:TQEAAeSw6zhpvNxv	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35518	177	v1|406785114003|0	Lenovo T14s Gen 2 i7 512GB 16GB 14"	550.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/406785114003?_skw=thinkpad&hash=item5eb6483f93:g:4CIAAeSwHKtpvNCP	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35519	177	v1|137149430610|0	Lenovo Thinkpad X13 Gen 5, Core Ultra 7 165U, 32GB RAM, 512GB SSD UK	899.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/137149430610?_skw=thinkpad&hash=item1feebe3b52:g:5FEAAeSwAu9pvKTt	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35520	177	v1|147213500013|0	Lenovo ThinkPad L13 Yoga Gen.1 Core i5-10210u 1,6GHz 8GB 256GB FHD Touch Win11	233.24	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/147213500013?_skw=thinkpad&hash=item22469bbe6d:g:gtwAAeSwdRtpvGJ2	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35521	177	v1|147213499988|0	Lenovo ThinkPad T480s i5-8350U 1.7GHz 8GB 256GB 14" FHD Touch Win11 Pro	233.24	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/147213499988?_skw=thinkpad&hash=item22469bbe54:g:zCIAAeSwlYJpsBIC	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35522	177	v1|137149204819|0	RARE IBM Thinkpad T23 Pentium III 1Ghz 256MB ram 1024x768 Healthy Battery	145.26	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/137149204819?_skw=thinkpad&hash=item1feebac953:g:F6EAAeSwWpxpvIxE	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35523	177	v1|287218283512|0	Lenovo ThinkPad X13 Yoga Gen 2 Laptop  I5 8GB	239.90	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/287218283512?_skw=thinkpad&hash=item42df8b33f8:g:ktAAAeSw52VpvIM2	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35524	177	v1|147213213248|0	Lenovo ThinkPad X1 Carbon (6th Gen) Intel Core I5-8250U, 8GB RAM, 256GB SSD	95.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/147213213248?_skw=thinkpad&hash=item2246975e40:g:vXMAAeSwnNBpvHUv	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35525	177	v1|336490811197|0	Lenovo Thinkpad C13 Yoga G1 Chromebook AMD Ryzen 5 3500c 8GB RAM 128GB SSD 13.3"	99.99	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/336490811197?_skw=thinkpad&hash=item4e586a4f3d:g:hYgAAeSwlXFpraXr	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35526	177	v1|198207070720|0	Lenovo ThinkPad X1 Carbon Gen 9	599.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/198207070720?_skw=thinkpad&hash=item2e260fe200:g:IiIAAeSwxQtpvFKV	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35527	177	v1|206151787390|0	Lenovo ThinkPad L13 Yoga Gen 2 Spares 13 Touch No M/B No CPU No RAM No SSD No OS	39.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206151787390?_skw=thinkpad&hash=item2fff9aa37e:g:7HIAAeSw~QlpvFBo	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35528	177	v1|327057584332|0	Lenovo ThinkPad L13 Yoga | i5-10210U 10th Gen | 8GB RAM | 256GB M.2 SSD | Touchs	225.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/327057584332?_skw=thinkpad&hash=item4c2626b0cc:g:D9UAAeSwxxJpu~2q	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35529	177	v1|377047480515|0	Lenovo ThinkPad X13 Gen 4 - i7 32GB Ram 512GB 13.3" Touch WTY 08/27 - Not Yoga	579.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/377047480515?_skw=thinkpad&hash=item57c9c7f8c3:g:ZjQAAeSwCGppvCcT	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35530	177	v1|377047622748|0	Lenovo ThinkPad X1 Yoga G7 i5 16GB Ram 2-in-1 lid casing has marks Battery 90%	329.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/377047622748?_skw=thinkpad&hash=item57c9ca245c:g:ZBYAAeSwAVppvD0v	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35531	177	v1|377047598309|0	Lenovo ThinkPad X1 Yoga Gen 8 i5 32GB Ram 512GB SSD 14" Touch 2-in-1 Win 11 Pro	549.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/377047598309?_skw=thinkpad&hash=item57c9c9c4e5:g:A2IAAeSw3RlpvDhq	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35532	177	v1|206151750627|0	Lenovo ThinkPad L13 Yoga Gen.2 Core i5-1135G7 2.4 GHz 8GB 256GB FHD Touch	281.69	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/206151750627?_skw=thinkpad&hash=item2fff9a13e3:g:~cMAAeSwxgZpvE2a	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35533	177	v1|377047549610|0	Lenovo ThinkPad X1 Yoga Gen 8 i7-1365U 32GB RAM 512GB 14" 2-in-1 Privacy Screen	579.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/377047549610?_skw=thinkpad&hash=item57c9c906aa:g:J0oAAeSwDKxpvDDT	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35534	177	v1|377047602278|0	Lenovo ThinkPad X1 Yoga G7 i5 16GB Ram 256GB SSD Convertible 2-in-1 battery 100%	369.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/377047602278?_skw=thinkpad&hash=item57c9c9d466:g:g2kAAeSwpPhpvDsN	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35535	177	v1|377047647851|0	Lenovo ThinkPad 15.6” Laptop Windows 11 Pro 4GB RAM Core Intel I5 500GB HDD	63.10	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/377047647851?_skw=thinkpad&hash=item57c9ca866b:g:tDAAAeSwEVVpvEIH	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35536	177	v1|298141011461|0	Lenovo ThinkPad T460s Laptop 14-inch, I5-6300U 2.4GHz	73.50	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/298141011461?_skw=thinkpad&hash=item456a96ce05:g:b6sAAeSwwYxpvDyE	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35537	177	v1|298140992462|0	Lenovo ThinkPad T490 Laptop 8GB. 256GB SSD, Windows 11 Pro. touscreen	94.30	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/298140992462?_skw=thinkpad&hash=item456a9683ce:g:UmkAAeSwYOVpvDsH	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35538	177	v1|157769780739|0	Thinkpad X240 1.90 GHz Core i5 4GB RAM 120GB SSD Dual Battery - Windows 10 Pro!!	109.90	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/157769780739?_skw=thinkpad&hash=item24bbcfce03:g:3tAAAeSwW15pvDXD	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35539	177	v1|227264182636|0	Lenovo ThinkPad T490s , 14" Full HD i5-8265U, 8GB RAM, 256GB SSD Windows 11	167.10	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/227264182636?_skw=thinkpad&hash=item34ea00396c:g:a6EAAeSwmelpvDjY	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35540	177	v1|358351389726|0	Lenovo ThinkPad T440p Laptop 8GB RAM, No SSD, No OS *READ DESCRIPTION*	73.50	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/358351389726?_skw=thinkpad&hash=item536f68441e:g:89IAAeSwFJtpvDiM	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35541	177	v1|267613858858|0	Lenovo ThinkPad P16s Gen 1 Ryzen 7 PRO 6850U 680M 32GB 1TB FHD+ Laptop	499.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/267613858858?_skw=thinkpad&hash=item3e4f076c2a:g:4bYAAeSwPvlpvDVN	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35542	177	v1|287217696930|0	Lenovo ThinkPad P16s Gen 3 16" WUXGA Intel Core Ultra 9 185H RAM 64GB SSD 1TB	1850.00	GBP	Opened – never used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/287217696930?_skw=thinkpad&hash=item42df8240a2:g:xdwAAeSwadlpPXqk	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35543	177	v1|327057412767|0	LENOVO THINPAD T490 8TH GEN CORE I5 16GB RAM 256GB SSD WIN11	182.70	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/327057412767?_skw=thinkpad&hash=item4c2624129f:g:kTMAAeSwW3RpvC53	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35544	177	v1|236700011428|0	Lenovo ThinkPad X1 Carbon 4th Gen Laptop 14-inch I7 6600U 8GB RAM 256GB SSD	94.26	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/236700011428?_skw=thinkpad&hash=item371c6b8ba4:g:FOIAAeSwciBpvC-z	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35545	177	v1|287217673694|0	Lenovo ThinkPad T14s 2in1 Gen 1 14" Intel Core Ultra 7 255U RAM 32GB SSD 512GB	1550.00	GBP	Opened – never used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/287217673694?_skw=thinkpad&hash=item42df81e5de:g:tVAAAeSw3nxpoEab	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35546	177	v1|117096571651|0	Lenovo ThinkPad X1 Carbon 6th Gen i7-8650U | 16GB | FHD Ultralight (1314)	301.26	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/117096571651?_skw=thinkpad&hash=item1b437fe303:g:w8oAAeSwiBBpvCAV	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35547	177	v1|127757671640|0	Lenovo Thinkpad T470S Laptop i7-6600u 20GB RAM 256GB SSD Win11Pro(J195)	149.99	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/127757671640?_skw=thinkpad&hash=item1dbef35cd8:g:5-YAAeSwUztpvC9F	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35548	177	v1|406785087313|0	lenovo thinkpad p14s gen 5 Intel Ultra Core Ultral 7	700.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/406785087313?_skw=thinkpad&hash=item5eb647d751:g:cvMAAeSwn-FpvCqc	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35549	177	v1|287217614228|0	Lenovo ThinkPad X1 Carbon Gen 13/2.8K Touch/ Intel Ultra 7 265U/64GB RAM/1TB SSD	2499.00	GBP	Opened – never used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/287217614228?_skw=thinkpad&hash=item42df80fd94:g:JC8AAeSwpxZofzxs	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35550	177	v1|358351249069|0	Lenovo ThinkPad X1 Carbon Gen 13 Aura/Touch/ Intel Ultra 7 268V/32GB RAM/2TB SSD	1950.00	GBP	Opened – never used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/358351249069?_skw=thinkpad&hash=item536f661ead:g:JC8AAeSwpxZofzxs	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35551	177	v1|327057362387|0	Lenovo ThinkPad T480s 8th Gen I5, 16GB RAM, 256GB SSD, Win 11 Pro	182.70	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/327057362387?_skw=thinkpad&hash=item4c26234dd3:g:hRMAAeSwFOBpvCJH	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35552	177	v1|366289080574|0	Lenovo ThinkPad E15 i7-10510U Radeon RX 640 16GB Ram 512GB SSD Win11Pro(J193)	259.99	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/366289080574?_skw=thinkpad&hash=item554887d0fe:g:1KcAAeSw8o5pvCXc	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35553	177	v1|177974379295|0	Lenovo ThinkPad X1 Carbon 4th Gen 14" Laptop i7 6th Gen 8GB RAM 256GB SSD Win 11	159.61	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/177974379295?_skw=thinkpad&hash=item297019831f:g:t9MAAeSwlCtpvCTv	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35554	177	v1|198206532359|0	Lenovo ThinkPad X13 2-in-1 Gen 5 Ultra 7 155U 32GB 512GB Touch Win11 + Charger	1100.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/198206532359?_skw=thinkpad&hash=item2e2607ab07:g:xlsAAeSwDFNpvCGA	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35555	177	v1|117096466493|0	Lenovo ThinkPad T495 14" Laptop - Ryzen 7 Pro - 8GB RAM - 256GB SSD (OFFERS OK)	195.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/117096466493?_skw=thinkpad&hash=item1b437e483d:g:d3cAAeSw~QlpvB3f	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35556	177	v1|117096459850|0	Lenovo ThinkPad X395 13.3" Laptop -Ryzen 7 Pro - 16GB RAM- 256GB SSD (OFFERS OK)	210.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/117096459850?_skw=thinkpad&hash=item1b437e2e4a:g:Xm0AAeSwG55pvBz9	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35557	177	v1|177974324616|0	Lenovo ThinkPad T14s Gen 1 14" Laptop i5-10210U Gen 8GB RAM 256GB SSD Windows 11	149.71	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/177974324616?_skw=thinkpad&hash=item297018ad88:g:A-AAAeSw-6ZpvBzp	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35558	177	v1|117096457112|0	Lenovo ThinkPad X395 13.3" Laptop -Ryzen 7 Pro - 16GB RAM- 256GB SSD (OFFERS OK)	210.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/117096457112?_skw=thinkpad&hash=item1b437e2398:g:bAkAAeSwxf5pvBwL	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35559	177	v1|117096452287|0	Lenovo ThinkPad X395 13.3" Laptop -Ryzen 7 Pro - 16GB RAM- 256GB SSD (OFFERS OK)	210.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/117096452287?_skw=thinkpad&hash=item1b437e10bf:g:WDcAAeSwMnNpvBmw	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35560	177	v1|318029598979|0	Lenovo ThinkPad X1 Yoga Gen 8 i5-1335  16GB RAM 256GB SSD 14"  lte internet	440.20	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/318029598979?_skw=thinkpad&hash=item4a0c0a9103:g:6k4AAeSwfUJpvBcI	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35561	177	v1|157769539662|0	Lenovo ThinkPad X1 Yoga 4th Gen i5-8265U 8GB 256GB Win 11 14" Touch	145.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/157769539662?_skw=thinkpad&hash=item24bbcc204e:g:sTQAAeSwjyRpu~13	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35562	177	v1|358351014724|0	Lenovo ThinkPad X1 Carbon Gen 12 - Ultra 7 165U, 32GB RAM, 512GB SSD	924.69	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/358351014724?_skw=thinkpad&hash=item536f628b44:g:bdEAAeSwa~1pvBZQ	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35563	177	v1|127757514713|0	Lenovo Thinkpad E14 gen 1 Intel i7, 16GB RAM 480GB SSD, 2020, Win11 , RRP 1200	158.76	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/127757514713?_skw=thinkpad&hash=item1dbef0f7d9:g:ShAAAeSwMGhpvBMe	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35564	177	v1|377047313393|0	Lenovo ThinkPad E15 Laptop, i5 10210U, 8GB RAM, 256GB NVMe	180.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/377047313393?_skw=thinkpad&hash=item57c9c56bf1:g:~mMAAeSwv6JpvBFM	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35565	177	v1|389770479162|0	Lenovo ThinkPad E15 Gen 2 Core i5 1135G7 16gb Memory 256gb SSD 15.6In FHD (7252)	275.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/389770479162?_skw=thinkpad&hash=item5ac021863a:g:5NMAAeSwH5FpfKtp	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35566	177	v1|406783306369|0	Lenovo Thinkpad L16 Gen 2 21SA001UUK 40.6 Cm 16" Notebook Wuxga Intel Core Ultra	1247.75	GBP	New	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/406783306369?_skw=thinkpad&hash=item5eb62caa81:g:a5kAAeSwyc1pvy~C	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	GB	0	\N
35567	177	v1|188194036563|0	Lenovo ThinkPad L16 Gen 2 Ryzen 5 Pro 215 Radeon 740M 512GB 16GB 1920 x 1200	1518.91	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188194036563?_skw=thinkpad&hash=item2bd13d1b53:g:w3AAAeSw5OJpv5WZ	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35568	177	v1|127762890379|0	lenovo thinkpad E595 TOP Mit Windows 11pro  Installiert	150.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/127762890379?_skw=thinkpad&hash=item1dbf42fe8b:g:B~QAAeSwj0Rpv4zJ	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35569	177	v1|287223675010|0	Lenovo ThinkPad T490 - i7-8565U 16GB 512GB SSD WQHD - Nvidia MX250 DE Win11 Pro	349.99	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/287223675010?_skw=thinkpad&hash=item42dfdd7882:g:quMAAeSw9-9pv4cg	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35570	177	v1|318041484537|0	Lenovo ThinkPad X1 Carbon Gen 10 i5 8GB 256GB SSD 14" Laptop Gebraucht	504.99	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/318041484537?_skw=thinkpad&hash=item4a0cbfecf9:g:J3MAAeSw3mtpv3h4	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	JP	0	\N
35571	177	v1|188193551864|0	Lenovo ThinkPad P14s Gen 5 Ryzen 7 Pro 8840HS Radeon 780M 1TB 32GB 1920 x 1200	2035.39	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188193551864?_skw=thinkpad&hash=item2bd135b5f8:g:ISgAAeSwWu5pv2ch	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35572	177	v1|358359762305|0	Lenovo V15 G2 IJL Laptop - Type82QY	199.99	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/358359762305?_skw=thinkpad&hash=item536fe80581:g:z8kAAeSwYqFpvzUb	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35573	177	v1|147216742325|0	Lenovo ThinkPad T460 i5-6300U 12GB 480GB Intel SSD DC S3510 Series Win 10 Pro	180.00	EUR	Gebraucht	FIXED_PRICE,AUCTION	EBAY_DE	https://www.ebay.de/itm/147216742325?_skw=thinkpad&hash=item2246cd37b5:g:vcwAAeSwD7RpvzSb	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35574	177	v1|236704486715|0	Lenovo ThinkPad E570 Laptop – Intel Core i5-7200U	120.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/236704486715?_skw=thinkpad&hash=item371cafd53b:g:M2wAAeSwoSJpvy14	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35575	177	v1|257418588476|0	Lenovo ThinkPad X390 – 13,3" (33,8 cm), 256 GB SSD, Intel Core i7 8. Gen, 16 RAM	250.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/257418588476?_skw=thinkpad&hash=item3bef57f13c:g:BWgAAeSwTgFpvyII	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35576	177	v1|287222809191|0	Lenovo ThinkPad E15 Gen 2 i5-1135G7 32GB RAM 250GB SSD Win 11 Pro	450.00	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/287222809191?_skw=thinkpad&hash=item42dfd04267:g:apkAAeSwdr5pvx56	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35577	177	v1|127762220284|0	Lenovo ThinkPad E14 G5 14“ Core i7-1335U 512 GB SSD 16 GB #Sehr gut QWERTZ Mwst.	599.00	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/127762220284?_skw=thinkpad&hash=item1dbf38c4fc:g:o9EAAeSwQytpvxIy	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	AT	0	\N
35578	177	v1|188192578228|0	Lenovo ThinkPad L16 Gen 1 Ryzen 5 Pro 7535U Radeon 660M 512GB 16GB 1920 x 1200	1340.59	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192578228?_skw=thinkpad&hash=item2bd126dab4:g:zJgAAeSwgHhpvw8~	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35579	177	v1|188192578033|0	Lenovo ThinkPad L16 Gen 1 Ryzen 5 Pro 7535U AMD Radeon 660M 512GB 16GB	1340.59	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192578033?_skw=thinkpad&hash=item2bd126d9f1:g:aQ0AAeSw4R1pvw96	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35580	177	v1|188192577852|0	Lenovo ThinkPad T16 Gen 4 Core Ultra 5 225U 512GB 16GB 1920 x 1200 16.0" Zoll	1895.19	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192577852?_skw=thinkpad&hash=item2bd126d93c:g:1a4AAeSwmFBpvw9l	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35581	177	v1|188192577451|0	Lenovo ThinkPad L14 Gen 5 Core Ultra 5 125U 262GB 16GB 1920 x 1200 14.0" Zoll	1287.39	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192577451?_skw=thinkpad&hash=item2bd126d7ab:g:nukAAeSwXslpvw9o	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35582	177	v1|188192577151|0	Lenovo ThinkPad P14s Gen 5 Ryzen 7 Pro 8840HS Radeon 780M 1TB 32GB 1920 x 1200	1795.39	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192577151?_skw=thinkpad&hash=item2bd126d67f:g:EQsAAeSwwkppvw8k	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35583	177	v1|188192574393|0	Lenovo ThinkPad X1 Carbon G13 Core Ultra 7 268V 140V 2TB 32GB 2880 x 1800	2917.00	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192574393?_skw=thinkpad&hash=item2bd126cbb9:g:yLAAAeSwBf9pvw7A	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35584	177	v1|188192561490|0	Lenovo ThinkPad X9-14 G1 Core Ultra 5 Intel 226V 130V 512GB 16GB	1324.59	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192561490?_skw=thinkpad&hash=item2bd1269952:g:aDcAAeSwLqFpvw5G	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35585	177	v1|188192559016|0	Lenovo ThinkPad L13 Yoga Gen 2 Core i5 11th Gen 1135G7 262GB 8GB 1920 x 1080	743.89	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192559016?_skw=thinkpad&hash=item2bd1268fa8:g:2SoAAeSwEJppvw7Z	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35586	177	v1|327061273640|0	IBM ThinkPad T23 P3 833MHz 256MB 80GB DVD RS232 LPT 2xUSB S3 SuperSavage WinXP	169.99	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/327061273640?_skw=thinkpad&hash=item4c265efc28:g:q6AAAeSwLW1pvwh6	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35587	177	v1|137154770517|0	ThinkPad X12 Detachable Gen 1 Type 20UW I5-1140G7 16GB 512GB 12,3" Win 11 Pro DE	489.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/137154770517?_skw=thinkpad&hash=item1fef0fb655:g:LTUAAeSw8NdpvwTC	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35588	177	v1|188192436778|0	Lenovo ThinkPad X1 Carbon G13 Core Ultra 7 258V Arc 140V 32GB 1920 x 1200	2665.95	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192436778?_skw=thinkpad&hash=item2bd124b22a:g:fuIAAeSwmsVpvwNx	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35589	177	v1|188192434586|0	Lenovo ThinkPad L13 Yoga Gen 4 Ryzen 5 7530U 512GB 16GB 1920 x 1200 13.0" Zoll	1034.39	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192434586?_skw=thinkpad&hash=item2bd124a99a:g:Lq0AAeSwxnBpvwMN	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35590	177	v1|188192434454|0	Lenovo ThinkPad L13 Yoga Gen 4 Core i5 13th Gen 1335U 512GB 8GB 1920 x 1200	879.79	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192434454?_skw=thinkpad&hash=item2bd124a916:g:mFwAAeSwHnppvwNE	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35591	177	v1|188192434232|0	Lenovo ThinkPad P16 Gen 2 Core i7 13th Gen 13850HX RTX 3500 Ada 1TB 32GB	3431.39	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192434232?_skw=thinkpad&hash=item2bd124a838:g:lo8AAeSwZgVpvwM~	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35592	177	v1|188192433854|0	Lenovo ThinkPad X9-14 G1 Core Ultra 5 228V 130V 1TB 32GB 2880 x 1800 14.0" Zoll	1327.19	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192433854?_skw=thinkpad&hash=item2bd124a6be:g:jA4AAeSwXERpvwMt	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35593	177	v1|188192433239|0	Lenovo ThinkPad X13 G4 Core i5 13th Gen i5-1335U 512GB 16GB 1920 x 1200 WUXGA	1120.89	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192433239?_skw=thinkpad&hash=item2bd124a457:g:WKwAAeSwUrVpvwJr	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35594	177	v1|188192433151|0	Lenovo ThinkPad T14 G3 Core i5 12th Gen i5-1245U 262GB 16GB 1920 x 1200 WUXGA	1038.39	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192433151?_skw=thinkpad&hash=item2bd124a3ff:g:PiAAAeSw~QxpvwJj	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35595	177	v1|188192432897|0	Lenovo ThinkPad P16 G1 Core i9 12th Gen i9-12950HX 1TB 16GB 3840 x 2400 WQUXGA	1933.91	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192432897?_skw=thinkpad&hash=item2bd124a301:g:mPsAAeSwGkFpvwMM	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35596	177	v1|188192432498|0	Lenovo ThinkPad L13 G4 Ryzen 7 Pro 7730U 1TB 32GB 1920 x 1200 13.0" Zoll touch	1222.00	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192432498?_skw=thinkpad&hash=item2bd124a172:g:jrwAAeSw8otpvwL5	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35597	177	v1|147216409855|0	ThinkPad X12 Detachable Gen 1 Type 20UW I5-1140G7 16GB 512GB 12,3" Win 11 Pro DE	499.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/147216409855?_skw=thinkpad&hash=item2246c824ff:g:Co4AAeSw4GhpvvKy	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35598	177	v1|188192230989|0	Lenovo ThinkPad 14 Gen 7 Ryzen 5 7th Gen 7533HS 512GB 16GB 1920x1200 14.0" Zoll	895.79	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192230989?_skw=thinkpad&hash=item2bd1218e4d:g:BCEAAeSwgHhpvvEh	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35599	177	v1|188192230443|0	Lenovo ThinkPad X1 Yoga Gen 10 G10 Core Ultra 7 258V 1TB 32GB 2880x1800	1940.93	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192230443?_skw=thinkpad&hash=item2bd1218c2b:g:5DIAAeSwEE5pvvF5	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35600	177	v1|257418183884|0	Lenovo ThinkPad X13 Laptop 13"  AMD  Gen 10 8GB RAM 256GB SSD Win11 B-Ware	189.00	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/257418183884?_skw=thinkpad&hash=item3bef51c4cc:g:e1kAAeSwz8lpvucF	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	NL	0	\N
35601	177	v1|257418183889|0	Lenovo ThinkPad X13 Laptop 13"  AMD  Gen 10 8GB RAM 256GB SSD Win11 C-Ware	123.00	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/257418183889?_skw=thinkpad&hash=item3bef51c4d1:g:ceQAAeSwGn1pvuZU	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	NL	0	\N
35602	177	v1|257418183877|0	Lenovo ThinkPad L13 Gen 2 Laptop 13"  Intel i5 16GB RAM 256GB SSD Win11 C-Ware	195.00	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/257418183877?_skw=thinkpad&hash=item3bef51c4c5:g:o9oAAeSwDLhpvucA	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	NL	0	\N
35603	177	v1|257418183883|0	Lenovo ThinkPad X13 Laptop 13"  AMD  Gen 10 16GB RAM 256GB SSD Win11 A-Ware	279.00	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/257418183883?_skw=thinkpad&hash=item3bef51c4cb:g:r04AAeSwqJ9pvuZU	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	NL	0	\N
35604	177	v1|397743839123|0	Lenovo ThinkPad E15 Gen2, Intel I7-1165G7, 16GB RAM, 256GB SSD, 15.6" Win11	310.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/397743839123?_skw=thinkpad&hash=item5c9b615793:g:wyoAAeSwZgVpvuSa	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35605	177	v1|406789214957|0	IBM Thinkpad R40 /2722 mit Windows XP / Pentium M 1,4Ghz / 120GB HDD / 512MB RAM	39.00	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/406789214957?_skw=thinkpad&hash=item5eb686d2ed:g:cx8AAeSwo3VpvtcG	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35606	177	v1|287222307277|0	Lenovo ThinkPad E14 Gen 6 - 35.6 cm (14") - Ryzen 5 7535HS - 16 GB RAM -  #EG544	1132.61	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287222307277?_skw=thinkpad&hash=item42dfc899cd:g:HSEAAeSwXslpvtXZ	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35607	177	v1|389779373984|0	Lenovo ThinkPad L16 G1 Intel Core Ultra 5 135U 16GB 512GB	599.99	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/389779373984?_skw=thinkpad&hash=item5ac0a93fa0:g:THIAAeSwUMZpvtAr	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	HR	0	\N
35608	177	v1|117100212389|0	Laptop Lenovo thinkpad t570 i7  SSD 500 gb 16 gb RAM	199.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/117100212389?_skw=thinkpad&hash=item1b43b770a5:g:-TgAAeSwMoRpvs~h	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35609	177	v1|147216224178|0	Lenovo ThinkPad T580 i7 8th Gen	120.00	EUR	Gebraucht	FIXED_PRICE,AUCTION	EBAY_DE	https://www.ebay.de/itm/147216224178?_skw=thinkpad&hash=item2246c54fb2:g:TzgAAeSwYC5pvtFf	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35610	177	v1|227266895790|0	Lenovo ThinkPad T470p 14" Intel  i7-7700HQ 2,80GHz 256GB SSD 16GB RAM DE	219.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/227266895790?_skw=thinkpad&hash=item34ea299fae:g:rKMAAeSwERtpnYJA	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35611	177	v1|188191871905|0	lenovo thinkpad e 580 i7 8th gen	195.00	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188191871905?_skw=thinkpad&hash=item2bd11c13a1:g:QA8AAeSwUMZpvs3q	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35612	177	v1|358358712767|0	Lenovo ThinkPad E15 Intel I3 10110U	180.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/358358712767?_skw=thinkpad&hash=item536fd801bf:g:4k8AAeSwGa5pvsYO	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35613	177	v1|206156262241|0	Lenovo ThinkPad T480 – 14" FHD | i5-8350U | 08GB RAM | 256GB SSD | Windows 11Pro	179.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/206156262241?_skw=thinkpad&hash=item2fffdeeb61:g:-SwAAeSwsAJpvsRN	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35614	177	v1|318039081823|0	Lenovo Thinkpad W700ds Windows 10 8GB RAM 2x120GB Festplatte Laptop Getestet ✅	1499.99	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/318039081823?_skw=thinkpad&hash=item4a0c9b435f:g:i54AAeSwY0hpvrwy	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35615	177	v1|188191657970|0	Nr.2 Lenovo ThinkPad T420 mit Windows 10 ** Intel Core i5 * 256 GB SSD * 6GB Ram	60.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/188191657970?_skw=thinkpad&hash=item2bd118cff2:g:eDAAAeSwl2hpvrjd	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35616	177	v1|188191612826|0	Nr.1 Lenovo ThinkPad T420 mit Ubuntu (Linux) ** Intel Core i5 * 500 GB HDD * 4GB	55.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/188191612826?_skw=thinkpad&hash=item2bd1181f9a:g:fUwAAeSwiuFpvrRa	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35617	177	v1|397743271551|0	Lenovo ThinkPad T490s, I5-8365U	250.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/397743271551?_skw=thinkpad&hash=item5c9b58ae7f:g:gLUAAeSwpAtpvrNM	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35618	177	v1|389778901534|0	Lenovo ThinkPad 11th Gen  i5-1135G7 16GB 256GB Win11Pro/DE.	379.00	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/389778901534?_skw=thinkpad&hash=item5ac0a20a1e:g:6hUAAeSw95tpvp6p	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35619	177	v1|117100012230|0	Lenovo ThinkPad P52s Touch - i7-8550U 4x1,8GHz,16GB,512GB NVMe,P500,FHD,FPR,BL	589.00	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/117100012230?_skw=thinkpad&hash=item1b43b462c6:g:J1oAAeSw6V1pvqyK	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35620	177	v1|298147099601|0	E-INK Lenovo Thinkpad Plus G4 i7-1355U 16GB Ram 512GB SSD Laptop PC Paperlike	1490.00	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/298147099601?_skw=thinkpad&hash=item456af3b3d1:g:BQkAAeSwT3xpvqxy	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35621	177	v1|406788911872|0	Lenovo Thinkpad x280 i5-7200U / Windows 11 / 256GB HDD / 8GB RAM / sehr gepflegt	119.00	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/406788911872?_skw=thinkpad&hash=item5eb6823300:g:yq4AAeSwlf1pts8y	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35622	177	v1|298147081977|0	Lenovo ThinkPad T16g Gen 3 - Intel Ultra 7 - 16" - Ultra 7 - 1.000 GB #BY914	4502.07	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/298147081977?_skw=thinkpad&hash=item456af36ef9:g:FUsAAeSwSoJpvqtt	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35623	177	v1|188191408438|0	IBM ThinkPad X41, Intel Pentium M 1.50Ghz, 1.5GB RAM, 40GB HDD + Extras	250.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/188191408438?_skw=thinkpad&hash=item2bd1150136:g:-ZMAAeSwRqppvqAl	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	HR	0	\N
35624	177	v1|227266711754|0	Lenovo ThinkPad T470s I7 8GB RAM 512GB SSD LTE 14" FHD	130.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/227266711754?_skw=thinkpad&hash=item34ea26d0ca:g:xcIAAeSw4JZpqWIZ	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35625	177	v1|397743071865|0	Lenovo ThinkPad X1 Carbon Gen 12 / Ultra 7 155U / 32 GB / 512 GB SSD / EN INT KB	1300.00	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/397743071865?_skw=thinkpad&hash=item5c9b55a279:g:CnUAAeSwGMhpvqEe	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35626	177	v1|298146981603|0	Lenovo ThinkPad L570 15,6 1TB SSD Intel i5-16GB Win 11 FullHD	249.00	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/298146981603?_skw=thinkpad&hash=item456af1e6e3:g:0wEAAeSw4phpvqCA	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35627	177	v1|188191377547|0	Lenovo ThinkPad X1 Yoga G5 | i5-10310U | 14"	310.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/188191377547?_skw=thinkpad&hash=item2bd114888b:g:yC4AAeSwhORpvp6o	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35628	177	v1|389778673132|0	Lenovo ThinkPad 11th Gen  i5-1135G7 8GB 256GB Win11Pro/DE.	359.00	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/389778673132?_skw=thinkpad&hash=item5ac09e8dec:g:6hUAAeSw95tpvp6p	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35629	177	v1|318038588436|0	Lenovo ThinkPad X200 Tablet – 4GB RAM – SSD – voll funktionsfähig	50.90	EUR	Gebraucht	FIXED_PRICE,AUCTION	EBAY_DE	https://www.ebay.de/itm/318038588436?_skw=thinkpad&hash=item4a0c93bc14:g:mZEAAeSw-QxpvpwF	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35630	177	v1|358358153565|0	Lenovo ThinkPad X13 Yoga Gen 2 i5-11th 16GB RAM 512GB SSD 13,3" FHD Touchscreen	423.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/358358153565?_skw=thinkpad&hash=item536fcf795d:g:UGQAAeSw6YtpvpaI	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35631	177	v1|227266626351|0	Lenovo ThinkPad T450 14 Zoll ( 256GB SSD , intel Core i5 5300U , 8GB RAM )...	150.00	EUR	Gebraucht	FIXED_PRICE,AUCTION	EBAY_DE	https://www.ebay.de/itm/227266626351?_skw=thinkpad&hash=item34ea25832f:g:3pEAAeSwzd1pvo~b	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35632	177	v1|147215943697|0	Lenovo ThinkPad E16 G3 16" WQXGA 120Hz Ultra 7 255H 32GB 1TB IR FPR ohne BS! NEU	1399.90	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/147215943697?_skw=thinkpad&hash=item2246c10811:g:BJ0AAeSwNctptD-V	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35633	177	v1|147215928153|0	Lenovo ThinkPad T14 Gen 1 14'' AMD Ryzen 5 PRO 4650U. 16GB	249.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/147215928153?_skw=thinkpad&hash=item2246c0cb59:g:TWgAAeSw8rRpvpCS	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35634	177	v1|227266609352|0	Lenovo ThinkPad T560 -Intel Core i7 - 16gb RAM - 500gb SSD - Notebook Win11	149.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/227266609352?_skw=thinkpad&hash=item34ea2540c8:g:PvkAAeSwU0Zpvo6G	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35635	177	v1|117099823896|0	Lenovo ThinkPad P52 – i7-8850H, 16GB RAM TOP ohne Windows laptop notebook	300.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/117099823896?_skw=thinkpad&hash=item1b43b18318:g:YVsAAeSwKeRpvpHi	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35636	177	v1|206155853587|0	Lenovo ThinkPad T480 – 14" FHD | i5-8350U | 08GB RAM | 256GB SSD | Windows 11Pro	179.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/206155853587?_skw=thinkpad&hash=item2fffd8af13:g:~sUAAeSwrDJpvotQ	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35637	177	v1|389778342212|0	Lenovo ThinkPad X1 Carbon Gen7 | i5-8365U | 16 / 512GB M.2 | Winds 11 | BIOS#35E	149.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/389778342212?_skw=thinkpad&hash=item5ac0998144:g:9eIAAeSw75ppvoa8	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35638	177	v1|397742576783|0	Lenovo L590 i 7 CPU ,16GB RAM,256 GB SSD,Win11 Pro Notebook inkl.Netzteil	280.00	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/397742576783?_skw=thinkpad&hash=item5c9b4e148f:g:dR4AAeSw6Ytpvnaw	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35639	177	v1|306834645950|0	Lenovo ThinkPad T14s G6 14" FHD+ Ultra 7 258V 32GB LPDDR5X-8533 256GB IR FPR NEU	1499.90	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/306834645950?_skw=thinkpad&hash=item4770c523be:g:JKUAAeSw92xpA2YZ	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35640	177	v1|157773710058|0	Lenovo ThinkPad X1 Titanium Touch i7-1160G7 11th 16GB 1TB NVMe Win11 "Yoga"	649.00	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/157773710058?_skw=thinkpad&hash=item24bc0bc2ea:g:Il8AAeSwryhpvm1N	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	NL	0	\N
35641	177	v1|127761167786|0	Lenovo ThinkPad E15 Gen 2, i5, 256 GB SSD, 16 GB RAM	249.00	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/127761167786?_skw=thinkpad&hash=item1dbf28b5aa:g:6PUAAeSwM29pvmO0	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35642	177	v1|147215646415|0	Lenovo ThinkPad X1 Carbon 9. Gen 14" 32GB, 512GB i7 1185U, Display 3840x2400 En	599.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/147215646415?_skw=thinkpad&hash=item2246bc7ecf:g:Wa4AAeSw4whpvk4Z	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35643	177	v1|389777823033|0	Laptop ThinkPad Yoga 460 Touchscreen + Stift i7-6500U 8GB RAM #3	180.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/389777823033?_skw=thinkpad&hash=item5ac0919539:g:fXgAAeSwPKtpvld2	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35644	177	v1|198211231145|0	X1 Carbon 7th Gen - (Type 20QD, 20QE) Laptop (ThinkPad) - Type 20QE	159.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/198211231145?_skw=thinkpad&hash=item2e264f5da9:g:oEcAAeSwXhxoxpL0	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35645	177	v1|117099543574|0	Lenovo ThinkPad E14 Gen 2 14"(480 SSD, Intel Core i5-1135G7, 16GB,MX450)	240.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/117099543574?_skw=thinkpad&hash=item1b43ad3c16:g:bNwAAeSwVhJpvlXO	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35646	177	v1|188190496573|0	Lenovo ThinkPad T14 G5 Ryzen 7 Pro 8840U Radeon 780M 512GB 32GB 2880 x 1800	1449.69	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190496573?_skw=thinkpad&hash=item2bd107173d:g:ai8AAeSwK9RpvlAj	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35647	177	v1|188190492416|0	Lenovo ThinkPad T14 G5 Ryzen 7 Pro 8840U Radeon 780M 512GB 32GB 1920 x 1200	1449.69	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190492416?_skw=thinkpad&hash=item2bd1070700:g:f6QAAeSwymlpvlAC	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35648	177	v1|188190480107|0	Lenovo ThinkPad P16v G1 Ryzen 7 Pro 7840HS RTX A500 512GB 16GB 1920 x 1200 WUXGA	2071.09	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190480107?_skw=thinkpad&hash=item2bd106d6eb:g:ZvAAAeSwLoxpvk82	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35649	177	v1|188190456846|0	Lenovo ThinkPad X1 Carbon G13 Core Ultra 7 258V 140V 512GB 32GB 1920 x 1200	2491.00	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190456846?_skw=thinkpad&hash=item2bd1067c0e:g:P7IAAeSwrDJpvk4l	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35650	177	v1|188190451369|0	Lenovo ThinkPad P14s G5 Ryzen 7 Pro 8840HS Radeon 780M 512GB 32GB	1538.89	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190451369?_skw=thinkpad&hash=item2bd10666a9:g:Wm0AAeSwR0tpvk1L	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35651	177	v1|188190404423|0	Lenovo ThinkPad P16 Gen 2 Core i7 13th Gen 13850HX RTX 4000 Ada 1TB 64GB	4901.39	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190404423?_skw=thinkpad&hash=item2bd105af47:g:NXAAAeSw~Qxpvki2	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35652	177	v1|188190402181|0	Lenovo ThinkPad P16 Gen 2 Core i7 13th Gen 13850HX RTX 4000 Ada 1TB 64GB	4901.39	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190402181?_skw=thinkpad&hash=item2bd105a685:g:QHsAAeSwjaZpvkfj	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35653	177	v1|188190399807|0	Lenovo ThinkPad P16 Gen 2 Core i7 13th Gen 13850HX RTX 4000 Ada 1TB 64GB	4901.39	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190399807?_skw=thinkpad&hash=item2bd1059d3f:g:3U4AAeSwdLdpvkdb	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35654	177	v1|188190398581|0	Lenovo ThinkPad P16 Gen 2 Core i7 13th Gen 13850HX RTX 4000 Ada 1TB 64GB	4901.39	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190398581?_skw=thinkpad&hash=item2bd1059875:g:MiIAAeSwzT9pvka8	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35655	177	v1|188190367229|0	Lenovo Thinkpad L16 G2 Ryzen 5 Pro 215 512GB 16GB 1920x1200 16.0" Zoll Black	1518.91	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190367229?_skw=thinkpad&hash=item2bd1051dfd:g:A2cAAeSwjKxpvkQW	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35656	177	v1|188190361750|0	Lenovo ThinkPad T14s Gen 2 20WN Core i7 11th Gen 1165G7 512GB 8GB 1920 x 1080	1102.19	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190361750?_skw=thinkpad&hash=item2bd1050896:g:BYcAAeSwfcVpvkNk	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35657	177	v1|188190356719|0	Lenovo ThinkPad T14 Gen 5 Ryzen Pro 8th Gen 8540U Radeon 740M 512GB 16GB	1465.69	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190356719?_skw=thinkpad&hash=item2bd104f4ef:g:BEIAAeSwYhhpvkKe	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35658	177	v1|188190354160|0	Lenovo ThinkPad P16 Gen 2 Core i7 13th Gen 13850HX RTX 4000 Ada 1TB 64GB	4901.39	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190354160?_skw=thinkpad&hash=item2bd104eaf0:g:0nAAAeSwYqFpvkHO	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35659	177	v1|188190334169|0	Lenovo ThinkPad T14 Gen 5 Ryzen Pro 8th Gen 8540U Radeon 740M 512GB 16GB	1465.69	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190334169?_skw=thinkpad&hash=item2bd1049cd9:g:n3EAAeSw0fVpvj~I	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35660	177	v1|188190327497|0	Lenovo ThinkPad T14 Gen 5 Ryzen Pro 8th Gen 8540U Radeon 740M 512GB 16GB	1465.69	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190327497?_skw=thinkpad&hash=item2bd10482c9:g:yOEAAeSwzadpvkAO	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35661	177	v1|188190318695|0	Lenovo ThinkPad X9-14 G1 Core Ultra 5 228V 130V 512GB 32GB 1920 x 1200 WUXGA	1705.39	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190318695?_skw=thinkpad&hash=item2bd1046067:g:uFQAAeSwhORpvj43	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35662	177	v1|188190317752|0	Lenovo ThinkPad T14 Gen 5 Ryzen Pro 8th Gen 8540U Radeon 740M 512GB 16GB	1465.69	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190317752?_skw=thinkpad&hash=item2bd1045cb8:g:rJ4AAeSwif9pvj5I	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35663	177	v1|188190309264|0	Lenovo ThinkPad L13 G6 Core Ultra 7 Intel 255U 512GB 16GB 1920 x 1200 WUXGA	1251.39	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190309264?_skw=thinkpad&hash=item2bd1043b90:g:vLYAAeSwYQdpvjxU	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35664	177	v1|188190286170|0	Lenovo ThinkPad T14 Gen 5 Ryzen Pro 8th Gen 8540U Radeon 740M 512GB 16GB	1465.69	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190286170?_skw=thinkpad&hash=item2bd103e15a:g:xq4AAeSwcIRpvjt0	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35665	177	v1|188190278883|0	Lenovo ThinkPad T14 Gen 5 Ryzen Pro 8th Gen 8540U Radeon 740M 512GB 16GB	1465.69	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190278883?_skw=thinkpad&hash=item2bd103c4e3:g:kYEAAeSwZgVpvjqe	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35666	177	v1|188190277912|0	Lenovo ThinkPad T14 Gen 5 Ryzen Pro 8th Gen 8540U Radeon 740M 512GB 16GB	1465.69	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190277912?_skw=thinkpad&hash=item2bd103c118:g:kYsAAeSwY0hpvjom	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35667	177	v1|188190272390|0	Lenovo ThinkPad X12 Detachable Core i7 11th Gen 1160G7 262GB 16GB 1920 x 1280	1067.59	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190272390?_skw=thinkpad&hash=item2bd103ab86:g:iTUAAeSwbKlpvjkx	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35668	177	v1|188190271981|0	Lenovo ThinkPad X12 Detachable Core i5 11th Gen 1140G7 262GB 16GB 1920 x 1280	1042.39	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190271981?_skw=thinkpad&hash=item2bd103a9ed:g:lE0AAeSwOyxpvjmc	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35669	177	v1|188190269285|0	Lenovo ThinkPad X1 Carbon G13 Core Ultra 7 258V 140V 512GB 32GB 1920 x 1200	2479.00	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190269285?_skw=thinkpad&hash=item2bd1039f65:g:kwIAAeSwtgZpvjiV	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35670	177	v1|188190262917|0	Lenovo ThinkPad X1 Tablet G3 Core i7 8th Gen i7-8550U 512GB 16GB	855.00	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190262917?_skw=thinkpad&hash=item2bd1038685:g:FiEAAeSwzd1pvjfz	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35671	177	v1|188190259362|0	Lenovo ThinkPad T14s G4 Ryzen 5 Pro 7540U Radeon 740M 512GB 16GB	1042.39	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190259362?_skw=thinkpad&hash=item2bd10378a2:g:v6IAAeSwsgtpvjeh	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35672	177	v1|188190240430|0	Lenovo ThinkPad X12 Detachable Core i5 11th Gen 1140G7 262GB 16GB 1920 x 1280	893.09	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190240430?_skw=thinkpad&hash=item2bd1032eae:g:VmkAAeSw9-9pvjcq	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35673	177	v1|267615332066|0	Lenovo ThinkPad P16v G2 (21KX004XGE) 16" Full HD Notebook Intel Core Ultra 7	2503.07	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/267615332066?_skw=thinkpad&hash=item3e4f1de6e2:g:5A4AAeSwjKdpvdj2	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35674	177	v1|287221180674|0	Lenovo ThinkPad P16 G3 (21RQ003WGE) 16" Touch Notebook Intel Core Ultra 9 SSD	8624.42	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287221180674?_skw=thinkpad&hash=item42dfb76902:g:U-sAAeSw8otpvdj2	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35675	177	v1|267615332041|0	Lenovo ThinkPad P16 G3 (21RQ000MGE) 16" Full HD Notebook Intel Core Ultra 9 SSD	6615.86	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/267615332041?_skw=thinkpad&hash=item3e4f1de6c9:g:wJ8AAeSw2jNptzx9	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35676	177	v1|267615332044|0	Lenovo ThinkPad P16 G3 (21RQ003QGE) 16" Full HD Notebook Intel Core Ultra 9 SSD	5641.99	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/267615332044?_skw=thinkpad&hash=item3e4f1de6cc:g:418AAeSwSHlpueJj	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35677	177	v1|287221158534|0	Lenovo ThinkPad T16 Gen 4 - (16") - Ultra 5 225U - 16 GB RAM - 512 GB SSD #AL268	1625.93	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287221158534?_skw=thinkpad&hash=item42dfb71286:g:KDYAAeSw8kRpvjD1	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35679	177	v1|358357024562|0	Lenovo ThinkPad P16s Gen 4 - AMD Ryzen AI 7 PRO 350 - AMD PRO - Win 11 Pr #BY825	2032.33	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/358357024562?_skw=thinkpad&hash=item536fbe3f32:g:WgQAAeSwnc1pvjCZ	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35680	177	v1|358357023738|0	Lenovo ThinkPad P14s Gen 5 #BY816	2063.75	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/358357023738?_skw=thinkpad&hash=item536fbe3bfa:g:VI0AAeSwhORpvjCE	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35681	177	v1|298145825755|0	Lenovo ThinkPad X1 Carbon Gen 13 - 14", Intel Core Ultra 7 258V, 32 GB RA #BY474	2578.01	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/298145825755?_skw=thinkpad&hash=item456ae043db:g:ohYAAeSwjaZpvjBo	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35682	177	v1|358357021902|0	Lenovo ThinkPad E16 Gen 3 - 16", AMD Ryzen 7 250, 16 GB RAM, 512 GB SSD,  #BY385	1060.34	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/358357021902?_skw=thinkpad&hash=item536fbe34ce:g:b6AAAeSwrIBpvjBg	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35683	177	v1|406787906626|0	Lenovo ThinkPad T14 Gen 3 AMD | Ryzen 5 PRO 6650U | 16GB  | 256GB NVMe | Win 11	479.00	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/406787906626?_skw=thinkpad&hash=item5eb672dc42:g:XTcAAeSwbq5pviv~	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35684	177	v1|188190151643|0	Lenovo ThinkPad X13 2-in-1 Gen 5 Core Ultra 13th Gen 135U 262GB 16GB 1920 x 1200	1226.00	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190151643?_skw=thinkpad&hash=item2bd101d3db:g:RX4AAeSwzadpvi2u	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35685	177	v1|198210916138|0	Lenovo ThinkPad X1 2-in-1 G10 21NU007MGE 14" WUXGA Core Ultra 7 258V 32GB/1TB...	2236.67	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/198210916138?_skw=thinkpad&hash=item2e264a8f2a:g:UvkAAeSwkGZpviym	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35686	177	v1|188190121909|0	Lenovo ThinkPad X1 Carbon G13 Core Ultra 7 255U 512GB 32GB 2880 x 1800	2461.69	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190121909?_skw=thinkpad&hash=item2bd1015fb5:g:bKgAAeSwY0ppvivg	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35687	177	v1|188190119064|0	Lenovo ThinkPad X12 Detachable Core i7 11th Gen 1160G7 262GB 16GB 1920 x 1280	1067.59	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190119064?_skw=thinkpad&hash=item2bd1015498:g:KFcAAeSwYB1pvisS	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35688	177	v1|188190111440|0	Lenovo ThinkPad X12 Detachable Core i5 11th Gen 1140G7 262GB 16GB 1920 x 1280	893.09	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190111440?_skw=thinkpad&hash=item2bd10136d0:g:cpwAAeSwrw5pvip6	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35689	177	v1|188190109446|0	Lenovo ThinkPad T14 G5 Ryzen 7 Pro 8840U Radeon 780M 512GB 16GB	1280.59	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190109446?_skw=thinkpad&hash=item2bd1012f06:g:BEYAAeSwTX5pvink	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35690	177	v1|188190092690|0	Lenovo ThinkPad T14s G4 Ryzen 5 Pro 7540U Radeon 740M 512GB 16GB	1190.09	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190092690?_skw=thinkpad&hash=item2bd100ed92:g:McIAAeSwiYFpviiX	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35691	177	v1|277821459997|0	Lenovo Thinkpad E595 & Dockingstation (AMD Ryzen 5 3500; 16 GB RAM; 512 GB SSD)	325.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/277821459997?_skw=thinkpad&hash=item40af730e1d:g:IykAAeSwfK5pLEmS	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35692	177	v1|287221029434|0	Lenovo ThinkPad E16 Gen 3 (Intel) – 16", Intel Core Ultra 5 228V, 32 GB R #CYY97	1242.58	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287221029434?_skw=thinkpad&hash=item42dfb51a3a:g:0jEAAeSwkGZpvhOS	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35693	177	v1|358356707528|0	Lenovo ThinkPad T14 Gen 6 - Intel Core Ultra 5 225U - Win 11 Pro - Intel  #CY02Q	2028.13	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/358356707528?_skw=thinkpad&hash=item536fb968c8:g:83YAAeSweElpvhLB	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35694	177	v1|358356659056|0	Lenovo ThinkPad P14s Gen 6 -  Core Ultra 7 255H - Win 11 Pro - NVIDIA RTX #AP607	2508.86	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/358356659056?_skw=thinkpad&hash=item536fb8ab70:g:5goAAeSwoolpvg2K	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35695	177	v1|358356652803|0	Lenovo ThinkPad T14 Gen 6, 14'', Core Ultra 5 228V, 32GB RAM, 1TB SSD, Wi #AP594	1713.92	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/358356652803?_skw=thinkpad&hash=item536fb89303:g:3BcAAeSwyc1pvgzn	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35696	177	v1|298145591912|0	Lenovo ThinkPad E16 Gen 3, 16'', Black, Core Ultra 7 258V, 32GB RAM, 1TB  #AP350	1285.53	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/298145591912?_skw=thinkpad&hash=item456adcb268:g:mt4AAeSw95tpvgzf	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35697	177	v1|298145591530|0	Lenovo ThinkPad L14 Gen 6 (AMD), Ryzen 5 PRO 215, 32 GB RAM, 1 TB SSD, Ra #AP928	1404.93	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/298145591530?_skw=thinkpad&hash=item456adcb0ea:g:sdcAAeSwBfVpvgy2	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35698	177	v1|358356650332|0	Lenovo ThinkPad L16 Gen 2 #AP940	1397.60	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/358356650332?_skw=thinkpad&hash=item536fb8895c:g:kakAAeSw9RFpvgyU	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35699	177	v1|287220999330|0	Lenovo ThinkPad T14 Gen 6 #AP954	2501.55	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287220999330?_skw=thinkpad&hash=item42dfb4a4a2:g:phIAAeSw9H9pvgyL	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35700	177	v1|287220999055|0	Lenovo ThinkPad E14 Gen 7 – 14", Intel Core Ultra 7 258V, 32 GB RAM, 1 TB #AP993	1272.96	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287220999055?_skw=thinkpad&hash=item42dfb4a38f:g:6YsAAeSwHPBpvgx7	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35701	177	v1|298145590592|0	Lenovo ThinkPad L14 Gen 6 #AP980	1154.60	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/298145590592?_skw=thinkpad&hash=item456adcad40:g:pd8AAeSw17hpvgxh	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35702	177	v1|358356649633|0	Lenovo ThinkPad L16 Gen 2 (Intel) - 16", Intel Core Ultra 5 225U, 16 GB R #AP915	1225.83	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/358356649633?_skw=thinkpad&hash=item536fb886a1:g:C~wAAeSwGMhpvgxV	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35703	177	v1|287220998394|0	LENOVO ThinkPad L13 G6 33,78cm (13,3") Ultra 5 225U 16GB 512GB W11P #AP898	1201.74	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287220998394?_skw=thinkpad&hash=item42dfb4a0fa:g:e1MAAeSwbKlpvgxO	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35704	177	v1|298145590181|0	Lenovo ThinkPad T14 G6 (Intel), Black, Core Ultra 5 225U, 16GB RAM, 512GB #AP278	1500.24	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/298145590181?_skw=thinkpad&hash=item456adcaba5:g:hoUAAeSw4cZpvgw-	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35705	177	v1|298145590071|0	Lenovo ThinkPad X1 Carbon G13, Black, Core Ultra 7 258V, 32GB RAM, 1TB SS #AP121	2393.67	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/298145590071?_skw=thinkpad&hash=item456adcab37:g:4xEAAeSwSoJpvgw2	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35706	177	v1|298145589715|0	LENOVO ThinkPad X1 Carbon G13 - 14", Intel Core Ultra 5 225U, 16 GB RAM,  #AP677	2012.42	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/298145589715?_skw=thinkpad&hash=item456adca9d3:g:4mAAAeSwncRpvgwk	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35707	177	v1|298145588035|0	Lenovo ThinkPad T14s G6 (Intel), Black, Core Ultra 5 228V, 32GB RAM, 1TB  #AP530	1988.33	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/298145588035?_skw=thinkpad&hash=item456adca343:g:lx4AAeSwrIBpvgwN	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35708	177	v1|358356643137|0	Lenovo ThinkPad X9-15 Gen 1 - (15.3") - Ultra 7 258V - Evo - 32 GB RAM -  #AP245	1786.18	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/358356643137?_skw=thinkpad&hash=item536fb86d41:g:V0UAAeSwTX5pvgv7	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35709	177	v1|287220989509|0	Lenovo ThinkPad T14 Gen 6 -  Core Ultra 5 226V - Win 11 Pro - Arc Graphic #TE226	1459.40	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287220989509?_skw=thinkpad&hash=item42dfb47e45:g:kqwAAeSwPOhpvgth	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35710	177	v1|358356635519|0	Lenovo ThinkPad T14 Gen 6 -  Core Ultra 5 226V - Win 11 Pro - Arc Graphic #TE227	1521.20	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/358356635519?_skw=thinkpad&hash=item536fb84f7f:g:91IAAeSwXzBpvgtb	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35711	177	v1|298145571029|0	Lenovo ThinkPad E16 Gen 3 (Intel), 16", Intel Core Ultra 5 225U, 32 GB RA #TE401	1411.21	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/298145571029?_skw=thinkpad&hash=item456adc60d5:g:e6AAAeSwzONpvgrH	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35712	177	v1|287220985552|0	Lenovo ThinkPad T14 Gen 6 #TE541	2118.20	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287220985552?_skw=thinkpad&hash=item42dfb46ed0:g:mcAAAeSwV8xpvgq~	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35713	177	v1|298145566499|0	Lenovo ThinkPad P1 Gen 8 - Ultra 7 255H - Evo - Win 11 Pro - RTX PRO 2000 #IN168	4162.71	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/298145566499?_skw=thinkpad&hash=item456adc4f23:g:S-UAAeSw-Qxpvgo2	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35714	177	v1|287220978123|0	Lenovo ThinkPad E14 Gen 7 – 14" 2.8K, Intel Core Ultra 5 228V, 32 GB RAM, #IN443	1283.43	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287220978123?_skw=thinkpad&hash=item42dfb451cb:g:SHQAAeSwtnBpvgoj	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35715	177	v1|298145556499|0	Lenovo ThinkPad L14 G6 (Intel), Black, Core Ultra 5 225U, 16GB RAM, 512GB #AL230	1227.92	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/298145556499?_skw=thinkpad&hash=item456adc2813:g:hGQAAeSw5JppvghC	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35716	177	v1|287220970983|0	Lenovo ThinkPad X1 Carbon Gen 13 - (14") - Ultra 7 258V - Evo - 32 GB RAM #AL005	2434.52	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287220970983?_skw=thinkpad&hash=item42dfb435e7:g:bUIAAeSwhORpvggx	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35717	177	v1|358356612266|0	Lenovo ThinkPad T14s G6 (Intel), Black, Core Ultra 7 258V, 32GB RAM, 1TB  #AL582	2132.87	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/358356612266?_skw=thinkpad&hash=item536fb7f4aa:g:X5YAAeSw~U5pvgf1	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35718	177	v1|298145546942|0	Lenovo ThinkPad P16 Gen 3 - 16", Core Ultra 9 275HX, 96 GB RAM, 1 TB SSD, #EG343	6596.85	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/298145546942?_skw=thinkpad&hash=item456adc02be:g:jckAAeSw4xBpvgdN	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35719	177	v1|287220961643|0	Lenovo ThinkPad E14 Gen 5 - (14") - Ryzen 5 7530U - 16 GB RAM - 512 GB SS #EG693	907.42	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287220961643?_skw=thinkpad&hash=item42dfb4116b:g:76cAAeSwzntpvgYh	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35720	177	v1|358356300749|0	Lenovo ThinkPad T14s 2-in-1 Gen 1, 14", Intel Core Ultra 7 255U, 32 GB RA #BY987	2266.93	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/358356300749?_skw=thinkpad&hash=item536fb333cd:g:pEwAAeSw0fVpveqP	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35721	177	v1|358356300490|0	Lenovo ThinkPad T14s 2-in-1 Gen 1 – 14", Intel Core Ultra 7 255U, 32 GB R #BY986	2315.11	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/358356300490?_skw=thinkpad&hash=item536fb332ca:g:4qsAAeSwOp1pveqG	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35722	177	v1|298145302381|0	Lenovo ThinkPad P16 Gen 3 - 16", Intel Core Ultra 9 275HX, 96 GB RAM, 1 T #BY313	3706.79	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/298145302381?_skw=thinkpad&hash=item456ad8476d:g:mIwAAeSwsdppveof	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35723	177	v1|358356294592|0	Lenovo ThinkPad E14 Gen 7 - 14", Intel Core Ultra 5 226V, 32 GB RAM, 512  #BY874	1084.43	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/358356294592?_skw=thinkpad&hash=item536fb31bc0:g:46wAAeSw7-tpveoB	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35724	177	v1|298145299518|0	Lenovo ThinkPad T14 Gen 6 – 14", Intel Core Ultra 7 258V, 32 GB RAM, 1 TB #BY908	2111.92	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/298145299518?_skw=thinkpad&hash=item456ad83c3e:g:8hMAAeSwWpxpvenx	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35725	177	v1|287220808300|0	LENOVO ThinkPad L16 Gen 2 - 16", Intel Core Ultra 7 255U, 32 GB RAM, 1 TB #BY888	1694.01	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287220808300?_skw=thinkpad&hash=item42dfb1ba6c:g:oZsAAeSwzOtpvenH	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35726	177	v1|287220808135|0	Lenovo ThinkPad L16 Gen 2 - 16", Intel Core Ultra 7 255U, 32 GB RAM, 1 TB #BY887	1634.31	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287220808135?_skw=thinkpad&hash=item42dfb1b9c7:g:K2MAAeSw0x5pvem8	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35727	177	v1|287220807993|0	Lenovo ThinkPad P16s Gen 4 - (16") - Ryzen AI 7 PRO 350 - AMD PRO - 64 GB #BY534	2227.13	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287220807993?_skw=thinkpad&hash=item42dfb1b939:g:~oAAAeSwLqFpvem0	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35728	177	v1|287220807897|0	Lenovo ThinkPad T16 Gen 4 (AMD) Copilot+ - 16", AMD Ryzen AI 7 350, 32 GB #BY671	2159.05	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287220807897?_skw=thinkpad&hash=item42dfb1b8d9:g:~jAAAeSwuAxpvemr	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35729	177	v1|358356291471|0	Lenovo ThinkPad X1 Carbon Gen 13 - 14", Intel Core Ultra 7 255U, 32 GB RA #BY472	2733.02	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/358356291471?_skw=thinkpad&hash=item536fb30f8f:g:3QcAAeSwiihpvemf	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35730	177	v1|287220806449|0	Lenovo ThinkPad T14 G6 (Intel), Black, Core Ultra 7 255U, 32GB RAM, 1TB S #BY655	2315.11	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287220806449?_skw=thinkpad&hash=item42dfb1b331:g:0M0AAeSwHKtpvemP	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35731	177	v1|287220796547|0	Lenovo ThinkPad T14 Gen 6 -  14", Core Ultra 5 228V - Arc Graphics 130V - 3 #907	1801.89	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287220796547?_skw=thinkpad&hash=item42dfb18c83:g:FdcAAeSwLlxpvej9	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35732	177	v1|358356282361|0	Lenovo ThinkPad E16 Gen 3 - 16", Intel Core Ultra 7 255H, 32 GB RAM, 1 TB S #520	1330.55	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/358356282361?_skw=thinkpad&hash=item536fb2ebf9:g:VpcAAeSwUoFpvei5	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35733	177	v1|287220794811|0	Lenovo ThinkPad X9-14 Gen 1 - (14") - Core Ultra 7 258V - Evo - 32 GB RAM - #690	1758.95	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287220794811?_skw=thinkpad&hash=item42dfb185bb:g:9koAAeSwrDJpveiO	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35734	177	v1|298145013972|0	Lenovo Thinkpad X380 Yoga	250.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/298145013972?_skw=thinkpad&hash=item456ad3e0d4:g:UXkAAeSwlJNpvcaU	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35735	177	v1|227265815210|0	ThinkPad E16 Gen 3	1556.00	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/227265815210?_skw=thinkpad&hash=item34ea1922aa:g:4wIAAeSwlQNpvcN3	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35736	177	v1|327059533051|0	TS / ThinkPad E / E16 AMD G3 / R5 220 / 32GB / 512GB SSD / 16.0" / WUXGA / Black	1317.00	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/327059533051?_skw=thinkpad&hash=item4c26446cfb:g:t3kAAeSwSZBpvcNu	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35737	177	v1|188188833096|0	Lenovo ThinkPad T14 G5 Core Ultra U5-135U 512GB 16GB 1920 x 1200 14.0" Zoll	1465.69	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188188833096?_skw=thinkpad&hash=item2bd0edb548:g:f0kAAeSw1yRpvbrG	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35738	177	v1|188188831455|0	Lenovo ThinkPad L16 Gen 2 Core Ultra 5 225U 512GB 16GB 1920 x 1200 16.0" Zoll	1518.91	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188188831455?_skw=thinkpad&hash=item2bd0edaedf:g:328AAeSwottpvbos	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35739	177	v1|188188830764|0	Lenovo ThinkPad P14s G6 Core Ultra 7 Intel 255H 2TB 32GB 1920 x 1200 WUXGA	2137.00	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188188830764?_skw=thinkpad&hash=item2bd0edac2c:g:DuIAAeSw3mtpvbqo	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35740	177	v1|188188818200|0	Lenovo ThinkPad P14s G6 Core Ultra 7 Intel 255H 140T 512GB 16GB 3072 x 1920 (3K)	1723.69	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188188818200?_skw=thinkpad&hash=item2bd0ed7b18:g:wD8AAeSwY0ppvblq	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35741	177	v1|188188815799|0	Lenovo ThinkPad P14s Gen 5 Ryzen 7 Pro 8840HS Radeon 780M 1TB 32GB 1920 x 1200	1795.39	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188188815799?_skw=thinkpad&hash=item2bd0ed71b7:g:gf0AAeSw65tpvbkE	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35742	177	v1|188188811266|0	Lenovo ThinkPad L13 G6 Ryzen 7 Pro 250 Radeon 780M 1TB 32GB 1920 x 1200 WUXGA	1689.39	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188188811266?_skw=thinkpad&hash=item2bd0ed6002:g:32IAAeSw1iJpvbki	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35743	177	v1|188188806533|0	Lenovo ThinkPad L14 Gen 5 Core Ultra 12th Gen 125U 262GB 16GB 1920 x 1200	1287.39	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188188806533?_skw=thinkpad&hash=item2bd0ed4d85:g:XbIAAeSw~Bdpvbg-	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35744	177	v1|267615065261|0	Lenovo X1 Carbon Gen 10 14 Zoll 1TB SSD Intel Core i7-1255U 16GB RAM	740.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/267615065261?_skw=thinkpad&hash=item3e4f19d4ad:g:p-oAAeSw4ExpvbLQ	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35745	177	v1|267615042090|0	Lenovo ThinkPad T14 Gen 4 Intel i5-1335U 16GB RAM 512GB SSD + 12M Garantie	760.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/267615042090?_skw=thinkpad&hash=item3e4f197a2a:g:EPMAAeSwZcNpvaix	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35746	177	v1|366291789910|0	Lenovo ThinkPad T560 - İ7 2,8ghz - 12GB Ram - 128GB SSD - 2xAkku	150.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/366291789910?_skw=thinkpad&hash=item5548b12856:g:dwAAAeSwz5xpvapm	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35747	177	v1|366291781199|0	Lenovo ThinkPad T560 - İ7 2,8ghz - 12GB Ram - 128GB SSD - 2xAkku	150.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/366291781199?_skw=thinkpad&hash=item5548b1064f:g:XIsAAeSwfcVpvakx	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35748	177	v1|318035435319|0	Laptop Lenovo ThinkPad X260 (Core i5 - 6300U CPU@2.40 Ghz x 2 8GB Ram) Notebook	100.00	EUR	Gebraucht	FIXED_PRICE,AUCTION	EBAY_DE	https://www.ebay.de/itm/318035435319?_skw=thinkpad&hash=item4a0c639f37:g:jzoAAeSwO4lpvaV0	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35749	177	v1|177977297612|0	Lenovo ThinkPad T14 G1 - Intel i7-10510U - 32 GB - 512 SSD - Akku 100%	349.90	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/177977297612?_skw=thinkpad&hash=item2970460acc:g:Ej8AAeSwmsVpvZXA	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35750	177	v1|147214688799|0	LENOVO Notebook Thinkpad T14 35,56cm (14") FHD, Ryzen 5, PRO 4560U, Win11Pro	434.51	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/147214688799?_skw=thinkpad&hash=item2246ade21f:g:ZQMAAeSwmWFpvpOH	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	DE	0	\N
35751	177	v1|198209717842|0	Lenovo ThinkPad L480 14" FHD i5-8250U 8GB 240GB SSD Windows 11 Pro Gebraucht	180.50	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/198209717842?_skw=thinkpad&hash=item2e26384652:g:e-AAAeSwOFhpvWXC	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	IT	0	\N
35752	177	v1|277824378106|0	Lenovo ThinkPad E495 Ryzen 5 - 16 GB Ram - 512 GB SSD Windows 11	599.00	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/277824378106?_skw=thinkpad&hash=item40af9f94fa:g:lxgAAOSwaAdhff8I	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	AU	0	\N
35753	177	v1|127762849490|0	Lenovo ThinkPad X250 12.5inch TOUCH  i5-5300U 16GB Memory 256GB SSD WINDOWS 11	269.00	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/127762849490?_skw=thinkpad&hash=item1dbf425ed2:g:lDMAAeSw-Qxpv4Kg	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	AU	0	\N
35754	177	v1|117101022015|0	Lenovo ThinkPad X250 12.5inch TOUCH  i5-5300U 16GB Memory 256GB SSD WINDOWS 11 P	289.00	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/117101022015?_skw=thinkpad&hash=item1b43c3cb3f:g:lDMAAeSw-Qxpv4Kg	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	AU	0	\N
35755	177	v1|117101013847|0	Lenovo ThinkPad X260 12.5inch FHD i7-6600U 16GB Memory 256GB SSD WINDOWS 11 P	359.00	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/117101013847?_skw=thinkpad&hash=item1b43c3ab57:g:lDMAAeSw-Qxpv4Kg	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	AU	0	\N
35756	177	v1|117101011167|0	Lenovo ThinkPad X260 12.5inch FHD i7-6600U 16GB Memory 256GB SSD WINDOWS 11 PRO	369.00	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/117101011167?_skw=thinkpad&hash=item1b43c3a0df:g:lDMAAeSw-Qxpv4Kg	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	AU	0	\N
35757	177	v1|127762833258|0	Lenovo X1 Carbon Gen3 (NP) 14" Laptop Intel i5-5300 8G 256G SSD WIFI Win11 Pro	220.00	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/127762833258?_skw=thinkpad&hash=item1dbf421f6a:g:pzkAAeSwABFoe0QY	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	AU	0	\N
35758	177	v1|127762832266|0	Lenovo X1 Carbon Gen4 14" Laptop i5-6300u 8G Ram 256G SSD WIFI Win11 Pro	239.00	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/127762832266?_skw=thinkpad&hash=item1dbf421b8a:g:pzkAAeSwABFoe0QY	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	AU	0	\N
35759	177	v1|127762830074|0	Lenovo X1 Carbon Gen4 14" Laptop Intel i5-6th 8G Ram 256G SSD WIFI Win11 Pro	239.00	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/127762830074?_skw=thinkpad&hash=item1dbf4212fa:g:pzkAAeSwABFoe0QY	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	AU	0	\N
35760	177	v1|318041490172|0	Lenovo ThinkPad X1 Carbon Gen 10 i5 8GB 256GB SSD 14" Laptop Used	990.67	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/318041490172?_skw=thinkpad&hash=item4a0cc002fc:g:~5oAAeSwJetpv3jY	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	JP	0	\N
35761	177	v1|177980422996|0	Lenovo ThinkPad P14S G5 U7-155H, 32GB, 1TB, 14.5" WUXGA, RTX 500 Ada 4GB, W11P	2899.99	AUD	Brand New	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/177980422996?_skw=thinkpad&hash=item297075bb54:g:ZogAAeSw5OJpvy9S	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	AU	0	\N
35762	177	v1|277823171131|0	Lenovo ThinkPad T14 Gen 4 Ryzen 7 7840M 16GB DDR5 Radeon 780M 256GB NVMe TOUCH	854.88	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/277823171131?_skw=thinkpad&hash=item40af8d2a3b:g:qkAAAeSwfyxpvv5k	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	CA	0	\N
35763	177	v1|397744094972|0	Lenovo ThinkPad L15 Laptop Core i5-10210U 8GB RAM 256GB SSD 15.6" Win 10 Japan	354.21	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/397744094972?_skw=thinkpad&hash=item5c9b653efc:g:RsEAAeSwQiVpvvqm	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	JP	0	\N
35764	177	v1|267615826953|0	Lenovo ThinkPad E14 Gen 7 - 14" - Intel Core Ultra 7 - 255H - 16 GB (21SX0038US)	2919.65	AUD	New	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/267615826953?_skw=thinkpad&hash=item3e4f257409:g:5pQAAeSwQBFpv3Nh	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35765	177	v1|206156571814|0	Lenovo ThinkPad X1 Extreme 2nd Gen | i7-9750H | 16GB RAM | 512GB SSD	407.23	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/206156571814?_skw=thinkpad&hash=item2fffe3a4a6:g:0IgAAeSw-Qxpvunk	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35766	177	v1|137154556819|0	Lenovo ThinkPad E14 Gen 2 14.0" i7-1165G7@2.80GHz 32GB RAM 512GB SSD TOUCHSCREEN	407.23	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/137154556819?_skw=thinkpad&hash=item1fef0c7393:g:~~4AAeSwIIFpvudV	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35767	177	v1|188192112977|0	Lenovo ThinkPad P1 Gen 6 21FW-SBAJ00 16" i7-13800H 64GB RAM 1TB SSD RTX 4080	2975.92	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/188192112977?_skw=thinkpad&hash=item2bd11fc151:g:xQEAAeSwmFBpvuXf	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35768	177	v1|336493440356|0	Lenovo ThinkPad L14 Gen 4 i5-1345U 32GB RAM 256GB SSD Windows 11 Pro	812.90	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/336493440356?_skw=thinkpad&hash=item4e58926d64:g:APsAAeSwgR1ptgMf	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35769	177	v1|298147617542|0	Lenovo ThinkPad P15v Gen 2i 15.6" i7-11850H 32GB 1TB SSD NVIDIA T1200 Win10 Pro	1065.01	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/298147617542?_skw=thinkpad&hash=item456afb9b06:g:dPgAAeSwt4JpvuRh	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35770	177	v1|406789281658|0	LENOVO ThinkPad L390 Yoga 2-in-1 13 FHD Touch I5-8365U 512GB SSD 16GB W/Pen W11P	352.41	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/406789281658?_skw=thinkpad&hash=item5eb687d77a:g:eg0AAeSwvddpvuHj	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35771	177	v1|389779535465|0	Lenovo ThinkPad X13 Gen 2i | i5-1135G7 16GB RAM 512GB NVMe SSD | FHD FPS Backlit	469.87	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/389779535465?_skw=thinkpad&hash=item5ac0abb669:g:QfgAAeSwLlxpvt1J	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35772	177	v1|306835202185|0	Lenovo ThinkPad T460 14" FHD Laptop Intel Core i5, 12GB RAM, 128GB SSD, MX Linux	180.12	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/306835202185?_skw=thinkpad&hash=item4770cda089:g:bwYAAeSw0x5pvuAl	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35773	177	v1|227266943970|0	Lenovo ThinkPad T570 TOUCH 15.6" Laptop i5-7300U 8GB 256GB NVMe SSD Win10P w/pwr	311.69	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/227266943970?_skw=thinkpad&hash=item34ea2a5be2:g:UtAAAeSwEJppvtiF	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35774	177	v1|267615764690|0	Lenovo ThinkPad T16 Gen 2 Intel i5-1335U @1.6GHZ 16GB RAM 512GB SSD WIN 11 Pro	938.20	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/267615764690?_skw=thinkpad&hash=item3e4f2480d2:g:Oj8AAeSwUrVpvtmt	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35775	177	v1|206156410151|0	Lenovo ThinkPad T14 Gen 1 14” FHD Intel Core i5-10310U  1.7GHz 8GB SSD 256GB	313.26	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/206156410151?_skw=thinkpad&hash=item2fffe12d27:g:FFcAAeSwpyZpvthN	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35776	177	v1|188191937432|0	Lenovo IdeaPad Slim 5 16IRU9 2n1 16" Touch (1TB SSD Core 7 150u 16 gb Good	587.36	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/188191937432?_skw=thinkpad&hash=item2bd11d1398:g:XG8AAeSwiihpvtUC	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35777	177	v1|157774363348|0	Lenovo ThinkPad E14 Gen4 256GB/16GB Ryzen 7 5825u backlit keyboard fingerprint	503.13	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/157774363348?_skw=thinkpad&hash=item24bc15bad4:g:WpgAAeSwRqppvtK9	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35778	177	v1|127761898676|0	Lenovo ThinkPad P14s Gen 2 | i7-1185G7 | NVIDIA Quadro T500 | 48GB DDR4 | 1TB	781.57	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/127761898676?_skw=thinkpad&hash=item1dbf33dcb4:g:VIUAAeSw95tpvtLE	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35779	177	v1|257418101344|0	Lenovo ThinkPad T14 Gen 6 21QDS3601Q Core Ultra 5 235U 2.0GHz 16GB RAM 256GB SSD	1096.38	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/257418101344?_skw=thinkpad&hash=item3bef508260:g:4dYAAeSwUrtpvtCF	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35780	177	v1|397743513548|0	Lenovo ThinkPad T16 Gen 1 16" Laptop i5-1240p 16GB RAM 256GB NVMe	649.99	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/397743513548?_skw=thinkpad&hash=item5c9b5c5fcc:g:9m8AAeSwWrVpvWGO	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35781	177	v1|206156289898|0	Lenovo ThinkPad T15 Gen 2i 15.6" Laptop i5-1135G7 8GB RAM 512GB NVMe	391.56	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/206156289898?_skw=thinkpad&hash=item2fffdf576a:g:FmwAAeSw6BppvYiQ	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35782	177	v1|206156289391|0	Lenovo ThinkPad T15 Gen 2i 15.6" Laptop i5-1135G7 8GB RAM 512GB NVMe, As Is	375.89	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/206156289391?_skw=thinkpad&hash=item2fffdf556f:g:2uIAAeSwdLdpvXMV	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35783	177	v1|206156288637|0	Lenovo ThinkPad T15 Gen 2i 15.6" Laptop i5-1135G7 8GB RAM 512GB NVMe, As Is	375.89	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/206156288637?_skw=thinkpad&hash=item2fffdf527d:g:~f4AAeSwe35pvVlz	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35784	177	v1|227266871735|0	Lenovo ThinkPad X1 2-1 G10 14" WUXGA Touchscreen Laptop, Ultra 7-255U, 32GB...	4096.00	AUD	Brand New	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/227266871735?_skw=thinkpad&hash=item34ea2941b7:g:KiAAAeSwdr5pvsp-	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	AU	0	\N
35785	177	v1|227266871663|0	Lenovo ThinkPad X1 CARBON G13 14" WUXGA Laptop, Ultra 5-225H, 32GB RAM, 512GB...	3254.00	AUD	Brand New	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/227266871663?_skw=thinkpad&hash=item34ea29416f:g:~4MAAeSwUCVpvsp8	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	AU	0	\N
35786	177	v1|206156287991|0	Lenovo ThinkPad T15 Gen 2i 15.6" Laptop i5-1135G7 16GB RAM 512GB NVMe, As Is	383.72	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/206156287991?_skw=thinkpad&hash=item2fffdf4ff7:g:iaAAAeSwWB5pvYHK	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35787	177	v1|397743497857|0	Lenovo ThinkPad T15 Gen 2i 15.6" Laptop i5-1145G7 16GB RAM 512GB NVMe - As Is	383.72	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397743497857?_skw=thinkpad&hash=item5c9b5c2281:g:M5gAAeSwWv5pvXg6	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35788	177	v1|397743492006|0	Lenovo ThinkPad T15 Gen 2i 15.6" Laptop i5-1145G7 16GB RAM 512GB NVMe, As Is	391.56	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/397743492006?_skw=thinkpad&hash=item5c9b5c0ba6:g:et8AAeSwCUlpvWXS	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35789	177	v1|206156283312|0	Lenovo ThinkPad T15 Gen 2i 15.6" Laptop i7-1165G7 16GB RAM 512GB NVMe, As Is	383.72	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/206156283312?_skw=thinkpad&hash=item2fffdf3db0:g:LHwAAeSwfKJpvV2u	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35790	177	v1|397743487534|0	Lenovo ThinkPad T15 Gen 2i 15.6" Laptop i5-1135G7 16GB RAM 512GB NVMe, As Is	383.72	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397743487534?_skw=thinkpad&hash=item5c9b5bfa2e:g:YfwAAeSw3nppvU-c	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35791	177	v1|397743485376|0	Lenovo ThinkPad T15 Gen 2i 15.6" Laptop i5-1135G7 16GB RAM 512GB NVMe	407.22	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/397743485376?_skw=thinkpad&hash=item5c9b5bf1c0:g:srQAAeSwWNVpvUxS	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35792	177	v1|287222123929|0	Lenovo ThinkPad T14 14" Intel Core i7 4.7GHz 40GB 256GB SSD Win11 * READ**	467.54	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/287222123929?_skw=thinkpad&hash=item42dfc5cd99:g:IsMAAeSwfNxo7Uxn	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35793	177	v1|168251689577|0	Lenovo ThinkPad T14s Gen 2 - Intel Core i7 11th Gen 16GB RAM 256GB SSD No OS	407.22	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/168251689577?_skw=thinkpad&hash=item272c950a69:g:~UwAAeSw24hpaQyY	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35794	177	v1|287222108337|0	Lenovo ThinkPad T14 14" Intel Core i7 4.8GHz 32GB 256GB SSD Win11 Touch * READ**	468.32	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/287222108337?_skw=thinkpad&hash=item42dfc590b1:g:IsMAAeSwfNxo7Uxn	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35795	177	v1|287222104464|0	Lenovo ThinkPad T14s 14" Intel i7 4.8GHz 32GB 256GB SSD Win11 * READ	453.44	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/287222104464?_skw=thinkpad&hash=item42dfc58190:g:tgEAAeSwGE5pMtlg	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35796	177	v1|206156174902|0	Lenovo ThinkPad X220 i7-2640M 2.80GHz 8GB RAM 500GB HDD w/OFFICE 21 & 90WCharger	249.96	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/206156174902?_skw=thinkpad&hash=item2fffdd9636:g:dTcAAeSw8M1pvrgi	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	CA	0	\N
35797	177	v1|206156171474|0	LENOVO THINKPAD T14s INTEL CORE i7 2.80GHz, 16 GB, 512GB 14" GEN 1 WIN 11 GEN 2	610.78	AUD	Open box	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/206156171474?_skw=thinkpad&hash=item2fffdd88d2:g:alYAAeSwXslpvrjv	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35798	177	v1|287222079940|0	Lenovo ThinkPad X1 Carbon Gen 9 14 - Intel Core i7 32GB 256GB Win 11 * READ`	546.63	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/287222079940?_skw=thinkpad&hash=item42dfc521c4:g:d-kAAeSweqBo3Dea	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35799	177	v1|157774163731|0	Lenovo ThinkPad T14s Gen 2 - 14" Intel Core i7-1185G7 16GB RAM 256GB SSD No OS	469.87	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/157774163731?_skw=thinkpad&hash=item24bc12af13:g:adsAAeSwGVBpvrX4	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35800	177	v1|287222041075|0	Lenovo ThinkPad X1 Carbon Gen 9 14 - Intel Core i7 16GB 256GB Win 11  * READ	530.97	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/287222041075?_skw=thinkpad&hash=item42dfc489f3:g:d-kAAeSweqBo3Dea	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35801	177	v1|287222032857|0	Lenovo ThinkPad T14 Gen 3 14" Intel Core i7 4.8GHz 32GB 256GB SSD Win11 * READ	562.30	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/287222032857?_skw=thinkpad&hash=item42dfc469d9:g:kLQAAeSwGE5pOd3R	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35802	177	v1|206156116798|0	Lenovo ThinkPad P1 Gen 4 i9-11950H RTX 3080 16GB 4K 64GB Mem 2TB SSD Win11Pro	2349.42	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/206156116798?_skw=thinkpad&hash=item2fffdcb33e:g:msgAAeSwgWRpZtWq	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35803	177	v1|177979377616|0	Lenovo ThinkPad T410 - i5 M520 2.4GHz - 6GB RAM - 240 GB SSD  - Linux Mint 22.3	155.06	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/177979377616?_skw=thinkpad&hash=item297065c7d0:g:G2oAAeSwon5pvqy1	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35804	177	v1|206156082478|0	LENOVO THINKPAD T14s INTEL CORE i7 2.80GHz, 16 GB, 512GB 14" GEN 1 WIN 11 GEN 2	610.78	AUD	Open box	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/206156082478?_skw=thinkpad&hash=item2fffdc2d2e:g:GXwAAeSwoA1pvqXY	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35805	177	v1|358358370741|0	Lenovo ThinkPad X390 13.3" FHD Touch i7-8665U 1.9GHz 16GB 1TB SSD	266.27	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/358358370741?_skw=thinkpad&hash=item536fd2c9b5:g:C-gAAeSwCnlpvqkK	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35806	177	v1|198211902707|0	Lenovo ThinkPad X1 Extreme 15.6" i7-8750H 16GB 512GB SSD GTX 1050 Ti FREE SHIP	610.69	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/198211902707?_skw=thinkpad&hash=item2e26599cf3:g:A6oAAeSwP4ZpvqdU	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35807	177	v1|267615639283|0	Lenovo ThinkPad P73 i7-9750H@2.60GHz QUADRO P620 4GB GPU 16GB RAM 512GB SSD  Lap	523.88	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/267615639283?_skw=thinkpad&hash=item3e4f2296f3:g:IqQAAeSwrIBpvqbc	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	CA	0	\N
35808	177	v1|267615637836|0	Lenovo ThinkPad T14 Gen 1 Intel Core i5-10210U 1.60GHz 16GB RAM 256 GB NVME  Lap	386.92	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/267615637836?_skw=thinkpad&hash=item3e4f22914c:g:Hp0AAeSwgI9pvqZ4	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	CA	0	\N
35809	177	v1|287221729614|0	Lenovo ThinkPad L15 Laptop Core i5-10210U 8GB RAM 256GB SSD 15.6" Win 10 Japan	367.08	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/287221729614?_skw=thinkpad&hash=item42dfbfc94e:g:NCEAAeSwbq5pvPTj	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	JP	0	\N
35810	177	v1|287221914206|0	LENOVO ThinkPad T570 15.6" Core i5-7300U @ 2.60GHz 256GB SSD 16GB RAM	227.11	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/287221914206?_skw=thinkpad&hash=item42dfc29a5e:g:yqcAAeSwd9RpvKOL	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35811	177	v1|236703574782|0	Reconditioned Lenovo T430 14" i5 2.50 GHz 4GB 120GB Windows 7 Pro USB 3.0	203.60	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/236703574782?_skw=thinkpad&hash=item371ca1eafe:g:k50AAeSw~U5pvpnN	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35813	177	v1|227266622660|0	Lenovo ThinkPad P1 Gen 4 i7-11850H 16" 4K HDR 2TB 32GB NVIDIA RTX A4000 - READ	900.00	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/227266622660?_skw=thinkpad&hash=item34ea2574c4:g:yygAAeSwT3xpvn~L	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	AU	0	\N
35814	177	v1|277822159521|0	Lenovo ThinkPad L13 Yoga i5-10210U | 256GB SSD | 8GB RAM | Win 11 Pro C264	140.95	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/277822159521?_skw=thinkpad&hash=item40af7dbaa1:g:j64AAeSwV8xpvnwI	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35815	177	v1|287221604734|0	Lenovo ThinkPad L13 Yoga i5-10210U | 256GB SSD | 8GB RAM | Win 11 Pro C263	172.28	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/287221604734?_skw=thinkpad&hash=item42dfbde17e:g:l2sAAeSwyXJpvnjv	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35816	177	v1|287221593760|0	Lenovo ThinkPad L13 Yoga i5-10210U | 256GB SSD | 8GB RAM | Win 11 Pro C262	187.94	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/287221593760?_skw=thinkpad&hash=item42dfbdb6a0:g:p9MAAeSwrIBpvndA	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35817	177	v1|188190836100|0	Lenovo ThinkPad X1 Yoga 4th Gen – i5-8365U | 8GB RAM | 256GB SSD | Touchscreen	300.00	AUD	Used	FIXED_PRICE,AUCTION	EBAY_AU	https://www.ebay.com.au/itm/188190836100?_skw=thinkpad&hash=item2bd10c4584:g:q3gAAeSwBblpvnA~	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	AU	0	\N
35818	177	v1|406788301266|0	Lenovo ThinkPad T460 20FN002SUS - NO BOOT DRIVE/RAM, Intel i5-6200u	85.60	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/406788301266?_skw=thinkpad&hash=item5eb678e1d2:g:OlUAAeSweLNpvm0k	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	CA	0	\N
35819	177	v1|318037494358|0	Lenovo ThinkPad X390 13.3"  I5-8365U 1.6GHz, 8GB RAM, 256GB NVMe SSD Win11Pro	264.70	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/318037494358?_skw=thinkpad&hash=item4a0c830a56:g:bMAAAeSwuHBpvlEX	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35820	177	v1|318037465746|0	Lenovo ThinkPad T560 Laptop 15.6” I5-6200U 2.30 GHz,12GB RAM, 256GB SSD Win10Pro	233.38	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/318037465746?_skw=thinkpad&hash=item4a0c829a92:g:by8AAeSwlJNpvk9l	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35821	177	v1|318037407176|0	Lenovo ThinkPad T490 I5-8265U 1.6GHz, 16GB RAM, 14-inch 256GB SSD, Win 11Pro	311.69	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/318037407176?_skw=thinkpad&hash=item4a0c81b5c8:g:AJoAAeSwif9pvkkT	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35822	177	v1|257417562364|0	Lenovo ThinkPad P14S Gen 2 Intel i7-1185G7 16GB RAM 256GB SSD NVIDIA T500 Touch	501.20	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/257417562364?_skw=thinkpad&hash=item3bef4848fc:g:b44AAeSwjKdpvkf0	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35823	177	v1|188190110490|0	Lenovo ThinkPad T580 15.6" FHD i7 8TH Gen laptop 16GB DDR4 1TB  SSD win 11 pro	501.21	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/188190110490?_skw=thinkpad&hash=item2bd101331a:g:-QwAAeSwRLlpvhow	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35824	177	v1|358356929500|0	Linux + Libreboot Thinkpad T480s | 16GB | 256GB | i5-8650U | Wifi 6 MonMode+	500.00	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/358356929500?_skw=thinkpad&hash=item536fbccbdc:g:VgQAAeSwzstpviMv	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	AU	0	\N
35825	177	v1|206155108228|0	Lenovo ThinkPad T14s Gen 1 16GB 256GB SSD Core i5-10310U Win 10 Pro	344.58	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/206155108228?_skw=thinkpad&hash=item2fffcd4f84:g:O2AAAeSwBfhpviHv	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35826	177	v1|318036763076|0	Lenovo ThinkPad L15 Gen 2a AMD Ryzen Pro 5650U, 16GB RAM, 256 GB NVMe SSD Win11P	468.32	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/318036763076?_skw=thinkpad&hash=item4a0c77e1c4:g:xuoAAeSwz8lpvhDg	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35827	177	v1|389777048063|0	Lenovo ThinkPad Extreme Gen3 Laptop Excellent Condition	1929.67	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/389777048063?_skw=thinkpad&hash=item5ac085c1ff:g:tz0AAeSwQdppvhGm	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	KR	0	\N
35828	177	v1|318036715350|0	Lenovo ThinkPad L15 Gen 1 Laptop 15.6" AMD Ryzen 5 4650U, 16GB RAM, 256GB NVMe	343.02	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/318036715350?_skw=thinkpad&hash=item4a0c772756:g:oUcAAeSwulNpvg2~	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35829	177	v1|318036650827|0	Lenovo ThinkPad X1 Carbon Gen 8 14” I5-10310U, 16GB RAM, 256GB NVMe SSD Win11Pro	468.32	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/318036650827?_skw=thinkpad&hash=item4a0c762b4b:g:lAAAAeSwkGZpvgik	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35830	177	v1|277821392011|0	Hackintosh - macOS Sequoia & Windows 11 - Intel Core i5-10210U 16GB DDr4 1TB SSD	438.56	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/277821392011?_skw=thinkpad&hash=item40af72048b:g:sxkAAeSwDXtpvgk3	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35831	177	v1|198212954302|0	Lenovo ThinkPad T14 Gen 4 i5-1335u 16GB DDR5 512GB RAM Win 11 Pro ACTIVE SUPPORT	916.28	AUD	New	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/198212954302?_skw=thinkpad&hash=item2e2669a8be:g:x~4AAeSwdLdpvfBe	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35832	177	v1|257417343284|0	Lenovo ThinkPad T430 i5-3320M @2.6GHz 8 GB RAM 14" 460GB HDD Windows 10 Pro	212.97	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/257417343284?_skw=thinkpad&hash=item3bef44f134:g:iwwAAeSwz8lpvgSL	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35833	177	v1|227266091215|0	Lenovo ThinkPad L16 Gen 2 16" NB Intel Ultra 5 8GB RAM 512GB SSD - Touchscreen	1080.71	AUD	Open box	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/227266091215?_skw=thinkpad&hash=item34ea1d58cf:g:2UwAAeSw2FppvgER	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35834	177	v1|318036470332|0	Lenovo ThinkPad X1 Carbon 6th Gen 14" FHD  i5-8350U 16GB RAM 256GB SSD Win 11	352.41	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/318036470332?_skw=thinkpad&hash=item4a0c736a3c:g:TNwAAeSwWD5pvfnU	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35835	177	v1|236702623432|0	Lenovo ThinkPad E14 Gen 5, i7 13th gen 16gb Ram, 512gb NVMe, Touchscreen, Win11P	551.32	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/236702623432?_skw=thinkpad&hash=item371c9366c8:g:r-kAAeSw3mtpvfn4	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35836	177	v1|206154830237|0	Lenovo P71 ThinkPad Intel i7-7700HQ Quadro GPU FHD NVMe SSD NICE! But Needs BATT	274.41	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/206154830237?_skw=thinkpad&hash=item2fffc9119d:g:iYMAAeSw7GJpvfGa	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35837	177	v1|318036409694|0	Lenovo ThinkPad T490 14” I7-10510U 1.80GHz, 16GB RAM, 256GB NVMe SSD Win11Pro	390.00	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/318036409694?_skw=thinkpad&hash=item4a0c727d5e:g:c9YAAeSws~JpvfTD	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35838	177	v1|366292279230|0	Lenovo ThinkPad P15 Gen 1 i7-10750H 32GB RAM 512GB SSD 4GB NVIDIA T2000 Win 11	797.81	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/366292279230?_skw=thinkpad&hash=item5548b89fbe:g:BKcAAeSwnc1pvfKy	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	CA	0	\N
35840	177	v1|236702532575|0	Lenovo Slim 7 Pro X Ryzen 9 6900HS, GeForce RTX 3050 4GB GDDR6, 32GB Win 11 Pro	1076.04	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/236702532575?_skw=thinkpad&hash=item371c9203df:g:kJcAAeSwgHhpveb4	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35841	177	v1|277821182343|0	LENOVO THINKPAD P1 GEN5 LAPTOP, 64GB RAM, 1T M.2, i9	2175.57	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/277821182343?_skw=thinkpad&hash=item40af6ed187:g:60EAAeSwYC5pvemd	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35842	177	v1|177977853729|0	IBM ThinkPad T42 Laptop 14" Intel Pentium M, Vintage, 100gb Hdd Cd/dvd	148.80	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/177977853729?_skw=thinkpad&hash=item29704e8721:g:zU0AAeSwV8xpveLE	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35843	177	v1|177977844915|0	Lenovo ThinkPad 13 Chromebook Parts Repair Keyboard Issue Works AS IS	101.79	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/177977844915?_skw=thinkpad&hash=item29704e64b3:g:pZMAAeSw4oFpvdvp	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35844	177	v1|267615205503|0	Lenovo ThinkPad X1 Carbon Gen 7 14"  i5-8365U 8GB Ram 256GB SSD Win11	300.00	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/267615205503?_skw=thinkpad&hash=item3e4f1bf87f:g:nSUAAeSwSIxpveT6	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	AU	0	\N
35845	177	v1|306834100035|0	Lenovo ThinkPad T460S 14'' (128gb SSD Intel Core i5-6300U 2.4GHz 8GB RAM) Laptop	234.93	AUD	Used	FIXED_PRICE,AUCTION	EBAY_AU	https://www.ebay.com.au/itm/306834100035?_skw=thinkpad&hash=item4770bccf43:g:EOcAAeSwaFdpveXE	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35846	177	v1|358356254498|0	(LOT of 2) Lenovo ThinkPad 14" E14 G2 i5-1135G7 16GB 256GB NVMe Windows 11 Pro	593.62	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/358356254498?_skw=thinkpad&hash=item536fb27f22:g:l5YAAeSwIKBpveSd	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35847	177	v1|397741005836|0	Lenovo ThinkPad E14 Gen 5 Laptop	1065.06	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397741005836?_skw=thinkpad&hash=item5c9b361c0c:g:lCgAAeSwbKlpveKX	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35848	177	v1|358356151709|0	(LOT of 2) Lenovo ThinkPad 14" E14 G4 i5-1235U 16GB 512GB NVMe Windows 11 Pro	953.87	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/358356151709?_skw=thinkpad&hash=item536fb0ed9d:g:rNoAAeSw6Ytpvdzf	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35849	177	v1|306834033689|0	Lenovo ThinkPad T14s Gen 6 14" WUXGA Snapdragon X Elite 32GB 1TB SSD	1251.46	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/306834033689?_skw=thinkpad&hash=item4770bbcc19:g:dnEAAeSwOvZpvdsu	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35850	177	v1|188189238690|0	Lenovo ThinkPad P53 15.6" i7-9850H 2.6GHz Quadro T2000 8GB RAM 512GB SSD	501.21	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/188189238690?_skw=thinkpad&hash=item2bd0f3e5a2:g:K5kAAeSwASBpvdnG	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35851	177	v1|257417149899|0	Lenovo ThinkPad P50 XEON E3-1505M v5 @ 2.9GHz | 32GB RAM, NO SSD | #P235	313.19	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/257417149899?_skw=thinkpad&hash=item3bef41fdcb:g:W2AAAeSwUMZpvdRy	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35852	177	v1|127760404449|0	Lenovo ThinkPad X1 Tablet Gen 3 i7-8650U 1.9GHz CPU 8GB RAM 250GB SSD Win 11 Pro	352.34	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/127760404449?_skw=thinkpad&hash=item1dbf1d0fe1:g:vvsAAeSwBblpvdGd	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35853	177	v1|147214919012|0	Lenovo ThinkPad X1 Nano Gen 1 i7-1180G7 16GB RAM 512GB SSD 13" 2k  Touch	853.62	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/147214919012?_skw=thinkpad&hash=item2246b16564:g:nacAAeSwGMhpvcyB	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35854	177	v1|188189060679|0	Lenovo ThinkPad E14 Gen 2-i5-1135G7@2.4GHz 16GB DDR4 Ram 256GB NVME SSD W11P	266.27	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/188189060679?_skw=thinkpad&hash=item2bd0f12e47:g:TusAAeSwOp1pvZdN	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35855	177	v1|336492313497|0	Lenovo Thinkpad T430s 14" Core i5-3320 2.6GHz 8GB RAM 320GB HDD W/MS Office 2016	258.44	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/336492313497?_skw=thinkpad&hash=item4e58813b99:g:XJsAAeSwQBFpvcjI	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35856	177	v1|198210037480|0	Lenovo ThinkPad P17 Gen 1 (i9-10885H 2.40GHz 16GB 512GB NVMe Quadro T2000) No AC	1065.07	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/198210037480?_skw=thinkpad&hash=item2e263d26e8:g:EzkAAeSwsV9pp2e7	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35857	177	v1|177977583846|0	Lenovo ThinkPad L16 G2 16" Touchscreen AMD Ryzen 7 PRO 250 16GB RAM, 512GB SSD	2526.88	AUD	New	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/177977583846?_skw=thinkpad&hash=item29704a68e6:g:5oEAAeSwmWFpvcdL	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35858	177	v1|127760331127|0	Lenovo ThinkPad T16 Gen 1 - 16" Intel Core i7-1260P 8GB RAM NO SSD/NO OS	577.96	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/127760331127?_skw=thinkpad&hash=item1dbf1bf177:g:wjoAAeSwH8RpvcQ3	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35859	177	v1|306833869153|0	Lenovo ThinkPad T15 Gen 1 4K UHD i5-10310U 16GB RAM 256GB SSD Win 11P - READ	344.57	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/306833869153?_skw=thinkpad&hash=item4770b94961:g:B0wAAeSwHPBpvb-3	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
35860	177	v1|137152039502|0	ThinkPad T14 Gen 4 14-inch i7-1365U 16Gb RAM 512Gb NVME Win 11 Pro Warranty	906.88	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/137152039502?_skw=thinkpad&hash=item1feee60a4e:g:kTYAAeSw9RFpvb5Q	ACTIVE	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	2026-03-22 18:53:05.598019+11	US	0	\N
\.


--
-- Data for Name: marketplaces; Type: TABLE DATA; Schema: public; Owner: thinkpaduser
--

COPY public.marketplaces (id, country_code, marketplace_id, enabled) FROM stdin;
1	US	EBAY_US	t
2	UK	EBAY_GB	t
3	DE	EBAY_DE	t
4	AU	EBAY_AU	t
\.


--
-- Data for Name: model_list; Type: TABLE DATA; Schema: public; Owner: thinkpaduser
--

COPY public.model_list (id, name, slug) FROM stdin;
551	Yoga 11e	thinkpad-yoga-11e
552	Yoga 11e Gen 2	thinkpad-yoga-11e-gen-2
553	Yoga 11e Gen 3	thinkpad-yoga-11e-gen-3
554	Yoga 11e Gen 4	thinkpad-yoga-11e-gen-4
555	Yoga 11e Gen 5	thinkpad-yoga-11e-gen-5
556	T14 Gen 5	thinkpad-t14-gen-5
1	700T	thinkpad-700t
2	300	thinkpad-300
3	300C	thinkpad-300c
4	700	thinkpad-700
5	700C	thinkpad-700c
6	550BJ	thinkpad-550bj
7	710T	thinkpad-710t
8	320	thinkpad-320
9	720	thinkpad-720
10	720C	thinkpad-720c
11	350	thinkpad-350
12	350C	thinkpad-350c
13	500	thinkpad-500
14	750	thinkpad-750
15	750C	thinkpad-750c
16	750P	thinkpad-750p
17	220	thinkpad-220
18	750CS	thinkpad-750cs
19	330C	thinkpad-330c
20	360	thinkpad-360
21	360CS	thinkpad-360cs
22	730T	thinkpad-730t
23	555BJ	thinkpad-555bj
24	230CS	thinkpad-230cs
25	355	thinkpad-355
26	355C	thinkpad-355c
27	355CS	thinkpad-355cs
28	360C	thinkpad-360c
29	360P	thinkpad-360p
30	360PE	thinkpad-360pe
31	510CS	thinkpad-510cs
32	755C	thinkpad-755c
33	755CS	thinkpad-755cs
34	750CE	thinkpad-750ce
35	340	thinkpad-340
36	330CS	thinkpad-330cs
37	360CE	thinkpad-360ce
38	360CSE	thinkpad-360cse
39	755CD	thinkpad-755cd
40	755CE	thinkpad-755ce
41	755CSE	thinkpad-755cse
42	800	thinkpad-800
43	340CSE	thinkpad-340cse
44	701C	thinkpad-701c
45	701CS	thinkpad-701cs
46	370C	thinkpad-370c
47	530CS	thinkpad-530cs
48	755CX	thinkpad-755cx
49	755CV	thinkpad-755cv
50	755CDV	thinkpad-755cdv
51	820	thinkpad-820
52	850	thinkpad-850
53	345C	thinkpad-345c
54	345CS	thinkpad-345cs
55	PC110	thinkpad-pc110
56	730TE	thinkpad-730te
57	760C	thinkpad-760c
58	760CD	thinkpad-760cd
59	365C	thinkpad-365c
60	365CS	thinkpad-365cs
61	365CD	thinkpad-365cd
62	365CSD	thinkpad-365csd
63	760L	thinkpad-760l
64	760LD	thinkpad-760ld
65	365E	thinkpad-365e
66	365ED	thinkpad-365ed
67	365X	thinkpad-365x
68	365XD	thinkpad-365xd
69	535	thinkpad-535
70	560	thinkpad-560
71	760E	thinkpad-760e
72	760ED	thinkpad-760ed
73	760EL	thinkpad-760el
74	760ELD	thinkpad-760eld
75	821	thinkpad-821
76	822	thinkpad-822
77	823	thinkpad-823
78	851	thinkpad-851
79	860	thinkpad-860
80	760XL	thinkpad-760xl
81	760XD	thinkpad-760xd
82	380	thinkpad-380
83	380D	thinkpad-380d
84	385D	thinkpad-385d
85	310	thinkpad-310
86	310D	thinkpad-310d
87	315E	thinkpad-315e
88	315D	thinkpad-315d
89	315ED	thinkpad-315ed
90	535E	thinkpad-535e
91	560E	thinkpad-560e
92	765L	thinkpad-765l
93	765D	thinkpad-765d
94	380E	thinkpad-380e
95	380ED	thinkpad-380ed
96	385ED	thinkpad-385ed
97	385E	thinkpad-385e
98	770	thinkpad-770
99	310E	thinkpad-310e
100	310ED	thinkpad-310ed
101	235	thinkpad-235
102	380X	thinkpad-380x
103	380XD	thinkpad-380xd
104	385XD	thinkpad-385xd
105	560X	thinkpad-560x
106	600	thinkpad-600
107	770E	thinkpad-770e
108	770ED	thinkpad-770ed
109	535X	thinkpad-535x
110	380Z	thinkpad-380z
111	560Z	thinkpad-560z
112	770X	thinkpad-770x
113	390	thinkpad-390
114	600E	thinkpad-600e
115	i Series 1410	thinkpad-i-series-1410
116	i Series 1450	thinkpad-i-series-1450
117	i Series 1411	thinkpad-i-series-1411
118	i Series 1451	thinkpad-i-series-1451
119	770Z	thinkpad-770z
120	390E	thinkpad-390e
121	570	thinkpad-570
122	240	thinkpad-240
123	i Series 1412	thinkpad-i-series-1412
124	i Series 1452	thinkpad-i-series-1452
125	i Series 1472	thinkpad-i-series-1472
126	i Series 1512	thinkpad-i-series-1512
127	i Series 1552	thinkpad-i-series-1552
128	i Series 1700	thinkpad-i-series-1700
129	i Series 1720	thinkpad-i-series-1720
130	i Series 1721	thinkpad-i-series-1721
131	i Series 1400	thinkpad-i-series-1400
132	390X	thinkpad-390x
133	i Series 1780	thinkpad-i-series-1780
134	i Series 1781	thinkpad-i-series-1781
135	i Series 1420	thinkpad-i-series-1420
136	i Series 1460	thinkpad-i-series-1460
137	i Series 1480	thinkpad-i-series-1480
138	i Series 1540	thinkpad-i-series-1540
139	i Series 1560	thinkpad-i-series-1560
140	600X	thinkpad-600x
141	i Series 1421	thinkpad-i-series-1421
142	i Series 1441	thinkpad-i-series-1441
143	i Series 1541	thinkpad-i-series-1541
144	570E	thinkpad-570e
145	i Series 1422	thinkpad-i-series-1422
146	i Series 1442	thinkpad-i-series-1442
147	i Series 1482	thinkpad-i-series-1482
148	i Series 1483	thinkpad-i-series-1483
149	i Series 1492	thinkpad-i-series-1492
150	i Series 1542	thinkpad-i-series-1542
151	i Series 1562	thinkpad-i-series-1562
152	i Series 1592	thinkpad-i-series-1592
153	A20m	thinkpad-a20m
154	A20p	thinkpad-a20p
155	T20	thinkpad-t20
156	240X	thinkpad-240x
157	i Series 1157	thinkpad-i-series-1157
158	i Series 1210	thinkpad-i-series-1210
159	i Series 1230	thinkpad-i-series-1230
160	i Series 1250	thinkpad-i-series-1250
161	i Series 1260	thinkpad-i-series-1260
162	i Series 1330	thinkpad-i-series-1330
163	i Series 1370	thinkpad-i-series-1370
164	i Series 1200	thinkpad-i-series-1200
165	i Series 1300	thinkpad-i-series-1300
166	130	thinkpad-130
167	X20	thinkpad-x20
168	A21m	thinkpad-a21m
169	A21p	thinkpad-a21p
170	A21e	thinkpad-a21e
171	T21	thinkpad-t21
172	240Z	thinkpad-240z
173	i Series 1124	thinkpad-i-series-1124
174	TransNote	thinkpad-transnote
175	T22	thinkpad-t22
176	A22m	thinkpad-a22m
177	A22p	thinkpad-a22p
178	X21	thinkpad-x21
179	S30	thinkpad-s30
180	i Series 1620	thinkpad-i-series-1620
181	i Series 1800	thinkpad-i-series-1800
182	A22e	thinkpad-a22e
183	T23	thinkpad-t23
184	A30	thinkpad-a30
185	A30p	thinkpad-a30p
186	R30	thinkpad-r30
187	X22	thinkpad-x22
188	S31	thinkpad-s31
189	X23	thinkpad-x23
190	R31	thinkpad-r31
191	A31	thinkpad-a31
192	A31p	thinkpad-a31p
193	T30	thinkpad-t30
194	X24	thinkpad-x24
195	R32	thinkpad-r32
196	X30	thinkpad-x30
197	R40	thinkpad-r40
198	T40	thinkpad-t40
199	T40p	thinkpad-t40p
200	X31	thinkpad-x31
201	G40	thinkpad-g40
202	R40e	thinkpad-r40e
203	R50	thinkpad-r50
204	T41	thinkpad-t41
205	T41p	thinkpad-t41p
206	R50p	thinkpad-r50p
207	X40	thinkpad-x40
208	R50e	thinkpad-r50e
209	R51	thinkpad-r51
210	T42	thinkpad-t42
211	T42p	thinkpad-t42p
212	G41	thinkpad-g41
213	T43	thinkpad-t43
214	R52	thinkpad-r52
215	T43p	thinkpad-t43p
216	X32	thinkpad-x32
217	X41	thinkpad-x41
218	X41 Tablet	thinkpad-x41-tablet
219	Z60m	thinkpad-z60m
220	Z60t	thinkpad-z60t
221	R51e	thinkpad-r51e
222	T60	thinkpad-t60
223	X60	thinkpad-x60
224	X60s	thinkpad-x60s
225	T60p	thinkpad-t60p
226	R60	thinkpad-r60
227	R60e	thinkpad-r60e
228	Z61t	thinkpad-z61t
229	Z61e	thinkpad-z61e
230	Z61m	thinkpad-z61m
231	Z61p	thinkpad-z61p
232	G50	thinkpad-g50
233	R60i	thinkpad-r60i
234	X60 Tablet	thinkpad-x60-tablet
235	R61	thinkpad-r61
236	T61	thinkpad-t61
237	X61	thinkpad-x61
238	X61s	thinkpad-x61s
239	X61 Tablet	thinkpad-x61-tablet
240	R61e	thinkpad-r61e
241	R61i	thinkpad-r61i
242	T61p	thinkpad-t61p
243	X61Ls	thinkpad-x61ls
244	X300	thinkpad-x300
245	T400	thinkpad-t400
246	T500	thinkpad-t500
247	X200	thinkpad-x200
248	R400	thinkpad-r400
249	R500	thinkpad-r500
250	SL400	thinkpad-sl400
251	SL500	thinkpad-sl500
252	SL300	thinkpad-sl300
253	W500	thinkpad-w500
254	W700	thinkpad-w700
255	X301	thinkpad-x301
256	W700ds	thinkpad-w700ds
257	X200s	thinkpad-x200s
258	X200 Tablet	thinkpad-x200-tablet
259	T400s	thinkpad-t400s
260	SL400c	thinkpad-sl400c
261	SL500c	thinkpad-sl500c
262	SL410	thinkpad-sl410
263	SL510	thinkpad-sl510
264	L410	thinkpad-l410
265	L510	thinkpad-l510
266	Edge 13"	thinkpad-edge-13"
267	T410	thinkpad-t410
268	T410i	thinkpad-t410i
269	T410s	thinkpad-t410s
270	W510	thinkpad-w510
271	T510	thinkpad-t510
272	T510i	thinkpad-t510i
273	X100e	thinkpad-x100e
274	T410si	thinkpad-t410si
275	W701	thinkpad-w701
276	W701ds	thinkpad-w701ds
277	X201	thinkpad-x201
278	X201i	thinkpad-x201i
279	X201s	thinkpad-x201s
280	X201si	thinkpad-x201si
281	X201 Tablet	thinkpad-x201-tablet
282	X201i Tablet	thinkpad-x201i-tablet
283	Edge 14"	thinkpad-edge-14"
284	Edge 15"	thinkpad-edge-15"
285	L412	thinkpad-l412
286	L512	thinkpad-l512
287	SL410k	thinkpad-sl410k
288	SL510k	thinkpad-sl510k
289	X120e	thinkpad-x120e
290	T420	thinkpad-t420
291	T420s	thinkpad-t420s
292	T520	thinkpad-t520
293	W520	thinkpad-w520
294	L420	thinkpad-l420
295	L421	thinkpad-l421
296	L520	thinkpad-l520
297	T420i	thinkpad-t420i
298	T520i	thinkpad-t520i
299	E420	thinkpad-e420
300	E520	thinkpad-e520
301	E220s	thinkpad-e220s
302	X220	thinkpad-x220
303	X220 Tablet	thinkpad-x220-tablet
304	X1	thinkpad-x1
305	E420s	thinkpad-e420s
306	E425	thinkpad-e425
307	E525	thinkpad-e525
308	X121e	thinkpad-x121e
309	X1 Hybrid	thinkpad-x1-hybrid
310	E130	thinkpad-e130
311	E330	thinkpad-e330
312	E430	thinkpad-e430
313	E530	thinkpad-e530
314	E135	thinkpad-e135
315	E335	thinkpad-e335
316	E435	thinkpad-e435
317	E535	thinkpad-e535
318	S430	thinkpad-s430
319	T430	thinkpad-t430
320	T430s	thinkpad-t430s
321	T530	thinkpad-t530
322	W530	thinkpad-w530
323	L430	thinkpad-l430
324	L530	thinkpad-l530
325	X230	thinkpad-x230
326	X230 Tablet	thinkpad-x230-tablet
327	X1 Carbon	thinkpad-x1-carbon
328	T430u	thinkpad-t430u
329	Twist	thinkpad-twist
330	Tablet 2	thinkpad-tablet-2
331	T431s	thinkpad-t431s
332	Helix	thinkpad-helix
333	X230s	thinkpad-x230s
334	X240s	thinkpad-x240s
335	E440	thinkpad-e440
336	E540	thinkpad-e540
337	L440	thinkpad-l440
338	L540	thinkpad-l540
339	S440	thinkpad-s440
340	S540	thinkpad-s540
341	T440	thinkpad-t440
342	T440s	thinkpad-t440s
343	T440p	thinkpad-t440p
344	T540	thinkpad-t540
345	T540p	thinkpad-t540p
346	W540	thinkpad-w540
347	X240	thinkpad-x240
348	X1 Carbon 2nd	thinkpad-x1-carbon-2nd
349	T450	thinkpad-t450
350	T450s	thinkpad-t450s
351	T550	thinkpad-t550
352	W541	thinkpad-w541
353	W550s	thinkpad-w550s
354	E450	thinkpad-e450
355	E550	thinkpad-e550
356	X250	thinkpad-x250
357	L450	thinkpad-l450
358	E460	thinkpad-e460
359	T460	thinkpad-t460
360	T460s	thinkpad-t460s
361	T460p	thinkpad-t460p
362	T560	thinkpad-t560
363	P50	thinkpad-p50
364	P50s	thinkpad-p50s
365	P70	thinkpad-p70
366	X260	thinkpad-x260
367	L460	thinkpad-l460
368	L560	thinkpad-l560
369	E560	thinkpad-e560
370	T470	thinkpad-t470
371	T470s	thinkpad-t470s
372	T470p	thinkpad-t470p
373	T570	thinkpad-t570
374	P51	thinkpad-p51
375	P51s	thinkpad-p51s
376	P71	thinkpad-p71
377	X270	thinkpad-x270
378	E470	thinkpad-e470
379	E570	thinkpad-e570
380	E570p	thinkpad-e570p
381	25	thinkpad-25
382	L470	thinkpad-l470
383	L570	thinkpad-l570
384	T480	thinkpad-t480
385	T480s	thinkpad-t480s
386	T580	thinkpad-t580
387	E480	thinkpad-e480
388	X280	thinkpad-x280
389	L480	thinkpad-l480
390	L580	thinkpad-l580
391	E580	thinkpad-e580
392	L380 Yoga	thinkpad-l380-yoga
393	P52	thinkpad-p52
394	P52s	thinkpad-p52s
395	P72	thinkpad-p72
396	A285	thinkpad-a285
397	A485	thinkpad-a485
398	P1	thinkpad-p1
399	X1 Extreme	thinkpad-x1-extreme
400	T490	thinkpad-t490
401	T490s	thinkpad-t490s
402	T590	thinkpad-t590
403	X390	thinkpad-x390
404	E490	thinkpad-e490
405	E590	thinkpad-e590
406	T495	thinkpad-t495
407	T495s	thinkpad-t495s
408	X395	thinkpad-x395
409	P73	thinkpad-p73
410	L490	thinkpad-l490
411	L590	thinkpad-l590
412	X390 Yoga	thinkpad-x390-yoga
413	P53	thinkpad-p53
414	P53s	thinkpad-p53s
415	P43s	thinkpad-p43s
416	P1 G2	thinkpad-p1-g2
417	X1 Extreme G2	thinkpad-x1-extreme-g2
418	T14	thinkpad-t14
419	T14s	thinkpad-t14s
420	T15	thinkpad-t15
421	X13	thinkpad-x13
422	X13 Yoga	thinkpad-x13-yoga
423	X1 Yoga G5	thinkpad-x1-yoga-g5
424	E14	thinkpad-e14
425	E15	thinkpad-e15
426	L13	thinkpad-l13
427	L13 Yoga	thinkpad-l13-yoga
428	L14	thinkpad-l14
429	L15	thinkpad-l15
430	L390	thinkpad-l390
431	X130e	thinkpad-x130e
432	X131e	thinkpad-x131e
433	X380	thinkpad-x380
434	L380	thinkpad-l380
435	P14s	thinkpad-p14s
436	P14	thinkpad-p14
437	E16	thinkpad-e16
457	T14 Gen 1	thinkpad-t14-gen-1
458	T14 Gen 2	thinkpad-t14-gen-2
459	T14 Gen 3	thinkpad-t14-gen-3
460	T14 Gen 4	thinkpad-t14-gen-4
461	T16 Gen 1	thinkpad-t16-gen-1
462	T16 Gen 2	thinkpad-t16-gen-2
474	X13 Gen 1	thinkpad-x13-gen-1
475	X13 Gen 2	thinkpad-x13-gen-2
476	X13 Gen 3	thinkpad-x13-gen-3
477	X13 Gen 4	thinkpad-x13-gen-4
478	X1 Carbon Gen 1	thinkpad-x1-carbon-gen-1
479	X1 Carbon Gen 2	thinkpad-x1-carbon-gen-2
480	X1 Carbon Gen 3	thinkpad-x1-carbon-gen-3
481	X1 Carbon Gen 4	thinkpad-x1-carbon-gen-4
482	X1 Carbon Gen 5	thinkpad-x1-carbon-gen-5
483	X1 Carbon Gen 6	thinkpad-x1-carbon-gen-6
484	X1 Carbon Gen 7	thinkpad-x1-carbon-gen-7
485	X1 Carbon Gen 8	thinkpad-x1-carbon-gen-8
486	X1 Carbon Gen 9	thinkpad-x1-carbon-gen-9
487	X1 Carbon Gen 10	thinkpad-x1-carbon-gen-10
488	X1 Carbon Gen 11	thinkpad-x1-carbon-gen-11
489	X1 Yoga Gen 1	thinkpad-x1-yoga-gen-1
490	X1 Yoga Gen 2	thinkpad-x1-yoga-gen-2
491	X1 Yoga Gen 3	thinkpad-x1-yoga-gen-3
492	X1 Yoga Gen 4	thinkpad-x1-yoga-gen-4
493	X1 Yoga Gen 5	thinkpad-x1-yoga-gen-5
494	X1 Yoga Gen 6	thinkpad-x1-yoga-gen-6
495	X1 Extreme Gen 1	thinkpad-x1-extreme-gen-1
496	X1 Extreme Gen 2	thinkpad-x1-extreme-gen-2
497	X1 Extreme Gen 3	thinkpad-x1-extreme-gen-3
498	X1 Extreme Gen 4	thinkpad-x1-extreme-gen-4
502	L13 Gen 2	thinkpad-l13-gen-2
503	L13 Gen 3	thinkpad-l13-gen-3
504	L14 Gen 1	thinkpad-l14-gen-1
505	L14 Gen 2	thinkpad-l14-gen-2
506	L14 Gen 3	thinkpad-l14-gen-3
507	L15 Gen 1	thinkpad-l15-gen-1
508	L15 Gen 2	thinkpad-l15-gen-2
509	L15 Gen 3	thinkpad-l15-gen-3
510	P1 Gen 1	thinkpad-p1-gen-1
511	P1 Gen 2	thinkpad-p1-gen-2
512	P1 Gen 3	thinkpad-p1-gen-3
513	P1 Gen 4	thinkpad-p1-gen-4
514	P14s Gen 1	thinkpad-p14s-gen-1
515	P14s Gen 2	thinkpad-p14s-gen-2
516	P15	thinkpad-p15
517	P15 Gen 2	thinkpad-p15-gen-2
518	P16	thinkpad-p16
519	P16 Gen 2	thinkpad-p16-gen-2
522	E14 Gen 1	thinkpad-e14-gen-1
523	E14 Gen 2	thinkpad-e14-gen-2
524	E14 Gen 3	thinkpad-e14-gen-3
525	E15 Gen 1	thinkpad-e15-gen-1
526	E15 Gen 2	thinkpad-e15-gen-2
527	E15 Gen 3	thinkpad-e15-gen-3
534	ThinkPad 13	thinkpad-thinkpad-13
535	ThinkPad Yoga 260	thinkpad-thinkpad-yoga-260
536	ThinkPad Yoga 370	thinkpad-thinkpad-yoga-370
537	ThinkPad Helix	thinkpad-thinkpad-helix
538	ThinkPad Tablet	thinkpad-thinkpad-tablet
539	ThinkPad Anniversary Edition 25	thinkpad-thinkpad-anniversary-edition-25
542	X1 Yoga	thinkpad-x1-yoga
\.


--
-- Data for Name: model_price_stats; Type: TABLE DATA; Schema: public; Owner: thinkpaduser
--

COPY public.model_price_stats (id, model_id, avg_price, min_price, max_price, listing_count, updated_at, marketplace) FROM stdin;
14885	11522	750.25	750.25	750.25	1	2026-03-22 18:53:05.598019+11	EBAY_AU
14886	11609	399.00	399.00	399.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14887	12005	2175.57	2175.57	2175.57	1	2026-03-22 18:53:05.598019+11	EBAY_AU
14888	11572	176.66	176.66	176.66	1	2026-03-22 18:53:05.598019+11	EBAY_AU
14889	12003	482.06	482.06	482.06	1	2026-03-22 18:53:05.598019+11	EBAY_AU
14890	11526	1644.60	1644.60	1644.60	1	2026-03-22 18:53:05.598019+11	EBAY_AU
14891	11502	885.98	885.98	885.98	1	2026-03-22 18:53:05.598019+11	EBAY_US
14892	11341	861.44	861.44	861.44	1	2026-03-22 18:53:05.598019+11	EBAY_AU
14893	11559	168.78	168.78	168.78	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14894	11686	233.24	233.24	233.24	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14895	11661	1270.00	1270.00	1270.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14896	11359	3138.14	3138.14	3138.14	1	2026-03-22 18:53:05.598019+11	EBAY_US
14897	11407	1487.97	1487.97	1487.97	1	2026-03-22 18:53:05.598019+11	EBAY_AU
14898	11971	523.88	523.88	523.88	1	2026-03-22 18:53:05.598019+11	EBAY_AU
14899	11633	167.10	167.10	167.10	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14900	11345	939.77	939.77	939.77	1	2026-03-22 18:53:05.598019+11	EBAY_AU
14901	11931	2975.92	2975.92	2975.92	1	2026-03-22 18:53:05.598019+11	EBAY_AU
14902	11832	1042.39	1042.39	1042.39	1	2026-03-22 18:53:05.598019+11	EBAY_DE
14903	11947	375.89	375.89	375.89	1	2026-03-22 18:53:05.598019+11	EBAY_AU
14904	11765	189.00	189.00	189.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
14905	11715	1950.00	1950.00	1950.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14906	11698	579.00	579.00	579.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14907	11779	1499.99	1499.99	1499.99	1	2026-03-22 18:53:05.598019+11	EBAY_DE
14908	11673	359.99	359.99	359.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14909	11356	189.99	189.99	189.99	1	2026-03-22 18:53:05.598019+11	EBAY_US
14910	11418	2831.23	2831.23	2831.23	1	2026-03-22 18:53:05.598019+11	EBAY_AU
14911	11825	1705.39	1705.39	1705.39	1	2026-03-22 18:53:05.598019+11	EBAY_DE
14912	11375	1206.40	1206.40	1206.40	1	2026-03-22 18:53:05.598019+11	EBAY_US
14913	11945	391.56	391.56	391.56	1	2026-03-22 18:53:05.598019+11	EBAY_AU
14914	11405	275.00	275.00	275.00	1	2026-03-22 18:53:05.598019+11	EBAY_US
14915	11583	721.85	721.85	721.85	1	2026-03-22 18:53:05.598019+11	EBAY_AU
14916	12002	797.81	797.81	797.81	1	2026-03-22 18:53:05.598019+11	EBAY_AU
14917	11936	180.12	180.12	180.12	1	2026-03-22 18:53:05.598019+11	EBAY_AU
14918	11733	150.00	150.00	150.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
14919	11681	98.46	98.46	98.46	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14920	11465	432.28	432.28	432.28	1	2026-03-22 18:53:05.598019+11	EBAY_AU
14921	11849	2236.67	2236.67	2236.67	1	2026-03-22 18:53:05.598019+11	EBAY_DE
14922	11750	743.89	743.89	743.89	1	2026-03-22 18:53:05.598019+11	EBAY_DE
14923	11508	864.25	864.25	864.25	1	2026-03-22 18:53:05.598019+11	EBAY_US
14924	11654	3855.00	3855.00	3855.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14925	11630	39.99	39.99	39.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14926	11704	167.10	167.10	167.10	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14927	12006	148.80	148.80	148.80	1	2026-03-22 18:53:05.598019+11	EBAY_AU
14928	11678	129.99	129.99	129.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14929	11635	79.99	79.99	79.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14930	11514	5100.03	5100.03	5100.03	1	2026-03-22 18:53:05.598019+11	EBAY_US
14931	12014	501.21	501.21	501.21	1	2026-03-22 18:53:05.598019+11	EBAY_AU
14932	11639	350.00	350.00	350.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14933	11773	199.00	199.00	199.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
14934	11554	379.90	379.90	379.90	1	2026-03-22 18:53:05.598019+11	EBAY_AU
14935	11627	79.99	79.99	79.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14936	11619	311.84	311.84	311.84	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14937	11567	236.86	236.86	236.86	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14938	11545	161.00	161.00	161.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14939	11893	2733.02	2733.02	2733.02	1	2026-03-22 18:53:05.598019+11	EBAY_DE
14940	11668	189.99	189.99	189.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14941	11995	916.28	916.28	916.28	1	2026-03-22 18:53:05.598019+11	EBAY_AU
14942	11998	352.41	352.41	352.41	1	2026-03-22 18:53:05.598019+11	EBAY_AU
14943	11650	301.26	301.26	301.26	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14944	11872	1786.18	1786.18	1786.18	1	2026-03-22 18:53:05.598019+11	EBAY_DE
14945	11742	599.00	599.00	599.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
14946	11709	94.26	94.26	94.26	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14947	11623	89.99	89.99	89.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14948	11503	1071.63	1071.63	1071.63	1	2026-03-22 18:53:05.598019+11	EBAY_US
14949	11581	169.99	169.99	169.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14950	11550	1689.70	1689.70	1689.70	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14951	11467	189.99	189.99	189.99	1	2026-03-22 18:53:05.598019+11	EBAY_US
14952	11780	60.00	60.00	60.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
14953	11710	1550.00	1550.00	1550.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14954	11721	210.00	210.00	210.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14955	11897	1758.95	1758.95	1758.95	1	2026-03-22 18:53:05.598019+11	EBAY_DE
14956	12019	258.44	258.44	258.44	1	2026-03-22 18:53:05.598019+11	EBAY_AU
14957	11449	566.98	566.98	566.98	1	2026-03-22 18:53:05.598019+11	EBAY_AU
14958	11530	313.24	313.24	313.24	1	2026-03-22 18:53:05.598019+11	EBAY_AU
14959	11409	1500.00	1500.00	1500.00	1	2026-03-22 18:53:05.598019+11	EBAY_US
14960	11421	501.21	501.21	501.21	1	2026-03-22 18:53:05.598019+11	EBAY_AU
14961	11342	345.00	345.00	345.00	1	2026-03-22 18:53:05.598019+11	EBAY_US
14962	11643	89.99	89.99	89.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14963	11547	49.99	49.99	49.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14964	11433	16.49	16.49	16.49	1	2026-03-22 18:53:05.598019+11	EBAY_US
14965	11795	150.00	150.00	150.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
14966	11667	639.00	639.00	639.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14967	11926	854.88	854.88	854.88	1	2026-03-22 18:53:05.598019+11	EBAY_AU
14968	11685	233.24	233.24	233.24	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14969	11800	179.00	179.00	179.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
14970	11599	179.00	179.00	179.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14971	11641	57.99	57.99	57.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14972	11870	2012.42	2012.42	2012.42	1	2026-03-22 18:53:05.598019+11	EBAY_DE
14973	11743	1340.59	1340.59	1340.59	1	2026-03-22 18:53:05.598019+11	EBAY_DE
14974	11881	2132.87	2132.87	2132.87	1	2026-03-22 18:53:05.598019+11	EBAY_DE
14975	11544	199.21	199.21	199.21	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14976	11987	501.21	501.21	501.21	1	2026-03-22 18:53:05.598019+11	EBAY_AU
14977	12024	906.88	906.88	906.88	1	2026-03-22 18:53:05.598019+11	EBAY_AU
14978	11657	1778.00	1778.00	1778.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14979	11557	999.99	999.99	999.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14980	11563	89.99	89.99	89.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14981	11702	94.30	94.30	94.30	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14982	11749	1324.59	1324.59	1324.59	1	2026-03-22 18:53:05.598019+11	EBAY_DE
14983	11999	551.32	551.32	551.32	1	2026-03-22 18:53:05.598019+11	EBAY_AU
14984	11367	149.95	149.95	149.95	1	2026-03-22 18:53:05.598019+11	EBAY_US
14985	11578	254.21	254.21	254.21	1	2026-03-22 18:53:05.598019+11	EBAY_AU
14986	11335	295.00	295.00	295.00	1	2026-03-22 18:53:05.598019+11	EBAY_US
14987	11845	2578.01	2578.01	2578.01	1	2026-03-22 18:53:05.598019+11	EBAY_DE
14988	11529	249.00	249.00	249.00	1	2026-03-22 18:53:05.598019+11	EBAY_US
14989	11777	180.00	180.00	180.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
14990	11774	120.00	120.00	120.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
14991	11616	79.99	79.99	79.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
14992	11343	450.00	450.00	450.00	1	2026-03-22 18:53:05.598019+11	EBAY_US
14993	11909	760.00	760.00	760.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
14994	11986	501.20	501.20	501.20	1	2026-03-22 18:53:05.598019+11	EBAY_AU
14995	11796	1399.90	1399.90	1399.90	1	2026-03-22 18:53:05.598019+11	EBAY_DE
14996	11992	343.02	343.02	343.02	1	2026-03-22 18:53:05.598019+11	EBAY_AU
14997	11425	540.00	540.00	540.00	1	2026-03-22 18:53:05.598019+11	EBAY_US
14998	11400	1302.25	1302.25	1302.25	1	2026-03-22 18:53:05.598019+11	EBAY_US
14999	11735	504.99	504.99	504.99	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15000	11459	1014.94	1014.94	1014.94	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15001	11883	907.42	907.42	907.42	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15002	11460	404.09	404.09	404.09	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15003	11877	4162.71	4162.71	4162.71	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15004	11513	3155.49	3155.49	3155.49	1	2026-03-22 18:53:05.598019+11	EBAY_US
15005	11500	1101.03	1101.03	1101.03	1	2026-03-22 18:53:05.598019+11	EBAY_US
15006	11812	2071.09	2071.09	2071.09	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15007	11371	1722.91	1722.91	1722.91	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15008	11874	1521.20	1521.20	1521.20	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15009	11919	359.00	359.00	359.00	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15010	11791	249.00	249.00	249.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15011	11847	479.00	479.00	479.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15012	11676	144.99	144.99	144.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15013	11420	2582.80	2582.80	2582.80	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15014	11799	300.00	300.00	300.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15015	11846	1060.34	1060.34	1060.34	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15016	11390	885.98	885.98	885.98	1	2026-03-22 18:53:05.598019+11	EBAY_US
15017	11652	849.00	849.00	849.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15018	11484	3986.59	3986.59	3986.59	1	2026-03-22 18:53:05.598019+11	EBAY_US
15019	11864	1272.96	1272.96	1272.96	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15020	11498	760.98	760.98	760.98	1	2026-03-22 18:53:05.598019+11	EBAY_US
15021	11725	440.20	440.20	440.20	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15022	11873	1459.40	1459.40	1459.40	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15023	11816	4901.39	4901.39	4901.39	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15024	11747	1795.39	1795.39	1795.39	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15025	12017	853.62	853.62	853.62	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15026	11552	1044.79	1044.79	1044.79	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15027	11608	260.69	260.69	260.69	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15028	11966	2349.42	2349.42	2349.42	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15029	11410	62.65	62.65	62.65	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15030	11783	379.00	379.00	379.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15031	11739	120.00	120.00	120.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15032	11850	2461.69	2461.69	2461.69	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15033	11792	310.00	310.00	310.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15034	11917	269.00	269.00	269.00	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15035	11694	579.00	579.00	579.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15036	11952	391.56	391.56	391.56	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15037	11497	760.00	760.00	760.00	1	2026-03-22 18:53:05.598019+11	EBAY_US
15038	11696	549.00	549.00	549.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15039	11955	407.22	407.22	407.22	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15040	11351	499.79	499.79	499.79	1	2026-03-22 18:53:05.598019+11	EBAY_US
15041	11693	225.00	225.00	225.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15042	11612	329.00	329.00	329.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15043	11525	175.00	175.00	175.00	1	2026-03-22 18:53:05.598019+11	EBAY_US
15044	11512	269.99	269.99	269.99	1	2026-03-22 18:53:05.598019+11	EBAY_US
15045	11647	130.00	130.00	130.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15046	11397	3097.30	3097.30	3097.30	1	2026-03-22 18:53:05.598019+11	EBAY_US
15047	11839	6615.86	6615.86	6615.86	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15048	11462	567.70	567.70	567.70	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15049	11589	80.00	80.00	80.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15050	11949	3254.00	3254.00	3254.00	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15051	11784	589.00	589.00	589.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15052	11431	1180.03	1180.03	1180.03	1	2026-03-22 18:53:05.598019+11	EBAY_US
15053	11752	489.00	489.00	489.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15054	11392	799.21	799.21	799.21	1	2026-03-22 18:53:05.598019+11	EBAY_US
15055	11988	500.00	500.00	500.00	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15056	11745	1895.19	1895.19	1895.19	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15057	11837	2503.07	2503.07	2503.07	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15058	11585	771.70	771.70	771.70	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15059	12011	1065.06	1065.06	1065.06	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15060	11380	52.00	52.00	52.00	1	2026-03-22 18:53:05.598019+11	EBAY_US
15061	11922	239.00	239.00	239.00	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15062	11352	379.99	379.99	379.99	1	2026-03-22 18:53:05.598019+11	EBAY_US
15063	11438	1011.23	1011.23	1011.23	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15064	11408	225.53	225.53	225.53	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15065	11758	1120.89	1120.89	1120.89	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15066	11523	2661.11	2661.11	2661.11	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15067	11428	885.98	885.98	885.98	1	2026-03-22 18:53:05.598019+11	EBAY_US
15068	11960	249.96	249.96	249.96	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15069	11805	249.00	249.00	249.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15070	11738	180.00	180.00	180.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15071	11766	123.00	123.00	123.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15072	11441	471.44	471.44	471.44	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15073	11844	2063.75	2063.75	2063.75	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15074	11362	189.00	189.00	189.00	1	2026-03-22 18:53:05.598019+11	EBAY_US
15075	11769	310.00	310.00	310.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15076	11336	1005.03	1005.03	1005.03	1	2026-03-22 18:53:05.598019+11	EBAY_US
15077	11448	336.74	336.74	336.74	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15078	11594	568.58	568.58	568.58	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15079	11338	279.99	279.99	279.99	1	2026-03-22 18:53:05.598019+11	EBAY_US
15080	11700	63.10	63.10	63.10	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15081	11852	893.09	893.09	893.09	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15082	11365	199.00	199.00	199.00	1	2026-03-22 18:53:05.598019+11	EBAY_US
15083	11723	210.00	210.00	210.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15084	11515	926.18	926.18	926.18	1	2026-03-22 18:53:05.598019+11	EBAY_US
15085	11472	1378.88	1378.88	1378.88	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15086	11851	1067.59	1067.59	1067.59	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15087	12009	234.93	234.93	234.93	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15088	11539	312.70	312.70	312.70	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15089	11899	1556.00	1556.00	1556.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15090	11815	4901.39	4901.39	4901.39	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15091	11443	371.19	371.19	371.19	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15092	11655	2279.00	2279.00	2279.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15093	11444	355.53	355.53	355.53	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15094	11753	2665.95	2665.95	2665.95	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15095	11611	149.99	149.99	149.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15096	12021	2526.88	2526.88	2526.88	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15097	11332	349.00	349.00	349.00	1	2026-03-22 18:53:05.598019+11	EBAY_US
15098	11818	4901.39	4901.39	4901.39	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15099	11672	199.00	199.00	199.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15100	11880	2434.52	2434.52	2434.52	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15101	11660	74.99	74.99	74.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15102	11453	1769.88	1769.88	1769.88	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15103	11346	900.61	900.61	900.61	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15104	11562	349.00	349.00	349.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15105	11934	352.41	352.41	352.41	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15106	11997	1080.71	1080.71	1080.71	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15107	11366	479.99	479.99	479.99	1	2026-03-22 18:53:05.598019+11	EBAY_US
15108	11889	1694.01	1694.01	1694.01	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15109	11468	2191.23	2191.23	2191.23	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15110	11602	349.00	349.00	349.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15111	11488	1193.85	1193.85	1193.85	1	2026-03-22 18:53:05.598019+11	EBAY_US
15112	11489	1051.53	1051.53	1051.53	1	2026-03-22 18:53:05.598019+11	EBAY_US
15113	11394	882.47	882.47	882.47	1	2026-03-22 18:53:05.598019+11	EBAY_US
15114	11485	2246.82	2246.82	2246.82	1	2026-03-22 18:53:05.598019+11	EBAY_US
15115	11474	2427.74	2427.74	2427.74	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15116	11802	280.00	280.00	280.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15117	11422	459.00	459.00	459.00	1	2026-03-22 18:53:05.598019+11	EBAY_US
15118	11833	2479.00	2479.00	2479.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15119	11814	1538.89	1538.89	1538.89	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15120	11724	210.00	210.00	210.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15121	11726	145.00	145.00	145.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15122	11670	79.99	79.99	79.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15123	11964	530.97	530.97	530.97	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15124	11905	1795.39	1795.39	1795.39	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15125	11471	156.63	156.63	156.63	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15126	11789	130.00	130.00	130.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15127	11434	864.25	864.25	864.25	1	2026-03-22 18:53:05.598019+11	EBAY_US
15128	11734	349.99	349.99	349.99	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15129	11981	300.00	300.00	300.00	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15130	11907	1287.39	1287.39	1287.39	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15131	11564	227.04	227.04	227.04	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15132	11636	783.22	783.22	783.22	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15133	11632	44.99	44.99	44.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15134	11699	369.00	369.00	369.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15135	11687	145.26	145.26	145.26	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15136	11689	95.00	95.00	95.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15137	11985	311.69	311.69	311.69	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15138	11969	266.27	266.27	266.27	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15139	11396	760.98	760.98	760.98	1	2026-03-22 18:53:05.598019+11	EBAY_US
15140	11993	468.32	468.32	468.32	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15141	11892	2159.05	2159.05	2159.05	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15142	11835	1042.39	1042.39	1042.39	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15143	11717	259.99	259.99	259.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15144	11912	100.00	100.00	100.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15145	11521	467.96	467.96	467.96	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15146	11591	231.01	231.01	231.01	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15147	11395	895.27	895.27	895.27	1	2026-03-22 18:53:05.598019+11	EBAY_US
15148	11961	610.78	610.78	610.78	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15149	11862	1397.60	1397.60	1397.60	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15150	11788	250.00	250.00	250.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15151	11930	407.23	407.23	407.23	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15152	11843	2032.33	2032.33	2032.33	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15153	11716	182.70	182.70	182.70	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15154	11746	1287.39	1287.39	1287.39	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15155	11436	619.69	619.69	619.69	1	2026-03-22 18:53:05.598019+11	EBAY_US
15156	11519	100.00	100.00	100.00	1	2026-03-22 18:53:05.598019+11	EBAY_US
15157	11759	1038.39	1038.39	1038.39	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15158	11669	149.99	149.99	149.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15159	11706	499.00	499.00	499.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15160	11473	313.24	313.24	313.24	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15161	11878	1283.43	1283.43	1283.43	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15162	11806	599.00	599.00	599.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15163	11703	109.90	109.90	109.90	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15164	11719	1100.00	1100.00	1100.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15165	11618	79.99	79.99	79.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15166	11898	250.00	250.00	250.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15167	11634	135.90	135.90	135.90	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15168	11476	1117.80	1117.80	1117.80	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15169	11869	2393.67	2393.67	2393.67	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15170	11478	910.72	910.72	910.72	1	2026-03-22 18:53:05.598019+11	EBAY_US
15171	11353	145.00	145.00	145.00	1	2026-03-22 18:53:05.598019+11	EBAY_US
15172	11540	192.90	192.90	192.90	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15173	11908	740.00	740.00	740.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15174	11558	516.70	516.70	516.70	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15175	11340	468.32	468.32	468.32	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15176	11720	195.00	195.00	195.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15177	11622	39.99	39.99	39.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15178	11675	180.00	180.00	180.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15179	11858	2508.86	2508.86	2508.86	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15180	11772	599.99	599.99	599.99	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15181	11373	354.95	354.95	354.95	1	2026-03-22 18:53:05.598019+11	EBAY_US
15182	11819	1518.91	1518.91	1518.91	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15183	11596	259.27	259.27	259.27	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15184	11504	663.03	663.03	663.03	1	2026-03-22 18:53:05.598019+11	EBAY_US
15185	11429	895.27	895.27	895.27	1	2026-03-22 18:53:05.598019+11	EBAY_US
15186	11957	407.22	407.22	407.22	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15187	11337	599.99	599.99	599.99	1	2026-03-22 18:53:05.598019+11	EBAY_US
15188	11994	438.56	438.56	438.56	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15189	11754	1034.39	1034.39	1034.39	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15190	11855	325.00	325.00	325.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15191	11804	649.00	649.00	649.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15192	11841	1625.93	1625.93	1625.93	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15193	11762	499.00	499.00	499.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15194	11756	3431.39	3431.39	3431.39	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15195	11376	760.98	760.98	760.98	1	2026-03-22 18:53:05.598019+11	EBAY_US
15196	11823	1465.69	1465.69	1465.69	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15197	11793	50.90	50.90	50.90	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15198	11625	79.99	79.99	79.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15199	11533	227.87	227.87	227.87	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15200	11355	1424.37	1424.37	1424.37	1	2026-03-22 18:53:05.598019+11	EBAY_US
15201	11979	172.28	172.28	172.28	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15202	11446	375.89	375.89	375.89	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15203	11918	289.00	289.00	289.00	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15204	11454	1046.26	1046.26	1046.26	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15205	11755	879.79	879.79	879.79	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15206	11916	599.00	599.00	599.00	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15207	12013	1251.46	1251.46	1251.46	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15208	11357	1702.84	1702.84	1702.84	1	2026-03-22 18:53:05.598019+11	EBAY_US
15209	11948	4096.00	4096.00	4096.00	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15210	11935	469.87	469.87	469.87	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15211	11570	123.25	123.25	123.25	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15212	11391	1541.93	1541.93	1541.93	1	2026-03-22 18:53:05.598019+11	EBAY_US
15213	11682	499.00	499.00	499.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15214	11822	4901.39	4901.39	4901.39	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15215	11450	557.58	557.58	557.58	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15216	12010	593.62	593.62	593.62	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15217	11781	55.00	55.00	55.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15218	11838	8624.42	8624.42	8624.42	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15219	11605	369.00	369.00	369.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15220	11339	275.00	275.00	275.00	1	2026-03-22 18:53:05.598019+11	EBAY_US
15221	11445	718.91	718.91	718.91	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15222	11389	1071.63	1071.63	1071.63	1	2026-03-22 18:53:05.598019+11	EBAY_US
15223	11965	562.30	562.30	562.30	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15224	11737	199.99	199.99	199.99	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15225	11861	1404.93	1404.93	1404.93	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15226	11829	1465.69	1465.69	1465.69	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15227	11509	560.00	560.00	560.00	1	2026-03-22 18:53:05.598019+11	EBAY_US
15228	11388	299.99	299.99	299.99	1	2026-03-22 18:53:05.598019+11	EBAY_US
15229	11383	266.25	266.25	266.25	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15230	11475	149.99	149.99	149.99	1	2026-03-22 18:53:05.598019+11	EBAY_US
15231	11713	700.00	700.00	700.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15232	11705	73.50	73.50	73.50	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15233	11582	346.24	346.24	346.24	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15234	11587	302.04	302.04	302.04	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15235	11906	1689.39	1689.39	1689.39	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15236	11967	155.06	155.06	155.06	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15237	11778	179.00	179.00	179.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15238	11831	1067.59	1067.59	1067.59	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15239	11707	1850.00	1850.00	1850.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15240	11411	311.69	311.69	311.69	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15241	11978	140.95	140.95	140.95	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15242	11740	250.00	250.00	250.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15243	11902	1518.91	1518.91	1518.91	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15244	11770	39.00	39.00	39.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15245	11644	299.00	299.00	299.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15246	11604	579.00	579.00	579.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15247	11398	1022.14	1022.14	1022.14	1	2026-03-22 18:53:05.598019+11	EBAY_US
15248	11452	374.33	374.33	374.33	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15249	11876	2118.20	2118.20	2118.20	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15250	11426	1495.69	1495.69	1495.69	1	2026-03-22 18:53:05.598019+11	EBAY_US
15251	11417	524.69	524.69	524.69	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15252	11976	719.05	719.05	719.05	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15253	11477	139.40	139.40	139.40	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15254	11941	503.13	503.13	503.13	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15255	11568	244.93	244.93	244.93	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15256	11798	149.00	149.00	149.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15257	11718	159.61	159.61	159.61	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15258	11924	990.67	990.67	990.67	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15259	11595	393.76	393.76	393.76	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15260	11887	1084.43	1084.43	1084.43	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15261	11507	697.02	697.02	697.02	1	2026-03-22 18:53:05.598019+11	EBAY_US
15262	11888	2111.92	2111.92	2111.92	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15263	11801	149.00	149.00	149.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15264	12012	953.87	953.87	953.87	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15265	11875	1411.21	1411.21	1411.21	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15266	11929	407.23	407.23	407.23	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15267	11977	900.00	900.00	900.00	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15268	11764	1940.93	1940.93	1940.93	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15269	11886	3706.79	3706.79	3706.79	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15270	11744	1340.59	1340.59	1340.59	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15271	11597	253.90	253.90	253.90	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15272	11607	414.69	414.69	414.69	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15273	11807	180.00	180.00	180.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15274	11555	229.50	229.50	229.50	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15275	11403	220.00	220.00	220.00	1	2026-03-22 18:53:05.598019+11	EBAY_US
15276	11808	159.00	159.00	159.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15277	11983	264.70	264.70	264.70	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15278	11776	195.00	195.00	195.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15279	11996	212.97	212.97	212.97	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15280	11840	5641.99	5641.99	5641.99	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15281	11437	1011.23	1011.23	1011.23	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15282	11820	1102.19	1102.19	1102.19	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15283	11406	399.99	399.99	399.99	1	2026-03-22 18:53:05.598019+11	EBAY_US
15284	11575	156.70	156.70	156.70	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15285	11927	354.21	354.21	354.21	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15286	11828	1465.69	1465.69	1465.69	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15287	11782	250.00	250.00	250.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15288	11915	180.50	180.50	180.50	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15289	11501	663.03	663.03	663.03	1	2026-03-22 18:53:05.598019+11	EBAY_US
15290	11760	1933.91	1933.91	1933.91	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15291	11790	1300.00	1300.00	1300.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15292	11592	125.50	125.50	125.50	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15293	11658	2207.00	2207.00	2207.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15294	11387	199.00	199.00	199.00	1	2026-03-22 18:53:05.598019+11	EBAY_US
15295	11859	1713.92	1713.92	1713.92	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15296	11824	1465.69	1465.69	1465.69	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15297	11722	149.71	149.71	149.71	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15298	11943	1096.38	1096.38	1096.38	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15299	11836	893.09	893.09	893.09	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15300	11854	1190.09	1190.09	1190.09	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15301	11868	1500.24	1500.24	1500.24	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15302	11866	1225.83	1225.83	1225.83	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15303	11469	374.34	374.34	374.34	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15304	11649	300.00	300.00	300.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15305	11483	1634.76	1634.76	1634.76	1	2026-03-22 18:53:05.598019+11	EBAY_US
15306	11642	54.99	54.99	54.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15307	11991	1929.67	1929.67	1929.67	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15308	11695	329.00	329.00	329.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15309	11551	113.98	113.98	113.98	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15310	11865	1154.60	1154.60	1154.60	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15311	11797	249.00	249.00	249.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15312	11584	1638.70	1638.70	1638.70	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15313	11653	1912.00	1912.00	1912.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15314	11990	468.32	468.32	468.32	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15315	11648	290.00	290.00	290.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15316	11856	1242.58	1242.58	1242.58	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15317	11447	969.51	969.51	969.51	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15318	11921	220.00	220.00	220.00	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15319	11942	781.57	781.57	781.57	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15320	11382	548.18	548.18	548.18	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15321	11708	182.70	182.70	182.70	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15322	11402	3388.97	3388.97	3388.97	1	2026-03-22 18:53:05.598019+11	EBAY_US
15323	11970	610.69	610.69	610.69	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15324	11576	189.94	189.94	189.94	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15325	11787	4502.07	4502.07	4502.07	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15326	11932	812.90	812.90	812.90	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15327	11333	259.99	259.99	259.99	1	2026-03-22 18:53:05.598019+11	EBAY_US
15328	11520	140.97	140.97	140.97	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15329	11518	650.00	650.00	650.00	1	2026-03-22 18:53:05.598019+11	EBAY_US
15330	11958	468.32	468.32	468.32	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15331	11372	529.39	529.39	529.39	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15332	11809	240.00	240.00	240.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15333	11541	220.69	220.69	220.69	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15334	11933	1065.01	1065.01	1065.01	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15335	11894	2315.11	2315.11	2315.11	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15336	11363	1644.60	1644.60	1644.60	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15337	11817	4901.39	4901.39	4901.39	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15338	11379	279.99	279.99	279.99	1	2026-03-22 18:53:05.598019+11	EBAY_US
15339	11542	218.03	218.03	218.03	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15340	11588	99.95	99.95	99.95	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15341	11553	290.86	290.86	290.86	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15342	11857	2028.13	2028.13	2028.13	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15343	11662	219.99	219.99	219.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15344	11640	150.00	150.00	150.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15345	11377	791.64	791.64	791.64	1	2026-03-22 18:53:05.598019+11	EBAY_US
15346	11938	938.20	938.20	938.20	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15347	11624	39.99	39.99	39.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15348	11457	447.94	447.94	447.94	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15349	12016	352.34	352.34	352.34	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15350	11537	208.70	208.70	208.70	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15351	11972	386.92	386.92	386.92	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15352	11775	219.00	219.00	219.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15353	11771	1132.61	1132.61	1132.61	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15354	11956	467.54	467.54	467.54	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15355	11663	589.00	589.00	589.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15356	11374	1009.71	1009.71	1009.71	1	2026-03-22 18:53:05.598019+11	EBAY_US
15357	11495	926.18	926.18	926.18	1	2026-03-22 18:53:05.598019+11	EBAY_US
15358	11614	449.00	449.00	449.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15359	11574	562.03	562.03	562.03	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15360	11603	344.71	344.71	344.71	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15361	11697	281.69	281.69	281.69	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15362	11399	1419.72	1419.72	1419.72	1	2026-03-22 18:53:05.598019+11	EBAY_US
15363	11954	383.72	383.72	383.72	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15364	11714	2499.00	2499.00	2499.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15365	11904	1723.69	1723.69	1723.69	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15366	11884	2266.93	2266.93	2266.93	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15367	11439	432.28	432.28	432.28	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15368	11628	89.99	89.99	89.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15369	11863	2501.55	2501.55	2501.55	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15370	11401	583.91	583.91	583.91	1	2026-03-22 18:53:05.598019+11	EBAY_US
15371	11535	635.83	635.83	635.83	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15372	11939	313.26	313.26	313.26	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15373	11688	239.90	239.90	239.90	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15374	11984	233.38	233.38	233.38	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15375	11757	1327.19	1327.19	1327.19	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15376	11370	159.99	159.99	159.99	1	2026-03-22 18:53:05.598019+11	EBAY_US
15377	11928	2919.65	2919.65	2919.65	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15378	11980	187.94	187.94	187.94	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15379	11900	1317.00	1317.00	1317.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15380	11890	1634.31	1634.31	1634.31	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15381	11974	227.11	227.11	227.11	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15382	11516	961.84	961.84	961.84	1	2026-03-22 18:53:05.598019+11	EBAY_US
15383	11427	2085.88	2085.88	2085.88	1	2026-03-22 18:53:05.598019+11	EBAY_US
15384	11621	79.99	79.99	79.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15385	11413	368.08	368.08	368.08	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15386	11348	939.77	939.77	939.77	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15387	11982	85.60	85.60	85.60	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15388	11601	149.99	149.99	149.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15389	11344	468.32	468.32	468.32	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15390	11651	1199.99	1199.99	1199.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15391	11842	3628.74	3628.74	3628.74	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15392	11827	1251.39	1251.39	1251.39	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15393	12000	274.41	274.41	274.41	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15394	11561	99.99	99.99	99.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15395	12004	1076.04	1076.04	1076.04	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15396	11590	222.66	222.66	222.66	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15397	11440	471.44	471.44	471.44	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15398	11674	247.99	247.99	247.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15399	11573	1650.77	1650.77	1650.77	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15400	12023	344.57	344.57	344.57	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15401	11569	378.52	378.52	378.52	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15402	11470	331.27	331.27	331.27	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15403	11349	783.14	783.14	783.14	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15404	11712	149.99	149.99	149.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15405	11424	1170.73	1170.73	1170.73	1	2026-03-22 18:53:05.598019+11	EBAY_US
15406	11691	599.00	599.00	599.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15407	11580	759.85	759.85	759.85	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15408	11631	79.99	79.99	79.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15409	11748	2917.00	2917.00	2917.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15410	11384	249.00	249.00	249.00	1	2026-03-22 18:53:05.598019+11	EBAY_US
15411	11834	855.00	855.00	855.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15412	11732	1518.91	1518.91	1518.91	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15413	11586	113.98	113.98	113.98	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15414	11393	997.99	997.99	997.99	1	2026-03-22 18:53:05.598019+11	EBAY_US
15415	11944	649.99	649.99	649.99	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15416	11458	969.51	969.51	969.51	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15417	11975	203.60	203.60	203.60	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15418	11690	99.99	99.99	99.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15419	11546	58.94	58.94	58.94	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15420	11494	217.71	217.71	217.71	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15421	11598	199.99	199.99	199.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15422	11959	453.44	453.44	453.44	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15423	11910	150.00	150.00	150.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15424	11736	2035.39	2035.39	2035.39	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15425	11659	219.99	219.99	219.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15426	11423	3077.61	3077.61	3077.61	1	2026-03-22 18:53:05.598019+11	EBAY_US
15427	11629	79.99	79.99	79.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15428	11656	1804.00	1804.00	1804.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15429	11613	70.00	70.00	70.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15430	11364	539.99	539.99	539.99	1	2026-03-22 18:53:05.598019+11	EBAY_US
15431	12007	101.79	101.79	101.79	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15432	11419	264.70	264.70	264.70	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15433	11768	279.00	279.00	279.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15434	11646	190.00	190.00	190.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15435	12001	390.00	390.00	390.00	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15436	11487	1557.50	1557.50	1557.50	1	2026-03-22 18:53:05.598019+11	EBAY_US
15437	11435	1538.91	1538.91	1538.91	1	2026-03-22 18:53:05.598019+11	EBAY_US
15438	11794	423.00	423.00	423.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15439	11951	383.72	383.72	383.72	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15440	11430	947.90	947.90	947.90	1	2026-03-22 18:53:05.598019+11	EBAY_US
15441	11901	1465.69	1465.69	1465.69	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15442	11481	896.78	896.78	896.78	1	2026-03-22 18:53:05.598019+11	EBAY_US
15443	11989	344.58	344.58	344.58	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15444	11538	73.50	73.50	73.50	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15445	11464	830.12	830.12	830.12	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15446	11381	626.51	626.51	626.51	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15447	11556	156.09	156.09	156.09	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15448	11610	179.99	179.99	179.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15449	11803	1499.90	1499.90	1499.90	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15450	11786	119.00	119.00	119.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15451	11666	539.00	539.00	539.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15452	11811	1449.69	1449.69	1449.69	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15453	11950	383.72	383.72	383.72	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15454	11903	2137.00	2137.00	2137.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15455	11532	2254.97	2254.97	2254.97	1	2026-03-22 18:53:05.598019+11	EBAY_US
15456	11826	1465.69	1465.69	1465.69	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15457	11638	149.97	149.97	149.97	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15458	11813	2491.00	2491.00	2491.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15459	11491	812.10	812.10	812.10	1	2026-03-22 18:53:05.598019+11	EBAY_US
15460	11891	2227.13	2227.13	2227.13	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15461	11701	73.50	73.50	73.50	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15462	11455	1351.26	1351.26	1351.26	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15463	11626	69.99	69.99	69.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15464	11505	799.21	799.21	799.21	1	2026-03-22 18:53:05.598019+11	EBAY_US
15465	11416	2144.24	2144.24	2144.24	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15466	11432	760.98	760.98	760.98	1	2026-03-22 18:53:05.598019+11	EBAY_US
15467	11334	359.00	359.00	359.00	1	2026-03-22 18:53:05.598019+11	EBAY_US
15468	11466	839.51	839.51	839.51	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15469	11785	1490.00	1490.00	1490.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15470	11579	135.90	135.90	135.90	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15471	11506	663.03	663.03	663.03	1	2026-03-22 18:53:05.598019+11	EBAY_US
15472	11548	349.00	349.00	349.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15473	11683	550.00	550.00	550.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15474	11386	199.00	199.00	199.00	1	2026-03-22 18:53:05.598019+11	EBAY_US
15475	11830	1465.69	1465.69	1465.69	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15476	11451	701.68	701.68	701.68	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15477	12008	300.00	300.00	300.00	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15478	11895	1801.89	1801.89	1801.89	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15479	11853	1280.59	1280.59	1280.59	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15480	11679	1699.90	1699.90	1699.90	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15481	11354	2364.72	2364.72	2364.72	1	2026-03-22 18:53:05.598019+11	EBAY_US
15482	11761	1222.00	1222.00	1222.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15483	11385	199.00	199.00	199.00	1	2026-03-22 18:53:05.598019+11	EBAY_US
15484	11360	2789.04	2789.04	2789.04	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15485	11885	2315.11	2315.11	2315.11	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15486	11882	6596.85	6596.85	6596.85	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15487	11867	1201.74	1201.74	1201.74	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15488	11524	170.99	170.99	170.99	1	2026-03-22 18:53:05.598019+11	EBAY_US
15489	11968	610.78	610.78	610.78	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15490	11728	158.76	158.76	158.76	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15491	11731	1247.75	1247.75	1247.75	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15492	11368	388.44	388.44	388.44	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15493	11560	499.00	499.00	499.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15494	11412	200.00	200.00	200.00	1	2026-03-22 18:53:05.598019+11	EBAY_US
15495	11480	1197.00	1197.00	1197.00	1	2026-03-22 18:53:05.598019+11	EBAY_US
15496	11962	546.63	546.63	546.63	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15497	11496	864.25	864.25	864.25	1	2026-03-22 18:53:05.598019+11	EBAY_US
15498	11606	78.70	78.70	78.70	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15499	11577	125.50	125.50	125.50	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15500	11493	569.52	569.52	569.52	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15501	11528	299.99	299.99	299.99	1	2026-03-22 18:53:05.598019+11	EBAY_US
15502	11479	697.02	697.02	697.02	1	2026-03-22 18:53:05.598019+11	EBAY_US
15503	11486	1557.50	1557.50	1557.50	1	2026-03-22 18:53:05.598019+11	EBAY_US
15504	11463	850.48	850.48	850.48	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15505	11414	2885.95	2885.95	2885.95	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15506	11499	926.18	926.18	926.18	1	2026-03-22 18:53:05.598019+11	EBAY_US
15507	11763	895.79	895.79	895.79	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15508	11848	1226.00	1226.00	1226.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15509	11677	163.70	163.70	163.70	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15510	11369	1037.59	1037.59	1037.59	1	2026-03-22 18:53:05.598019+11	EBAY_US
15511	11510	1300.00	1300.00	1300.00	1	2026-03-22 18:53:05.598019+11	EBAY_US
15512	12018	266.27	266.27	266.27	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15513	11711	301.26	301.26	301.26	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15514	11442	529.39	529.39	529.39	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15515	11566	350.00	350.00	350.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15516	12020	1065.07	1065.07	1065.07	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15517	11730	275.00	275.00	275.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15518	11536	436.54	436.54	436.54	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15519	11482	844.15	844.15	844.15	1	2026-03-22 18:53:05.598019+11	EBAY_US
15520	11920	369.00	369.00	369.00	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15521	11492	906.08	906.08	906.08	1	2026-03-22 18:53:05.598019+11	EBAY_US
15522	11767	195.00	195.00	195.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15523	11461	375.89	375.89	375.89	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15524	11404	175.00	175.00	175.00	1	2026-03-22 18:53:05.598019+11	EBAY_US
15525	11879	1227.92	1227.92	1227.92	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15526	11692	39.99	39.99	39.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15527	11664	1489.00	1489.00	1489.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15528	11549	2556.70	2556.70	2556.70	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15529	11517	663.03	663.03	663.03	1	2026-03-22 18:53:05.598019+11	EBAY_US
15530	11896	1330.55	1330.55	1330.55	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15531	11741	450.00	450.00	450.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15532	11415	264.70	264.70	264.70	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15533	11821	1465.69	1465.69	1465.69	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15534	11946	375.89	375.89	375.89	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15535	11358	3108.14	3108.14	3108.14	1	2026-03-22 18:53:05.598019+11	EBAY_US
15536	11913	349.90	349.90	349.90	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15537	11637	62.95	62.95	62.95	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15538	11680	59.95	59.95	59.95	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15539	11671	149.99	149.99	149.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15540	11871	1988.33	1988.33	1988.33	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15541	11729	180.00	180.00	180.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15542	11620	525.00	525.00	525.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15543	11937	311.69	311.69	311.69	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15544	11456	1057.94	1057.94	1057.94	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15545	11923	239.00	239.00	239.00	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15546	11751	169.99	169.99	169.99	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15547	11350	125.00	125.00	125.00	1	2026-03-22 18:53:05.598019+11	EBAY_US
15548	11810	1449.69	1449.69	1449.69	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15549	11593	251.21	251.21	251.21	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15550	11615	45.00	45.00	45.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15551	11543	219.83	219.83	219.83	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15552	11953	383.72	383.72	383.72	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15553	11727	924.69	924.69	924.69	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15554	11925	2899.99	2899.99	2899.99	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15555	11665	489.00	489.00	489.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15556	11490	2201.83	2201.83	2201.83	1	2026-03-22 18:53:05.598019+11	EBAY_US
15557	11940	587.36	587.36	587.36	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15558	11963	469.87	469.87	469.87	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15559	11361	3853.95	3853.95	3853.95	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15560	12022	577.96	577.96	577.96	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15561	11973	367.08	367.08	367.08	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15562	11511	135.00	135.00	135.00	1	2026-03-22 18:53:05.598019+11	EBAY_US
15563	11527	469.88	469.88	469.88	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15564	11600	135.90	135.90	135.90	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15565	12015	313.19	313.19	313.19	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15566	11571	172.30	172.30	172.30	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15567	11645	299.00	299.00	299.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15568	11914	434.51	434.51	434.51	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15569	11860	1285.53	1285.53	1285.53	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15570	11347	468.32	468.32	468.32	1	2026-03-22 18:53:05.598019+11	EBAY_AU
15571	11531	249.99	249.99	249.99	1	2026-03-22 18:53:05.598019+11	EBAY_US
15572	11911	150.00	150.00	150.00	1	2026-03-22 18:53:05.598019+11	EBAY_DE
15573	11684	899.00	899.00	899.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15574	11534	241.35	241.35	241.35	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15575	11617	79.99	79.99	79.99	1	2026-03-22 18:53:05.598019+11	EBAY_GB
15576	11378	384.95	384.95	384.95	1	2026-03-22 18:53:05.598019+11	EBAY_US
15577	11565	69.00	69.00	69.00	1	2026-03-22 18:53:05.598019+11	EBAY_GB
\.


--
-- Data for Name: models; Type: TABLE DATA; Schema: public; Owner: thinkpaduser
--

COPY public.models (id, name, canon_model_id, raw_model, raw_mpn, parsed_aspect, parsed_title, parsed_mpn, model_source, listing_id) FROM stdin;
11916	UNKNOWN	\N	\N	\N	\N	\N	\N	\N	35752
11332	R61	235	Lenovo ThinkPad R61	\N	R61	\N	\N	\N	35167
11333	T14s	419	Lenovo ThinkPad T14s	20UH002WUS	T14s	\N	\N	\N	35168
11334	E450	354	Lenovo Thinkpad E450	\N	E450	\N	\N	\N	35169
11335	E450	354	Lenovo Thinkpad E450	\N	E450	\N	\N	\N	35170
11336	E16	437	Not Available	21JN003YUS	\N	E16	\N	\N	35171
11337	UNKNOWN	\N	Lenovo ThinkPad P17	\N	\N	\N	\N	\N	35172
11338	T14s	419	Lenovo ThinkPad T14s	THINKPAD P14S	T14s	\N	\N	\N	35173
11339	P14s Gen 1	514	Lenovo P14s Gen 1	\N	P14s Gen 1	\N	\N	\N	35174
11340	T15	420	\N	\N	\N	T15	\N	\N	35175
11341	E14	424	Lenovo ThinkPad E14 Gen 6	21M3000PUS	E14	\N	\N	\N	35176
11342	P14s Gen 2	515	Lenovo P14S Gen 2	\N	P14s Gen 2	\N	\N	\N	35177
11343	P14s Gen 2	515	Lenovo P14S Gen 2	\N	P14s Gen 2	\N	\N	\N	35178
11344	T15	420	\N	\N	\N	T15	\N	\N	35179
11345	X1 Yoga	542	Lenovo ThinkPad X1 Yoga	\N	X1 Yoga	\N	\N	\N	35180
11346	X1 Yoga	542	Lenovo ThinkPad X1 Yoga	\N	X1 Yoga	\N	\N	\N	35181
11347	T15	420	\N	\N	\N	T15	\N	\N	35182
11348	X1 Yoga	542	Lenovo ThinkPad X1 Yoga	\N	X1 Yoga	\N	\N	\N	35183
11349	T480	384	Lenovo ThinkPad T480	\N	T480	\N	\N	\N	35184
11350	T430	319	\N	\N	\N	T430	\N	\N	35185
11351	T480	384	Libreboot T480	T580	T480	\N	\N	\N	35186
11352	X1 Carbon	327	Lenovo ThinkPad X1 Carbon 9th Gen	20XW004DUS	X1 Carbon	\N	\N	\N	35187
11353	X1 Carbon	327	ThinkPad X1 Carbon (1st Gen)	NA	X1 Carbon	\N	\N	\N	35188
11354	P14s	435	Lenovo ThinkPad P14s Gen 5	\N	P14s	\N	\N	\N	35189
11355	X13	421	Lenovo ThinkPad X13 2-in-1 Gen 5	\N	X13	\N	\N	\N	35190
11356	L14 Gen 1	504	Lenovo L14 Gen 1	ThinkPad L14 Gen 1	L14 Gen 1	\N	\N	\N	35191
11357	T14	418	Lenovo ThinkPad T14 G5	\N	T14	\N	\N	\N	35192
11358	P16 Gen 2	519	Lenovo ThinkPad P16 Gen 2	21FA002TUS	P16 Gen 2	\N	\N	\N	35193
11359	UNKNOWN	\N	21FA002TUS+QQ2-00021	21FA002TUS+QQ2-00021	\N	\N	\N	\N	35194
11360	E14	424	21SX0038US	21SX0038US	\N	E14	\N	\N	35195
11361	T14 Gen 5	556	21MC000KUS	21MC000KUS	\N	T14 Gen 5	\N	\N	35196
11362	T480s	385	Lenovo ThinkPad T480s	ThinkPad T480S	T480s	\N	\N	\N	35197
11363	P14s	435	ThinkPad P14s Gen 6	21QL	P14s	\N	\N	\N	35198
11364	340	35	Lenovo Yoga 7	83JR0002US	\N	340	\N	\N	35199
11365	T480s	385	Lenovo ThinkPad T480s	ThinkPad T480S	T480s	\N	\N	\N	35200
11366	UNKNOWN	\N	V15 G2 ITL	82KB00C3US	\N	\N	\N	\N	35201
11367	X1	304	Lenovo ThinkPad X1	ThinkPad X1 Tablet Gen 3	X1	\N	\N	\N	35202
11368	X1 Carbon Gen 8	485	Lenovo ThinkPad X1 Carbon Gen 8	X1 Carbon Gen 8	X1 Carbon Gen 8	\N	\N	\N	35203
11369	UNKNOWN	\N	Lenovo ThinkPad X12 Detachable	\N	\N	\N	\N	\N	35204
11370	UNKNOWN	\N	Lenovo Yoga 710	71015IKB	\N	\N	\N	\N	35205
11371	X1	304	ThinkPad X1 2-in-1 Gen 10	21NU	X1	\N	\N	\N	35206
11372	X280	388	NA	NA	\N	X280	\N	\N	35298
11373	X1 Carbon	327	THINKPAD X1 CARBON (9TH GEN)	\N	X1 Carbon	\N	\N	\N	35207
11374	T15	420	Lenovo Thinkpad T15 G1	\N	T15	\N	\N	\N	35208
11375	T14	418	Lenovo ThinkPad T14 G3	\N	T14	\N	\N	\N	35209
11376	T14	418	Lenovo Thinkpad T14 G1	\N	T14	\N	\N	\N	35210
11377	T14	418	Lenovo Thinkpad T14 G1	\N	T14	\N	\N	\N	35211
11378	X1 Carbon	327	THINKPAD X1 CARBON (9TH GEN)	\N	X1 Carbon	\N	\N	\N	35212
11379	T14	418	Lenovo ThinkPad T14	20XK0016US	T14	\N	\N	\N	35213
11380	T410	267	Lenovo ThinkPad T410	T410	T410	\N	\N	\N	35214
11381	X1 Carbon Gen 10	487	Lenovo ThinkPad X1 Carbon Gen 10	21CB000CUS	X1 Carbon Gen 10	\N	\N	\N	35215
11382	X1 Yoga	542	Lenovo ThinkPad X1 Yoga (3rd Gen)	x1, Yoga, ThinkPad X1 Yoga 3rd Gen, X1 YOGA	X1 Yoga	\N	\N	\N	35216
11383	E14 Gen 2	523	Lenovo E14 Gen 2	\N	E14 Gen 2	\N	\N	\N	35217
11384	T470	370	Lenovo ThinkPad T470	\N	T470	\N	\N	\N	35218
11385	T480s	385	Lenovo ThinkPad T480s	ThinkPad T480S	T480s	\N	\N	\N	35219
11386	T480s	385	Lenovo ThinkPad T480s	ThinkPad T480S	T480s	\N	\N	\N	35220
11387	T480s	385	Lenovo ThinkPad T480s	ThinkPad T480S	T480s	\N	\N	\N	35221
11388	X1	304	Lenovo ThinkPad X1	\N	X1	\N	\N	\N	35222
11389	X1 Carbon	327	Lenovo ThinkPad X1 Carbon G9	\N	X1 Carbon	\N	\N	\N	35223
11390	T14	418	Lenovo Thinkpad T14 G1	\N	T14	\N	\N	\N	35224
11391	UNKNOWN	\N	Lenovo ThinkPad X9-14 G1	\N	\N	\N	\N	\N	35225
11392	T15	420	Lenovo Thinkpad T15 G1	\N	T15	\N	\N	\N	35226
11393	T14s	419	Lenovo ThinkPad T14s Gen 1	\N	T14s	\N	\N	\N	35227
11394	T14	418	Lenovo ThinkPad T14 G1	\N	T14	\N	\N	\N	35228
11395	T14	418	Lenovo ThinkPad T14 G1	\N	T14	\N	\N	\N	35229
11396	T14	418	Lenovo ThinkPad T14 G1	\N	T14	\N	\N	\N	35230
11397	X1 Carbon	327	Lenovo ThinkPad X1 Carbon G13	\N	X1 Carbon	\N	\N	\N	35231
11398	L13 Yoga	427	Lenovo ThinkPad L13 Yoga Gen 4	\N	L13 Yoga	\N	\N	\N	35232
11399	L13	426	Lenovo ThinkPad L13 G4	\N	L13	\N	\N	\N	35233
11400	X13	421	Lenovo ThinkPad X13 G4	\N	X13	\N	\N	\N	35234
11401	UNKNOWN	\N	Lenovo 14W G2 DualCore AMD	\N	\N	\N	\N	\N	35235
11402	X1 Carbon	327	Lenovo ThinkPad X1 Carbon G13	\N	X1 Carbon	\N	\N	\N	35236
11403	UNKNOWN	\N	Lenovo IdeaPad 17IIL05	81wf000hus	\N	\N	\N	\N	35237
11404	UNKNOWN	\N	Lenovo Flex 5	IdeaPad 330S-15IKB 81F5	\N	\N	\N	\N	35238
11405	UNKNOWN	\N	IdeaPad Slim 3	\N	\N	\N	\N	\N	35239
11406	X13	421	Lenovo X13	\N	X13	\N	\N	\N	35240
11407	X1	304	Lenovo ThinkPad X1	\N	X1	\N	\N	\N	35241
11408	L13	426	THINKPAD L13 GEN2	THINKPAD L13 GEN2	L13	\N	\N	\N	35242
11409	P1	398	Lenovo ThinkPad P1 Gen 7	21FV001PUS	P1	\N	\N	\N	35243
11410	Twist	329	lenovo twist	33474HU	Twist	\N	\N	\N	35244
11411	T14s	419	Lenovo ThinkPad T14s	T14S	T14s	\N	\N	\N	35245
11412	UNKNOWN	\N	ThinkPad	\N	\N	\N	\N	\N	35246
11413	T14s	419	Lenovo ThinkPad T14s	\N	T14s	\N	\N	\N	35247
11414	P1	398	\N	\N	\N	P1	\N	\N	35248
11415	E14	424	Thinkpad E14 G2	20TA004GUS	E14	\N	\N	\N	35249
11416	350	11	Lenovo P16s Gen 4	21QR0024US	\N	350	\N	\N	35250
11417	T14s	419	Lenovo ThinkPad T14s	ThinkPad T14s Gen2, THINKPAD T14S GEN 2	T14s	\N	\N	\N	35251
11418	E14	424	\N	21sx0038us	\N	E14	\N	\N	35252
11419	E14	424	Thinkpad E14 G2	20TA004GUS	E14	\N	\N	\N	35253
11420	UNKNOWN	\N	Lenovo T16 Gen 4	ThinkPad T16 Gen 4, 21QE007TUS	\N	\N	\N	\N	35254
11421	T420	290	Lenovo ThinkPad T420	T420	T420	\N	\N	\N	35255
11422	T14 Gen 2	458	Lenovo ThinkPad T14 Gen 2	\N	T14 Gen 2	\N	\N	\N	35256
11423	P1	398	Lenovo ThinkPad P1 Gen 7 21KV	\N	P1	\N	\N	\N	35257
11424	UNKNOWN	\N	Lenovo ThinkPad X12 Detachable 20UW	\N	\N	\N	\N	\N	35258
11425	T14 Gen 5	556	Lenovo ThinkPad T14 Gen 5	THINKPAD T14 GEN 5	T14 Gen 5	\N	\N	\N	35259
11426	L14	428	Lenovo ThinkPad L14 Gen 5	\N	L14	\N	\N	\N	35260
11427	P14s	435	Lenovo ThinkPad P14s Gen 5	\N	P14s	\N	\N	\N	35261
11428	T14	418	Lenovo ThinkPad T14 G1	\N	T14	\N	\N	\N	35262
11429	T14	418	Lenovo Thinkpad T14 G1	\N	T14	\N	\N	\N	35263
11430	T14	418	Lenovo Thinkpad T14 G1	\N	T14	\N	\N	\N	35264
11431	X1 Carbon	327	Lenovo ThinkPad X1 Carbon G9	\N	X1 Carbon	\N	\N	\N	35265
11432	T14s	419	Lenovo Thinkpad T14s G1	\N	T14s	\N	\N	\N	35266
11433	T14 Gen 4	460	\N	\N	\N	T14 Gen 4	\N	\N	35267
11434	T14	418	Lenovo Thinkpad T14 G1	\N	T14	\N	\N	\N	35268
11435	UNKNOWN	\N	Lenovo ThinkPad X9-14 G1	\N	\N	\N	\N	\N	35269
11436	T14	418	Lenovo Thinkpad T14 G1	\N	T14	\N	\N	\N	35270
11437	E15	425	ThinkPad E15 TP0117A	\N	E15	\N	\N	\N	35271
11438	E15	425	ThinkPad E15 TP0117A	\N	E15	\N	\N	\N	35272
11439	X280	388	NA	NA	\N	X280	\N	\N	35273
11440	X280	388	NA	NA	\N	X280	\N	\N	35274
11441	X270	377	ThinkPad X270	NA	X270	\N	\N	\N	35275
11442	X280	388	NA	NA	\N	X280	\N	\N	35276
11443	L13	426	ThinkPad L13	NA	L13	\N	\N	\N	35277
11444	T430s	320	ThinkPad T430s	NA	T430s	\N	\N	\N	35278
11445	X13 Gen 2	475	ThinkPad X13 Gen 2	NA	X13 Gen 2	\N	\N	\N	35279
11446	E480	387	ThinkPad E480	NA	E480	\N	\N	\N	35280
11447	T14 Gen 2	458	T14 Gen 2	NA	T14 Gen 2	\N	\N	\N	35281
11448	X250	356	NA	NA	\N	X250	\N	\N	35282
11449	E590	405	ThinkPad E590	NA	E590	\N	\N	\N	35283
11450	L15	429	ThinkPad L15 Gen1	NA	L15	\N	\N	\N	35284
11451	T14s	419	ThinkPad T14s Gen 1	NA	T14s	\N	\N	\N	35285
11452	E15	425	ThinkPad E15 (20RES3LW00)	NA	E15	\N	\N	\N	35286
11453	P1	398	NA	NA	\N	P1	\N	\N	35287
11454	L14	428	ThinkPad L14 Gen3	NA	L14	\N	\N	\N	35288
11455	L13	426	NA	NA	\N	L13	\N	\N	35289
11456	X1 Carbon	327	ThinkPad X1 Carbon Gen9	NA	X1 Carbon	\N	\N	\N	35290
11457	L590	411	Not specified	NA	\N	L590	\N	\N	35291
11458	T14	418	ThinkPad T14 Gen2	NA	T14	\N	\N	\N	35292
11459	L13 Gen 2	502	NA	NA	\N	L13 Gen 2	\N	\N	35293
11460	L13	426	Not specified	NA	\N	L13	\N	\N	35294
11461	L570	383	L570	NA	L570	\N	\N	\N	35295
11462	T495	406	Lenovo Thinkpad T495	\N	T495	\N	\N	\N	35296
11463	L13	426	L13 GEN3	NA	L13	\N	\N	\N	35297
11464	E14 Gen 2	523	ThinkPad E14 Gen 2	NA	E14 Gen 2	\N	\N	\N	35299
11465	L390	430	ThinkPad L390	NA	L390	\N	\N	\N	35300
11466	X13	421	ThinkPad X13	NA	X13	\N	\N	\N	35301
11467	UNKNOWN	\N	Lenovo Yoga	C94014IIL	\N	\N	\N	\N	35302
11468	P1	398	Lenovo thinkpad p1 Gen 7	21KV0000US	P1	\N	\N	\N	35303
11469	T420	290	Lenovo ThinkPad T420	T420	T420	\N	\N	\N	35304
11470	E14 Gen 2	523	ThinkPad E14 Gen 2	LE31945C-B	E14 Gen 2	\N	\N	\N	35305
11471	T43	213	IBM ThinkPad T43	\N	T43	\N	\N	\N	35306
11472	E15	425	ThinkPad E15 G4	\N	E15	\N	\N	\N	35307
11473	T490	400	Lenovo T490	THINKPAD T490	T490	\N	\N	\N	35308
11474	X1	304	Lenovo ThinkPad X1	21NS0014US	X1	\N	\N	\N	35309
11475	UNKNOWN	\N	Lenovo ThnkBook 15 IIL	\N	\N	\N	\N	\N	35310
11476	T14s	419	ThinkPad T14s Gen 1	\N	T14s	\N	\N	\N	35311
11477	T420	290	Lenovo ThinkPad T420	T420	T420	\N	\N	\N	35312
11478	T14	418	Lenovo Thinkpad T14 G1	\N	T14	\N	\N	\N	35313
11479	UNKNOWN	\N	Lenovo Chromebook Duet 11M889	\N	\N	\N	\N	\N	35314
11480	L13 Yoga	427	Lenovo ThinkPad L13 Yoga Gen 4	\N	L13 Yoga	\N	\N	\N	35315
11481	UNKNOWN	\N	Lenovo IdeaPad 5 2-in-1 16IRU9	\N	\N	\N	\N	\N	35316
11482	UNKNOWN	\N	Lenovo IdeaPad Slim 3 14IRU8	\N	\N	\N	\N	\N	35317
11483	P14s	435	Lenovo ThinkPad P14s G4	\N	P14s	\N	\N	\N	35318
11484	P16 Gen 2	519	Lenovo ThinkPad P16 Gen 2	\N	P16 Gen 2	\N	\N	\N	35319
11485	P16	518	Lenovo ThinkPad P16 G1	\N	P16	\N	\N	\N	35320
11486	UNKNOWN	\N	Lenovo ThinkPad L16 Gen 1	\N	\N	\N	\N	\N	35321
11487	UNKNOWN	\N	Lenovo ThinkPad L16 Gen 1	\N	\N	\N	\N	\N	35322
11488	X1 Yoga	542	Lenovo ThinkPad X1 Yoga G6	\N	X1 Yoga	\N	\N	\N	35323
11489	T14	418	Lenovo Thinkpad T14 G2	\N	T14	\N	\N	\N	35324
11490	UNKNOWN	\N	Lenovo ThinkPad T16 Gen 4	\N	\N	\N	\N	\N	35325
11491	T14	418	Lenovo ThinkPad T14 G1	\N	T14	\N	\N	\N	35326
11492	T14	418	Lenovo Thinkpad T14 G1	\N	T14	\N	\N	\N	35327
11493	T14 Gen 3	459	See Title/Description	See Title/Description	\N	T14 Gen 3	\N	\N	35328
11494	E14	424	Thinkpad E14 G2	20TA004GUS	E14	\N	\N	\N	35329
11495	T14	418	Lenovo Thinkpad T14 G1	\N	T14	\N	\N	\N	35330
11496	T14	418	Lenovo Thinkpad T14 G1	\N	T14	\N	\N	\N	35331
11497	UNKNOWN	\N	Lenovo Yoga Slim 7i Aura Edition	MPNXB55130AM	\N	\N	\N	\N	35332
11498	T14	418	Lenovo ThinkPad T14 G1	\N	T14	\N	\N	\N	35333
11499	T14	418	Lenovo Thinkpad T14 G2	\N	T14	\N	\N	\N	35334
11500	X1 Carbon	327	Lenovo ThinkPad X1 Carbon G9	\N	X1 Carbon	\N	\N	\N	35335
11501	T14	418	Lenovo Thinkpad T14 G1	\N	T14	\N	\N	\N	35336
11502	T14	418	Lenovo ThinkPad T14 G1	\N	T14	\N	\N	\N	35337
11503	T15	420	Lenovo Thinkpad T15 G1	\N	T15	\N	\N	\N	35338
11504	T14	418	Lenovo Thinkpad T14 G1	\N	T14	\N	\N	\N	35339
11505	T15	420	Lenovo Thinkpad T15 G1	\N	T15	\N	\N	\N	35340
11506	T14	418	Lenovo ThinkPad T14 G1	\N	T14	\N	\N	\N	35341
11507	UNKNOWN	\N	Lenovo Chromebook Duet 11M889	\N	\N	\N	\N	\N	35342
11508	L13 Yoga	427	Lenovo ThinkPad L13 Yoga Gen 2	\N	L13 Yoga	\N	\N	\N	35343
11509	T560	362	Lenovo ThinkPad T560	THINKPAD T560	T560	\N	\N	\N	35344
11510	X1 Carbon	327	Lenovo ThinkPad X1 Carbon Gen 12	21HM002FUS	X1 Carbon	\N	\N	\N	35345
11511	UNKNOWN	\N	Radeon	Lenovo Y40-70	\N	\N	\N	\N	35346
11512	T460s	360	Lenovo ThinkPad T460S	\N	T460s	\N	\N	\N	35347
11513	UNKNOWN	\N	\N	21KS0027US	\N	\N	\N	\N	35348
11514	UNKNOWN	\N	\N	21RS0024US	\N	\N	\N	\N	35349
11515	T14s	419	Lenovo Thinkpad T14s G2	\N	T14s	\N	\N	\N	35350
11516	T14s	419	Lenovo Thinkpad T14s G2	\N	T14s	\N	\N	\N	35351
11517	T14	418	Lenovo ThinkPad T14 G1	\N	T14	\N	\N	\N	35352
11518	UNKNOWN	\N	Lenovo IdeaPad Gaming 3 15ACH6	15ACH6	\N	\N	\N	\N	35353
11519	UNKNOWN	\N	ThinkPad 11e Yoga Gen 6	\N	\N	\N	\N	\N	35354
11520	T43	213	IBM ThinkPad T43	THINKPAD T43	T43	\N	\N	\N	35355
11521	T14 Gen 3	459	See Title/Description	See Title/Description	\N	T14 Gen 3	\N	\N	35356
11522	T14	418	Lenovo ThinkPad T14 G2	20W0003KUS	T14	\N	\N	\N	35357
11523	P16 Gen 2	519	Lenovo ThinkPad P16 Gen 2	21FBS2UX00	P16 Gen 2	\N	\N	\N	35358
11524	T480	384	Lenovo T480	\N	T480	\N	\N	\N	35359
11525	UNKNOWN	\N	IdeaPad S340-81N8	\N	\N	\N	\N	\N	35360
11526	UNKNOWN	\N	Lenovo ThinkPad P15v	\N	\N	\N	\N	\N	35361
11527	UNKNOWN	\N	16iru9	16IRU9	\N	\N	\N	\N	35362
11528	P43s	415	Lenovo P43s	\N	P43s	\N	\N	\N	35363
11529	P53s	414	Lenovo ThinkPad P53s	\N	P53s	\N	\N	\N	35364
11530	E15 Gen 2	526	ThinkPad E15 Gen 2	20TD-003KUS	E15 Gen 2	\N	\N	\N	35365
11531	T440p	343	Lenovo T440P	\N	T440p	\N	\N	\N	35366
11532	X1 Yoga	542	Lenovo ThinkPad X1 Yoga Gen 10 G10	\N	X1 Yoga	\N	\N	\N	35367
11533	T480	384	Lenovo ThinkPad T480	\N	T480	\N	\N	\N	35368
11534	ThinkPad 13	534	Lenovo ThinkPad 13	\N	ThinkPad 13	\N	\N	\N	35369
11535	P15	516	Lenovo Thinkpad P15	\N	P15	\N	\N	\N	35370
11536	X1 Carbon Gen 10	487	Lenovo X1CARBON	NAX1 CARBON	\N	X1 Carbon Gen 10	\N	\N	35371
11537	L13 Yoga	427	Lenovo ThinkPad L13 Yoga	\N	L13 Yoga	\N	\N	\N	35372
11538	T440	341	Lenovo ThinkPad T440	\N	T440	\N	\N	\N	35373
11539	X1 Yoga	542	Lenovo ThinkPad X1 Yoga	\N	X1 Yoga	\N	\N	\N	35374
11540	T480s	385	Lenovo ThinkPad T480s	\N	T480s	\N	\N	\N	35375
11541	T480s	385	Lenovo ThinkPad T480s	\N	T480s	\N	\N	\N	35376
11542	T480s	385	Lenovo ThinkPad T480s	\N	T480s	\N	\N	\N	35377
11543	T480s	385	Lenovo ThinkPad T480s	\N	T480s	\N	\N	\N	35378
11544	L13	426	Lenovo ThinkPad L13	\N	L13	\N	\N	\N	35379
11545	T495	406	Thinkpad T495	\N	T495	\N	\N	\N	35380
11546	T430	319	Lenovo ThinkPad T430	\N	T430	\N	\N	\N	35381
11547	T61	236	Lenovo ThinkPad T61	\N	T61	\N	\N	\N	35382
11548	X1 Yoga	542	Lenovo ThinkPad X1 Yoga	21CD0032UK	X1 Yoga	\N	\N	\N	35383
11549	P1	398	Lenovo ThinkPad P1 Gen 6	\N	P1	\N	\N	\N	35384
11550	P1	398	Lenovo ThinkPad P1	\N	P1	\N	\N	\N	35385
11551	X240	347	Lenovo ThinkPad X240	\N	X240	\N	\N	\N	35386
11552	UNKNOWN	\N	Lenovo Thinkpad X13s	21EYS5MU00	\N	\N	\N	\N	35387
11553	X13 Gen 1	474	Lenovo X13 Gen 1	\N	X13 Gen 1	\N	\N	\N	35388
11554	T490	400	Lenovo Thinkpad T490	Lenovo ThinkPad T480	T490	\N	\N	\N	35389
11555	T460s	360	Lenovo ThinkPad T460S	\N	T460s	\N	\N	\N	35390
11556	L15	429	ThinkPad L15	20U3	L15	\N	\N	\N	35391
11557	X13	421	ThinkPad X13 Gen 5	21LU0025UK	X13	\N	\N	\N	35392
11558	T14s	419	Lenovo ThinkPad T14s	\N	T14s	\N	\N	\N	35393
11680	X250	356	Lenovo ThinkPad X250	\N	X250	\N	\N	\N	35515
11559	X13 Yoga	422	Lenovo ThinkPad X13 Yoga	\N	X13 Yoga	\N	\N	\N	35394
11560	UNKNOWN	\N	Lenovo ThinkPad P15v	\N	\N	\N	\N	\N	35395
11561	X201	277	x201	\N	X201	\N	\N	\N	35396
11562	X1 Yoga	542	Lenovo ThinkPad X1 Yoga	21CD0032UK	X1 Yoga	\N	\N	\N	35397
11563	UNKNOWN	\N	ThinkPad Yoga 460	TP00079A	\N	\N	\N	\N	35398
11564	X1 Carbon	327	Lenovo ThinkPad X1 Carbon 3rd Gen	\N	X1 Carbon	\N	\N	\N	35399
11565	X240	347	Lenovo ThinkPad X240	X240	X240	\N	\N	\N	35400
11566	X1 Carbon	327	Lenovo ThinkPad X1 Carbon 9th Gen	\N	X1 Carbon	\N	\N	\N	35401
11567	X13	421	Lenovo ThinkPad X13	\N	X13	\N	\N	\N	35402
11568	L13	426	Lenovo Thinkpad L13	\N	L13	\N	\N	\N	35403
11569	P53s	414	Lenovo ThinkPad P53s	\N	P53s	\N	\N	\N	35404
11570	T450	349	ThinkPad T450	\N	T450	\N	\N	\N	35405
11571	L490	410	Lenovo L490	20Q5S18N00	L490	\N	\N	\N	35406
11572	X131e	432	Lenovo ThinkPad X131e	\N	X131e	\N	\N	\N	35407
11573	T14 Gen 5	556	ThinkPad T14 Gen 5	21MMS2Ce0N	T14 Gen 5	\N	\N	\N	35408
11574	X1	304	Lenovo Thinkpad X1 Titanium	\N	X1	\N	\N	\N	35409
11575	T470s	371	\N	\N	\N	T470s	\N	\N	35410
11576	UNKNOWN	\N	V14-IIL	Does Not Apply, 82C401FFUS	\N	\N	\N	\N	35411
11577	L430	323	Lenovo Thinkpad L430	\N	L430	\N	\N	\N	35412
11578	E14	424	Lenovo ThinkPad E14 2nd Gen	\N	E14	\N	\N	\N	35413
11579	X230	325	Lenovo ThinkPad X230	\N	X230	\N	\N	\N	35414
11580	E14	424	ThinkPad E14 Gen 5	\N	E14	\N	\N	\N	35415
11581	X1 Yoga	542	Lenovo ThinkPad X1 Yoga	\N	X1 Yoga	\N	\N	\N	35416
11582	T14s	419	Lenovo ThinkPad T14s Gen 1	20T1S4322L	T14s	\N	\N	\N	35417
11583	P53	413	Lenovo ThinkPad P53	20QQ-S2U300	P53	\N	\N	\N	35418
11584	X1	304	Lenovo ThinkPad X1	\N	X1	\N	\N	\N	35419
11585	X1	304	Lenovo ThinkPad X1	\N	X1	\N	\N	\N	35420
11586	T450	349	ThinkPad T450	\N	T450	\N	\N	\N	35421
11587	X280	388	Lenovo ThinkPad X280	ThinkPad X280	X280	\N	\N	\N	35422
11588	X270	377	Lenovo ThinkPad X270	\N	X270	\N	\N	\N	35423
11589	T430	319	Lenovo ThinkPad T430	\N	T430	\N	\N	\N	35424
11590	T480	384	Lenovo ThinkPad T480	\N	T480	\N	\N	\N	35425
11591	T480	384	Lenovo ThinkPad T480	\N	T480	\N	\N	\N	35426
11592	X230	325	Lenovo ThinkPad X230	X230	X230	\N	\N	\N	35427
11593	X1	304	Lenovo ThinkPad X1	\N	X1	\N	\N	\N	35428
11594	P1	398	Lenovo ThinkPad P1	\N	P1	\N	\N	\N	35429
11595	P1	398	Lenovo ThinkPad P1	\N	P1	\N	\N	\N	35430
11596	T490	400	Lenovo ThinkPad T490	\N	T490	\N	\N	\N	35431
11597	T490	400	Lenovo ThinkPad T490	\N	T490	\N	\N	\N	35432
11598	X1 Carbon	327	Lenovo ThinkPad X1 Carbon 8th Gen	\N	X1 Carbon	\N	\N	\N	35433
11599	X13 Gen 1	474	Lenovo X13 Gen 1	20T2	X13 Gen 1	\N	\N	\N	35434
11600	X230	325	Lenovo ThinkPad X230	\N	X230	\N	\N	\N	35435
11601	E14 Gen 2	523	\N	\N	\N	E14 Gen 2	\N	\N	35436
11602	X1 Yoga	542	Lenovo ThinkPad X1 Yoga	21CES2DM00	X1 Yoga	\N	\N	\N	35437
11603	X1 Carbon	327	Lenovo ThinkPad X1 Carbon Gen8	\N	X1 Carbon	\N	\N	\N	35438
11604	X13 Gen 4	477	Lenovo ThinkPad X13 Gen 4	21EYS5MU00	X13 Gen 4	\N	\N	\N	35439
11605	X1 Yoga	542	Lenovo ThinkPad X1 Yoga	21CD0032UK	X1 Yoga	\N	\N	\N	35440
11606	T430	319	Lenovo ThinkPad T430	\N	T430	\N	\N	\N	35441
11607	X230	325	X230	\N	X230	\N	\N	\N	35442
11608	T440p	343	Lenovo ThinkPad T440P	\N	T440p	\N	\N	\N	35443
11609	T14 Gen 2	458	Lenovo ThinkPad T14 Gen 2	\N	T14 Gen 2	\N	\N	\N	35444
11610	E14 Gen 3	524	\N	\N	\N	E14 Gen 3	\N	\N	35445
11611	L14 Gen 2	505	\N	\N	\N	L14 Gen 2	\N	\N	35446
11612	T14s	419	Lenovo ThinkPad T14s Gen 2	\N	T14s	\N	\N	\N	35447
11613	X260	366	Lenovo ThinkPad X260	\N	X260	\N	\N	\N	35448
11614	T14s	419	Lenovo ThinkPad T14s Gen 3	\N	T14s	\N	\N	\N	35449
11615	UNKNOWN	\N	Lenovo Thinkpad Edge	\N	\N	\N	\N	\N	35450
11616	L390	430	\N	\N	\N	L390	\N	\N	35451
11617	L390	430	\N	\N	\N	L390	\N	\N	35452
11618	L480	389	\N	\N	\N	L480	\N	\N	35453
11619	X13 Gen 4	477	Lenovo ThinkPad X13 Gen 4	21EX002XUK	X13 Gen 4	\N	\N	\N	35454
11620	X1 Yoga	542	ThinkPad X1 Yoga 5th Gen	20UCS0YB0E	X1 Yoga	\N	\N	\N	35455
11621	X230	325	Lenovo ThinkPad X230	\N	X230	\N	\N	\N	35456
11622	L480	389	\N	\N	\N	L480	\N	\N	35457
11623	L490	410	\N	\N	\N	L490	\N	\N	35458
11624	T580	386	\N	\N	\N	T580	\N	\N	35459
11625	L480	389	\N	\N	\N	L480	\N	\N	35460
11626	L480	389	\N	\N	\N	L480	\N	\N	35461
11627	L380 Yoga	392	\N	\N	\N	L380 Yoga	\N	\N	35462
11628	L480	389	\N	\N	\N	L480	\N	\N	35463
11629	L480	389	\N	\N	\N	L480	\N	\N	35464
11630	L14 Gen 1	504	\N	\N	\N	L14 Gen 1	\N	\N	35465
11631	L380 Yoga	392	\N	\N	\N	L380 Yoga	\N	\N	35466
11632	L14 Gen 1	504	\N	\N	\N	L14 Gen 1	\N	\N	35467
11633	L13 Yoga	427	Lenovo ThinkPad L13 Yoga	\N	L13 Yoga	\N	\N	\N	35468
11634	T430	319	Lenovo ThinkPad T430	2349-PZG	T430	\N	\N	\N	35469
11635	T450	349	ThinkPad T450	\N	T450	\N	\N	\N	35470
11636	L14	428	Everyday Laptops	21L2S88900	\N	L14	\N	\N	35471
11637	T440	341	Lenovo ThinkPad T440	20B7A1P700	T440	\N	\N	\N	35472
11638	Yoga 11e	551	Lenovo Thinkpad Yoga 11e	YOGA 11E	Yoga 11e	\N	\N	\N	35473
11639	X1	304	Lenovo ThinkPad Carbon X1 Gen 9	\N	X1	\N	\N	\N	35474
11640	P14s	435	P14s	\N	P14s	\N	\N	\N	35475
11641	E560	369	Lenovo ThinkPad E560	\N	E560	\N	\N	\N	35476
11642	L440	337	Lenovo Thinkpad L440	\N	L440	\N	\N	\N	35477
11643	T460	359	Lenovo ThinkPad T460	\N	T460	\N	\N	\N	35478
11644	T14s	419	Lenovo ThinkPad T14s	\N	T14s	\N	\N	\N	35479
11645	E14	424	\N	\N	\N	E14	\N	\N	35480
11646	UNKNOWN	\N	Lenovo ThinkPad E585	\N	\N	\N	\N	\N	35481
11647	UNKNOWN	\N	\N	\N	\N	\N	\N	\N	35482
11648	T495	406	Lenovo T495-Ryzen 7 Pro	LENOVO THINKPAD T495	T495	\N	\N	\N	35483
11649	X1 Yoga	542	Lenovo ThinkPad X1 Yoga Gen 7	\N	X1 Yoga	\N	\N	\N	35484
11650	X1	304	Lenovo ThinkPad X1	20KGSAH900	X1	\N	\N	\N	35485
11651	500	13	Lenovo p16s gen 3	\N	\N	500	\N	\N	35486
11652	UNKNOWN	\N	Lenovo ThinkPad L16 Gen 2	21SC0006UK	\N	\N	\N	\N	35487
11653	T14s	419	\N	21TB002CUK	\N	T14s	\N	\N	35488
11654	P16	518	\N	21RQ000FUK	\N	P16	\N	\N	35489
11655	350	11	\N	21QR0058UK	\N	350	\N	\N	35490
11656	350	11	\N	21QR0057UK	\N	350	\N	\N	35491
11657	P14s	435	\N	21QL006PUK	\N	P14s	\N	\N	35492
11658	P14s	435	\N	21QL006NUK	\N	P14s	\N	\N	35493
11659	X13 Yoga	422	Lenovo ThinkPad X13 Yoga Gen 2	\N	X13 Yoga	\N	\N	\N	35494
11660	L450	357	Lenovo Thinkpad L450	\N	L450	\N	\N	\N	35495
11661	L14	428	\N	21S8003SUK	\N	L14	\N	\N	35496
11662	X1 Yoga Gen 4	492	X1 Yoga Gen 4	\N	X1 Yoga Gen 4	\N	\N	\N	35497
11663	X1 Yoga	542	ThinkPad X1 Yoga 6th Gen	20Y0S1KC1S	X1 Yoga	\N	\N	\N	35498
11664	P1	398	Lenovo ThinkPad P1 Gen 6	21FV0011UK	P1	\N	\N	\N	35499
11665	P52	393	Lenovo ThinkPad P52	20MAS16U00	P52	\N	\N	\N	35500
11666	T14 Gen 2	458	Lenovo ThinkPad T14 Gen 2	20W1S2TW2E	T14 Gen 2	\N	\N	\N	35501
11667	X1 Yoga	542	ThinkPad X1 Yoga 6th Gen	20Y0S1KC1K	X1 Yoga	\N	\N	\N	35502
11668	X1 Yoga Gen 4	492	X1 YOGA Gen 4	\N	X1 Yoga Gen 4	\N	\N	\N	35503
11669	T470s	371	Lenovo ThinkPad T470S	T470S	T470s	\N	\N	\N	35504
11670	T570	373	Lenovo ThinkPad T570	\N	T570	\N	\N	\N	35505
11671	T480	384	Lenovo ThinkPad T480	\N	T480	\N	\N	\N	35506
11672	T490	400	Thinkpad T490	T490	T490	\N	\N	\N	35507
11673	X13 Yoga	422	Lenovo ThinkPad X13 Yoga	\N	X13 Yoga	\N	\N	\N	35508
11674	T14	418	Lenovo ThinkPad T14	T14 G1	T14	\N	\N	\N	35509
11675	T14	418	Lenovo ThinkPad T14	\N	T14	\N	\N	\N	35510
11676	T14	418	Lenovo ThinkPad T14	\N	T14	\N	\N	\N	35511
11677	UNKNOWN	\N	THINKPAD C13 YOGA GEN1 CHROMEBOOK	\N	\N	\N	\N	\N	35512
11678	T570	373	Lenovo ThinkPad T570	\N	T570	\N	\N	\N	35513
11679	UNKNOWN	\N	ZBook Studio G11	B17GTUC	\N	\N	\N	\N	35514
11681	ThinkPad 13	534	Lenovo 13 2nd Gen	\N	\N	ThinkPad 13	\N	\N	35516
11682	P15	516	ThinkPad P15 Gen 1	20ST001BUK	P15	\N	\N	\N	35517
11683	T14s	419	Lenovo ThinkPad T14s	\N	T14s	\N	\N	\N	35518
11684	X13	421	Lenovo Thinkpad X13	21LVS7D900	X13	\N	\N	\N	35519
11685	L13 Yoga	427	Lenovo ThinkPad L13 Yoga	\N	L13 Yoga	\N	\N	\N	35520
11686	T480	384	Lenovo ThinkPad T480	\N	T480	\N	\N	\N	35521
11687	T23	183	IBM T23	\N	T23	\N	\N	\N	35522
11688	X13 Yoga	422	Lenovo ThinkPad X13 Yoga	X13 YOGA	X13 Yoga	\N	\N	\N	35523
11689	X1	304	Lenovo ThinkPad X1	\N	X1	\N	\N	\N	35524
11690	UNKNOWN	\N	Lenovo Thinkpad C13 Yoga	\N	\N	\N	\N	\N	35525
11691	X1	304	Lenovo ThinkPad X1	\N	X1	\N	\N	\N	35526
11692	L13 Yoga	427	\N	\N	\N	L13 Yoga	\N	\N	35527
11693	L13 Yoga	427	Lenovo ThinkPad L13 Yoga	REFURBISHED LAPTOPS	L13 Yoga	\N	\N	\N	35528
11694	X13 Gen 4	477	Lenovo ThinkPad X13 Gen 4	21EYS5MU00	X13 Gen 4	\N	\N	\N	35529
11695	X1 Yoga	542	Lenovo ThinkPad X1 Yoga	21CD0032UK	X1 Yoga	\N	\N	\N	35530
11696	X1 Yoga	542	Lenovo ThinkPad X1 Yoga	21HRS2GT00	X1 Yoga	\N	\N	\N	35531
11697	L13	426	Lenovo ThinkPad L13	\N	L13	\N	\N	\N	35532
11698	X1 Yoga	542	Lenovo ThinkPad X1 Yoga (8th Gen)	\N	X1 Yoga	\N	\N	\N	35533
11699	X1 Yoga	542	Lenovo ThinkPad X1 Yoga	21CD0032UK	X1 Yoga	\N	\N	\N	35534
11700	UNKNOWN	\N	\N	\N	\N	\N	\N	\N	35535
11701	T460s	360	Lenovo ThinkPad T460S	ThinkPad T460s	T460s	\N	\N	\N	35536
11702	T490	400	\N	\N	\N	T490	\N	\N	35537
11703	X240	347	Lenovo ThinkPad X240	20AMA1BK00	X240	\N	\N	\N	35538
11897	UNKNOWN	\N	\N	21QA001PGE	\N	\N	\N	\N	35733
11704	T490s	401	Lenovo ThinkPad T490s	20NX002SUK	T490s	\N	\N	\N	35539
11705	T440p	343	Lenovo ThinkPad T440P	\N	T440p	\N	\N	\N	35540
11706	UNKNOWN	\N	Lenovo ThinkPad P16s Gen 1	Thinkpad P16S Gen 1	\N	\N	\N	\N	35541
11707	UNKNOWN	\N	Lenovo ThinkPad P16s G3	21KS	\N	\N	\N	\N	35542
11708	T490	400	LENOVO T490 8TH GEN	\N	T490	\N	\N	\N	35543
11709	X1	304	Lenovo ThinkPad X1	\N	X1	\N	\N	\N	35544
11710	T14s	419	Lenovo ThinkPad T14s 2-in-1 Gen 1	\N	T14s	\N	\N	\N	35545
11711	X1	304	Lenovo ThinkPad X1	20KGSAH900	X1	\N	\N	\N	35546
11712	T470s	371	Lenovo ThinkPad T470S	T470S	T470s	\N	\N	\N	35547
11713	P14s	435	lenovo thinkpad P14s Gen 5	\N	P14s	\N	\N	\N	35548
11714	X1 Carbon	327	Lenovo ThinkPad X1 Carbon Gen 13 Aura	\N	X1 Carbon	\N	\N	\N	35549
11715	X1 Carbon	327	Lenovo ThinkPad X1 Carbon Gen 13 Aura	\N	X1 Carbon	\N	\N	\N	35550
11716	T480s	385	Lenovo ThinkPad T480s	\N	T480s	\N	\N	\N	35551
11717	E15	425	Lenovo ThinkPad E15	\N	E15	\N	\N	\N	35552
11718	X1	304	Lenovo ThinkPad X1	\N	X1	\N	\N	\N	35553
11719	X13	421	Lenovo ThinkPad X13 2-in-1 Gen 5	\N	X13	\N	\N	\N	35554
11720	T495	406	Lenovo Thinkpad T495	\N	T495	\N	\N	\N	35555
11721	X395	408	Lenovo ThinkPad X395	\N	X395	\N	\N	\N	35556
11722	T14s	419	Lenovo ThinkPad T14s	\N	T14s	\N	\N	\N	35557
11723	X395	408	Lenovo ThinkPad X395	\N	X395	\N	\N	\N	35558
11724	X395	408	Lenovo ThinkPad X395	\N	X395	\N	\N	\N	35559
11725	X1 Yoga	542	Lenovo ThinkPad X1 Yoga	\N	X1 Yoga	\N	\N	\N	35560
11726	X1 Yoga	542	Lenovo ThinkPad X1 Yoga	20QGS1C600	X1 Yoga	\N	\N	\N	35561
11727	X1 Carbon	327	Lenovo ThinkPad X1 Carbon Gen 12	\N	X1 Carbon	\N	\N	\N	35562
11728	E14	424	lenovo Thinkpad E14	\N	E14	\N	\N	\N	35563
11729	E15	425	Lenovo ThinkPad E15	\N	E15	\N	\N	\N	35564
11730	E15 Gen 2	526	Lenovo ThinkPad E15 Gen 2	\N	E15 Gen 2	\N	\N	\N	35565
11731	UNKNOWN	\N	\N	21SA001UUK	\N	\N	\N	\N	35566
11732	UNKNOWN	\N	Lenovo ThinkPad L16 Gen 2	\N	\N	\N	\N	\N	35567
11733	UNKNOWN	\N	Lenovo Thinkpad E595	\N	\N	\N	\N	\N	35568
11734	T490	400	Lenovo ThinkPad T490	T460p T470p T470 T470s T480 T480s T490 T490s T14 T14s	T490	\N	\N	\N	35569
11735	X1 Carbon Gen 10	487	Lenovo X1CARBON	NAX1 CARBON	\N	X1 Carbon Gen 10	\N	\N	35570
11736	P14s	435	Lenovo ThinkPad P14s Gen 5	\N	P14s	\N	\N	\N	35571
11737	UNKNOWN	\N	Lenovo V15 G2 IJL 82QY	\N	\N	\N	\N	\N	35572
11738	T460	359	Lenovo ThinkPad T460	T460	T460	\N	\N	\N	35573
11739	E570	379	Lenovo Thinkpad E570	\N	E570	\N	\N	\N	35574
11740	X390	403	Lenovo ThinkPad X390	\N	X390	\N	\N	\N	35575
11741	E15	425	Lenovo ThinkPad E15 2nd Gen	\N	E15	\N	\N	\N	35576
11742	E14	424	\N	\N	\N	E14	\N	\N	35577
11743	UNKNOWN	\N	Lenovo ThinkPad L16 Gen 1	\N	\N	\N	\N	\N	35578
11744	UNKNOWN	\N	Lenovo ThinkPad L16 Gen 1	\N	\N	\N	\N	\N	35579
11745	UNKNOWN	\N	Lenovo ThinkPad T16 Gen 4	\N	\N	\N	\N	\N	35580
11746	L14	428	Lenovo ThinkPad L14 Gen 5	\N	L14	\N	\N	\N	35581
11747	P14s	435	Lenovo ThinkPad P14s Gen 5	\N	P14s	\N	\N	\N	35582
11748	X1 Carbon	327	Lenovo ThinkPad X1 Carbon G13	\N	X1 Carbon	\N	\N	\N	35583
11749	UNKNOWN	\N	Lenovo ThinkPad X9-14 G1	\N	\N	\N	\N	\N	35584
11750	L13 Yoga	427	Lenovo ThinkPad L13 Yoga Gen 2	\N	L13 Yoga	\N	\N	\N	35585
11751	T23	183	Lenovo ThinkPad T23	\N	T23	\N	\N	\N	35586
11752	UNKNOWN	\N	X12 Detachable Gen 1	\N	\N	\N	\N	\N	35587
11753	X1 Carbon	327	Lenovo ThinkPad X1 Carbon G13	\N	X1 Carbon	\N	\N	\N	35588
11754	L13 Yoga	427	Lenovo ThinkPad L13 Yoga Gen 4	\N	L13 Yoga	\N	\N	\N	35589
11755	L13 Yoga	427	Lenovo ThinkPad L13 Yoga Gen 4	\N	L13 Yoga	\N	\N	\N	35590
11756	P16 Gen 2	519	Lenovo ThinkPad P16 Gen 2	\N	P16 Gen 2	\N	\N	\N	35591
11757	UNKNOWN	\N	Lenovo ThinkPad X9-14 G1	\N	\N	\N	\N	\N	35592
11758	X13	421	Lenovo ThinkPad X13 G4	\N	X13	\N	\N	\N	35593
11759	T14	418	Lenovo ThinkPad T14 G3	\N	T14	\N	\N	\N	35594
11760	P16	518	Lenovo ThinkPad P16 G1	\N	P16	\N	\N	\N	35595
11761	L13	426	Lenovo ThinkPad L13 G4	\N	L13	\N	\N	\N	35596
11762	UNKNOWN	\N	X12 Detachable Gen 1	\N	\N	\N	\N	\N	35597
11763	UNKNOWN	\N	Lenovo ThinkPad 14 Gen 7	\N	\N	\N	\N	\N	35598
11764	X1 Yoga	542	Lenovo ThinkPad X1 Yoga Gen 10 G10	\N	X1 Yoga	\N	\N	\N	35599
11765	X13	421	\N	lenovo_thinkpad_x13_r5_pro_4..	\N	\N	X13	\N	35600
11766	X13	421	\N	lenovo_thinkpad_x13_r3_pro_4..	\N	\N	X13	\N	35601
11767	L13 Gen 2	502	\N	lenovo_thinkpad_l13_gen_2_i5..	\N	\N	L13 Gen 2	\N	35602
11768	X13	421	\N	lenovo_thinkpad_x13_r5_pro_4..	\N	\N	X13	\N	35603
11769	E15 Gen 2	526	Lenovo ThinkPad E15 Gen 2	\N	E15 Gen 2	\N	\N	\N	35604
11770	R40	197	Thinkpad R40	\N	R40	\N	\N	\N	35605
11771	E14	424	\N	21M3002BGE	\N	E14	\N	\N	35606
11772	UNKNOWN	\N	Lenovo ThinkPad L16 Gen 1.	\N	\N	\N	\N	\N	35607
11773	T570	373	Lenovo ThinkPad T570	\N	T570	\N	\N	\N	35608
11774	T580	386	Lenovo Thinkpad T580	\N	T580	\N	\N	\N	35609
11775	T470p	372	Lenovo T470p	\N	T470p	\N	\N	\N	35610
11776	UNKNOWN	\N	\N	\N	\N	\N	\N	\N	35611
11777	E15	425	\N	\N	\N	E15	\N	\N	35612
11778	T480	384	Lenovo ThinkPad T480	\N	T480	\N	\N	\N	35613
11779	W700ds	256	Lenovo Thinkpad W700ds	\N	W700ds	\N	\N	\N	35614
11780	T420	290	Lenovo ThinkPad T420	\N	T420	\N	\N	\N	35615
11781	T420	290	Lenovo ThinkPad T420	\N	T420	\N	\N	\N	35616
11782	T490s	401	Lenovo ThinkPad T490s	\N	T490s	\N	\N	\N	35617
11783	L15	429	Lenovo ThinkPad L15	PF3D7E5M	L15	\N	\N	\N	35618
11784	P52s	394	Lenovo ThinkPad P52s	20LC-S1AJ00	P52s	\N	\N	\N	35619
11785	UNKNOWN	\N	Lenovo Thinkpad Plus G4	\N	\N	\N	\N	\N	35620
11786	X280	388	Lenovo ThinkPad X280	\N	X280	\N	\N	\N	35621
11787	UNKNOWN	\N	\N	21V50001GE	\N	\N	\N	\N	35622
11788	X41	217	IBM ThinkPad X41	\N	X41	\N	\N	\N	35623
11789	T470s	371	Lenovo ThinkPad T470S	20HGS30X00	T470s	\N	\N	\N	35624
11790	X1	304	Lenovo ThinkPad X1	\N	X1	\N	\N	\N	35625
11791	L570	383	Lenovo ThinkPad L570	\N	L570	\N	\N	\N	35626
11792	X1 Yoga	542	Lenovo ThinkPad X1 Yoga	\N	X1 Yoga	\N	\N	\N	35627
11793	X200	247	Lenovo ThinkPad X200	X200S	X200	\N	\N	\N	35629
11794	X13 Yoga	422	Lenovo ThinkPad X13 Yoga	\N	X13 Yoga	\N	\N	\N	35630
11795	T450	349	Lenovo ThinkPad T450	THINKPADT450	T450	\N	\N	\N	35631
11796	E16	437	Lenovo ThinkPad E16 G3	21SSS00E00	E16	\N	\N	\N	35632
11797	T14	418	Lenovo ThinkPad T14	ThinkPad T14 G1	T14	\N	\N	\N	35633
11798	T560	362	Lenovo ThinkPad T560	\N	T560	\N	\N	\N	35634
11799	P52	393	Lenovo ThinkPad P52	\N	P52	\N	\N	\N	35635
11800	T480	384	Lenovo ThinkPad T480	\N	T480	\N	\N	\N	35636
11801	X1	304	Lenovo ThinkPad X1	\N	X1	\N	\N	\N	35637
11802	L590	411	L590	\N	L590	\N	\N	\N	35638
11803	T14s	419	Lenovo ThinkPad T14s G6	21QXCTO1WW	T14s	\N	\N	\N	35639
11804	X1	304	Lenovo Thinkpad X1 Titanium	\N	X1	\N	\N	\N	35640
11805	E15	425	Lenovo ThinkPad E15	20TD-0004GE	E15	\N	\N	\N	35641
11806	X1 Carbon	327	Lenovo ThinkPad X1 Carbon 9. Generation	20XX001XGE	X1 Carbon	\N	\N	\N	35642
11807	UNKNOWN	\N	Lenovo Yoga 460	\N	\N	\N	\N	\N	35643
11808	X1	304	Lenovo ThinkPad X1	\N	X1	\N	\N	\N	35644
11809	E14	424	Lenovo ThinkPad E14 2nd Gen	\N	E14	\N	\N	\N	35645
11810	T14	418	Lenovo ThinkPad T14 G5	\N	T14	\N	\N	\N	35646
11811	T14	418	Lenovo ThinkPad T14 G5	\N	T14	\N	\N	\N	35647
11812	UNKNOWN	\N	Lenovo ThinkPad P16v G1	\N	\N	\N	\N	\N	35648
11813	X1 Carbon	327	Lenovo ThinkPad X1 Carbon G13	\N	X1 Carbon	\N	\N	\N	35649
11814	P14s	435	Lenovo ThinkPad P14s G5	\N	P14s	\N	\N	\N	35650
11815	P16 Gen 2	519	Lenovo ThinkPad P16 Gen 2	\N	P16 Gen 2	\N	\N	\N	35651
11816	P16 Gen 2	519	Lenovo ThinkPad P16 Gen 2	\N	P16 Gen 2	\N	\N	\N	35652
11817	P16 Gen 2	519	Lenovo ThinkPad P16 Gen 2	\N	P16 Gen 2	\N	\N	\N	35653
11818	P16 Gen 2	519	Lenovo ThinkPad P16 Gen 2	\N	P16 Gen 2	\N	\N	\N	35654
11819	UNKNOWN	\N	Lenovo Thinkpad L16 G2	\N	\N	\N	\N	\N	35655
11820	T14s	419	Lenovo ThinkPad T14s Gen 2 20WN	\N	T14s	\N	\N	\N	35656
11821	T14 Gen 5	556	Lenovo ThinkPad T14 Gen 5	\N	T14 Gen 5	\N	\N	\N	35657
11822	P16 Gen 2	519	Lenovo ThinkPad P16 Gen 2	\N	P16 Gen 2	\N	\N	\N	35658
11823	T14 Gen 5	556	Lenovo ThinkPad T14 Gen 5	\N	T14 Gen 5	\N	\N	\N	35659
11824	T14 Gen 5	556	Lenovo ThinkPad T14 Gen 5	\N	T14 Gen 5	\N	\N	\N	35660
11825	UNKNOWN	\N	Lenovo ThinkPad X9-14 G1	\N	\N	\N	\N	\N	35661
11826	T14 Gen 5	556	Lenovo ThinkPad T14 Gen 5	\N	T14 Gen 5	\N	\N	\N	35662
11827	L13	426	Lenovo ThinkPad L13 G6	\N	L13	\N	\N	\N	35663
11828	T14 Gen 5	556	Lenovo ThinkPad T14 Gen 5	\N	T14 Gen 5	\N	\N	\N	35664
11829	T14 Gen 5	556	Lenovo ThinkPad T14 Gen 5	\N	T14 Gen 5	\N	\N	\N	35665
11830	T14 Gen 5	556	Lenovo ThinkPad T14 Gen 5	\N	T14 Gen 5	\N	\N	\N	35666
11831	UNKNOWN	\N	Lenovo ThinkPad X12 Detachable	\N	\N	\N	\N	\N	35667
11832	UNKNOWN	\N	Lenovo ThinkPad X12 Detachable	\N	\N	\N	\N	\N	35668
11833	X1 Carbon	327	Lenovo ThinkPad X1 Carbon G13	\N	X1 Carbon	\N	\N	\N	35669
11834	X1	304	Lenovo ThinkPad X1 Tablet G3	\N	X1	\N	\N	\N	35670
11835	T14s	419	Lenovo ThinkPad T14s G4	\N	T14s	\N	\N	\N	35671
11836	UNKNOWN	\N	Lenovo ThinkPad X12 Detachable	\N	\N	\N	\N	\N	35672
11837	UNKNOWN	\N	\N	21KX004XGE	\N	\N	\N	\N	35673
11838	P16	518	\N	21RQ003WGE	\N	P16	\N	\N	35674
11839	P16	518	\N	21RQ000MGE	\N	P16	\N	\N	35675
11840	P16	518	\N	21RQ003QGE	\N	P16	\N	\N	35676
11841	UNKNOWN	\N	\N	21QE0035GE	\N	\N	\N	\N	35677
11842	P1	398	\N	21Q8003NGE	\N	P1	\N	\N	35678
11843	350	11	\N	21QR005BGE	\N	350	\N	\N	35679
11844	P14s	435	\N	21G20063GE	\N	P14s	\N	\N	35680
11845	X1 Carbon	327	\N	21NS004NGE	\N	X1 Carbon	\N	\N	35681
11846	E16	437	\N	21ST001TGE	\N	E16	\N	\N	35682
11847	T14	418	Lenovo Thinkpad t14 G3	21CF002TGE	T14	\N	\N	\N	35683
11848	X13	421	Lenovo ThinkPad X13 2-in-1 Gen 5	\N	X13	\N	\N	\N	35684
11849	X1	304	Lenovo ThinkPad X1 2-in-1 G10 21NU007MGE 14" WUXGA Core Ultr	21NU007MGE	X1	\N	\N	\N	35685
11850	X1 Carbon	327	Lenovo ThinkPad X1 Carbon G13	\N	X1 Carbon	\N	\N	\N	35686
11851	UNKNOWN	\N	Lenovo ThinkPad X12 Detachable	\N	\N	\N	\N	\N	35687
11852	UNKNOWN	\N	Lenovo ThinkPad X12 Detachable	\N	\N	\N	\N	\N	35688
11853	T14	418	Lenovo ThinkPad T14 G5	\N	T14	\N	\N	\N	35689
11854	T14s	419	Lenovo ThinkPad T14s G4	\N	T14s	\N	\N	\N	35690
11855	UNKNOWN	\N	Lenovo ThinkPad E595	\N	\N	\N	\N	\N	35691
11856	E16	437	\N	22AY003WGE	\N	E16	\N	\N	35692
11857	T14	418	\N	21QC00ANGE	\N	T14	\N	\N	35693
11858	P14s	435	\N	21QT006QGE	\N	P14s	\N	\N	35694
11859	T14	418	\N	21QG009QGE	\N	T14	\N	\N	35695
11860	E16	437	\N	22AY001UGE	\N	E16	\N	\N	35696
11861	L14	428	\N	21S80031GE	\N	L14	\N	\N	35697
11862	UNKNOWN	\N	\N	21SC0028GE	\N	\N	\N	\N	35698
11863	T14	418	\N	21QE008DGE	\N	T14	\N	\N	35699
11864	E14	424	\N	21U20020GE	\N	E14	\N	\N	35700
11865	L14	428	\N	21S80013GE	\N	L14	\N	\N	35701
11866	UNKNOWN	\N	\N	21SA0016GE	\N	\N	\N	\N	35702
11867	L13	426	\N	21R50006GE	\N	L13	\N	\N	35703
11868	T14	418	\N	21QC0037GE	\N	T14	\N	\N	35704
11869	X1 Carbon	327	\N	21NS00MLGE	\N	X1 Carbon	\N	\N	35705
11870	X1 Carbon	327	\N	21NX008PGE	\N	X1 Carbon	\N	\N	35706
11871	T14s	419	\N	21QX003CGE	\N	T14s	\N	\N	35707
11872	UNKNOWN	\N	\N	21Q6001DGE	\N	\N	\N	\N	35708
11873	T14	418	\N	21QG009RGE	\N	T14	\N	\N	35709
11874	T14	418	\N	21QG009NGE	\N	T14	\N	\N	35710
11875	E16	437	\N	21SR007BGE	\N	E16	\N	\N	35711
11876	T14	418	\N	21QC0045GE	\N	T14	\N	\N	35712
11877	P1	398	\N	21Q8000GGE	\N	P1	\N	\N	35713
11878	E14	424	\N	21U2002QGE	\N	E14	\N	\N	35714
11879	L14	428	\N	21S6001EGE	\N	L14	\N	\N	35715
11880	X1 Carbon	327	\N	21NS00MMGE	\N	X1 Carbon	\N	\N	35716
11881	T14s	419	\N	21QX00GVGE	\N	T14s	\N	\N	35717
11882	P16	518	\N	21RQ000MGE	\N	P16	\N	\N	35718
11883	E14	424	Lenovo ThinkPad E14 Gen 5	21JR0006GE, 21JR000CGE, 21JS0000GE	E14	\N	\N	\N	35719
11884	T14s	419	\N	21R3005XGE	\N	T14s	\N	\N	35720
11885	T14s	419	\N	21R3005WGE	\N	T14s	\N	\N	35721
11886	P16	518	\N	21RQ000GGE	\N	P16	\N	\N	35722
11887	E14	424	\N	21U20027GE	\N	E14	\N	\N	35723
11888	T14	418	\N	21QG003MGE	\N	T14	\N	\N	35724
11889	UNKNOWN	\N	\N	21SA004BGE	\N	\N	\N	\N	35725
11890	UNKNOWN	\N	\N	21SA004AGE	\N	\N	\N	\N	35726
11891	350	11	\N	21QR003TGE	\N	350	\N	\N	35727
11892	350	11	\N	21QN005KGE	\N	350	\N	\N	35728
11893	X1 Carbon	327	\N	21NX007GGE	\N	X1 Carbon	\N	\N	35729
11894	T14	418	\N	21QC0063GE	\N	T14	\N	\N	35730
11895	T14	418	\N	21QG003PGE	\N	T14	\N	\N	35731
11896	E16	437	\N	21SR0041GE	\N	E16	\N	\N	35732
11898	X380	433	Lenovo ThinkPad X380 Yoga	\N	X380	\N	\N	\N	35734
11899	E16	437	ThinkPad E16 Gen 3 (Intel)	21SR007BGE	E16	\N	\N	\N	35735
11900	E16	437	ThinkPad E16 Gen 3 (AMD)	21ST004DGE	E16	\N	\N	\N	35736
11901	T14	418	Lenovo ThinkPad T14 G5	\N	T14	\N	\N	\N	35737
11902	UNKNOWN	\N	Lenovo ThinkPad L16 Gen 2	\N	\N	\N	\N	\N	35738
11903	P14s	435	Lenovo ThinkPad P14s G6	\N	P14s	\N	\N	\N	35739
11904	P14s	435	Lenovo ThinkPad P14s G6	\N	P14s	\N	\N	\N	35740
11905	P14s	435	Lenovo ThinkPad P14s Gen 5	\N	P14s	\N	\N	\N	35741
11906	L13	426	Lenovo ThinkPad L13 G6	\N	L13	\N	\N	\N	35742
11907	L14	428	Lenovo ThinkPad L14 Gen 5	\N	L14	\N	\N	\N	35743
11908	X1	304	Lenovo ThinkPad X1	\N	X1	\N	\N	\N	35744
11909	T14	418	Lenovo ThinkPad T14	\N	T14	\N	\N	\N	35745
11910	T560	362	Lenovo ThinkPad T560	\N	T560	\N	\N	\N	35746
11911	T560	362	Lenovo ThinkPad T560	\N	T560	\N	\N	\N	35747
11912	X260	366	Lenovo ThinkPad X260	\N	X260	\N	\N	\N	35748
11913	T14	418	Lenovo ThinkPad T14	Lenovo ThinkPad T14, Lenovo ThinkPad T14 Gen 1, Lenovo ThinkPad T14 G1, ThinkPad T14 G1, ThinkPad T14 Gen 1	T14	\N	\N	\N	35749
11914	T14	418	20UE	20UE	\N	T14	\N	\N	35750
11915	L480	389	Lenovo ThinkPad L480	\N	L480	\N	\N	\N	35751
11917	X250	356	Lenovo ThinkPad X250	\N	X250	\N	\N	\N	35753
11918	X250	356	Lenovo ThinkPad X250	\N	X250	\N	\N	\N	35754
11919	X260	366	lenovo X260	\N	X260	\N	\N	\N	35755
11920	X260	366	lenovo X260	\N	X260	\N	\N	\N	35756
11921	X1 Carbon	327	Lenovo ThinkPad X1 Carbon 3 Gen	\N	X1 Carbon	\N	\N	\N	35757
11922	X1	304	Lenovo Carbon X1 Gen 4	\N	X1	\N	\N	\N	35758
11923	X1	304	Lenovo Carbon X1 Gen 4	\N	X1	\N	\N	\N	35759
11924	X1 Carbon Gen 10	487	Lenovo X1CARBON	NAX1 CARBON	\N	X1 Carbon Gen 10	\N	\N	35760
11925	P14s	435	\N	\N	\N	P14s	\N	\N	35761
11926	T14 Gen 4	460	See Title/Description	See Title/Description	\N	T14 Gen 4	\N	\N	35762
11927	L15	429	ThinkPad L15	20U3	L15	\N	\N	\N	35763
11928	E14	424	\N	21SX0038US	\N	E14	\N	\N	35764
11929	X1 Extreme	399	ThinkPad X1 Extreme 2nd Gen	ThinkPad X1 Extreme 2nd	X1 Extreme	\N	\N	\N	35765
11930	E14 Gen 2	523	Lenovo E14 Gen 2	\N	E14 Gen 2	\N	\N	\N	35766
11931	P1	398	ThinkPad P1 Gen 6	21FW-SBAJ00	P1	\N	\N	\N	35767
11932	L14	428	Lenovo L14 Gen 4	THINKPAD L14	L14	\N	\N	\N	35768
11933	UNKNOWN	\N	P15v Gen 2i	ThinkPad P15v Gen 2i -2f1ae18U	\N	\N	\N	\N	35769
11934	L390	430	ThinkPad L390 Yoga	NA, THINKPAD L390	L390	\N	\N	\N	35770
11935	X13	421	Lenovo X13 Gen 2i	\N	X13	\N	\N	\N	35771
11936	T460	359	Lenovo ThinkPad T460	T460	T460	\N	\N	\N	35772
11937	T570	373	Lenovo ThinkPad T570	T570	T570	\N	\N	\N	35773
11938	T16 Gen 2	462	Lenovo ThinkPad T16 Gen 2	\N	T16 Gen 2	\N	\N	\N	35774
11939	T14 Gen 1	457	Lenovo ThinkPad T14 Gen 1	PF-2GJ1M5, 20S1S7VJ00	T14 Gen 1	\N	\N	\N	35775
11940	UNKNOWN	\N	16iru9	16IRU9	\N	\N	\N	\N	35776
11941	E14	424	Lenovo ThinkPad E14 Gen 4	21EB0021US	E14	\N	\N	\N	35777
11942	P14s Gen 2	515	ThinkPad P14s Gen 2	\N	P14s Gen 2	\N	\N	\N	35778
11943	T14	418	ThinkPad T14 Gen 6	21QDS3601Q	T14	\N	\N	\N	35779
11944	T16 Gen 1	461	Lenovo T16 Gen 1 16	\N	T16 Gen 1	\N	\N	\N	35780
11945	T15	420	Lenovo ThinkPad T15 Gen 2i	\N	T15	\N	\N	\N	35781
11946	T15	420	Lenovo ThinkPad T15 Gen 2i	\N	T15	\N	\N	\N	35782
11947	T15	420	Lenovo ThinkPad T15 Gen 2i	\N	T15	\N	\N	\N	35783
11948	X1	304	21Q0001YAU	21Q0001YAU	\N	X1	\N	\N	35784
11949	X1 Carbon	327	21NX0028AU	21NX0028AU	\N	X1 Carbon	\N	\N	35785
11950	T15	420	Lenovo ThinkPad T15 Gen 2i	\N	T15	\N	\N	\N	35786
11951	T15	420	Lenovo ThinkPad T15 Gen 2i	\N	T15	\N	\N	\N	35787
11952	T15	420	Lenovo ThinkPad T15 Gen 2i	\N	T15	\N	\N	\N	35788
11953	T15	420	Lenovo ThinkPad T15 Gen 2i	\N	T15	\N	\N	\N	35789
11954	T15	420	Lenovo ThinkPad T15 Gen 2i	\N	T15	\N	\N	\N	35790
11955	T15	420	Lenovo ThinkPad T15 Gen 2i	\N	T15	\N	\N	\N	35791
11956	T14	418	Lenovo ThinkPad T14	T14 gen2	T14	\N	\N	\N	35792
11957	T14s	419	Lenovo ThinkPad T14s	\N	T14s	\N	\N	\N	35793
11958	T14	418	Lenovo ThinkPad T14	T14 gen2	T14	\N	\N	\N	35794
11959	T14s	419	Lenovo ThinkPad T14s	\N	T14s	\N	\N	\N	35795
11960	X220	302	Lenovo ThinkPad X220	\N	X220	\N	\N	\N	35796
11961	T14s	419	Lenovo ThinkPad T14s	\N	T14s	\N	\N	\N	35797
11962	X1 Carbon Gen 9	486	ThinkPad X1 Carbon Gen 9	\N	X1 Carbon Gen 9	\N	\N	\N	35798
11963	T14s	419	Lenovo ThinkPad T14s Gen 2	\N	T14s	\N	\N	\N	35799
11964	X1 Carbon Gen 9	486	ThinkPad X1 Carbon Gen 9	\N	X1 Carbon Gen 9	\N	\N	\N	35800
11965	T14	418	Lenovo ThinkPad T14	T14 gen3	T14	\N	\N	\N	35801
11966	P1	398	Lenovo ThinkPad P1	20Y4S0SE00	P1	\N	\N	\N	35802
11967	T410	267	Lenovo ThinkPad T410	2537FP5	T410	\N	\N	\N	35803
11968	T14s	419	Lenovo ThinkPad T14s	\N	T14s	\N	\N	\N	35804
11969	X390	403	x390 8665u	X390	X390	\N	\N	\N	35805
11970	X1 Extreme	399	Lenovo ThinkPad X1 Extreme 1st Gen	THINKPAD X1 EXTREME	X1 Extreme	\N	\N	\N	35806
11971	P73	409	See Title/Description	W2-2-B-Mar26210G64Y	\N	P73	\N	\N	35807
11972	T14 Gen 1	457	See Title/Description	Y9-C-Mar26150M48D	\N	T14 Gen 1	\N	\N	35808
11973	L15	429	ThinkPad L15	20U3	L15	\N	\N	\N	35809
11974	T570	373	Lenovo ThinkPad T570	T570	T570	\N	\N	\N	35810
11975	T430	319	Lenovo ThinkPad T430	\N	T430	\N	\N	\N	35811
11976	T14 Gen 1	457	\N	\N	\N	T14 Gen 1	\N	\N	35812
11977	P1 Gen 4	513	Lenovo ThinkPad P1 Gen 4	20Y30067US, 20Y3	P1 Gen 4	\N	\N	\N	35813
11978	L13 Yoga	427	Lenovo ThinkPad L13 Yoga	B101	L13 Yoga	\N	\N	\N	35814
11979	L13 Yoga	427	Lenovo ThinkPad L13 Yoga	B101	L13 Yoga	\N	\N	\N	35815
11980	L13 Yoga	427	Lenovo ThinkPad L13 Yoga	B101	L13 Yoga	\N	\N	\N	35816
11981	X1 Yoga	542	Lenovo ThinkPad X1 Yoga	\N	X1 Yoga	\N	\N	\N	35817
11982	T460	359	Lenovo ThinkPad T460	\N	T460	\N	\N	\N	35818
11983	X390	403	Lenovo ThinkPad X390	X390	X390	\N	\N	\N	35819
11984	T560	362	Lenovo ThinkPad T560	THINKPAD T560	T560	\N	\N	\N	35820
11985	T490	400	Lenovo T490	T490	T490	\N	\N	\N	35821
11986	P14s Gen 2	515	Lenovo P14S Gen 2	\N	P14s Gen 2	\N	\N	\N	35822
11987	T580	386	Lenovo Thinkpad T580	20JXS0FH00	T580	\N	\N	\N	35823
11988	T480s	385	Lenovo ThinkPad T480s	\N	T480s	\N	\N	\N	35824
11989	T14s	419	Lenovo ThinkPad T14s	\N	T14s	\N	\N	\N	35825
11990	L15	429	Leonovo Ryzen L15	s.F_9 20250726 zs.09	L15	\N	\N	\N	35826
11991	UNKNOWN	\N	ThinkPad Extreme Gen3	\N	\N	\N	\N	\N	35827
11992	L15 Gen 1	507	Lenovo ThinkPad L15 Gen 1	\N	L15 Gen 1	\N	\N	\N	35828
11993	X1 Carbon Gen 8	485	ThinkPad X1 Carbon Gen 8	\N	X1 Carbon Gen 8	\N	\N	\N	35829
11994	E15	425	\N	THINKPAD E15	\N	\N	E15	\N	35830
11995	T14	418	Lenovo ThinkPad T14	\N	T14	\N	\N	\N	35831
11996	T430	319	Lenovo ThinkPad T430	\N	T430	\N	\N	\N	35832
11997	UNKNOWN	\N	Lenovo ThinkPad L16 Gen 2	21SBS2C900	\N	\N	\N	\N	35833
11998	X1 Carbon	327	Lenovo Thinkpad X1 Carbon 6th Gen	\N	X1 Carbon	\N	\N	\N	35834
11999	E14	424	lenovo e14 gen 5	\N	E14	\N	\N	\N	35835
12000	P71	376	Lenovo P71	ThinkPad P71	P71	\N	\N	\N	35836
12001	T490	400	Lenovo T490	\N	T490	\N	\N	\N	35837
12002	P15	516	ThinkPad P15 Gen 1	\N	P15	\N	\N	\N	35838
12003	T480s	385	Lenovo ThinkPad T480s	LENOVO THINKPAD T480S	T480s	\N	\N	\N	35839
12004	UNKNOWN	\N	\N	\N	\N	\N	\N	\N	35840
12005	P1	398	Lenovo ThinkPad P1	THINKPAD P1	P1	\N	\N	\N	35841
12006	T42	210	IBM ThinkPad T42	IBM THINKPAD T42	T42	\N	\N	\N	35842
12007	ThinkPad 13	534	Samsung ChromeBook	\N	\N	ThinkPad 13	\N	\N	35843
12008	X1	304	Lenovo ThinkPad X1	\N	X1	\N	\N	\N	35844
12009	T460s	360	Lenovo ThinkPad T460S	20F90038US	T460s	\N	\N	\N	35845
12010	E14	424	Thinkpad E14 G2	20TA004GUS	E14	\N	\N	\N	35846
12011	E14	424	Lenovo E14 Gen 5	15F004WM	E14	\N	\N	\N	35847
12012	E14	424	Thinkpad E14 G4	21E3008SUS	E14	\N	\N	\N	35848
12013	T14s	419	Lenovo ThinkPad T14s Gen 6	21N1X001US-R	T14s	\N	\N	\N	35849
12014	P53	413	ThinkPad	P53	\N	\N	P53	\N	35850
12015	P50	363	Lenovo Thinkpad P50	LENOVO P50	P50	\N	\N	\N	35851
12016	X1	304	Lenovo ThinkPad X1	ThinkPad X1 Tablet Gen 3	X1	\N	\N	\N	35852
12017	X1	304	Lenovo X1 Nano	X1 Nano	X1	\N	\N	\N	35853
12018	E14 Gen 2	523	Lenovo ThinkPad E14 Gen 2	Lenovo ThinkPad E14 Gen 2	E14 Gen 2	\N	\N	\N	35854
12019	T430s	320	Lenovo ThinkPad T430S	T430s	T430s	\N	\N	\N	35855
12020	UNKNOWN	\N	Lenovo ThinkPad P17 Gen 1	\N	\N	\N	\N	\N	35856
12021	UNKNOWN	\N	Lenovo ThinkPad L16 Gen 2	21SC001AUS	\N	\N	\N	\N	35857
12022	T16 Gen 1	461	Lenovo ThinkPad T16 Gen 1	\N	T16 Gen 1	\N	\N	\N	35858
12023	T15	420	Lenovo ThinkPad T15 Gen 1	\N	T15	\N	\N	\N	35859
12024	T14 Gen 4	460	ThinkPad T14 Gen 4	21HE-SC3T00	T14 Gen 4	\N	\N	\N	35860
\.


--
-- Data for Name: price_history; Type: TABLE DATA; Schema: public; Owner: thinkpaduser
--

COPY public.price_history (id, listing_id, price, currency, recorded_at) FROM stdin;
20595	35414	135.90	GBP	2026-03-22 18:53:05.598019+11
20596	35241	1487.97	AUD	2026-03-22 18:53:05.598019+11
20597	35812	719.05	AUD	2026-03-22 18:53:05.598019+11
20598	35839	482.06	AUD	2026-03-22 18:53:05.598019+11
20599	35167	349.00	USD	2026-03-22 18:53:05.598019+11
20600	35168	259.99	USD	2026-03-22 18:53:05.598019+11
20601	35169	359.00	USD	2026-03-22 18:53:05.598019+11
20602	35170	295.00	USD	2026-03-22 18:53:05.598019+11
20603	35171	1005.03	USD	2026-03-22 18:53:05.598019+11
20604	35172	599.99	USD	2026-03-22 18:53:05.598019+11
20605	35173	279.99	USD	2026-03-22 18:53:05.598019+11
20606	35174	275.00	USD	2026-03-22 18:53:05.598019+11
20607	35175	468.32	AUD	2026-03-22 18:53:05.598019+11
20608	35176	861.44	AUD	2026-03-22 18:53:05.598019+11
20609	35177	345.00	USD	2026-03-22 18:53:05.598019+11
20610	35178	450.00	USD	2026-03-22 18:53:05.598019+11
20611	35179	468.32	AUD	2026-03-22 18:53:05.598019+11
20612	35180	939.77	AUD	2026-03-22 18:53:05.598019+11
20613	35181	900.61	AUD	2026-03-22 18:53:05.598019+11
20614	35182	468.32	AUD	2026-03-22 18:53:05.598019+11
20615	35183	939.77	AUD	2026-03-22 18:53:05.598019+11
20616	35184	783.14	AUD	2026-03-22 18:53:05.598019+11
20617	35185	125.00	USD	2026-03-22 18:53:05.598019+11
20618	35186	499.79	USD	2026-03-22 18:53:05.598019+11
20619	35187	379.99	USD	2026-03-22 18:53:05.598019+11
20620	35188	145.00	USD	2026-03-22 18:53:05.598019+11
20621	35189	2364.72	USD	2026-03-22 18:53:05.598019+11
20622	35190	1424.37	USD	2026-03-22 18:53:05.598019+11
20623	35191	189.99	USD	2026-03-22 18:53:05.598019+11
20624	35192	1702.84	USD	2026-03-22 18:53:05.598019+11
20625	35193	3108.14	USD	2026-03-22 18:53:05.598019+11
20626	35194	3138.14	USD	2026-03-22 18:53:05.598019+11
20627	35195	2789.04	AUD	2026-03-22 18:53:05.598019+11
20628	35196	3853.95	AUD	2026-03-22 18:53:05.598019+11
20629	35197	189.00	USD	2026-03-22 18:53:05.598019+11
20630	35198	1644.60	AUD	2026-03-22 18:53:05.598019+11
20631	35199	539.99	USD	2026-03-22 18:53:05.598019+11
20632	35200	199.00	USD	2026-03-22 18:53:05.598019+11
20633	35201	479.99	USD	2026-03-22 18:53:05.598019+11
20634	35202	149.95	USD	2026-03-22 18:53:05.598019+11
20635	35203	388.44	AUD	2026-03-22 18:53:05.598019+11
20636	35204	1037.59	USD	2026-03-22 18:53:05.598019+11
20637	35205	159.99	USD	2026-03-22 18:53:05.598019+11
20638	35206	1722.91	AUD	2026-03-22 18:53:05.598019+11
20639	35207	354.95	USD	2026-03-22 18:53:05.598019+11
20640	35208	1009.71	USD	2026-03-22 18:53:05.598019+11
20641	35209	1206.40	USD	2026-03-22 18:53:05.598019+11
20642	35210	760.98	USD	2026-03-22 18:53:05.598019+11
20643	35211	791.64	USD	2026-03-22 18:53:05.598019+11
20644	35212	384.95	USD	2026-03-22 18:53:05.598019+11
20645	35213	279.99	USD	2026-03-22 18:53:05.598019+11
20646	35214	52.00	USD	2026-03-22 18:53:05.598019+11
20647	35215	626.51	AUD	2026-03-22 18:53:05.598019+11
20648	35216	548.18	AUD	2026-03-22 18:53:05.598019+11
20649	35217	266.25	AUD	2026-03-22 18:53:05.598019+11
20650	35218	249.00	USD	2026-03-22 18:53:05.598019+11
20651	35219	199.00	USD	2026-03-22 18:53:05.598019+11
20652	35220	199.00	USD	2026-03-22 18:53:05.598019+11
20653	35221	199.00	USD	2026-03-22 18:53:05.598019+11
20654	35222	299.99	USD	2026-03-22 18:53:05.598019+11
20655	35223	1071.63	USD	2026-03-22 18:53:05.598019+11
20656	35224	885.98	USD	2026-03-22 18:53:05.598019+11
20657	35225	1541.93	USD	2026-03-22 18:53:05.598019+11
20658	35226	799.21	USD	2026-03-22 18:53:05.598019+11
20659	35227	997.99	USD	2026-03-22 18:53:05.598019+11
20660	35228	882.47	USD	2026-03-22 18:53:05.598019+11
20661	35229	895.27	USD	2026-03-22 18:53:05.598019+11
20662	35230	760.98	USD	2026-03-22 18:53:05.598019+11
20663	35231	3097.30	USD	2026-03-22 18:53:05.598019+11
20664	35232	1022.14	USD	2026-03-22 18:53:05.598019+11
20665	35233	1419.72	USD	2026-03-22 18:53:05.598019+11
20666	35234	1302.25	USD	2026-03-22 18:53:05.598019+11
20667	35235	583.91	USD	2026-03-22 18:53:05.598019+11
20668	35236	3388.97	USD	2026-03-22 18:53:05.598019+11
20669	35237	220.00	USD	2026-03-22 18:53:05.598019+11
20670	35238	175.00	USD	2026-03-22 18:53:05.598019+11
20671	35239	275.00	USD	2026-03-22 18:53:05.598019+11
20672	35240	399.99	USD	2026-03-22 18:53:05.598019+11
20673	35242	225.53	AUD	2026-03-22 18:53:05.598019+11
20674	35243	1500.00	USD	2026-03-22 18:53:05.598019+11
20675	35244	62.65	AUD	2026-03-22 18:53:05.598019+11
20676	35245	311.69	AUD	2026-03-22 18:53:05.598019+11
20677	35246	200.00	USD	2026-03-22 18:53:05.598019+11
20678	35247	368.08	AUD	2026-03-22 18:53:05.598019+11
20679	35248	2885.95	AUD	2026-03-22 18:53:05.598019+11
20680	35249	264.70	AUD	2026-03-22 18:53:05.598019+11
20681	35250	2144.24	AUD	2026-03-22 18:53:05.598019+11
20682	35251	524.69	AUD	2026-03-22 18:53:05.598019+11
20683	35252	2831.23	AUD	2026-03-22 18:53:05.598019+11
20684	35253	264.70	AUD	2026-03-22 18:53:05.598019+11
20685	35254	2582.80	AUD	2026-03-22 18:53:05.598019+11
20686	35255	501.21	AUD	2026-03-22 18:53:05.598019+11
20687	35256	459.00	USD	2026-03-22 18:53:05.598019+11
20688	35257	3077.61	USD	2026-03-22 18:53:05.598019+11
20689	35258	1170.73	USD	2026-03-22 18:53:05.598019+11
20690	35259	540.00	USD	2026-03-22 18:53:05.598019+11
20691	35260	1495.69	USD	2026-03-22 18:53:05.598019+11
20692	35261	2085.88	USD	2026-03-22 18:53:05.598019+11
20693	35262	885.98	USD	2026-03-22 18:53:05.598019+11
20694	35263	895.27	USD	2026-03-22 18:53:05.598019+11
20695	35264	947.90	USD	2026-03-22 18:53:05.598019+11
20696	35265	1180.03	USD	2026-03-22 18:53:05.598019+11
20697	35266	760.98	USD	2026-03-22 18:53:05.598019+11
20698	35267	16.49	USD	2026-03-22 18:53:05.598019+11
20699	35268	864.25	USD	2026-03-22 18:53:05.598019+11
20700	35269	1538.91	USD	2026-03-22 18:53:05.598019+11
20701	35270	619.69	USD	2026-03-22 18:53:05.598019+11
20702	35271	1011.23	AUD	2026-03-22 18:53:05.598019+11
20703	35272	1011.23	AUD	2026-03-22 18:53:05.598019+11
20704	35273	432.28	AUD	2026-03-22 18:53:05.598019+11
20705	35274	471.44	AUD	2026-03-22 18:53:05.598019+11
20706	35275	471.44	AUD	2026-03-22 18:53:05.598019+11
20707	35276	529.39	AUD	2026-03-22 18:53:05.598019+11
20708	35277	371.19	AUD	2026-03-22 18:53:05.598019+11
20709	35278	355.53	AUD	2026-03-22 18:53:05.598019+11
20710	35279	718.91	AUD	2026-03-22 18:53:05.598019+11
20711	35280	375.89	AUD	2026-03-22 18:53:05.598019+11
20712	35281	969.51	AUD	2026-03-22 18:53:05.598019+11
20713	35282	336.74	AUD	2026-03-22 18:53:05.598019+11
20714	35283	566.98	AUD	2026-03-22 18:53:05.598019+11
20715	35284	557.58	AUD	2026-03-22 18:53:05.598019+11
20716	35285	701.68	AUD	2026-03-22 18:53:05.598019+11
20717	35286	374.33	AUD	2026-03-22 18:53:05.598019+11
20718	35287	1769.88	AUD	2026-03-22 18:53:05.598019+11
20719	35288	1046.26	AUD	2026-03-22 18:53:05.598019+11
20720	35289	1351.26	AUD	2026-03-22 18:53:05.598019+11
20721	35290	1057.94	AUD	2026-03-22 18:53:05.598019+11
20722	35291	447.94	AUD	2026-03-22 18:53:05.598019+11
20723	35292	969.51	AUD	2026-03-22 18:53:05.598019+11
20724	35293	1014.94	AUD	2026-03-22 18:53:05.598019+11
20725	35294	404.09	AUD	2026-03-22 18:53:05.598019+11
20726	35295	375.89	AUD	2026-03-22 18:53:05.598019+11
20727	35296	567.70	GBP	2026-03-22 18:53:05.598019+11
20728	35297	850.48	AUD	2026-03-22 18:53:05.598019+11
20729	35298	529.39	AUD	2026-03-22 18:53:05.598019+11
20730	35299	830.12	AUD	2026-03-22 18:53:05.598019+11
20731	35300	432.28	AUD	2026-03-22 18:53:05.598019+11
20732	35301	839.51	AUD	2026-03-22 18:53:05.598019+11
20733	35302	189.99	USD	2026-03-22 18:53:05.598019+11
20734	35303	2191.23	AUD	2026-03-22 18:53:05.598019+11
20735	35304	374.34	AUD	2026-03-22 18:53:05.598019+11
20736	35305	331.27	AUD	2026-03-22 18:53:05.598019+11
20737	35306	156.63	AUD	2026-03-22 18:53:05.598019+11
20738	35307	1378.88	AUD	2026-03-22 18:53:05.598019+11
20739	35308	313.24	AUD	2026-03-22 18:53:05.598019+11
20740	35309	2427.74	AUD	2026-03-22 18:53:05.598019+11
20741	35310	149.99	USD	2026-03-22 18:53:05.598019+11
20742	35311	1117.80	AUD	2026-03-22 18:53:05.598019+11
20743	35312	139.40	AUD	2026-03-22 18:53:05.598019+11
20744	35313	910.72	USD	2026-03-22 18:53:05.598019+11
20745	35314	697.02	USD	2026-03-22 18:53:05.598019+11
20746	35315	1197.00	USD	2026-03-22 18:53:05.598019+11
20747	35316	896.78	USD	2026-03-22 18:53:05.598019+11
20748	35317	844.15	USD	2026-03-22 18:53:05.598019+11
20749	35318	1634.76	USD	2026-03-22 18:53:05.598019+11
20750	35319	3986.59	USD	2026-03-22 18:53:05.598019+11
20751	35320	2246.82	USD	2026-03-22 18:53:05.598019+11
20752	35321	1557.50	USD	2026-03-22 18:53:05.598019+11
20753	35322	1557.50	USD	2026-03-22 18:53:05.598019+11
20754	35323	1193.85	USD	2026-03-22 18:53:05.598019+11
20755	35324	1051.53	USD	2026-03-22 18:53:05.598019+11
20756	35325	2201.83	USD	2026-03-22 18:53:05.598019+11
20757	35326	812.10	USD	2026-03-22 18:53:05.598019+11
20758	35327	906.08	USD	2026-03-22 18:53:05.598019+11
20759	35328	569.52	AUD	2026-03-22 18:53:05.598019+11
20760	35329	217.71	AUD	2026-03-22 18:53:05.598019+11
20761	35330	926.18	USD	2026-03-22 18:53:05.598019+11
20762	35331	864.25	USD	2026-03-22 18:53:05.598019+11
20763	35332	760.00	USD	2026-03-22 18:53:05.598019+11
20764	35333	760.98	USD	2026-03-22 18:53:05.598019+11
20765	35334	926.18	USD	2026-03-22 18:53:05.598019+11
20766	35335	1101.03	USD	2026-03-22 18:53:05.598019+11
20767	35336	663.03	USD	2026-03-22 18:53:05.598019+11
20768	35337	885.98	USD	2026-03-22 18:53:05.598019+11
20769	35338	1071.63	USD	2026-03-22 18:53:05.598019+11
20770	35339	663.03	USD	2026-03-22 18:53:05.598019+11
20771	35340	799.21	USD	2026-03-22 18:53:05.598019+11
20772	35341	663.03	USD	2026-03-22 18:53:05.598019+11
20773	35342	697.02	USD	2026-03-22 18:53:05.598019+11
20774	35343	864.25	USD	2026-03-22 18:53:05.598019+11
20775	35344	560.00	USD	2026-03-22 18:53:05.598019+11
20776	35345	1300.00	USD	2026-03-22 18:53:05.598019+11
20777	35346	135.00	USD	2026-03-22 18:53:05.598019+11
20778	35347	269.99	USD	2026-03-22 18:53:05.598019+11
20779	35348	3155.49	USD	2026-03-22 18:53:05.598019+11
20780	35349	5100.03	USD	2026-03-22 18:53:05.598019+11
20781	35350	926.18	USD	2026-03-22 18:53:05.598019+11
20782	35351	961.84	USD	2026-03-22 18:53:05.598019+11
20783	35352	663.03	USD	2026-03-22 18:53:05.598019+11
20784	35353	650.00	USD	2026-03-22 18:53:05.598019+11
20785	35354	100.00	USD	2026-03-22 18:53:05.598019+11
20786	35355	140.97	AUD	2026-03-22 18:53:05.598019+11
20787	35356	467.96	AUD	2026-03-22 18:53:05.598019+11
20788	35357	750.25	AUD	2026-03-22 18:53:05.598019+11
20789	35358	2661.11	AUD	2026-03-22 18:53:05.598019+11
20790	35359	170.99	USD	2026-03-22 18:53:05.598019+11
20791	35360	175.00	USD	2026-03-22 18:53:05.598019+11
20792	35361	1644.60	AUD	2026-03-22 18:53:05.598019+11
20793	35362	469.88	AUD	2026-03-22 18:53:05.598019+11
20794	35363	299.99	USD	2026-03-22 18:53:05.598019+11
20795	35364	249.00	USD	2026-03-22 18:53:05.598019+11
20796	35365	313.24	AUD	2026-03-22 18:53:05.598019+11
20797	35366	249.99	USD	2026-03-22 18:53:05.598019+11
20798	35367	2254.97	USD	2026-03-22 18:53:05.598019+11
20799	35368	227.87	GBP	2026-03-22 18:53:05.598019+11
20800	35369	241.35	GBP	2026-03-22 18:53:05.598019+11
20801	35370	635.83	GBP	2026-03-22 18:53:05.598019+11
20802	35371	436.54	GBP	2026-03-22 18:53:05.598019+11
20803	35372	208.70	GBP	2026-03-22 18:53:05.598019+11
20804	35373	73.50	GBP	2026-03-22 18:53:05.598019+11
20805	35374	312.70	GBP	2026-03-22 18:53:05.598019+11
20806	35375	192.90	GBP	2026-03-22 18:53:05.598019+11
20807	35376	220.69	GBP	2026-03-22 18:53:05.598019+11
20808	35377	218.03	GBP	2026-03-22 18:53:05.598019+11
20809	35378	219.83	GBP	2026-03-22 18:53:05.598019+11
20810	35379	199.21	GBP	2026-03-22 18:53:05.598019+11
20811	35380	161.00	GBP	2026-03-22 18:53:05.598019+11
20812	35381	58.94	GBP	2026-03-22 18:53:05.598019+11
20813	35382	49.99	GBP	2026-03-22 18:53:05.598019+11
20814	35383	349.00	GBP	2026-03-22 18:53:05.598019+11
20815	35384	2556.70	GBP	2026-03-22 18:53:05.598019+11
20816	35385	1689.70	GBP	2026-03-22 18:53:05.598019+11
20817	35386	113.98	AUD	2026-03-22 18:53:05.598019+11
20818	35387	1044.79	AUD	2026-03-22 18:53:05.598019+11
20819	35388	290.86	GBP	2026-03-22 18:53:05.598019+11
20820	35389	379.90	AUD	2026-03-22 18:53:05.598019+11
20821	35390	229.50	GBP	2026-03-22 18:53:05.598019+11
20822	35391	156.09	GBP	2026-03-22 18:53:05.598019+11
20823	35392	999.99	GBP	2026-03-22 18:53:05.598019+11
20824	35393	516.70	GBP	2026-03-22 18:53:05.598019+11
20825	35394	168.78	GBP	2026-03-22 18:53:05.598019+11
20826	35395	499.00	GBP	2026-03-22 18:53:05.598019+11
20827	35396	99.99	GBP	2026-03-22 18:53:05.598019+11
20828	35397	349.00	GBP	2026-03-22 18:53:05.598019+11
20829	35398	89.99	GBP	2026-03-22 18:53:05.598019+11
20830	35399	227.04	AUD	2026-03-22 18:53:05.598019+11
20831	35678	3628.74	EUR	2026-03-22 18:53:05.598019+11
20832	35400	69.00	GBP	2026-03-22 18:53:05.598019+11
20833	35401	350.00	GBP	2026-03-22 18:53:05.598019+11
20834	35402	236.86	GBP	2026-03-22 18:53:05.598019+11
20835	35403	244.93	GBP	2026-03-22 18:53:05.598019+11
20836	35404	378.52	GBP	2026-03-22 18:53:05.598019+11
20837	35405	123.25	AUD	2026-03-22 18:53:05.598019+11
20838	35406	172.30	GBP	2026-03-22 18:53:05.598019+11
20839	35407	176.66	AUD	2026-03-22 18:53:05.598019+11
20840	35408	1650.77	AUD	2026-03-22 18:53:05.598019+11
20841	35409	562.03	GBP	2026-03-22 18:53:05.598019+11
20842	35410	156.70	GBP	2026-03-22 18:53:05.598019+11
20843	35411	189.94	AUD	2026-03-22 18:53:05.598019+11
20844	35412	125.50	GBP	2026-03-22 18:53:05.598019+11
20845	35413	254.21	AUD	2026-03-22 18:53:05.598019+11
20846	35415	759.85	AUD	2026-03-22 18:53:05.598019+11
20847	35416	169.99	GBP	2026-03-22 18:53:05.598019+11
20848	35417	346.24	AUD	2026-03-22 18:53:05.598019+11
20849	35418	721.85	AUD	2026-03-22 18:53:05.598019+11
20850	35419	1638.70	GBP	2026-03-22 18:53:05.598019+11
20851	35420	771.70	GBP	2026-03-22 18:53:05.598019+11
20852	35421	113.98	AUD	2026-03-22 18:53:05.598019+11
20853	35422	302.04	AUD	2026-03-22 18:53:05.598019+11
20854	35423	99.95	GBP	2026-03-22 18:53:05.598019+11
20855	35424	80.00	GBP	2026-03-22 18:53:05.598019+11
20856	35425	222.66	GBP	2026-03-22 18:53:05.598019+11
20857	35426	231.01	GBP	2026-03-22 18:53:05.598019+11
20858	35427	125.50	GBP	2026-03-22 18:53:05.598019+11
20859	35428	251.21	GBP	2026-03-22 18:53:05.598019+11
20860	35429	568.58	GBP	2026-03-22 18:53:05.598019+11
20861	35430	393.76	GBP	2026-03-22 18:53:05.598019+11
20862	35431	259.27	GBP	2026-03-22 18:53:05.598019+11
20863	35432	253.90	GBP	2026-03-22 18:53:05.598019+11
20864	35433	199.99	GBP	2026-03-22 18:53:05.598019+11
20865	35434	179.00	GBP	2026-03-22 18:53:05.598019+11
20866	35435	135.90	GBP	2026-03-22 18:53:05.598019+11
20867	35436	149.99	GBP	2026-03-22 18:53:05.598019+11
20868	35437	349.00	GBP	2026-03-22 18:53:05.598019+11
20869	35438	344.71	EUR	2026-03-22 18:53:05.598019+11
20870	35439	579.00	GBP	2026-03-22 18:53:05.598019+11
20871	35440	369.00	GBP	2026-03-22 18:53:05.598019+11
20872	35441	78.70	GBP	2026-03-22 18:53:05.598019+11
20873	35442	414.69	GBP	2026-03-22 18:53:05.598019+11
20874	35443	260.69	GBP	2026-03-22 18:53:05.598019+11
20875	35444	399.00	GBP	2026-03-22 18:53:05.598019+11
20876	35445	179.99	GBP	2026-03-22 18:53:05.598019+11
20877	35446	149.99	GBP	2026-03-22 18:53:05.598019+11
20878	35447	329.00	GBP	2026-03-22 18:53:05.598019+11
20879	35448	70.00	GBP	2026-03-22 18:53:05.598019+11
20880	35449	449.00	GBP	2026-03-22 18:53:05.598019+11
20881	35450	45.00	GBP	2026-03-22 18:53:05.598019+11
20882	35451	79.99	GBP	2026-03-22 18:53:05.598019+11
20883	35452	79.99	GBP	2026-03-22 18:53:05.598019+11
20884	35453	79.99	GBP	2026-03-22 18:53:05.598019+11
20885	35454	311.84	GBP	2026-03-22 18:53:05.598019+11
20886	35455	525.00	GBP	2026-03-22 18:53:05.598019+11
20887	35456	79.99	GBP	2026-03-22 18:53:05.598019+11
20888	35457	39.99	GBP	2026-03-22 18:53:05.598019+11
20889	35458	89.99	GBP	2026-03-22 18:53:05.598019+11
20890	35459	39.99	GBP	2026-03-22 18:53:05.598019+11
20891	35460	79.99	GBP	2026-03-22 18:53:05.598019+11
20892	35461	69.99	GBP	2026-03-22 18:53:05.598019+11
20893	35462	79.99	GBP	2026-03-22 18:53:05.598019+11
20894	35463	89.99	GBP	2026-03-22 18:53:05.598019+11
20895	35464	79.99	GBP	2026-03-22 18:53:05.598019+11
20896	35465	39.99	GBP	2026-03-22 18:53:05.598019+11
20897	35466	79.99	GBP	2026-03-22 18:53:05.598019+11
20898	35467	44.99	GBP	2026-03-22 18:53:05.598019+11
20899	35468	167.10	GBP	2026-03-22 18:53:05.598019+11
20900	35469	135.90	GBP	2026-03-22 18:53:05.598019+11
20901	35470	79.99	GBP	2026-03-22 18:53:05.598019+11
20902	35471	783.22	GBP	2026-03-22 18:53:05.598019+11
20903	35472	62.95	GBP	2026-03-22 18:53:05.598019+11
20904	35473	149.97	GBP	2026-03-22 18:53:05.598019+11
20905	35474	350.00	GBP	2026-03-22 18:53:05.598019+11
20906	35475	150.00	GBP	2026-03-22 18:53:05.598019+11
20907	35476	57.99	GBP	2026-03-22 18:53:05.598019+11
20908	35477	54.99	GBP	2026-03-22 18:53:05.598019+11
20909	35478	89.99	GBP	2026-03-22 18:53:05.598019+11
20910	35479	299.00	GBP	2026-03-22 18:53:05.598019+11
20911	35480	299.00	GBP	2026-03-22 18:53:05.598019+11
20912	35481	190.00	GBP	2026-03-22 18:53:05.598019+11
20913	35482	130.00	GBP	2026-03-22 18:53:05.598019+11
20914	35483	290.00	GBP	2026-03-22 18:53:05.598019+11
20915	35484	300.00	GBP	2026-03-22 18:53:05.598019+11
20916	35485	301.26	GBP	2026-03-22 18:53:05.598019+11
20917	35486	1199.99	GBP	2026-03-22 18:53:05.598019+11
20918	35487	849.00	GBP	2026-03-22 18:53:05.598019+11
20919	35488	1912.00	GBP	2026-03-22 18:53:05.598019+11
20920	35489	3855.00	GBP	2026-03-22 18:53:05.598019+11
20921	35490	2279.00	GBP	2026-03-22 18:53:05.598019+11
20922	35491	1804.00	GBP	2026-03-22 18:53:05.598019+11
20923	35492	1778.00	GBP	2026-03-22 18:53:05.598019+11
20924	35493	2207.00	GBP	2026-03-22 18:53:05.598019+11
20925	35494	219.99	GBP	2026-03-22 18:53:05.598019+11
20926	35495	74.99	GBP	2026-03-22 18:53:05.598019+11
20927	35496	1270.00	GBP	2026-03-22 18:53:05.598019+11
20928	35497	219.99	GBP	2026-03-22 18:53:05.598019+11
20929	35498	589.00	GBP	2026-03-22 18:53:05.598019+11
20930	35499	1489.00	GBP	2026-03-22 18:53:05.598019+11
20931	35500	489.00	GBP	2026-03-22 18:53:05.598019+11
20932	35501	539.00	GBP	2026-03-22 18:53:05.598019+11
20933	35502	639.00	GBP	2026-03-22 18:53:05.598019+11
20934	35503	189.99	GBP	2026-03-22 18:53:05.598019+11
20935	35504	149.99	GBP	2026-03-22 18:53:05.598019+11
20936	35505	79.99	GBP	2026-03-22 18:53:05.598019+11
20937	35506	149.99	GBP	2026-03-22 18:53:05.598019+11
20938	35507	199.00	GBP	2026-03-22 18:53:05.598019+11
20939	35508	359.99	GBP	2026-03-22 18:53:05.598019+11
20940	35509	247.99	GBP	2026-03-22 18:53:05.598019+11
20941	35510	180.00	GBP	2026-03-22 18:53:05.598019+11
20942	35511	144.99	GBP	2026-03-22 18:53:05.598019+11
20943	35512	163.70	GBP	2026-03-22 18:53:05.598019+11
20944	35513	129.99	GBP	2026-03-22 18:53:05.598019+11
20945	35514	1699.90	GBP	2026-03-22 18:53:05.598019+11
20946	35515	59.95	GBP	2026-03-22 18:53:05.598019+11
20947	35516	98.46	GBP	2026-03-22 18:53:05.598019+11
20948	35517	499.00	GBP	2026-03-22 18:53:05.598019+11
20949	35518	550.00	GBP	2026-03-22 18:53:05.598019+11
20950	35519	899.00	GBP	2026-03-22 18:53:05.598019+11
20951	35520	233.24	GBP	2026-03-22 18:53:05.598019+11
20952	35521	233.24	GBP	2026-03-22 18:53:05.598019+11
20953	35522	145.26	GBP	2026-03-22 18:53:05.598019+11
20954	35523	239.90	GBP	2026-03-22 18:53:05.598019+11
20955	35524	95.00	GBP	2026-03-22 18:53:05.598019+11
20956	35525	99.99	GBP	2026-03-22 18:53:05.598019+11
20957	35526	599.00	GBP	2026-03-22 18:53:05.598019+11
20958	35527	39.99	GBP	2026-03-22 18:53:05.598019+11
20959	35528	225.00	GBP	2026-03-22 18:53:05.598019+11
20960	35529	579.00	GBP	2026-03-22 18:53:05.598019+11
20961	35530	329.00	GBP	2026-03-22 18:53:05.598019+11
20962	35531	549.00	GBP	2026-03-22 18:53:05.598019+11
20963	35532	281.69	GBP	2026-03-22 18:53:05.598019+11
20964	35533	579.00	GBP	2026-03-22 18:53:05.598019+11
20965	35534	369.00	GBP	2026-03-22 18:53:05.598019+11
20966	35535	63.10	GBP	2026-03-22 18:53:05.598019+11
20967	35536	73.50	GBP	2026-03-22 18:53:05.598019+11
20968	35537	94.30	GBP	2026-03-22 18:53:05.598019+11
20969	35538	109.90	GBP	2026-03-22 18:53:05.598019+11
20970	35539	167.10	GBP	2026-03-22 18:53:05.598019+11
20971	35540	73.50	GBP	2026-03-22 18:53:05.598019+11
20972	35541	499.00	GBP	2026-03-22 18:53:05.598019+11
20973	35542	1850.00	GBP	2026-03-22 18:53:05.598019+11
20974	35543	182.70	GBP	2026-03-22 18:53:05.598019+11
20975	35544	94.26	GBP	2026-03-22 18:53:05.598019+11
20976	35545	1550.00	GBP	2026-03-22 18:53:05.598019+11
20977	35546	301.26	GBP	2026-03-22 18:53:05.598019+11
20978	35547	149.99	GBP	2026-03-22 18:53:05.598019+11
20979	35548	700.00	GBP	2026-03-22 18:53:05.598019+11
20980	35549	2499.00	GBP	2026-03-22 18:53:05.598019+11
20981	35550	1950.00	GBP	2026-03-22 18:53:05.598019+11
20982	35551	182.70	GBP	2026-03-22 18:53:05.598019+11
20983	35552	259.99	GBP	2026-03-22 18:53:05.598019+11
20984	35553	159.61	GBP	2026-03-22 18:53:05.598019+11
20985	35554	1100.00	GBP	2026-03-22 18:53:05.598019+11
20986	35555	195.00	GBP	2026-03-22 18:53:05.598019+11
20987	35556	210.00	GBP	2026-03-22 18:53:05.598019+11
20988	35557	149.71	GBP	2026-03-22 18:53:05.598019+11
20989	35558	210.00	GBP	2026-03-22 18:53:05.598019+11
20990	35559	210.00	GBP	2026-03-22 18:53:05.598019+11
20991	35560	440.20	GBP	2026-03-22 18:53:05.598019+11
20992	35561	145.00	GBP	2026-03-22 18:53:05.598019+11
20993	35562	924.69	GBP	2026-03-22 18:53:05.598019+11
20994	35563	158.76	GBP	2026-03-22 18:53:05.598019+11
20995	35564	180.00	GBP	2026-03-22 18:53:05.598019+11
20996	35565	275.00	GBP	2026-03-22 18:53:05.598019+11
20997	35566	1247.75	GBP	2026-03-22 18:53:05.598019+11
20998	35567	1518.91	EUR	2026-03-22 18:53:05.598019+11
20999	35568	150.00	EUR	2026-03-22 18:53:05.598019+11
21000	35569	349.99	EUR	2026-03-22 18:53:05.598019+11
21001	35570	504.99	EUR	2026-03-22 18:53:05.598019+11
21002	35571	2035.39	EUR	2026-03-22 18:53:05.598019+11
21003	35572	199.99	EUR	2026-03-22 18:53:05.598019+11
21004	35573	180.00	EUR	2026-03-22 18:53:05.598019+11
21005	35574	120.00	EUR	2026-03-22 18:53:05.598019+11
21006	35575	250.00	EUR	2026-03-22 18:53:05.598019+11
21007	35576	450.00	EUR	2026-03-22 18:53:05.598019+11
21008	35577	599.00	EUR	2026-03-22 18:53:05.598019+11
21009	35578	1340.59	EUR	2026-03-22 18:53:05.598019+11
21010	35579	1340.59	EUR	2026-03-22 18:53:05.598019+11
21011	35580	1895.19	EUR	2026-03-22 18:53:05.598019+11
21012	35581	1287.39	EUR	2026-03-22 18:53:05.598019+11
21013	35582	1795.39	EUR	2026-03-22 18:53:05.598019+11
21014	35583	2917.00	EUR	2026-03-22 18:53:05.598019+11
21015	35584	1324.59	EUR	2026-03-22 18:53:05.598019+11
21016	35585	743.89	EUR	2026-03-22 18:53:05.598019+11
21017	35586	169.99	EUR	2026-03-22 18:53:05.598019+11
21018	35587	489.00	EUR	2026-03-22 18:53:05.598019+11
21019	35588	2665.95	EUR	2026-03-22 18:53:05.598019+11
21020	35589	1034.39	EUR	2026-03-22 18:53:05.598019+11
21021	35590	879.79	EUR	2026-03-22 18:53:05.598019+11
21022	35591	3431.39	EUR	2026-03-22 18:53:05.598019+11
21023	35592	1327.19	EUR	2026-03-22 18:53:05.598019+11
21024	35593	1120.89	EUR	2026-03-22 18:53:05.598019+11
21025	35594	1038.39	EUR	2026-03-22 18:53:05.598019+11
21026	35595	1933.91	EUR	2026-03-22 18:53:05.598019+11
21027	35596	1222.00	EUR	2026-03-22 18:53:05.598019+11
21028	35597	499.00	EUR	2026-03-22 18:53:05.598019+11
21029	35598	895.79	EUR	2026-03-22 18:53:05.598019+11
21030	35599	1940.93	EUR	2026-03-22 18:53:05.598019+11
21031	35600	189.00	EUR	2026-03-22 18:53:05.598019+11
21032	35601	123.00	EUR	2026-03-22 18:53:05.598019+11
21033	35602	195.00	EUR	2026-03-22 18:53:05.598019+11
21034	35603	279.00	EUR	2026-03-22 18:53:05.598019+11
21035	35604	310.00	EUR	2026-03-22 18:53:05.598019+11
21036	35605	39.00	EUR	2026-03-22 18:53:05.598019+11
21037	35606	1132.61	EUR	2026-03-22 18:53:05.598019+11
21038	35607	599.99	EUR	2026-03-22 18:53:05.598019+11
21039	35608	199.00	EUR	2026-03-22 18:53:05.598019+11
21040	35609	120.00	EUR	2026-03-22 18:53:05.598019+11
21041	35610	219.00	EUR	2026-03-22 18:53:05.598019+11
21042	35611	195.00	EUR	2026-03-22 18:53:05.598019+11
21043	35612	180.00	EUR	2026-03-22 18:53:05.598019+11
21044	35613	179.00	EUR	2026-03-22 18:53:05.598019+11
21045	35614	1499.99	EUR	2026-03-22 18:53:05.598019+11
21046	35615	60.00	EUR	2026-03-22 18:53:05.598019+11
21047	35616	55.00	EUR	2026-03-22 18:53:05.598019+11
21048	35617	250.00	EUR	2026-03-22 18:53:05.598019+11
21049	35618	379.00	EUR	2026-03-22 18:53:05.598019+11
21050	35619	589.00	EUR	2026-03-22 18:53:05.598019+11
21051	35620	1490.00	EUR	2026-03-22 18:53:05.598019+11
21052	35621	119.00	EUR	2026-03-22 18:53:05.598019+11
21053	35622	4502.07	EUR	2026-03-22 18:53:05.598019+11
21054	35623	250.00	EUR	2026-03-22 18:53:05.598019+11
21055	35624	130.00	EUR	2026-03-22 18:53:05.598019+11
21056	35625	1300.00	EUR	2026-03-22 18:53:05.598019+11
21057	35626	249.00	EUR	2026-03-22 18:53:05.598019+11
21058	35627	310.00	EUR	2026-03-22 18:53:05.598019+11
21059	35628	359.00	EUR	2026-03-22 18:53:05.598019+11
21060	35629	50.90	EUR	2026-03-22 18:53:05.598019+11
21061	35630	423.00	EUR	2026-03-22 18:53:05.598019+11
21062	35631	150.00	EUR	2026-03-22 18:53:05.598019+11
21063	35632	1399.90	EUR	2026-03-22 18:53:05.598019+11
21064	35633	249.00	EUR	2026-03-22 18:53:05.598019+11
21065	35634	149.00	EUR	2026-03-22 18:53:05.598019+11
21066	35635	300.00	EUR	2026-03-22 18:53:05.598019+11
21067	35636	179.00	EUR	2026-03-22 18:53:05.598019+11
21068	35637	149.00	EUR	2026-03-22 18:53:05.598019+11
21069	35638	280.00	EUR	2026-03-22 18:53:05.598019+11
21070	35639	1499.90	EUR	2026-03-22 18:53:05.598019+11
21071	35640	649.00	EUR	2026-03-22 18:53:05.598019+11
21072	35641	249.00	EUR	2026-03-22 18:53:05.598019+11
21073	35642	599.00	EUR	2026-03-22 18:53:05.598019+11
21074	35643	180.00	EUR	2026-03-22 18:53:05.598019+11
21075	35644	159.00	EUR	2026-03-22 18:53:05.598019+11
21076	35645	240.00	EUR	2026-03-22 18:53:05.598019+11
21077	35646	1449.69	EUR	2026-03-22 18:53:05.598019+11
21078	35647	1449.69	EUR	2026-03-22 18:53:05.598019+11
21079	35648	2071.09	EUR	2026-03-22 18:53:05.598019+11
21080	35649	2491.00	EUR	2026-03-22 18:53:05.598019+11
21081	35650	1538.89	EUR	2026-03-22 18:53:05.598019+11
21082	35651	4901.39	EUR	2026-03-22 18:53:05.598019+11
21083	35652	4901.39	EUR	2026-03-22 18:53:05.598019+11
21084	35653	4901.39	EUR	2026-03-22 18:53:05.598019+11
21085	35654	4901.39	EUR	2026-03-22 18:53:05.598019+11
21086	35655	1518.91	EUR	2026-03-22 18:53:05.598019+11
21087	35656	1102.19	EUR	2026-03-22 18:53:05.598019+11
21088	35657	1465.69	EUR	2026-03-22 18:53:05.598019+11
21089	35658	4901.39	EUR	2026-03-22 18:53:05.598019+11
21090	35659	1465.69	EUR	2026-03-22 18:53:05.598019+11
21091	35660	1465.69	EUR	2026-03-22 18:53:05.598019+11
21092	35661	1705.39	EUR	2026-03-22 18:53:05.598019+11
21093	35662	1465.69	EUR	2026-03-22 18:53:05.598019+11
21094	35663	1251.39	EUR	2026-03-22 18:53:05.598019+11
21095	35664	1465.69	EUR	2026-03-22 18:53:05.598019+11
21096	35665	1465.69	EUR	2026-03-22 18:53:05.598019+11
21097	35666	1465.69	EUR	2026-03-22 18:53:05.598019+11
21098	35667	1067.59	EUR	2026-03-22 18:53:05.598019+11
21099	35668	1042.39	EUR	2026-03-22 18:53:05.598019+11
21100	35669	2479.00	EUR	2026-03-22 18:53:05.598019+11
21101	35670	855.00	EUR	2026-03-22 18:53:05.598019+11
21102	35671	1042.39	EUR	2026-03-22 18:53:05.598019+11
21103	35672	893.09	EUR	2026-03-22 18:53:05.598019+11
21104	35673	2503.07	EUR	2026-03-22 18:53:05.598019+11
21105	35674	8624.42	EUR	2026-03-22 18:53:05.598019+11
21106	35675	6615.86	EUR	2026-03-22 18:53:05.598019+11
21107	35676	5641.99	EUR	2026-03-22 18:53:05.598019+11
21108	35677	1625.93	EUR	2026-03-22 18:53:05.598019+11
21109	35679	2032.33	EUR	2026-03-22 18:53:05.598019+11
21110	35680	2063.75	EUR	2026-03-22 18:53:05.598019+11
21111	35681	2578.01	EUR	2026-03-22 18:53:05.598019+11
21112	35682	1060.34	EUR	2026-03-22 18:53:05.598019+11
21113	35683	479.00	EUR	2026-03-22 18:53:05.598019+11
21114	35684	1226.00	EUR	2026-03-22 18:53:05.598019+11
21115	35685	2236.67	EUR	2026-03-22 18:53:05.598019+11
21116	35686	2461.69	EUR	2026-03-22 18:53:05.598019+11
21117	35687	1067.59	EUR	2026-03-22 18:53:05.598019+11
21118	35688	893.09	EUR	2026-03-22 18:53:05.598019+11
21119	35689	1280.59	EUR	2026-03-22 18:53:05.598019+11
21120	35690	1190.09	EUR	2026-03-22 18:53:05.598019+11
21121	35691	325.00	EUR	2026-03-22 18:53:05.598019+11
21122	35692	1242.58	EUR	2026-03-22 18:53:05.598019+11
21123	35693	2028.13	EUR	2026-03-22 18:53:05.598019+11
21124	35694	2508.86	EUR	2026-03-22 18:53:05.598019+11
21125	35695	1713.92	EUR	2026-03-22 18:53:05.598019+11
21126	35696	1285.53	EUR	2026-03-22 18:53:05.598019+11
21127	35697	1404.93	EUR	2026-03-22 18:53:05.598019+11
21128	35698	1397.60	EUR	2026-03-22 18:53:05.598019+11
21129	35699	2501.55	EUR	2026-03-22 18:53:05.598019+11
21130	35700	1272.96	EUR	2026-03-22 18:53:05.598019+11
21131	35701	1154.60	EUR	2026-03-22 18:53:05.598019+11
21132	35702	1225.83	EUR	2026-03-22 18:53:05.598019+11
21133	35703	1201.74	EUR	2026-03-22 18:53:05.598019+11
21134	35704	1500.24	EUR	2026-03-22 18:53:05.598019+11
21135	35705	2393.67	EUR	2026-03-22 18:53:05.598019+11
21136	35706	2012.42	EUR	2026-03-22 18:53:05.598019+11
21137	35707	1988.33	EUR	2026-03-22 18:53:05.598019+11
21138	35708	1786.18	EUR	2026-03-22 18:53:05.598019+11
21139	35709	1459.40	EUR	2026-03-22 18:53:05.598019+11
21140	35710	1521.20	EUR	2026-03-22 18:53:05.598019+11
21141	35711	1411.21	EUR	2026-03-22 18:53:05.598019+11
21142	35712	2118.20	EUR	2026-03-22 18:53:05.598019+11
21143	35713	4162.71	EUR	2026-03-22 18:53:05.598019+11
21144	35714	1283.43	EUR	2026-03-22 18:53:05.598019+11
21145	35715	1227.92	EUR	2026-03-22 18:53:05.598019+11
21146	35716	2434.52	EUR	2026-03-22 18:53:05.598019+11
21147	35717	2132.87	EUR	2026-03-22 18:53:05.598019+11
21148	35718	6596.85	EUR	2026-03-22 18:53:05.598019+11
21149	35719	907.42	EUR	2026-03-22 18:53:05.598019+11
21150	35720	2266.93	EUR	2026-03-22 18:53:05.598019+11
21151	35721	2315.11	EUR	2026-03-22 18:53:05.598019+11
21152	35722	3706.79	EUR	2026-03-22 18:53:05.598019+11
21153	35723	1084.43	EUR	2026-03-22 18:53:05.598019+11
21154	35724	2111.92	EUR	2026-03-22 18:53:05.598019+11
21155	35725	1694.01	EUR	2026-03-22 18:53:05.598019+11
21156	35726	1634.31	EUR	2026-03-22 18:53:05.598019+11
21157	35727	2227.13	EUR	2026-03-22 18:53:05.598019+11
21158	35728	2159.05	EUR	2026-03-22 18:53:05.598019+11
21159	35729	2733.02	EUR	2026-03-22 18:53:05.598019+11
21160	35730	2315.11	EUR	2026-03-22 18:53:05.598019+11
21161	35731	1801.89	EUR	2026-03-22 18:53:05.598019+11
21162	35732	1330.55	EUR	2026-03-22 18:53:05.598019+11
21163	35733	1758.95	EUR	2026-03-22 18:53:05.598019+11
21164	35734	250.00	EUR	2026-03-22 18:53:05.598019+11
21165	35735	1556.00	EUR	2026-03-22 18:53:05.598019+11
21166	35736	1317.00	EUR	2026-03-22 18:53:05.598019+11
21167	35737	1465.69	EUR	2026-03-22 18:53:05.598019+11
21168	35738	1518.91	EUR	2026-03-22 18:53:05.598019+11
21169	35739	2137.00	EUR	2026-03-22 18:53:05.598019+11
21170	35740	1723.69	EUR	2026-03-22 18:53:05.598019+11
21171	35741	1795.39	EUR	2026-03-22 18:53:05.598019+11
21172	35742	1689.39	EUR	2026-03-22 18:53:05.598019+11
21173	35743	1287.39	EUR	2026-03-22 18:53:05.598019+11
21174	35744	740.00	EUR	2026-03-22 18:53:05.598019+11
21175	35745	760.00	EUR	2026-03-22 18:53:05.598019+11
21176	35746	150.00	EUR	2026-03-22 18:53:05.598019+11
21177	35747	150.00	EUR	2026-03-22 18:53:05.598019+11
21178	35748	100.00	EUR	2026-03-22 18:53:05.598019+11
21179	35749	349.90	EUR	2026-03-22 18:53:05.598019+11
21180	35750	434.51	EUR	2026-03-22 18:53:05.598019+11
21181	35751	180.50	EUR	2026-03-22 18:53:05.598019+11
21182	35752	599.00	AUD	2026-03-22 18:53:05.598019+11
21183	35753	269.00	AUD	2026-03-22 18:53:05.598019+11
21184	35754	289.00	AUD	2026-03-22 18:53:05.598019+11
21185	35755	359.00	AUD	2026-03-22 18:53:05.598019+11
21186	35756	369.00	AUD	2026-03-22 18:53:05.598019+11
21187	35757	220.00	AUD	2026-03-22 18:53:05.598019+11
21188	35758	239.00	AUD	2026-03-22 18:53:05.598019+11
21189	35759	239.00	AUD	2026-03-22 18:53:05.598019+11
21190	35760	990.67	AUD	2026-03-22 18:53:05.598019+11
21191	35761	2899.99	AUD	2026-03-22 18:53:05.598019+11
21192	35762	854.88	AUD	2026-03-22 18:53:05.598019+11
21193	35763	354.21	AUD	2026-03-22 18:53:05.598019+11
21194	35764	2919.65	AUD	2026-03-22 18:53:05.598019+11
21195	35765	407.23	AUD	2026-03-22 18:53:05.598019+11
21196	35766	407.23	AUD	2026-03-22 18:53:05.598019+11
21197	35767	2975.92	AUD	2026-03-22 18:53:05.598019+11
21198	35768	812.90	AUD	2026-03-22 18:53:05.598019+11
21199	35769	1065.01	AUD	2026-03-22 18:53:05.598019+11
21200	35770	352.41	AUD	2026-03-22 18:53:05.598019+11
21201	35771	469.87	AUD	2026-03-22 18:53:05.598019+11
21202	35772	180.12	AUD	2026-03-22 18:53:05.598019+11
21203	35773	311.69	AUD	2026-03-22 18:53:05.598019+11
21204	35774	938.20	AUD	2026-03-22 18:53:05.598019+11
21205	35775	313.26	AUD	2026-03-22 18:53:05.598019+11
21206	35776	587.36	AUD	2026-03-22 18:53:05.598019+11
21207	35777	503.13	AUD	2026-03-22 18:53:05.598019+11
21208	35778	781.57	AUD	2026-03-22 18:53:05.598019+11
21209	35779	1096.38	AUD	2026-03-22 18:53:05.598019+11
21210	35780	649.99	AUD	2026-03-22 18:53:05.598019+11
21211	35781	391.56	AUD	2026-03-22 18:53:05.598019+11
21212	35782	375.89	AUD	2026-03-22 18:53:05.598019+11
21213	35783	375.89	AUD	2026-03-22 18:53:05.598019+11
21214	35784	4096.00	AUD	2026-03-22 18:53:05.598019+11
21215	35785	3254.00	AUD	2026-03-22 18:53:05.598019+11
21216	35786	383.72	AUD	2026-03-22 18:53:05.598019+11
21217	35787	383.72	AUD	2026-03-22 18:53:05.598019+11
21218	35788	391.56	AUD	2026-03-22 18:53:05.598019+11
21219	35789	383.72	AUD	2026-03-22 18:53:05.598019+11
21220	35790	383.72	AUD	2026-03-22 18:53:05.598019+11
21221	35791	407.22	AUD	2026-03-22 18:53:05.598019+11
21222	35792	467.54	AUD	2026-03-22 18:53:05.598019+11
21223	35793	407.22	AUD	2026-03-22 18:53:05.598019+11
21224	35794	468.32	AUD	2026-03-22 18:53:05.598019+11
21225	35795	453.44	AUD	2026-03-22 18:53:05.598019+11
21226	35796	249.96	AUD	2026-03-22 18:53:05.598019+11
21227	35797	610.78	AUD	2026-03-22 18:53:05.598019+11
21228	35798	546.63	AUD	2026-03-22 18:53:05.598019+11
21229	35799	469.87	AUD	2026-03-22 18:53:05.598019+11
21230	35800	530.97	AUD	2026-03-22 18:53:05.598019+11
21231	35801	562.30	AUD	2026-03-22 18:53:05.598019+11
21232	35802	2349.42	AUD	2026-03-22 18:53:05.598019+11
21233	35803	155.06	AUD	2026-03-22 18:53:05.598019+11
21234	35804	610.78	AUD	2026-03-22 18:53:05.598019+11
21235	35805	266.27	AUD	2026-03-22 18:53:05.598019+11
21236	35806	610.69	AUD	2026-03-22 18:53:05.598019+11
21237	35807	523.88	AUD	2026-03-22 18:53:05.598019+11
21238	35808	386.92	AUD	2026-03-22 18:53:05.598019+11
21239	35809	367.08	AUD	2026-03-22 18:53:05.598019+11
21240	35810	227.11	AUD	2026-03-22 18:53:05.598019+11
21241	35811	203.60	AUD	2026-03-22 18:53:05.598019+11
21242	35813	900.00	AUD	2026-03-22 18:53:05.598019+11
21243	35814	140.95	AUD	2026-03-22 18:53:05.598019+11
21244	35815	172.28	AUD	2026-03-22 18:53:05.598019+11
21245	35816	187.94	AUD	2026-03-22 18:53:05.598019+11
21246	35817	300.00	AUD	2026-03-22 18:53:05.598019+11
21247	35818	85.60	AUD	2026-03-22 18:53:05.598019+11
21248	35819	264.70	AUD	2026-03-22 18:53:05.598019+11
21249	35820	233.38	AUD	2026-03-22 18:53:05.598019+11
21250	35821	311.69	AUD	2026-03-22 18:53:05.598019+11
21251	35822	501.20	AUD	2026-03-22 18:53:05.598019+11
21252	35823	501.21	AUD	2026-03-22 18:53:05.598019+11
21253	35824	500.00	AUD	2026-03-22 18:53:05.598019+11
21254	35825	344.58	AUD	2026-03-22 18:53:05.598019+11
21255	35826	468.32	AUD	2026-03-22 18:53:05.598019+11
21256	35827	1929.67	AUD	2026-03-22 18:53:05.598019+11
21257	35828	343.02	AUD	2026-03-22 18:53:05.598019+11
21258	35829	468.32	AUD	2026-03-22 18:53:05.598019+11
21259	35830	438.56	AUD	2026-03-22 18:53:05.598019+11
21260	35831	916.28	AUD	2026-03-22 18:53:05.598019+11
21261	35832	212.97	AUD	2026-03-22 18:53:05.598019+11
21262	35833	1080.71	AUD	2026-03-22 18:53:05.598019+11
21263	35834	352.41	AUD	2026-03-22 18:53:05.598019+11
21264	35835	551.32	AUD	2026-03-22 18:53:05.598019+11
21265	35836	274.41	AUD	2026-03-22 18:53:05.598019+11
21266	35837	390.00	AUD	2026-03-22 18:53:05.598019+11
21267	35838	797.81	AUD	2026-03-22 18:53:05.598019+11
21268	35840	1076.04	AUD	2026-03-22 18:53:05.598019+11
21269	35841	2175.57	AUD	2026-03-22 18:53:05.598019+11
21270	35842	148.80	AUD	2026-03-22 18:53:05.598019+11
21271	35843	101.79	AUD	2026-03-22 18:53:05.598019+11
21272	35844	300.00	AUD	2026-03-22 18:53:05.598019+11
21273	35845	234.93	AUD	2026-03-22 18:53:05.598019+11
21274	35846	593.62	AUD	2026-03-22 18:53:05.598019+11
21275	35847	1065.06	AUD	2026-03-22 18:53:05.598019+11
21276	35848	953.87	AUD	2026-03-22 18:53:05.598019+11
21277	35849	1251.46	AUD	2026-03-22 18:53:05.598019+11
21278	35850	501.21	AUD	2026-03-22 18:53:05.598019+11
21279	35851	313.19	AUD	2026-03-22 18:53:05.598019+11
21280	35852	352.34	AUD	2026-03-22 18:53:05.598019+11
21281	35853	853.62	AUD	2026-03-22 18:53:05.598019+11
21282	35854	266.27	AUD	2026-03-22 18:53:05.598019+11
21283	35855	258.44	AUD	2026-03-22 18:53:05.598019+11
21284	35856	1065.07	AUD	2026-03-22 18:53:05.598019+11
21285	35857	2526.88	AUD	2026-03-22 18:53:05.598019+11
21286	35858	577.96	AUD	2026-03-22 18:53:05.598019+11
21287	35859	344.57	AUD	2026-03-22 18:53:05.598019+11
21288	35860	906.88	AUD	2026-03-22 18:53:05.598019+11
\.


--
-- Data for Name: ram; Type: TABLE DATA; Schema: public; Owner: thinkpaduser
--

COPY public.ram (id, size) FROM stdin;
1	4GB
2	8GB
3	16GB
4	32GB
5	64GB
6	128GB
7	1GB
8	128MB
9	256MB
10	512MB
11	16MB
12	32MB
13	64MB
14	2GB
15	24GB
16	1TB
17	3GB
18	2.5GB
19	16 GB
20	8 GB
\.


--
-- Data for Name: specs; Type: TABLE DATA; Schema: public; Owner: thinkpaduser
--

COPY public.specs (id, cpu, cpu_freq, ram, storage, storage_type, screen_size, display, gpu, os, listing_id, raw_ram, raw_storage, raw_storage_type, ram_processed, storage_processed, storage_type_processed) FROM stdin;
22907	\N	\N	\N	\N	\N	\N	\N	\N	\N	35307	\N	\N	\N	f	f	t
22764	Intel Core i5 3rd Gen.	\N	\N	\N	\N	12.5 in	\N	\N	Windows 10 LTSC	35414	\N	\N	\N	f	f	t
22772	Not Available	\N	\N	\N	\N	Not Available	\N	\N	\N	35171	\N	\N	\N	f	f	t
22773	11th Generation Intel Core i7-11800H	\N	\N	\N	SSD	17.3 in	\N	Dedicated Graphics	\N	35172	\N	\N	SSD (Solid State Drive)	f	f	t
22765	Intel Core Ultra 7	\N	32	2048	SSD	14 in	\N	\N	Windows 11 Pro	35241	32 GB	2 TB	SSD (Solid State Drive)	t	t	t
22766	Intel Core i5 10th Gen.	\N	\N	256	\N	14 in	\N	\N	\N	35812	\N	256 GB	\N	f	t	t
22767	Intel Core i7 8th Gen.	1.90 GHz	16	512	SSD	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	35839	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
22768	AMD Ryzen 7 7735HS	\N	32	1024	SSD	16 in	\N	\N	\N	35167	32 GB	1 TB	SSD (Solid State Drive)	t	t	t
22769	AMD Ryzen 7	\N	16	512	SSD	14 in	1920 x 1080	AMD Radeon Graphics	Windows 11 Pro	35168	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
22770	Intel Core i3 5th Gen.	2.00 GHz	4	4	\N	14 in	\N	Integrated/On-Board Graphics	Not Included	35169	4 GB	4 GB	\N	t	t	t
22771	Intel Core i3 5th Gen.	2.00 GHz	4	4	\N	14 in	\N	Integrated/On-Board Graphics	Not Included	35170	4 GB	4 GB	\N	t	t	t
22774	Intel Core i7 10th Gen.	1.80 GHz	16	512	SSD	14 in	1920 x 1080	Intel UHD Graphics	Windows 11 Pro	35173	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
22775	AMD Ryzen 7 PRO 4750U	2.30 GHz	16	512	SSD	14 in	1920 x 1080	AMD Radeon Graphics	Windows 11 Pro	35174	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
22776	\N	\N	\N	512	\N	\N	\N	\N	\N	35175	\N	512 GB	\N	f	t	t
22777	AMD Ryzen 7	2.70 GHz	16	512	SSD	14 in	1920 x 1200	AMD Radeon 680M	Windows 11 Pro	35176	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
22778	Intel Core i7-10610U	2.30 GHz	48	1024	SSD	14 in	1920 x 1080	NVIDIA Quadro P520	Windows 11 Pro	35177	48GB	1 TB	SSD (Solid State Drive)	t	t	t
22779	Intel Core i7-1185G7	3.00 GHz	48	1024	SSD	14 in	1920 x 1080	NVIDIA Quadro T500	Windows 11 Pro	35178	48 GB	1 TB	SSD (Solid State Drive)	t	t	t
22780	\N	\N	\N	256	\N	\N	\N	\N	\N	35179	\N	256 GB	\N	f	t	t
22781	Intel Core i7 11th Gen.	3.00 GHz	32	1024	SSD	14 in	3840 x 2400	Intel Iris Xe Graphics	Windows 11 Pro	35180	32 GB	1 TB	SSD (Solid State Drive)	t	t	t
22782	Intel Core i7 11th Gen.	3.00 GHz	16	1024	SSD	14 in	3840 x 2400	Intel Iris Xe Graphics	Windows 11 Pro	35181	16 GB	1 TB	SSD (Solid State Drive)	t	t	t
22783	\N	\N	\N	512	\N	\N	\N	\N	\N	35182	\N	512 GB	\N	f	t	t
22784	Intel Core i7 11th Gen.	3.00 GHz	32	1024	SSD	14 in	3840 x 2400	Intel Iris Xe Graphics	Windows 11 Pro	35183	32 GB	1 TB	SSD (Solid State Drive)	t	t	t
22785	Intel Core i7 8th Gen.	1.90 GHz	32	1024	SSD	14 in	1920 x 1080	NVIDIA GeForce MX150	Windows 11 Pro	35184	32 GB	1 TB	SSD (Solid State Drive)	t	t	t
22786	Intel Core i5 3rd Gen.	\N	8	128	SSD	14 in	\N	Intel HD Graphics 4000	Windows 11 Pro	35185	8 GB	128 GB	SSD (Solid State Drive)	t	t	t
22787	Intel Core i5-8250U	1.70 GHz	16	256	SSD	14 in	1920 x 1080	Intel UHD Graphics 620	Linux	35186	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
22788	i7-1165G7	2.80 GHz	16	512	SSD	14 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	35187	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
22789	Intel(R) Core(TM) i5-3427U CPU @ 1.80GHz	1.80GHz	4	128	\N	14 in.	1600 x 900	Intel HD Graphics 4000	Windows 10 Pro	35188	4 GB	128 GB	Not Included	t	t	t
22795	Intel Core i7 i7-13700HX	\N	\N	\N	\N	16 in	2560x1600	\N	\N	35194	\N	\N	\N	f	f	t
22832	258V	\N	\N	\N	\N	14.0	1920 x 1200	Intel	Windows 11 Home	35231	\N	\N	\N	f	f	t
22848	Intel Core i7 @ 2.6GHz	\N	\N	\N	\N	15.6 in	\N	\N	\N	35248	\N	\N	\N	f	f	t
22793	U5-135U	\N	\N	512	\N	14.0	1920 x 1200	\N	Windows 11 Pro	35192	\N	512GB	\N	f	t	t
22805	1140G7	\N	\N	262	\N	12.0	1920 x 1280	\N	Windows 11 Home	35204	\N	262GB	\N	f	t	t
22809	I5-10210U	\N	\N	262	\N	15.0	1920 x 1080 (FHD)	\N	Windows 11 Pro	35208	\N	262GB	\N	f	t	t
22810	I5-1245U	\N	\N	262	\N	14.0	1920 x 1200 WUXGA	\N	Windows 11 Pro	35209	\N	262GB	\N	f	t	t
22811	Ryzen 5 PRO 4650U	\N	\N	262	\N	14.0	1920 x 1080 (FHD)	\N	Windows 11 Pro	35210	\N	262GB	\N	f	t	t
22812	4650U	2.1 GHz	\N	512	\N	14.0	1920 x 1080	\N	Windows 11 Pro	35211	\N	512GB	\N	f	t	t
22815	Intel Core i5 1st Gen.	\N	\N	500	HDD	14 in	\N	Intel HD Graphics	Windows 10	35214	\N	500 GB	HDD (Hard Disk Drive)	f	t	t
22818	Intel i5-1135G7	\N	\N	256	SSD	14 in	\N	\N	Windows 11 Pro	35217	\N	256 GB	SSD (Solid State Drive)	f	t	t
22824	I5-1135G7	\N	\N	262	\N	14.0	1920 x 1080 (FHD)	\N	Windows 11 Pro	35223	\N	262GB	\N	f	t	t
22825	I5-10310U	\N	\N	512	\N	14.0	1920 x 1080	\N	Windows 11 Pro	35224	\N	512GB	\N	f	t	t
22826	228V	\N	\N	1024	\N	14.0	2880 x 1800	Intel(R) Arc(TM)	Windows 11 Home	35225	\N	1.0TB	\N	f	t	t
22827	I5-10310U	\N	\N	262	\N	15.0	1920 x 1080 (FHD)	\N	Windows 10 Pro	35226	\N	262GB	\N	f	t	t
22828	Ryzen 7 Pro 4750U	\N	\N	512	\N	14.0	1920 x 1080	\N	Windows 10	35227	\N	512GB	\N	f	t	t
22829	10210U	1.6 GHz	\N	512	\N	14.0	1920 x 1080	\N	Windows 11 Pro	35228	\N	512GB	\N	f	t	t
22830	4650U	\N	\N	262	\N	14.0	1920 x 1080 (FHD)	\N	Windows 11 Pro	35229	\N	262GB	\N	f	t	t
22831	4650U	2.1 GHz	\N	262	\N	14.0	1920 x 1080	AMD	Windows 11 Pro	35230	\N	262GB	\N	f	t	t
22833	1335U	\N	\N	512	\N	13.0	1920 x 1200	\N	Windows 11 Pro	35232	\N	512GB	\N	f	t	t
22834	7730U	\N	\N	1024	\N	13.0	1920 x 1200	\N	Windows 11	35233	\N	1.0TB	\N	f	t	t
22835	I5-1335U	\N	\N	512	\N	13.0	1920 x 1200 WUXGA	\N	Windows 11 Home	35234	\N	512GB	\N	f	t	t
22836	3015e	\N	\N	131	\N	14.0	1366 x 768 (HD)	\N	Windows	35235	\N	131GB	\N	f	t	t
22837	268V	\N	\N	2048	\N	14.0	2880 x 1800	Intel(R) Arc(TM)	No OS	35236	\N	2.0TB	\N	f	t	t
22844	Intel Core i5 3rd Gen	1.70 GHz	\N	24	SSD	12.5 in	1366 x 768	Intel HD Graphics 4000	Windows 10	35244	\N	24GB	HDD + SSD	f	t	t
22921	7535U	2.9 GHz	\N	512	\N	16.0	1920 x 1200	AMD	Windows 11 Pro	35321	\N	512GB	\N	f	t	t
22852	NONE	\N	\N	\N	\N	14 in	\N	\N	\N	35252	\N	\N	\N	f	f	t
22867	\N	\N	\N	\N	\N	\N	\N	\N	\N	35267	\N	\N	\N	f	f	t
22871	\N	\N	\N	\N	\N	\N	\N	\N	\N	35271	\N	\N	\N	f	f	t
22872	\N	\N	\N	\N	\N	\N	\N	\N	\N	35272	\N	\N	\N	f	f	t
22911	\N	\N	\N	\N	\N	\N	\N	\N	\N	35311	\N	\N	\N	f	f	t
22850	AMD Ryzen 7	\N	\N	512	SSD	16 in	1920 x 1200	Integrated/On-Board Graphics	Windows 11 Pro	35250	\N	512 GB	SSD (Solid State Drive)	f	t	t
22857	185H	2.3 GHz	\N	2048	\N	16.0	2560 x 1600	NVIDIA	Windows 11 Pro	35257	\N	2.0TB	\N	f	t	t
22858	1140G7	1.8 GHz	\N	256	\N	12.3	1920 x 1280	\N	No OS	35258	\N	256GB	\N	f	t	t
22860	125U	\N	\N	262	\N	14.0	1920 x 1200	\N	Windows 11 Pro	35260	\N	262GB	\N	f	t	t
22861	8840HS	3.3 GHz	\N	1024	\N	14.0	1920 x 1200	AMD	Windows 11 Pro	35261	\N	1.0TB	\N	f	t	t
22862	I5-10310U	\N	\N	512	\N	14.0	1920 x 1080 (FHD)	\N	Windows 11 Pro	35262	\N	512GB	\N	f	t	t
22863	4650U	\N	\N	262	\N	14.0	1920 x 1080 (FHD)	\N	Windows 11 Pro	35263	\N	262GB	\N	f	t	t
22864	I5-10310U	\N	\N	512	\N	14.0	1920 x 1080	\N	Windows 11 Pro	35264	\N	512GB	\N	f	t	t
22865	I7-1185G7	\N	\N	1024	\N	14.0	1920 x 1200 WUXGA	\N	Windows 11 Pro	35265	\N	1.0TB	\N	f	t	t
22866	Ryzen 5 PRO 4650U	\N	\N	262	\N	14.0	1920 x 1080 (FHD)	\N	Windows 11 Pro	35266	\N	262GB	\N	f	t	t
22868	10310U	1.7 GHz	\N	262	\N	14.0	1920 x 1080	\N	Windows 11 Pro - Nordic	35268	\N	262GB	\N	f	t	t
22869	Intel Core Ultra 5 226V	\N	\N	512	\N	14.0	1920 x 1200 WUXGA	Intel(R) Arc(TM)	Windows 11 Home	35269	\N	512GB	\N	f	t	t
22870	I5-10310U	\N	\N	262	\N	14.0	1920 x 1080 (FHD)	\N	Windows 10 Pro	35270	\N	262GB	\N	f	t	t
22913	4650U	\N	\N	512	\N	14.0	1920 x 1080 (FHD)	\N	Windows 11 Pro	35313	\N	512GB	\N	f	t	t
22914	838	\N	\N	131	\N	11.0	1920 x 1200	\N	Chrome	35314	\N	131GB	\N	f	t	t
22915	Ryzen 5 7530U	\N	\N	512	\N	13.0	1920 x 1200	\N	Windows 11 Pro	35315	\N	512GB	\N	f	t	t
22916	120U	\N	\N	512	\N	16.0	1920 x 1200	\N	Windows 11 Home	35316	\N	512GB	\N	f	t	t
22917	1355U	\N	\N	512	\N	14.0	1920 x 1080	\N	No OS	35317	\N	512GB	\N	f	t	t
22918	7840U	\N	\N	512	\N	14.0	1920 x 1200 WUXGA	AMD	No OS	35318	\N	512GB	\N	f	t	t
22919	13850HX	\N	\N	1024	\N	16.0	2560 x 1600	NVIDIA	Windows 11 Pro	35319	\N	1.0TB	\N	f	t	t
22920	I9-12950HX	\N	\N	1024	\N	16.0	3840 x 2400 WQUXGA	\N	No OS	35320	\N	1.0TB	\N	f	t	t
22948	Not Available	\N	\N	\N	\N	Not Available	\N	\N	\N	35348	\N	\N	\N	f	f	t
22949	Not Available	\N	\N	\N	\N	Not Available	\N	\N	\N	35349	\N	\N	\N	f	f	t
22954	Intel Core m3 8th Gen.	\N	\N	\N	\N	11 in	\N	Integrated/On-Board Graphics	Windows for Education	35354	\N	\N	\N	f	f	t
22922	AMD Ryzen 5 Pro 7535U	2.9 GHz	\N	512	\N	16.0	1920 x 1200	AMD	Windows 11 Pro (FR)	35322	\N	512GB	\N	f	t	t
22923	1185G7	\N	\N	512	\N	14.0	1920 x 1200	\N	Windows 11 Pro	35323	\N	512GB	\N	f	t	t
22924	1185G7	\N	\N	256	\N	14.0	1920 x 1080	\N	Windows 11 Pro	35324	\N	256GB	\N	f	t	t
22925	225U	\N	\N	512	\N	16.0	1920 x 1200	\N	Windows 11 Pro	35325	\N	512GB	\N	f	t	t
22926	4650U	2.1 GHz	\N	512	\N	14.0	1920 x 1080	AMD	Windows 11 Pro	35326	\N	512GB	\N	f	t	t
22927	4750U	1.7 GHz	\N	512	\N	14.0	1920 x 1080	\N	Windows 11 Pro	35327	\N	512GB	\N	f	t	t
22930	10210U	\N	\N	262	\N	14.0	1920 x 1080	\N	Windows 11 Pro	35330	\N	262GB	\N	f	t	t
22931	I5-10310U	\N	\N	262	\N	14.0	1920 x 1080 (FHD)	\N	Windows 11 Pro	35331	\N	262GB	\N	f	t	t
22933	Ryzen 5 PRO 4650U	\N	\N	262	\N	14.0	1920 x 1080 (FHD)	\N	Windows 11 Pro	35333	\N	262GB	\N	f	t	t
22934	1145G7	\N	\N	256	\N	14.0	1920 x 1080	\N	Windows 11 Pro	35334	\N	256GB	\N	f	t	t
22935	I7-1165G7	\N	\N	512	\N	14.0	1920 x 1080 (FHD)	\N	Windows 11 Pro	35335	\N	512GB	\N	f	t	t
22936	I5-10310U	\N	\N	262	\N	14.0	1920 x 1080 (FHD)	\N	Windows 10 Pro	35336	\N	262GB	\N	f	t	t
22937	I5-10210U	\N	\N	512	\N	14.0	1920 x 1080 (FHD)	\N	Windows 11 Pro	35337	\N	512GB	\N	f	t	t
22938	I5-10210U	\N	\N	262	\N	15.0	1920 x 1080 (FHD)	\N	Windows 11 Pro	35338	\N	262GB	\N	f	t	t
22939	I5-10310U	\N	\N	262	\N	14.0	1920 x 1080 (FHD)	\N	Windows 10 Pro	35339	\N	262GB	\N	f	t	t
22940	I5-10310U	\N	\N	262	\N	15.0	1920 x 1080 (FHD)	\N	\N	35340	\N	262GB	\N	f	t	t
22941	I5-10210U	\N	\N	262	\N	14.0	1920 x 1080 (FHD)	\N	Windows 10 Pro	35341	\N	262GB	\N	f	t	t
22942	838	\N	\N	131	\N	11.0	1920 x 1200	\N	Chrome	35342	\N	131GB	\N	f	t	t
22943	1135G7	\N	\N	262	\N	13.0	1920 x 1080	\N	Windows 10 Home	35343	\N	262GB	\N	f	t	t
22944	\N	2.40 GHz	\N	\N	\N	15.6"	\N	\N	\N	35344	\N	0	\N	f	t	t
22950	I5-1135G7	\N	\N	262	\N	14.0	1920 x 1080 (FHD)	\N	Windows 11 Pro	35350	\N	262GB	\N	f	t	t
22951	Ryzen 7 Pro 5850U	\N	\N	512	\N	14.0	1920 x 1080 (FHD)	\N	Windows 11	35351	\N	512GB	\N	f	t	t
22952	I5-10210U	\N	\N	262	\N	14.0	1920 x 1080 (FHD)	\N	Windows 10 Pro	35352	\N	262GB	\N	f	t	t
22967	258V	\N	\N	1024	\N	14.0	2880x1800	\N	Windows 11	35367	\N	1.0TB	\N	f	t	t
22981	Inte Core i5 3320M 2.6 GHz	\N	\N	119	SSD	14 in	1366 x 768	Intel HD Graphics 4000	Windows 10 Pro	35381	\N	119GB	SSD (Solid State Drive)	f	t	t
23000	\N	\N	\N	\N	\N	\N	\N	\N	\N	35678	\N	\N	\N	f	f	t
22986	Intel Core i5-4200U	1.60 GHz	\N	4	\N	12.5 in	\N	\N	Windows 10 Pro	35386	\N	4 GB	\N	f	t	t
23010	Intel Core i7 11. Gen	2.00-2.49GHz	\N	1024	\N	13.5"	2256 x 1504	\N	Windows 11 Pro	35409	\N	1TB	\N	f	t	t
23011	Intel Core i5-6300U	\N	\N	256	\N	14 in	1600 x 900	\N	\N	35410	\N	256 GB	\N	f	t	t
23025	Intel Core i5 8. gene	1.60GHz	\N	256	\N	14.5 inches (36.8cm)	1920 x 1080	\N	Windows 11 Pros	35425	\N	256GB	\N	f	t	t
23026	Intel Core i5 8. gene	1.60GHz	\N	256	\N	14.5 inches (36.8cm)	1920 x 1080	\N	Windows 11 Pros	35426	\N	256GB	\N	f	t	t
23031	Intel Core i5 8. gene	1.60GHz	\N	256	\N	14,5 Zoll (36,8 cm)	1920 x 1080	\N	Windows 11 Pros	35431	\N	256GB	\N	f	t	t
23032	Intel Core i5 8. gene	1.60GHz	\N	256	\N	14,5 Zoll (36,8 cm)	1920 x 1080	\N	Windows 11 Pros	35432	\N	256GB	\N	f	t	t
23045	\N	\N	\N	\N	\N	\N	\N	\N	\N	35445	\N	\N	\N	f	f	t
23046	\N	\N	\N	\N	\N	\N	\N	\N	\N	35446	\N	\N	\N	f	f	t
23051	\N	\N	\N	\N	\N	\N	\N	\N	\N	35451	\N	\N	\N	f	f	t
23052	\N	\N	\N	\N	\N	\N	\N	\N	\N	35452	\N	\N	\N	f	f	t
23053	\N	\N	\N	\N	\N	\N	\N	\N	\N	35453	\N	\N	\N	f	f	t
23057	\N	\N	\N	\N	\N	\N	\N	\N	\N	35457	\N	\N	\N	f	f	t
23058	\N	\N	\N	\N	\N	\N	\N	\N	\N	35458	\N	\N	\N	f	f	t
23059	\N	\N	\N	\N	\N	\N	\N	\N	\N	35459	\N	\N	\N	f	f	t
23060	\N	\N	\N	\N	\N	\N	\N	\N	\N	35460	\N	\N	\N	f	f	t
23061	\N	\N	\N	\N	\N	\N	\N	\N	\N	35461	\N	\N	\N	f	f	t
23062	\N	\N	\N	\N	\N	\N	\N	\N	\N	35462	\N	\N	\N	f	f	t
23063	\N	\N	\N	\N	\N	\N	\N	\N	\N	35463	\N	\N	\N	f	f	t
23064	\N	\N	\N	\N	\N	\N	\N	\N	\N	35464	\N	\N	\N	f	f	t
23065	\N	\N	\N	\N	\N	\N	\N	\N	\N	35465	\N	\N	\N	f	f	t
23066	\N	\N	\N	\N	\N	\N	\N	\N	\N	35466	\N	\N	\N	f	f	t
23067	\N	\N	\N	\N	\N	\N	\N	\N	\N	35467	\N	\N	\N	f	f	t
23080	\N	\N	\N	\N	\N	\N	\N	\N	\N	35480	\N	\N	\N	f	f	t
23082	AMD PRO A12-8830B R7	\N	\N	\N	\N	12.5 in	\N	\N	\N	35482	\N	\N	\N	f	f	t
23088	AMD Ryzen AI 7 PRO 350	\N	\N	\N	\N	14 in	\N	\N	\N	35488	\N	\N	\N	f	f	t
23089	Intel Core Ultra 9 275HX	\N	\N	\N	\N	16 in	\N	\N	\N	35489	\N	\N	\N	f	f	t
23090	AMD Ryzen AI 7 PRO 350	\N	\N	\N	\N	16 in	\N	\N	\N	35490	\N	\N	\N	f	f	t
23091	AMD Ryzen AI 7 PRO 350	\N	\N	\N	\N	16 in	\N	\N	\N	35491	\N	\N	\N	f	f	t
23092	AMD Ryzen AI 7 PRO 350	\N	\N	\N	\N	14 in	\N	\N	\N	35492	\N	\N	\N	f	f	t
23093	AMD Ryzen AI 7 PRO 350	\N	\N	\N	\N	14 in	\N	\N	\N	35493	\N	\N	\N	f	f	t
23096	AMD Ryzen™ 5 PRO 215	\N	\N	\N	\N	14 in	\N	\N	\N	35496	\N	\N	\N	f	f	t
23127	\N	\N	\N	\N	\N	\N	\N	\N	\N	35527	\N	\N	\N	f	f	t
23106	Intel Core i5 8th Gen.	1.70 GHz	\N	256	NVMe	14 in	1920 x 1080	\N	Windows 11 Pro	35506	\N	256 GB	NVMe (Non-Volatile Memory Express)	f	t	t
23121	Intel Core i5 8. gene	1.70GHz	\N	256	\N	14.5 inches (36.8cm)	1920 x 1080	\N	Windows 11 Pros	35521	\N	256GB	\N	f	t	t
23136	Intel Core i5-6300U	\N	\N	256	SSD	14 in	1920 x 1080	Intel HD Graphics	\N	35536	\N	256 GB	SSD (Solid State Drive)	f	t	t
23137	Intel Core i5 8th Gen.	\N	\N	256	SSD	14 in	1920 x 1080	Integrated/On-Board Graphics	Windows 11 Pro	35537	\N	256 GB	SSD (Solid State Drive)	f	t	t
23166	Not Available	\N	\N	\N	\N	Not Available	\N	\N	\N	35566	\N	\N	\N	f	f	t
23174	Intel Core I5-7200U	\N	\N	\N	\N	15,6 Zoll	\N	\N	Windows 10	35574	\N	\N	\N	f	f	t
23200	Ryzen 5	\N	\N	\N	\N	13 Zoll	\N	\N	\N	35600	\N	\N	\N	f	f	t
23201	Ryzen 3	\N	\N	\N	\N	13 Zoll	\N	\N	\N	35601	\N	\N	\N	f	f	t
23202	Core i5	\N	\N	\N	\N	13 Zoll	\N	\N	\N	35602	\N	\N	\N	f	f	t
23203	Ryzen 5	\N	\N	\N	\N	13 Zoll	\N	\N	\N	35603	\N	\N	\N	f	f	t
23205	Pentium M 1,4Ghz	\N	\N	\N	HDD	15 Zoll	\N	\N	Windows XP	35605	\N	\N	HDD (Hard Disk Drive)	f	f	t
23206	\N	\N	\N	\N	\N	\N	\N	\N	\N	35606	\N	\N	\N	f	f	t
23222	\N	\N	\N	\N	\N	\N	\N	\N	\N	35622	\N	\N	\N	f	f	t
23211	Intel Core i7-8550U	\N	\N	256	SSD	15,6 Zoll	1920 x 1080	\N	\N	35611	\N	256 GB	SSD (Solid State Drive)	f	t	t
23213	Intel Core i5-8350U	1,70 GHz	\N	256	SSD	14 Zoll	1920 x 1080	Intel HD Graphics 620	Windows 11 Pro	35613	\N	256 GB	SSD (Solid State Drive)	f	t	t
23223	Intel Pentium M	1,50 GHz	\N	40	HDD	12,1 Zoll	1024 x 768	\N	Windows XP	35623	\N	40 GB	HDD (Hard Disk Drive)	f	t	t
23224	Intel Core i7 6. Gen	\N	\N	512	SSD	14 Zoll	1920 x 1080	\N	Windows 11 Pro	35624	\N	512 GB	SSD (Solid State Drive)	f	t	t
23227	Intel Core i5-10310U	\N	\N	512	\N	14-14,9 Zoll	\N	\N	Windows 11 Pro	35627	\N	512 GB	\N	f	t	t
23234	Intel Core i7 8. Gen	\N	\N	16	\N	15 Zoll	\N	\N	Nicht enthalten	35635	\N	16 GB	\N	f	t	t
23235	Intel Core i5-8350U	1,70 GHz	\N	256	SSD	14 Zoll	1920 x 1080	Intel HD Graphics 620	Windows 11 Pro	35636	\N	256 GB	SSD (Solid State Drive)	f	t	t
23246	8840U	\N	32	512	SSD	14.0	1920 x 1200	AMD	\N	35647	32 GB	512 GB	SSD M.2	t	t	t
23276	\N	\N	\N	\N	\N	\N	\N	\N	\N	35677	\N	\N	\N	f	f	t
23277	\N	\N	\N	\N	\N	\N	\N	\N	\N	35679	\N	\N	\N	f	f	t
23278	\N	\N	\N	\N	\N	\N	\N	\N	\N	35680	\N	\N	\N	f	f	t
23279	\N	\N	\N	\N	\N	\N	\N	\N	\N	35681	\N	\N	\N	f	f	t
23280	\N	\N	\N	\N	\N	\N	\N	\N	\N	35682	\N	\N	\N	f	f	t
23290	\N	\N	\N	\N	\N	\N	\N	\N	\N	35692	\N	\N	\N	f	f	t
23291	\N	\N	\N	\N	\N	\N	\N	\N	\N	35693	\N	\N	\N	f	f	t
23292	\N	\N	\N	\N	\N	\N	\N	\N	\N	35694	\N	\N	\N	f	f	t
23293	\N	\N	\N	\N	\N	\N	\N	\N	\N	35695	\N	\N	\N	f	f	t
23294	\N	\N	\N	\N	\N	\N	\N	\N	\N	35696	\N	\N	\N	f	f	t
23295	\N	\N	\N	\N	\N	\N	\N	\N	\N	35697	\N	\N	\N	f	f	t
23296	\N	\N	\N	\N	\N	\N	\N	\N	\N	35698	\N	\N	\N	f	f	t
23297	\N	\N	\N	\N	\N	\N	\N	\N	\N	35699	\N	\N	\N	f	f	t
23298	\N	\N	\N	\N	\N	\N	\N	\N	\N	35700	\N	\N	\N	f	f	t
23299	\N	\N	\N	\N	\N	\N	\N	\N	\N	35701	\N	\N	\N	f	f	t
23300	\N	\N	\N	\N	\N	\N	\N	\N	\N	35702	\N	\N	\N	f	f	t
23301	\N	\N	\N	\N	\N	\N	\N	\N	\N	35703	\N	\N	\N	f	f	t
23302	\N	\N	\N	\N	\N	\N	\N	\N	\N	35704	\N	\N	\N	f	f	t
23303	\N	\N	\N	\N	\N	\N	\N	\N	\N	35705	\N	\N	\N	f	f	t
23304	\N	\N	\N	\N	\N	\N	\N	\N	\N	35706	\N	\N	\N	f	f	t
23305	\N	\N	\N	\N	\N	\N	\N	\N	\N	35707	\N	\N	\N	f	f	t
23306	\N	\N	\N	\N	\N	\N	\N	\N	\N	35708	\N	\N	\N	f	f	t
23307	\N	\N	\N	\N	\N	\N	\N	\N	\N	35709	\N	\N	\N	f	f	t
23308	\N	\N	\N	\N	\N	\N	\N	\N	\N	35710	\N	\N	\N	f	f	t
23309	\N	\N	\N	\N	\N	\N	\N	\N	\N	35711	\N	\N	\N	f	f	t
23310	\N	\N	\N	\N	\N	\N	\N	\N	\N	35712	\N	\N	\N	f	f	t
23311	\N	\N	\N	\N	\N	\N	\N	\N	\N	35713	\N	\N	\N	f	f	t
23312	\N	\N	\N	\N	\N	\N	\N	\N	\N	35714	\N	\N	\N	f	f	t
23313	\N	\N	\N	\N	\N	\N	\N	\N	\N	35715	\N	\N	\N	f	f	t
23314	\N	\N	\N	\N	\N	\N	\N	\N	\N	35716	\N	\N	\N	f	f	t
23315	\N	\N	\N	\N	\N	\N	\N	\N	\N	35717	\N	\N	\N	f	f	t
23316	\N	\N	\N	\N	\N	\N	\N	\N	\N	35718	\N	\N	\N	f	f	t
23318	\N	\N	\N	\N	\N	\N	\N	\N	\N	35720	\N	\N	\N	f	f	t
23319	\N	\N	\N	\N	\N	\N	\N	\N	\N	35721	\N	\N	\N	f	f	t
23320	\N	\N	\N	\N	\N	\N	\N	\N	\N	35722	\N	\N	\N	f	f	t
23321	\N	\N	\N	\N	\N	\N	\N	\N	\N	35723	\N	\N	\N	f	f	t
23322	\N	\N	\N	\N	\N	\N	\N	\N	\N	35724	\N	\N	\N	f	f	t
23323	\N	\N	\N	\N	\N	\N	\N	\N	\N	35725	\N	\N	\N	f	f	t
23324	\N	\N	\N	\N	\N	\N	\N	\N	\N	35726	\N	\N	\N	f	f	t
23325	\N	\N	\N	\N	\N	\N	\N	\N	\N	35727	\N	\N	\N	f	f	t
23326	\N	\N	\N	\N	\N	\N	\N	\N	\N	35728	\N	\N	\N	f	f	t
23327	\N	\N	\N	\N	\N	\N	\N	\N	\N	35729	\N	\N	\N	f	f	t
23328	\N	\N	\N	\N	\N	\N	\N	\N	\N	35730	\N	\N	\N	f	f	t
23329	\N	\N	\N	\N	\N	\N	\N	\N	\N	35731	\N	\N	\N	f	f	t
23330	\N	\N	\N	\N	\N	\N	\N	\N	\N	35732	\N	\N	\N	f	f	t
23331	\N	\N	\N	\N	\N	\N	\N	\N	\N	35733	\N	\N	\N	f	f	t
23348	AMD Ryzen 5 PRO	\N	\N	\N	\N	14 Zoll	1920x1080	\N	\N	35750	\N	\N	\N	f	f	t
23346	6300U, Core i5	2,40 GHz	\N	512	\N	12,5 Zoll	\N	Intel HD Graphics	Linux	35748	\N	512 GB	\N	f	t	t
23351	Intel Core i5 6th Gen.	\N	\N	256	SSD	12.5 in	\N	Intel HD Graphics	Windows 11 Pro	35753	\N	256 GB	SSD (Solid State Drive)	f	t	t
23352	Intel Core i5 6th Gen.	\N	\N	256	SSD	12.5 in	\N	Intel HD Graphics	Windows 11 Pro	35754	\N	256 GB	SSD (Solid State Drive)	f	t	t
23353	Intel Core i7 6th Gen.	\N	\N	256	SSD	12.5 in	\N	Intel HD Graphics	Windows 11 Pro	35755	\N	256 GB	SSD (Solid State Drive)	f	t	t
23354	Intel Core i7 6th Gen.	\N	\N	256	SSD	12.5 in	\N	Intel HD Graphics	Windows 11 Pro	35756	\N	256 GB	SSD (Solid State Drive)	f	t	t
23390	Intel Core i7 11th Gen.	2.80 GHz	\N	256	NVMe	14 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Home	35792	\N	256 GB	NVMe (Non-Volatile Memory Express)	f	t	t
23415	Intel Core i5-6200U	2.40 GHz	\N	\N	\N	14 in	\N	Intel HD Graphics	Not Included	35818	\N	\N	\N	f	f	t
23424	\N	\N	\N	\N	\N	\N	\N	\N	\N	35827	\N	\N	\N	f	f	t
23439	Intel Celeron	\N	\N	\N	\N	11 in	\N	\N	Chrome OS	35843	\N	\N	\N	f	f	t
23250	13850HX	\N	64	1024	SSD	16.0	2560 x 1600	NVIDIA	Windows 11 Pro	35651	64 GB	1.0 TB	SSD M.2	t	t	t
23405	See Title/Description	See Title/Description	\N	\N	\N	See Title	See Title/Description	\N	Not Included	35807	\N	See Title/Description	See Title/Description	f	t	t
23406	See Title/Description	See Title/Description	\N	\N	\N	See Title	See Title/Description	\N	Not Included	35808	\N	See Title/Description	See Title/Description	f	t	t
23436	\N	\N	\N	32	\N	\N	\N	\N	\N	35840	\N	32 GB	\N	f	t	t
22796	Intel Core Ultra 7 255H	\N	16	\N	\N	14 in	1920x1200	\N	\N	35195	16 GB	\N	\N	t	f	t
22797	AMD Ryzen 7 PRO 8840U	\N	32	\N	\N	14 in	1920x1200	\N	\N	35196	32 GB	\N	\N	t	f	t
22846	Intel Core i7 4th Gen.	2.90 GHz	16	\N	SSD	15.6 in	\N	\N	Windows 10 Pro	35246	16 GB	\N	SSD (Solid State Drive)	t	f	t
22792	i5-10210U	\N	16	256	SSD	14 in	1920 x 1080	Intel UHD Graphics	Windows 11 Pro	35191	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
22794	Intel Core i7 13th Gen.	2.10 GHz	32	1024	SSD	16 in	2560 x 1600	NVIDIA RTX 2000 Ada Generation	Windows 11 Pro	35193	32 GB	1 TB	SSD (Solid State Drive)	t	t	t
22798	Intel Core i5-8350U	1.70 GHz	8	256	SSD	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	35197	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
22799	AMD Ryzen 7	5.00 GHz	96	4096	SSD	14 in	1920 x 1200	AMD Radeon Graphics	Windows 11 Pro	35198	96 gb	4 TB	SSD (Solid State Drive)	t	t	t
22800	AMD Ryzen AI 300 Series	\N	16	512	SSD	14 in	1920 x 1200	AMD Radeon Graphics	Windows 11 Home	35199	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
22801	Intel Core i5-8350U	1.70 GHz	8	256	SSD	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	35200	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
22802	Intel Core i5 11th Gen.	2.40 GHz	8	256	SSD	15.6 in	1920 x 1080	Intel Iris Xe Graphics	Windows 10 Pro	35201	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
22803	Intel Core i5-8250U	1.60 GHz	8	500	SSD	13 in	3000 x 2000	Intel UHD Graphics 620	Windows 11 Pro	35202	8 GB	500 GB	SSD (Solid State Drive)	t	t	t
22804	Intel Core i7 10th Gen.	1.80 GHz	16	256	SSD	14 in	1920 x 1080	Intel UHD Graphics	Windows 11 Pro	35203	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
22806	Intel Core i5 7th Gen.	\N	8	256	SSD	15.6 in	1920 x 1080	Intel HD Graphics 620	Windows 10	35205	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
22807	Core Ultra 5	4.50 GHz	16	512	SSD	14 in	1920 x 1200	INTEGRATED ARC GRAPHICS	Windows 11 Pro	35206	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
22955	Intel Pentium M	\N	1	\N	\N	15 in	\N	\N	Windows XP	35355	1 GB	\N	\N	t	f	t
22973	I5-4300U	\N	8	\N	SSD	14 in	1366 x 768	Intel HD Graphics	Not Included	35373	8 GB	\N	SSD (Solid State Drive)	t	f	t
23030	Intel Core i7 8. gene	2.20GHz	16	\N	\N	15,6 Zoll	1920 x 1080	\N	Windows 11 Pros	35430	16 GB	\N	\N	t	f	t
23076	Intel Core i5-6200U	2.30 GHz	8	\N	\N	15.6 in	\N	Intel HD Graphics 520	Not Included	35476	8 GB	\N	\N	t	f	t
23122	Intel Pentium III	1.00 GHz	0.25	\N	HDD	14.1 in	1024 x 768	Integrated/On-Board Graphics	\N	35522	256 MB	\N	HDD (Hard Disk Drive)	t	f	t
23188	258V	\N	32	\N	SSD	14.0	1920 x 1200	Intel	Windows 11 Home	35588	32 GB	\N	SSD	t	f	t
23272	Core Ultra 7	\N	0.032	\N	\N	40,6 cm	\N	NVIDIA RTX 1000	\N	35673	32.768 MB	\N	\N	t	f	t
23273	Core Ultra 9	\N	0.096	\N	\N	40,6 cm	\N	NVIDIA RTX PRO 5000	\N	35674	98.304 MB	\N	\N	t	f	t
23274	Core Ultra 9	\N	0.096	\N	\N	40,6 cm	\N	NVIDIA RTX PRO 4000	\N	35675	98.304 MB	\N	\N	t	f	t
23275	Core Ultra 9	\N	0.096	\N	\N	40,6 cm	\N	NVIDIA RTX PRO 3000	\N	35676	98.304 MB	\N	\N	t	f	t
23427	\N	2.10 GHz	16	\N	SSD	15.6	\N	Intel HD Graphics 620	Not Included	35830	16 GB	\N	SSD (Solid State Drive)	t	f	t
23447	Intel Xeon	2.80 GHz	32	\N	SSD	15.6 in	\N	\N	\N	35851	32 GB	\N	SSD (Solid State Drive)	t	f	t
22900	NA	\N	\N	\N	SSD	NA	\N	NA	NA	35300	NA	NA	SSD	t	t	t
22790	8840HS	3.3 GHz	\N	1024	\N	14.0	1920 x 1200	AMD	Windows 11 Pro	35189	\N	1.0TB	\N	f	t	t
22791	Core Ultra 135U	\N	\N	262	\N	13.0	1920 x 1200	\N	Windows 11 Pro	35190	\N	262GB	\N	f	t	t
22808	Intel Core i7 11th Gen.	3.00 GHz	32	512	SSD	14 in	1920X1200	Integrated/On-Board Graphics	Not Included	35207	32 GB	512 GB	SSD (Solid State Drive)	t	t	t
22813	Intel Core i7 11th Gen.	3.00 GHz	32	512	SSD	14 in	1920X1200	Integrated/On-Board Graphics	Not Included	35212	32 GB	512 GB	SSD (Solid State Drive)	t	t	t
22814	AMD Ryzen 5 PRO 5000 Series	2.30 GHz	16	512	SSD	14 in	1920 x 1080	AMD Radeon Graphics	Windows 11 Pro	35213	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
22816	Intel Core i7 12th Gen.	3.40 GHz	16	256	SSD	14 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	35215	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
22817	Intel Core i5 8th Gen.	1.90 GHz	16	1024	SSD	14 in	2560 x 1440	Intel HD Graphics	Windows 11 Pro	35216	16 GB	1 TB	SSD (Solid State Drive)	t	t	t
22819	Intel Core i7 7th Gen.	2.80 GHz	16	512	SSD	14 in	1920 x 1080	Intel HD Graphics 620	Windows 11 Pro	35218	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
22820	Intel Core i5-8350U	1.70 GHz	8	256	SSD	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	35219	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
22821	Intel Core i5-8350U	1.70 GHz	8	256	SSD	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	35220	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
22822	Intel Core i5-8350U	1.70 GHz	8	256	SSD	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	35221	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
22823	Intel Core i7 11th Gen.	3.00 GHz	16	512	SSD	14 in	\N	\N	Windows 10 Pro	35222	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
22838	Intel Core i5-1035G1	1.00 GHz	8	256	SSD	17.3 in	1920 x 1080	Intel UHD Graphics	Windows 11 Home	35237	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
22839	Intel Core i5-8250U	\N	8	256	SSD	15.6 in	1920 x 1080	Intel UHD Graphics	Windows 11 Home	35238	8GB	256 GB	SSD (Solid State Drive)	t	t	t
22840	i3-N305	1.8GHz	8	128	SSD	15.8	1920 x 1080	UHD Graphics	Windows 11 Home	35239	8GB RAM	128GB	SSD	t	t	t
22841	Intel Core i7 10th Gen.	1.80 GHz	32	1024	SSD	14 in	\N	\N	Windows 11 Pro	35240	32 GB	1 TB	SSD (Solid State Drive)	t	t	t
22842	Intel Core i5 11th Gen.	\N	8	256	SSD	13.3 in	1920 x 1080	\N	Windows 11 Pro	35242	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
22843	Intel Core Ultra 7 155H	2.40 GHz	32	1024	SSD	16 in	2560 x 1600	NVIDIA RTX 2000 Ada Generation	Windows 11 Pro	35243	32 GB	1 TB	SSD (Solid State Drive)	t	t	t
22845	AMD Ryzen 5	\N	16	256	SSD	14 in	1920 x 1080	AMD Radeon Graphics	Windows 11 Pro	35245	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
22847	AMD Ryzen 7 PRO 4750U	\N	16	512	NVMe	14 in	1920 x 1080	AMD Radeon Graphics	Windows 11 Pro	35247	16 GB	512 GB	NVMe (Non-Volatile Memory Express)	t	t	t
22849	i5-1135G7 (11th Gen)	1.3GHz	8	256	SSD	14 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	35249	8GB	256GB	SSD (Solid State Drive)	t	t	t
22851	Intel Core i7 11th Gen.	3.00 GHz	32	512	SSD	14 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	35251	32 GB	512 GB	SSD (Solid State Drive)	t	t	t
22853	i5-1135G7 (11th Gen)	1.3GHz	8	256	SSD	14 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	35253	8GB	256GB	SSD (Solid State Drive)	t	t	t
22854	Intel Core Ultra 7	Intel Core Ultra 7 265U	32	1024	SSD	16 in	1920 x 1200	Intel Graphics	Windows 11 Pro	35254	32 GB	1 TB	SSD (Solid State Drive)	t	t	t
22855	core i7-2620M	2.70 GHz	16	256	SSD	14 in	1600 x 900	Intel HD Graphics 3000	Windows 11 Pro	35255	16 GB	256 GB	HDD + SSD	t	t	t
22856	Intel Core i5-1135G7	2.40 GHz	16	256	NVMe	14 in	1920 x 1080	Intel UHD Graphics	Windows 11 Pro	35256	16 GB	256 GB	NVMe (Non-Volatile Memory Express)	t	t	t
22859	Intel Core Ultra 5	1.60 GHz	16	512	SSD	14 in	1920 x 1200	Intel Graphics	Windows 11 Pro	35259	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
22873	NA	\N	\N	\N	\N	NA	\N	NA	NA	35273	NA	NA	NA	t	t	t
22874	NA	\N	\N	\N	\N	NA	\N	NA	NA	35274	NA	NA	NA	t	t	t
22875	Intel Core i5-7200U	\N	\N	\N	\N	12.5 inches (please convert cm to inches)	\N	NA	Windows	35275	NA	NA	NA	t	t	t
22876	NA	\N	\N	\N	\N	NA	\N	NA	NA	35276	NA	NA	NA	t	t	t
22877	NA	\N	\N	\N	SSD	NA	\N	NA	Windows 11 Pro	35277	NA	NA	SSD	t	t	t
22878	Intel Core i7-3520M (3rd Gen)	\N	\N	\N	SSD	NA	\N	NA	Windows 11 Pro	35278	NA	NA	SSD	t	t	t
22879	NA	\N	\N	\N	NVMe	13.3 inches	\N	NA	Windows 11 Pro	35279	NA	NA	NVMe SSD	t	t	t
22880	2.5GHz (exact model unspecified)	\N	\N	\N	\N	14 inches (please convert cm to inches)	\N	NA	Windows 10 Home	35280	NA	NA	NA	t	t	t
22881	Intel Core i7 1185	\N	\N	\N	\N	14 inches (please convert to cm: approximately 35.56 cm)	\N	NA	Windows 11 Pro	35281	NA	NA	NA	t	t	t
22882	NA	\N	\N	\N	\N	NA	\N	NA	NA	35282	NA	NA	NA	t	t	t
22883	Intel Core i5-8265U	\N	\N	\N	\N	NA	\N	NA	NA	35283	NA	NA	NA	t	t	t
22884	Intel Core i5-10210U (4 cores, 1.6GHz, up to 4.2GHz)	\N	\N	\N	\N	NA	\N	NA	Windows 11	35284	NA	NA	NA	t	t	t
22885	Intel Core i7 (7GHz)	\N	\N	\N	\N	14 inches	\N	NA	NA	35285	NA	NA	NA	t	t	t
22886	Intel Core i5-10210U (Please convert cm to inches for size	\N	\N	\N	\N	NA	\N	NA	Optional, with recovery media available	35286	NA	NA	NA	t	t	t
22887	NA	\N	\N	\N	\N	NA	\N	NA	NA	35287	NA	NA	NA	t	t	t
22888	NA	\N	\N	\N	\N	NA	\N	NA	NA	35288	NA	NA	NA	t	t	t
22889	NA	\N	\N	\N	\N	NA	\N	NA	NA	35289	NA	NA	NA	t	t	t
22890	Intel Core i5-1145G7 (2.6GHz)	\N	\N	\N	\N	NA	\N	NA	Windows 11 Pro 64-bit	35290	NA	NA	NA	t	t	t
22891	NA	\N	\N	\N	\N	NA	\N	NA	NA	35291	NA	NA	NA	t	t	t
22892	Intel Core i5-1145G7 (11th Gen)	\N	\N	\N	SSD	14 inches	\N	NA	NA	35292	NA	NA	SSD	t	t	t
22893	Intel 60GHz	\N	\N	\N	\N	NA	\N	NA	Windows 11 Pro	35293	NA	NA	NA	t	t	t
22894	NA	\N	\N	\N	\N	NA	\N	NA	Windows 11	35294	NA	NA	NA	t	t	t
22895	NA	\N	\N	\N	SSD	15.6 inches (please convert to inches)	\N	NA	Windows 11 Pro	35295	NA	NA	SSD	t	t	t
22896	AMD Ryzen 7	2.30 GHz	32	512	SSD	14 in	1920 x 1080	AMD Radeon Graphics	Windows 11 Pro	35296	32 GB	512 GB	SSD (Solid State Drive)	t	t	t
22897	Intel Core i5-1245	\N	\N	\N	\N	NA	\N	NA	NA	35297	NA	NA	NA	t	t	t
22898	NA	\N	\N	\N	\N	NA	\N	NA	NA	35298	NA	NA	NA	t	t	t
22899	Intel Core i5 (11th Gen)	\N	\N	\N	\N	14 inches	\N	NA	Windows 11	35299	NA	NA	NA	t	t	t
22901	Intel Core i5 (10th Gen)	\N	\N	\N	SSD	13.3 inches	\N	NA	Windows 11 Pro	35301	NA	NA	SSD (256GB)	t	t	t
22902	i5-1035G4	\N	8	256	SSD	14 in	1920 x 1080	Integrated/On-Board Graphics	Windows 11 Home	35302	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
22903	Intel Core Ultra 7-155H	2.50 GHz	32	1024	SSD	16 in	2560 x 1600	NVIDIA RTX 2000 Ada Generation	Windows 11 Pro	35303	32 GB	1 TB	SSD (Solid State Drive)	t	t	t
22904	core i7-2640M	2.80 GHz	16	128	SSD	14 in	1600 x 900	Intel HD Graphics 3000	Windows 11 Pro	35304	16 GB	128 GB	HDD + SSD	t	t	t
22905	Intel Core i5 11th Gen.	\N	16	256	NVMe	14"	1920 x 1080	Intel Iris Xe Graphics	Windows	35305	16 GB	256GB	nvme	t	t	t
22906	Intel Pentium M	1.86	2	30	\N	14 in	1400 x 1050	Dedicated Graphics	Windows XP	35306	2 GB	30 GB	\N	t	t	t
22908	Intel Core i7 8th Gen.	1.80 GHz	16	256	SSD	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	35308	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
22909	Intel Core Ultra 7 Series 2	\N	32	\N	SSD	14 in	2880 x 1800	Intel Arc	Windows 11 Pro	35309	32 GB	512 gigabytes	SSD	t	t	t
22910	Intel Core i7 1165G7	1.00 GHz	8	256	SSD	15.6 in	1920 x 1080	Intel IRIS Graphics 940	Windows 11 Pro	35310	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
22912	Core i5-2520M	2.50 GHz	8	120	SSD	14 in	1366 x 768	Intel HD Graphics 3000	Windows 11 Pro	35312	8 GB	120 GB	SSD (Solid State Drive)	t	t	t
22928	See Title/Description	See Title/Description	\N	\N	\N	See Title/Description	See Title/Description	See Title/Description	See Title/Description	35328	See Title/Description	See Title/Description	See Title/Description	t	t	t
22929	i5-1135G7 (11th Gen)	1.3GHz	8	256	SSD	14 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	35329	8GB	256GB	SSD (Solid State Drive)	t	t	t
22932	Intel Core Ultra 7 256V	2.20 GHz	16	1024	SSD	14 in	1920 x 1200	Intel Arc 140V (8GB)	Windows 11 Home	35332	16 GB	1 TB	SSD (Solid State Drive)	t	t	t
22945	Intel Core i7 13th Gen.	3.90 GHz	32	512	SSD	14 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	35345	32 GB	512 GB	SSD (Solid State Drive)	t	t	t
22946	Intel Cor i7-5500U	2.40 GHz	8	512	SSD	14 in	1920 x 1080	AMD Radeon Graphics	Windows 10	35346	8 GB	512 GB SSD	SSD (Solid State Drive)	t	t	t
22947	Intel Core i7-6600U	2.50-3.00 GHz	12	180	SSD	14 in	2560 x 1440	Intel HD Graphics	\N	35347	12 GB	180GB	SSD (Solid State Drive)	t	t	t
22953	AMD Ryzen 5 5600H	3.30 GHz	8	512	SSD	15.6 in	1920 x 1080	NVIDIA GeForce RTX 3050	Windows 11 Home	35353	8 GB	512 GB	SSD (Solid State Drive)	t	t	t
22956	See Title/Description	See Title/Description	\N	\N	\N	See Title/Description	See Title/Description	See Title/Description	See Title/Description	35356	See Title/Description	See Title/Description	See Title/Description	t	t	t
22957	i5-1135G7	2.40GHz	16	512	SSD	14 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	35357	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
22958	Intel Core i7 13th Gen.	2.10 GHz	64	512	SSD	16 in	2560 x 1600	NVIDIA RTX 2000 Ada Generation	Windows 11 Pro	35358	64 GB	512 GB	SSD (Solid State Drive)	t	t	t
22959	Intel Core i5-8250U	\N	8	256	SSD	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	35359	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
22960	Intel Core i3-8145U	\N	8	128	SSD	15.6"	\N	\N	Windows 10 Home	35360	8GB	128 GB	SSD (Solid State Drive)	t	t	t
22961	Intel Core i9-11950H	2.60 GHz	32	1024	NVMe	15.6	3840 x 2160	NVIDIA RTX A2000	Windows 11 Pro	35361	32 GB	1 TB	NVMe (Non-Volatile Memory Express)	t	t	t
22962	Intel Core i7 13th Gen.	1.70 GHz	16	1024	SSD	16 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Home	35362	16 GB	1 TB	SSD (Solid State Drive)	t	t	t
22963	i7-8665U	1.90 GHz	32	512	SSD	14 in	2560 x 1440	NVIDIA Quadro P520	Windows 11	35363	32 GB	512 GB	SSD (Solid State Drive)	t	t	t
22964	Intel Core i7 8th Gen.	1.90 GHz	8	512	SSD	15.6 in	1920 x 1080	NVIDIA Quadro P520	Windows 11 Pro	35364	8 GB	512 GB	SSD (Solid State Drive)	t	t	t
22965	i5-1135G7	2.4GHz	8	256	SSD	15.6"	\N	Intel Iris Xe Graphics	Windows 11 Home	35365	8GB RAM	256GB	SSD	t	t	t
22966	i7-4810MQ	2.80 GHz	16	1024	SSD	14 in	1920 x 1080	Nvidia GeForce GT 730M	Windows 10	35366	16 GB	1 TB	SSD (Solid State Drive)	t	t	t
22968	Intel Core i5 8. gene	1.60GHz	8	256	\N	14.5 inches (36.8cm)	1920 x 1080	\N	Windows 11 Pros	35368	8GB	256GB	\N	t	t	t
22969	Intel Core i5 10. gene	1.70GHz	8	256	\N	13,3 Zoll	1920 x 1080	\N	Windows 11 Pros	35369	8 GB	256GB	\N	t	t	t
22970	Intel Core i7 9. gene	2.60GHz	32	512	\N	15,6 Zoll	1920 x 1080	\N	Windows 11 Pros	35370	32 GB	512GB	\N	t	t	t
22971	Core i5	1.60 GHz	8	256	SSD	14 in	1920 x 1080	NA	Windows 11 Pro	35371	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
22972	Intel Core i5-1135G7	2.40 GHz	16	256	NVMe	13.3 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	35372	16 GB	256 GB	NVMe (Non-Volatile Memory Express)	t	t	t
22974	intel core i7 vpro 8th gen	\N	8	1024	SSD	14 in	1920 x 1080	Integrated/On-Board Graphics	Ubuntu	35374	8 GB	1 TB	SSD (Solid State Drive)	t	t	t
22975	Intel Core i5 8. gene	1.70GHz	8	256	\N	14.5 inches (36.8cm)	1920 x 1080	\N	Windows 11 Pros	35375	8GB	256GB	\N	t	t	t
22976	Intel Core i5 8. gene	1.70GHz	8	256	\N	14.5 inches (36.8cm)	1920 x 1080	\N	Windows 11 Pros	35376	8GB	256GB	\N	t	t	t
22977	Intel Core i5 8. gene	1.60GHz	8	256	\N	14,5 Zoll (36,8 cm)	1920 x 1080	\N	Windows 11 Pros	35377	8GB	256GB	\N	t	t	t
22978	Intel Core i5 8. gene	1.70GHz	8	256	\N	14,5 Zoll (36,8 cm)	1920 x 1080	\N	Windows 11 Pros	35378	8GB	256GB	\N	t	t	t
22979	Intel Core i3-10110U	2.10 GHz	8	128	\N	13,3 Zoll	1920 x 1080	\N	Windows 11 Pro	35379	8 GB	128 GB	\N	t	t	t
22980	AMD Ryzen 3500u	\N	8	256	NVMe	14 in	1920 x 1080	Integrated/On-Board Graphics	Windows 11 Pro	35380	8 GB	256 GB	NVMe (Non-Volatile Memory Express)	t	t	t
22982	Intel Core 2 Duo	\N	3	250	HDD	14 in	1280 x 800	\N	Linux	35382	3 GB	250 GB	HDD (Hard Disk Drive)	t	t	t
22983	Intel Core i5 12th Gen.	1.70 GHz	16	256	SSD	14 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	35383	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
22984	Intel Core i9 13th Gen.	2.60 GHz	32	1024	NVMe	16 in	2560 x 1600	NVIDIA GeForce RTX 4090	Windows 11 Pro	35384	32 GB	1 TB	Nvme	t	t	t
22985	i7-12800H	2.40 GHz	64	1843.2	SSD	16 in	2560 x 1600	NVIDIA RTX A4500	Windows 11 Home	35385	64 GB	1.8TB	SSD (Solid State Drive)	t	t	t
23270	7540U	\N	16	512	SSD	14.0	1920 x 1200 WUXGA	AMD	No OS	35671	16 GB	512 GB	SSD M.2	t	t	t
22987	Snapdragon 8cx Gen 3	3.00 GHz	16	256	SSD	13.3 in	1920 x 1200	Integrated/On-Board Graphics	Windows 11 Pro	35387	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
22988	AMD Ryzen 5 PRO 4000 Series	2.10 GHz	16	240	SSD	13.3 in	1920 x 1080	AMD Radeon Vega 6	Windows 11 Pro	35388	16 GB	240GB	SSD (Solid State Drive)	t	t	t
22989	Intel Core i5 8th Gen.	1.60 GHz	16	512	SSD	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	35389	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
22990	Intel Core i5-6300U	2.40 GHz	16	512	NVMe	14-14.9"	1920 x 1080	Intel HD Graphics	Windows 11 Pro	35390	16 GB	512 GB	NVMe (Non-Volatile Memory Express)	t	t	t
22991	Intel Core i5 10th Gen.	1.60 GHz	8	256	SSD	15.6 in	1920 x 1080	Integrated Intel UHD Graphics	Windows 10	35391	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
22992	Intel Ultra 7	4.80 GHz	32	1024	SSD	13.3 in	1920 x 1200	Intel UHD Graphics	Windows 11 Pro	35392	32 GB	1 TB	SSD (Solid State Drive)	t	t	t
22993	AMD Ryzen 5	\N	16	256	SSD	14 in	\N	AMD Radeon Graphics	Windows 11 Pro	35393	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
22994	Intel Core i5-1135G7	2.40 GHz	8	512	NVMe	13 in	1920 x 1080	Integrated/On-Board Graphics	Windows 11 Pro	35394	8 GB	512 GB	NVMe (Non-Volatile Memory Express)	t	t	t
22995	Intel Core i7 11th Gen.	\N	64	1024	SSD	15-15.9"	1920 x 1080	NVIDIA T600	Windows 11 Pro	35395	64 GB	1 TB	SSD (Solid State Drive)	t	t	t
22996	i5-M540	2.53GHz	4	150	HDD	12.1"	1280 x 800	Intel HD Graphics	Windows 10 Pro	35396	4GB RAM	150GB	HDD	t	t	t
22997	Intel Core i5 12th Gen.	1.70 GHz	16	256	SSD	14 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	35397	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
22998	Intel Core i5 6th Gen.	3.20 GHz - 3.60 GHz	8	256	SSD	14"	FHD (1920 x 1080)	Intel HD Graphics 530	Windows 10 Pro 64Bit	35398	8GB RAM	256 GB	SSD (Solid State Drive)	t	t	t
22999	intel i7 5600U	2.40 GHz	8	256	SSD	14 in	1920 x 1080	Intel HD Graphics 5500	Windows 10 Pro	35399	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
23001	Intel Core i5 4th Gen.	2.90 GHz	8	240	SSD	12.5 in	\N	Intel HD Graphics	Windows 11 Pro	35400	8 GB	240GB	SSD (Solid State Drive)	t	t	t
23002	Intel Core i7 1165G7	\N	16	500	SSD	14 in	\N	Integrated/On-Board Graphics	Windows 11 Pro	35401	16 GB	500 GB	SSD (Solid State Drive)	t	t	t
23003	Intel Core i5-10210U	1.60GHz	8	256	\N	13,3 Zoll	1920 x 1080	\N	Windows 11 Pros	35402	8 GB	256GB	\N	t	t	t
23004	Intel Core i7-8550U	1.60GHz	8	256	\N	13,3 Zoll	1920 x 1080	\N	Windows 11 Pros	35403	8 GB	256GB	\N	t	t	t
23005	Intel Core i7-8565U	1.90GHz	16	512	\N	15,6 Zoll	1920 x 1080	\N	Windows 11 Pros	35404	16 GB	512GB	\N	t	t	t
23006	Intel Core i5 5th Gen.	2.30 GHz	8	240	SSD	14 in	1366 x 768	Intel HD Graphics 5000	Windows 10 Pro	35405	8 GB	240GB	SSD (Solid State Drive)	t	t	t
23007	Intel Core i5 8th Gen.	1.60 GHz	16	256	NVMe	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	35406	16 GB	256 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23008	Intel Celeron	\N	8	16	SSD	11.6 in	\N	Integrated/On-Board Graphics	Chrome OS	35407	8 GB	16 GB	SSD (Solid State Drive)	t	t	t
23009	Intel Core Ultra 7 165U	4.90 GHz	32	1024	SSD	14 in	1920 x 1200	Intel Graphics	Windows 11 Pro	35408	32 GB	1 TB	SSD (Solid State Drive)	t	t	t
23012	Intel Core i5-1035G1	1.00 GHz	8	256	SSD	14 in	1920 x 1080	Intel UHD Graphics	Windows 11 Pro	35411	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
23013	Intel Core i5-3230M	\N	8	128	\N	14 in	\N	\N	\N	35412	8 GB	128 GB	\N	t	t	t
23014	Intel i5-1135G7	2.42 GHz	8	256	SSD	14 in	1920 x 1080	intel iris Graphics	Windows 11 Pro	35413	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
23015	amd ryzen 7 7730U	\N	16	512	NVMe	14 in	1920 x 1280	Raptor Lake-P	Windows 11 Pro	35415	16 GB	512 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23016	Intel Core i7-8550U	1.80GHz	16	128	SSD	14-inch	\N	Integrated Graphics	Windows 11 Home	35416	16GB	128 GB	Solid State Drive	t	t	t
23017	Intel Core i5 10th Gen.	1.70 GHz	16	\N	SSD	14 in	1920 x 1080	Intel UHD Graphics	Windows 11 Pro	35417	16 GB	256	SSD (Solid State Drive)	t	t	t
23018	Intel Core i7 9th Gen.	2.60 GHz	32	512	SSD	15.6 in	1920 x 1080	Intel UHD Graphics & NVIDIA Quadro T2000	Windows 11 Pro	35418	32 GB	512 GB	SSD (Solid State Drive)	t	t	t
23019	Intel Core i7 11th Gen.	\N	64	1024	SSD	14 in	\N	Intel Iris Xe Graphics	Windows 11 Pro	35419	64 GB	1 TB	SSD (Solid State Drive)	t	t	t
23020	Ultra 7	5.2Ghz	64	1024	SSD	14 in	1920 x 1200	Intel Graphics	Windows 11 Pro	35420	64 GB	1 TB	SSD (Solid State Drive)	t	t	t
23021	Intel Core i5 5th Gen.	2.30 GHz	8	240	SSD	14 in	1366 x 768	Intel HD Graphics 5000	Windows 11 Pro	35421	8 GB	240GB	SSD (Solid State Drive)	t	t	t
23022	Intel Core i5-8350U	\N	16	256	SSD	12.5 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	35422	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23023	Intel i5-7300u	2.60 GHz	8	256	SSD	12.5 in	1366 x 768	Intel HD Graphics	Windows 11 Pro	35423	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
23024	Intel Core i5 3rd Gen.	2.60 GHz	8	256	SSD	14 in	1600 x 900	Intel HD Graphics 4000	Windows 10 Pro	35424	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
23027	Intel Core i5 3rd Gen.	3.30 GHz	8	128	SSD	12.5 in	1366 x 768	Intel HD Graphics 4000	Linux Mint	35427	8 GB	128 GB	SSD (Solid State Drive)	t	t	t
23028	Intel Core i5 7. gene	2.80GHz	16	512	\N	14,5 Zoll	1920 x 1080	\N	Windows 11 Pros	35428	16 GB	512GB	\N	t	t	t
23029	Intel Xeon E2176M	2.70GHz	32	1024	\N	15,6 Zoll	1920 x 1080	\N	Windows 11 Pros	35429	32 GB	1TB	\N	t	t	t
23033	Intel Core i5 10th Gen.	\N	16	512	SSD	14 in	\N	\N	Windows 11 Pro	35433	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
23034	Intel Core i5-10210U	2.20 GHz	16	256	SSD	13.3 in	1920 x 1080	Intel UHD Graphics	Windows 11 Pro	35434	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23035	Intel Core i5 3rd Gen.	2.60 GHz	8	256	\N	12.5 in	\N	\N	Windows10LTSC	35435	8 GB	256 GB	\N	t	t	t
23036	Intel Core i3-1115G4	3 GHz	8	256	SSD	14-inch	\N	Integrated Graphics	Windows 11 Pro	35436	8GB	256 GB	Solid State Drive	t	t	t
23037	Intel Core i5 12th Gen.	1.60 GHz	16	256	SSD	14 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	35437	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23038	Intel Core i7 10th Gen.	1.80 GHz	16	512	NVMe	14 in	3840 x 2160	Integrated/On-Board Graphics	Windows 11 Pro	35438	16 GB	512 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23039	Intel Core i7 13th Gen 1365U vPro	1.80 GHz	32	512	SSD	13.3 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	35439	32 GB	512 GB	SSD (Solid State Drive)	t	t	t
23040	Intel Core i5 12th Gen.	1.70 GHz	16	256	SSD	14 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	35440	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23041	Intel Core i5 3rd Gen.	\N	8	500	SSD	14 in	1366 x 768	Intel HD Graphics 4000	Linux	35441	8 GB	500 GB	SSD (Solid State Drive)	t	t	t
23042	Intel Core i5 3rd Gen.	2.60 GHz	16	240	SSD	12.5 in	1366 x 768	Intel HD Graphics 4000	Windows 11 Pro	35442	16 GB	240GB	SSD (Solid State Drive)	t	t	t
23043	i7-4710MQ	2.50 GHz	16	240	SSD	14 in	1920 x 1080	Intel HD Graphics	Windows 10	35443	16 GB	240GB	SSD (Solid State Drive)	t	t	t
23044	Intel Core i7 11th Gen.	3.00 GHz	32	512	NVMe	14 in	1920 x 1080	Integrated/On-Board Graphics	Windows 11 Pro	35444	32 GB	512 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23047	Intel Core i7 11th Gen.	2.80 GHz	16	512	NVMe	14 in	1920 x 1080	Integrated/On-Board Graphics	Windows 11 Pro	35447	16 GB	512 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23048	Intel Core i5-6300U	2.4 GHz	8	256	SSD	12.5 in	1366 x 768	Intel HD Graphics 520	Windows 10 Pro	35448	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
23049	Intel Core i5 12th Gen.	1.30 GHz	24	512	NVMe	14 in	1920 x 1200	Integrated/On-Board Graphics	Windows 11 Pro	35449	24 GB	512 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23050	i3 3110	2.40 GHz	4	500	\N	15.6 in	1366 x 768	Integrated/On-Board Graphics	Windows 10 Pro	35450	4 GB	500 GB	\N	t	t	t
23054	Intel Core i5 13th Gen.	4.60 GHz	16	256	SSD	13.3 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	35454	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23055	Intel Core i7 10th Gen.	1.80 GHz	16	256	SSD	14 in	3840 x 2160	Intel UHD Graphics	Windows 11 Pro	35455	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23056	Intel Core i5 3rd Gen.	\N	8	320	HDD	12.5 in	1366 x 768	Integrated/On-Board Graphics	Windows 10 Pro	35456	8 GB	320 GB	HDD (Hard Disk Drive)	t	t	t
23068	Intel Core i5 11th Gen.	2.40 GHz	8	256	SSD	13.4 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	35468	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
23069	Intel Core i5 3rd Gen.	2.60 GHz	12	128	SSD	14.1 in	1366 x 768	Intel HD 4000	Windows 10 Professional 64 Bit	35469	12 GB	128 GB	mSATA SSD + HDD	t	t	t
23070	Intel Core i5 5th Gen.	2.30 GHz	8	240	SSD	14 in	1366 x 768	Intel HD Graphics 5000	Windows 11 Pro	35470	8 GB	240GB	SSD (Solid State Drive)	t	t	t
23071	Intel Core Ultra 5	\N	8	256	SSD	14 in	1920 x 1200	Intel Graphics	Windows 11 Pro Education	35471	8 GB	256 GB	SSD	t	t	t
23072	Intel Core i5-4300U	1.90 GHz	4	128	SSD	14.1 in	1600 x 900	Intel HD Graphics 4400	Windows 11 Pro	35472	4 GB	128 GB	SSD (Solid State Drive)	t	t	t
23073	Intel Pentium(R) Silver N5000 CPU @1.10GHz	\N	4	128	SSD	11.6 in	1366 x 768	Integrated/On-Board Graphics	Windows 11	35473	4 GB	128 GB	SSD (Solid State Drive)	t	t	t
23074	Intel Core i7 11th Gen.	2.80 GHz	16	256	NVMe	14 in	\N	Intel Iris Xe Graphics	Windows 11 Pro	35474	16 GB	256 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23075	Intel Core i7 11th Gen.	3.00 GHz	16	512	SSD	14 in	\N	\N	Windows 11 Pro	35475	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
23077	i5-4210M	\N	4	180	SSD	14 in	\N	Intel HD Graphics 4000	Not Included	35477	4 GB	180GB	SSD (Solid State Drive)	t	t	t
23078	Intel Core i5-6300U	2.40 GHz	8	500	SSD	14 in	1920 x 1080	Intel HD Graphics	Not Included	35478	8 GB	500 GB	SSD (Solid State Drive)	t	t	t
23079	Intel Core i7 10th Gen.	1.80 GHz	16	512	NVMe	14 in	1920 x 1080	Integrated Intel UHD Graphics	Windows 11 Pro	35479	16 GB	512 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23081	AMD Ryzen 7	\N	8	256	\N	15.6 in	\N	\N	Windows 10	35481	8 GB	256 GB	\N	t	t	t
23083	AMD Ryzen 7	2.30 GHz	16	256	SSD	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	35483	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23084	Intel Core i5 11th Gen.	1.70 GHz	32	256	SSD	14 in	1920 x 1200	\N	Windows 11 Home	35484	32 GB	256 GB	SSD (Solid State Drive)	t	t	t
23085	Intel Core i7 8th Gen.	1.90 GHz	16	256	SSD	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	35485	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23086	Ultra 7 155H	\N	32	1024	SSD	16 in	\N	\N	\N	35486	32 GB	1 TB	SSD (Solid State Drive)	t	t	t
23087	AMD Ryzen™ 5 PRO 215	3.20 GHz	16	512	SSD	16 in	1920 x 1200	Radeon 740M	Windows 11 Pro	35487	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
23094	Intel Core i5 11th Gen.	2.40 GHz	8	256	SSD	13.3 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	35494	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
23095	Intel Core i5 5th Gen.	2.30 GHz	8	256	SSD	14.1 in	1366 x 768	Intel HD Graphics 520	Windows 11 Home	35495	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
23097	Intel Core i5 8th Gen.	1.60 GHz	16	512	SSD	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11	35497	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
23098	Intel Core i7 11th Gen.	3.00 GHz	32	512	SSD	14 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	35498	32 GB	512 GB	SSD (Solid State Drive)	t	t	t
23099	Intel Core i7 13th Gen.	2.40 GHz	16	512	SSD	16 in	2560 x 1600	NVIDIA RTX A1000	Windows 11 Pro	35499	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
23100	Intel Core i7 8th Gen.	2.20 GHz	16	512	SSD	15.6 in	1920 x 1080	NVIDIA Quadro P1000	Windows 11 Pro	35500	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
23101	Intel Core i5 11th Gen.	2.60 GHz	16	512	SSD	14 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	35501	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
23102	Intel Core i7 11th Gen.	3.00 GHz	32	512	SSD	14 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	35502	32 GB	512 GB	SSD (Solid State Drive)	t	t	t
23103	Intel Core i7 8th Gen.	1.90 GHz	16	256	SSD	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11	35503	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23104	Intel Core i7-6600U	3.60 GHz	20	256	SSD	14.1 in	1920 x 1080	Intel HD Graphics	Windows 11 Pro	35504	20 GB	256 GB	SSD (Solid State Drive)	t	t	t
23105	Intel Core i7 6th Gen.	2.6 GHz	8	256	SSD	15.6 in	1920 x 1080	Intel HD Graphics 520	Windows 11 Pro	35505	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
23107	Intel Core i5-8265U	1.60 GHz	8	256	SSD	14 in	1920 x 1080	Intel UHD Graphics	Windows 11 Pro	35507	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
23108	Intel Core i5 11th Gen.	2.60 GHz	16	512	NVMe	13.3 in	2560 x 1600	Intel Iris Xe Graphics	Windows 11 Pro	35508	16 GB	512 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23109	AMD Ryzen 5 PRO 4000 Series	2.10 GHz	24	256	NVMe	14.1 in	1920 x 1080	AMD Radeon Graphics	Windows 11 Pro	35509	24 GB	256 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23110	Intel Core i5 10th Gen.	1.70 GHz	16	256	SSD	14 in	1920 x 1080	Intel UHD Graphics	Windows 11 Pro	35510	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23111	Intel Core i5-10210U	\N	16	256	SSD	14 in	1920 x 1080	Intel UHD Graphics	Windows 11 Pro	35511	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23112	AMD RYZEN 5 3500C WITH RADEON VEGA MOBILE GFX	\N	8	128	\N	Standard	\N	\N	\N	35512	8 GB	128 GB	\N	t	t	t
23113	Intel Core i7 6th Gen.	2.6 GHz	16	256	SSD	15.6 in	1920 x 1080	Intel HD Graphics 520	Windows 11 Pro	35513	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23114	Intel Ultra 7	5.00 GHz	32	1024	SSD	16 in	3840 x 2400	NVIDIA RTX 2000 Ada Generation	Windows 11 Pro	35514	32 GB	1 TB	SSD (Solid State Drive)	t	t	t
23115	Intel Core i5 4th Gen.	1.90 GHz	8	256	SSD	12 in	1366 x 768	Intel HD Graphics 5500	Windows 10 Pro	35515	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
23116	Intel Core I5-7200U	\N	8	256	\N	13.3 in	1920 x 1080	\N	Windows 11 Home	35516	8 GB	256 GB	Not included	t	t	t
23117	Intel Core i7 9th Gen.	2.60 GHz	32	512	SSD	15.6 in	1920 x 1080	NVIDIA Quadro T1000	Windows 11	35517	32 GB	512 GB	SSD (Solid State Drive)	t	t	t
23118	Intel Core i7 2nd Gen.	1.40 GHz	32	1024	SSD	14 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	35518	32 GB	1 TB	SSD (Solid State Drive)	t	t	t
23119	Intel Core Ultra 7 165U vPro Processor	4.90 GHz	512	512	SSD	13.3 in	1920 x 1200	Intel Graphics	Windows 11 Pro	35519	512 GB	512 GB	SSD (Solid State Drive)	t	t	t
23120	Intel Core i5-10210U	1.60GHz	8	256	\N	13.3 inches	1920 x 1080	\N	Windows 11	35520	8 GB	256GB	\N	t	t	t
23123	Intel Core i5-1135G7	\N	8	256	SSD	13.3 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	35523	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
23124	Intel Core i5-8250U	1.60 GHz	256	256	SSD	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	35524	256 GB	256 GB	SSD (Solid State Drive)	t	t	t
23125	AMD Ryzen 5	\N	8	128	SSD	13.3 in	\N	AMD Radeon Graphics	Chrome OS	35525	8 GB	128 GB	SSD (Solid State Drive)	t	t	t
23126	11th Gen Intel Core i5-1135G7 @2.40GHz	2.40 GHz	16	2048	NVMe	14 in	3840 x 2400	Intel Iris Xe Graphics	Windows 11 Pro	35526	16 GB	2 TB	NVMe (Non-Volatile Memory Express)	t	t	t
23128	Intel Core i5 10th Gen.	\N	8	256	SSD	14 in	1920 x 1080	Intel UHD Graphics	Windows 11 Pro	35528	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
23129	Intel Core i7 13th Gen 1365U vPro	1.80 GHz	32	512	SSD	13.3 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	35529	32 GB	512 GB	SSD (Solid State Drive)	t	t	t
23130	Intel Core i5 12th Gen.	1.70 GHz	16	256	SSD	14 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	35530	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23131	Intel i5-1345GU	1.60 GHz	32	512	SSD	14 in	1920 x 1200	Intel® Iris® Xe Graphics	Windows 11 Pro	35531	32 GB	512 GB	SSD (Solid State Drive)	t	t	t
23132	Intel Core i5-1135G7	1.60GHz	8	256	\N	13,3 Zoll	1920 x 1080	\N	Windows 11	35532	8 GB	256GB	\N	t	t	t
23133	Intel Core i7 13th Gen.	1.80 GHz	32	512	SSD	14 in	1920 x 1200	Intel® Iris® Xe Graphics	Windows 11 Pro	35533	32 GB	512 GB	SSD (Solid State Drive)	t	t	t
23134	Intel Core i5 12th Gen.	1.70 GHz	16	256	SSD	14 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	35534	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23135	Core I5	\N	4	500	HDD	15.6 in	\N	Integrated/On-Board Graphics	Windows 11 Pro	35535	4 GB	500 GB	HDD (Hard Disk Drive)	t	t	t
23138	Intel Core i5 4300U	1.90 GHz	4	120	SSD	12.5 in	1366 x 768	Intel HD 4400	Windows 10 Pro	35538	4 GB	120 GB	SSD (Solid State Drive)	t	t	t
23139	Intel Core i5 8th Gen.	1.60 GHz	8	256	SSD	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	35539	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
23140	Intel Core i5 4th Gen.	\N	8	\N	SSD	14 in	1920 x 1080	Intel HD Graphics	\N	35540	8 GB	0	SSD (Solid State Drive)	t	t	t
23141	AMD Ryzen 7 6000 Series	\N	32	1024	\N	16 in	1920 x 1200	AMD Radeon 680M	Windows 11 Pro	35541	32 GB	1 TB	\N	t	t	t
23142	Intel Ultra 9 185H	\N	64	1024	SSD	16 in	1920 x 1200	Intel Arc Graphics	Windows 11 Home	35542	64 GB	1 TB	SSD (Solid State Drive)	t	t	t
23143	Intel Core i5 8th Gen.	1.60 GHz	16	256	SSD	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	35543	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23144	Intel Core i7-6600U	\N	8	256	SSD	14 in	1920 x 1080	Integrated/On-Board Graphics	Windows 11 Pro	35544	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
23145	Intel Core Ultra 7 255U	5.2 GHz	32	512	SSD	14 in	1920 x 1200	Intel Arc Graphics	Windows 11 Pro	35545	32 GB	512 GB	SSD (Solid State Drive)	t	t	t
23146	Intel Core i7 8th Gen.	1.90 GHz	16	256	SSD	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	35546	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23147	Intel Core i7-6600U	3.60 GHz	20	256	SSD	14.1 in	1920 x 1080	Intel HD Graphics	Windows 11 Pro	35547	20 GB	256 GB	SSD (Solid State Drive)	t	t	t
23148	intel core ultra 7	1.40 GHz	24	512	SSD	14.5 in	1920 x 1080	Dedicated Graphics	Windows 11 Pro	35548	24 GB	512 GB	SSD (Solid State Drive)	t	t	t
23149	Intel Core Ultra 7 265U	\N	64	1024	\N	14 in	2.8K (2880x1800) OLED	Integrated/On-Board Graphics	Windows 11 Pro	35549	64 GB	1 TB	\N	t	t	t
23150	Intel Core Ultra 7 268V	\N	32	2048	\N	14 in	1920 x 1200	Integrated/On-Board Graphics	Windows 11 Pro	35550	32 GB	2TB	\N	t	t	t
23151	Intel Core i5 8th Gen.	1.70 GHz	16	256	SSD	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	35551	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23152	Intel Core i7 10th Gen.	1.80 GHz	16	512	SSD	15.6 in	1920 x 1080	Intel UHD Graphics	Windows 11 Pro	35552	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
23153	Intel Core i7 10th Gen.	2.50 GHz	8	256	SSD	14 in	1920 x 1080	Intel UHD Graphics for 10th Gen Intel Processors	Windows 11 Pro	35553	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
23154	Intel Core Ultra 7 155U	\N	32	512	NVMe	13.3 in	1920 x 1200	\N	Windows 11 Pro	35554	32 GB	512 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23155	AMD Ryzen 7	2.30 GHz	8	256	SSD	14 in	1920 x 1080	Integrated/On-Board Graphics	Windows 11 Pro	35555	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
23156	AMD Ryzen 7 Pro 3000 Series	2.30 GHz	16	256	SSD	13.3 in	1920 x 1080	Radeon Vega Mobile Gfx	Windows 11 Pro	35556	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23157	Intel Core i5-10210U	1.60 GHz	8	256	NVMe	14 in	1920 x 1080	Intel UHD Graphics	Windows 11 Pro	35557	8 GB	256 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23158	AMD Ryzen 7 Pro 3000 Series	2.30 GHz	16	256	SSD	13.3 in	1920 x 1080	Radeon Vega Mobile Gfx	Windows 11 Pro	35558	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23159	AMD Ryzen 7 Pro 3000 Series	2.30 GHz	16	256	SSD	13.3 in	1920 x 1080	Radeon Vega Mobile Gfx	Windows 11 Pro	35559	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23160	Intel i5-1135G7	1.80 GHz	16	256	SSD	14 in	1920 x 1080	Intel® Iris® Xe Graphics	Windows 11 Pro	35560	16gb	256 GB	SSD (Solid State Drive)	t	t	t
23161	Intel Core i5 8th Gen.	1.60 GHz	8	256	SSD	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	35561	8GB	256 GB	SSD (Solid State Drive)	t	t	t
23162	Intel Core Ultra 7 165U	4.30 GHz	16	512	SSD	14 in	1920 x 1200	Integrated Intel Graphics	Windows 11 Pro	35562	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
23163	intel i7 10510U	1.80 GHz	16	480	SSD	14 in	1920 x 1080	intel iris Graphics	Windows 11 Pro	35563	16 GB	480GB	SSD (Solid State Drive)	t	t	t
23164	Intel Core i5-10210U	\N	8	256	NVMe	15.6 in	1920 x 1080	Intel UHD Graphics	Win 11	35564	8 GB	256 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23165	Intel Core i5 11th Gen.	2.20 GHz	16	256	SSD	15.6 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	35565	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23167	215	\N	16	512	SSD	16.0	1920 x 1200	AMD	Windows 11	35567	16 GB	512 GB	SSD M.2	t	t	t
23168	AMD Ryzen 3	\N	16	256	\N	15,6 Zoll	\N	Intel Core i5 11th Gen.	Windows 11 Pro	35568	16 GB	256 GB	NVM Express (nichtflüchtige Speicher)	t	t	t
23169	Intel Core i7 8. Gen	\N	16	500	SSD	14 Zoll	2160 x 1440	NVIDIA GeForce MX250	Windows 11 Pro	35569	16 GB	500 GB	SSD (Solid State Drive)	t	t	t
23170	Core i5	1,60 GHz	8	256	\N	14 Zoll	1920 x 1080	NA	Windows 11 Pro	35570	8 GB	256 GB	\N	t	t	t
23171	8840HS	3.3 GHz	32	1024	SSD	14.0	1920 x 1200	AMD	Windows 11 Pro	35571	32 GB	1.0 TB	SSD	t	t	t
23172	Intel Celeron	\N	16	512	SSD	15,6 Zoll	1920 x 1080	Intel UHD Graphics	Windows 11 Pro	35572	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
23173	Intel Core i5 6. Gen	2,40 GHz	8	128	SSD	14 Zoll	1920 x 1080	Intel HD Graphics	Windows 11 Pro	35573	8 GB	128 GB	SSD (Solid State Drive)	t	t	t
23175	Intel Core i7-8665U	1,60 GHz	16	256	SSD	13,3 Zoll (33,8 cm)	1920 x 1080	Integrierte Grafik	Windows 11 Pro	35575	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23176	Intel Core i5-1135G7	\N	32	250	SSD	15,6 Zoll	1920 x 1080	Intel UHD Graphics	Windows 11 Pro	35576	32 GB	250 GB	SSD (Solid State Drive)	t	t	t
23177	Intel i7-1355U	\N	16	512	SSD	14 Zoll	\N	\N	Windows 11	35577	16 GB	512 GB SSD	SSD (Solid State Drive)	t	t	t
23178	7535U	2.9 GHz	16	512	SSD	16.0	1920 x 1200	AMD	Windows 11 Pro	35578	16 GB	512 GB	SSD	t	t	t
23179	AMD Ryzen 5 Pro 7535U	2.9 GHz	16	512	SSD	16.0	1920 x 1200	AMD	Windows 11 Pro (FR)	35579	16 GB	512 GB	SSD	t	t	t
23180	225U	\N	16	512	SSD	16.0	1920 x 1200	On-Board-Graphics	Windows 11 Pro	35580	16 GB	512 GB	SSD	t	t	t
23181	125U	\N	16	262	SSD	14.0	1920 x 1200	On-Board-Graphics	Windows 11 Pro	35581	16 GB	262 GB	SSD	t	t	t
23182	8840HS	3.3 GHz	32	1024	SSD	14.0	1920 x 1200	AMD	Windows 11 Pro	35582	32 GB	1.0 TB	SSD	t	t	t
23183	268V	\N	32	2048	SSD	14.0	2880 x 1800	Intel(R) Arc(TM)	No OS	35583	32 GB	2.0 TB	SSD	t	t	t
23184	Intel Core Ultra 5 226V	\N	16	512	SSD	14.0	1920 x 1200 WUXGA	Intel(R) Arc(TM)	Windows 11 Home	35584	16 GB	512 GB	SSD M.2	t	t	t
23185	1135G7	\N	8	262	SSD	13.0	1920 x 1080	On-Board-Graphics	Windows 10 Home	35585	8 GB	262 GB	SSD	t	t	t
23186	Intel Pentium 3 P3 Mobile	866 MHz	0.25	80	HDD	14,1 Zoll	1024 x 768	S3 SuperSavage IXC 1014	Windows XP Pro 32bit deutsch	35586	256 MB	80 GB	HDD (Hard Disk Drive)	t	t	t
23187	Intel Core i5-1140G7	1,80 GHz	16	512	SSD	12,3 Zoll	1920 x 1280	Intel Iris Xe Graphics	Windows 11 Pro	35587	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
23189	Ryzen 5 7530U	\N	16	512	SSD	13.0	1920 x 1200	On-Board-Graphics	Windows 11 Pro	35589	16 GB	512 GB	SSD M.2	t	t	t
23190	1335U	\N	8	512	SSD	13.0	1920 x 1200	On-Board-Graphics	Windows 11 Pro	35590	8 GB	512 GB	SSD M.2	t	t	t
23191	13850HX	\N	32	1024	\N	16.0	2560 x 1600	NVIDIA	Windows 11 Pro	35591	32 GB	1.0 TB	\N	t	t	t
23192	228V	\N	32	1024	SSD	14.0	2880 x 1800	Intel(R) Arc(TM)	Windows 11 Home	35592	32 GB	1.0 TB	SSD	t	t	t
23193	i5-1335U	\N	16	512	SSD	13.0	1920 x 1200 WUXGA	On-Board-Graphics	Windows 11 Home	35593	16 GB	512 GB	SSD M.2	t	t	t
23194	i5-1245U	\N	16	262	\N	14.0	1920 x 1200 WUXGA	On-Board-Graphics	Windows 11 Pro	35594	16 GB	262 GB	\N	t	t	t
23195	i9-12950HX	\N	16	1024	SSD	16.0	3840 x 2400 WQUXGA	On-Board-Graphics	No OS	35595	16 GB	1.0 TB	SSD	t	t	t
23196	7730U	\N	32	1024	\N	13.0	1920 x 1200	On-Board-Graphics	Windows 11	35596	32 GB	1.0 TB	\N	t	t	t
23197	Intel Core i5-1140G7	1,80 GHz	16	512	SSD	12,3 Zoll	1920 x 1280	Intel Iris Xe Graphics	Windows 11 Pro	35597	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
23198	Ryzen 5 7533HS	\N	16	512	SSD	14.0	1920x1200	On-Board-Graphics	Windows 11 Pro	35598	16 GB	512 GB	SSD	t	t	t
23199	258V	\N	32	1024	SSD	14.0	2880x1800	On-Board-Graphics	Windows 11	35599	32 GB	1.0 TB	SSD	t	t	t
23204	i7-1165G7	2.8 – 4.7 GHz	16	256	SSD	15,6 Zoll	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	35604	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23207	Intel® Core™ Ultra 5 125U Processor(Core™ Ultra 5 125U	Intel Core Ultra 5 135U	16	512	SSD	16 Zoll	\N	Intel® Graphics	\N	35607	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
23208	Intel Core i7 7. Gen	\N	16	\N	SSD	15-15,9 Zoll	\N	\N	Windows 10 Pro	35608	16 GB	500	SSD (Solid State Drive)	t	t	t
23209	Intel Core i7-8550U	1,80 GHz	16	512	\N	15,6 Zoll	1920 x 1080	\N	Windows 11 Pro	35609	16 GB	512 GB	NVM Express (nichtflüchtige Speicher)	t	t	t
23210	Intel Core i7 7. Gen	2,80 GHz	16	256	SSD	14 Zoll	2560 x 1440	NVIDIA GeForce 940MX	Windows 11 Pro	35610	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23212	Intel Core i3-10110U	2,10 GHz	8	256	SSD	15,6 Zoll	1920 x 1080	Intel UHD Graphics	Windows 10 Pro	35612	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
23214	Intel Core 2 Extreme	\N	8	240	SSD	17 Zoll	1920 x 1200	\N	Windows 10	35614	8 GB	240 GB	HDD + SSD	t	t	t
23215	Intel Core i5-2520M	2,5 GHz	6	256	SSD	14 Zoll	1366 x 768	Intel HD Graphics 3000	Windows 10 Pro	35615	6 GB	256 GB	SSD (Solid State Drive)	t	t	t
23216	Intel Core i5-2520M	2,5 GHz	4	500	HDD	14 Zoll	1366 x 768	Intel HD Graphics 3000	Linux	35616	4 GB	500 GB	HDD (Hard Disk Drive)	t	t	t
23217	Intel Core i5 8. Gen	\N	8	256	SSD	14 Zoll	1920 x 1080	Integrierte / On-Board-Grafik	Windows 11 Pro	35617	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
23218	i5-1135G7	2,40 GHz	16	256	SSD	15 Zoll	1920 x 1080	TigerLake-LP GT2 [Iris Xe Graphics]	Windows 11 Pro	35618	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23219	Intel Core i7-8550U	1,80 GHz	\N	512	SSD	15,6 Zoll (39,6 cm)	1920 x 1080	NVIDIA Quadro P500	Windows 11 Pro	35619	DDR 4	512 GB	SSD (Solid State Drive)	t	t	t
23220	Intel i7-1355U	\N	16	512	SSD	13,3 Zoll	\N	Integrated Intel UHD Graphics	Windows 11 Pro	35620	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
23221	i5-7200U	\N	8	256	SSD	12,5 Zoll	\N	Integrierte / On-Board-Grafik	WIN 11	35621	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
23225	Intel Ultra 7 155U	1,70 GHz	32	512	SSD	14 Zoll	\N	\N	Windows 11 Pro	35625	32 GB	512 GB	SSD (Solid State Drive)	t	t	t
23226	Intel Core i5	2,40 GHz	16	1024	\N	15,6 Zoll	1920 x 1080	Intel HD Graphics	Windows 11 Pro	35626	16 GB	1 TB	\N	t	t	t
23228	Intel Core 2 Duo	1,86 GHz	4	4	SSD	12,1 Zoll	1280 x 800	Integrierte / On-Board-Grafik	Ubuntu	35629	4 GB	4 GB	SSD (Solid State Drive)	t	t	t
23229	Intel Core i5 11. Gen	2,80 GHz	16	512	SSD	13,3 Zoll	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	35630	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
23230	Intel Core i5 5. Gen	2,90 GHz	8	256	SSD	14 Zoll	1600 x 900	Intel HD Graphics	Windows 10 Pro	35631	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
23231	Intel Core Ultra 7 255H	2,00 GHz	32	1024	SSD	16 Zoll	2560 x 1600	Intel Arc Graphics 140T	ohne Betriebssystem!	35632	32 GB	1 TB	SSD (Solid State Drive)	t	t	t
23232	AMD Ryzen 5	\N	16	256	SSD	14 Zoll	1920 x 1080	AMD Radeon Graphics	Windows 11 Pro	35633	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23233	Intel Core i7 6. Gen	\N	16	500	SSD	15-15,9 Zoll	1920 x 1080	Intel HD Graphics	Windows 11 Home	35634	16 GB	500 GB	SSD (Solid State Drive)	t	t	t
23236	Intel Core i5 8. Gen	\N	16	512	\N	14 Zoll	\N	\N	Windows 11 Pro	35637	16 GB	512 GB	NVM Express (nichtflüchtige Speicher)	t	t	t
23237	i7 8565U	1,80 GHz	16	256	SSD	15,6 Zoll (39,6 cm)	1920 x 1080	Intel Corporation UHD Graphics 620	Windows 11 Pro	35638	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23238	Intel Core Ultra 7 258V	2,20 GHz	32	256	SSD	14 Zoll	1920 x 1200	Intel Arc Graphics 140V	Windows 11 Pro	35639	32 GB	256 GB	SSD (Solid State Drive)	t	t	t
23239	Intel Core i7 11. Gen	2,00-2,49 GHz	16	1024	SSD	13,5 Zoll	2256 x 1504	\N	Windows 11 Pro	35640	16 GB	1 TB	SSD (Solid State Drive)	t	t	t
23240	Intel Core i5 10. Gen	1,60 GHz	16	256	SSD	15,6 Zoll	1920 x 1080	Intel UHD Graphics	Windows 11 Pro	35641	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23241	Intel Core i5 11. Gen	3GHz	32	512	\N	14 Zoll	3840x2400	Intel Iris Xe Graphics	Windows 11 Pro	35642	32gb	512 GB	NVM Express (nichtflüchtige Speicher)	t	t	t
23242	i7-6500U	2,50 GHz	8	256	SSD	14 Zoll	1920 x 1080	Intel UHD Graphics	Linux	35643	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
23243	i5	\N	16	256	SSD	14 Zoll	\N	Integrierte / On-Board-Grafik	Windows 10	35644	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23244	Intel Core i5-1135G7	2,40 GHz	8	480	SSD	14 Zoll	1920 x 1080	Intel HD Graphics	Windows 11 Pro	35645	8 GB	480GB	SSD (Solid State Drive)	t	t	t
23245	8840U	\N	32	512	SSD	14.0	2880 x 1800	AMD	Windows 11 Home	35646	32 GB	512 GB	SSD M.2	t	t	t
23247	7840HS	\N	16	512	HDD	16.0	1920 x 1200 WUXGA	nVIDIA	Windows 11	35648	16 GB	512 GB	HDD	t	t	t
23248	258V	\N	32	512	SSD	14.0	1920 x 1200	Intel(R) Arc(TM)	Windows 11 Home	35649	32 GB	512 GB	SSD	t	t	t
23249	8840HS	\N	32	512	HDD	14.0	1920 x 1200 WUXGA	AMD	No OS	35650	32 GB	512 GB	HDD	t	t	t
23251	i7 13850HX	\N	64	1024	SSD	16.0	2560 x 1600	NVIDIA	Windows 11 Pro	35652	64 GB	1.0 TB	SSD M.2	t	t	t
23252	13850HX	\N	64	1024	SSD	16.0	2560 x 1600	NVIDIA	Windows 11 Pro	35653	64 GB	1.0 TB	SSD M.2	t	t	t
23253	13850HX	\N	64	1024	SSD	16.0	2560 x 1600	NVIDIA	Windows 11 Pro	35654	64 GB	1.0 TB	SSD M.2	t	t	t
23254	215	\N	16	512	SSD	16.0	1920x1200	On-Board-Graphics	Windows 11	35655	16 GB	512 GB	SSD	t	t	t
23255	1165G7	\N	8	512	SSD	14.0	1920 x 1080	On-Board-Graphics	Windows 10 Pro	35656	8 GB	512 GB	SSD M.2	t	t	t
23256	8540U	\N	16	512	SSD	14.0	1920 x 1200	AMD	Windows 11	35657	16 GB	512 GB	SSD M.2	t	t	t
23257	i7 13850HX	\N	64	1024	SSD	16.0	2560 x 1600	NVIDIA	Windows 11 Pro	35658	64 GB	1.0 TB	SSD M.2	t	t	t
23258	8540U	\N	16	512	SSD	14.0	1920 x 1200	AMD	Windows 11	35659	16 GB	512 GB	SSD M.2	t	t	t
23259	8540U	\N	16	512	SSD	14.0	1920 x 1200	AMD	Windows 11	35660	16 GB	512 GB	SSD M.2	t	t	t
23260	228V	\N	32	512	HDD	14.0	1920 x 1200 WUXGA	Intel(R) Arc(TM)	Windows 11 Home	35661	32 GB	512 GB	HDD	t	t	t
23261	8540U	\N	16	512	SSD	14.0	1920 x 1200	AMD	Windows 11	35662	16 GB	512 GB	SSD M.2	t	t	t
23262	Intel Core Ultra 7 255U	\N	16	512	HDD	13.0	1920 x 1200 WUXGA	On-Board-Graphics	Windows 11 Pro	35663	16 GB	512 GB	HDD	t	t	t
23263	8540U	\N	16	512	SSD	14.0	1920 x 1200	AMD	Windows 11	35664	16 GB	512 GB	SSD M.2	t	t	t
23264	8540U	\N	16	512	SSD	14.0	1920 x 1200	AMD	Windows 11	35665	16 GB	512 GB	SSD M.2	t	t	t
23265	8540U	\N	16	512	SSD	14.0	1920 x 1200	AMD	Windows 11	35666	16 GB	512 GB	SSD M.2	t	t	t
23266	1160G7	\N	16	262	SSD	12.0	1920 x 1280	On-Board-Graphics	Windows 11 Pro	35667	16 GB	262 GB	SSD M.2	t	t	t
23267	1140G7	\N	16	262	SSD	12.0	1920 x 1280	On-Board-Graphics	Windows 11 Home	35668	16 GB	262 GB	SSD M.2	t	t	t
23268	258V	\N	32	512	SSD	14.0	1920 x 1200	Intel(R) Arc(TM)	Windows 11 Home	35669	32 GB	512 GB	SSD	t	t	t
23269	i7-8550U	\N	16	512	SSD	13.0	3000 x 2000 QHD+	On-Board-Graphics	Windows 10 Pro	35670	16 GB	512 GB	SSD M.2	t	t	t
23271	1140G7	\N	16	262	SSD	12.0	1920 x 1280	On-Board-Graphics	Windows 11 Home	35672	16 GB	262 GB	SSD M.2	t	t	t
23281	Ryzen 5 PRO 6650U	bis zu 4.5 GHz	16	256	SSD	14 Zoll	1920 x 1200	AMD Radeon Graphics	Windows 11 Pro	35683	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23282	Core Ultra 135U	\N	16	262	SSD	13.0	1920 x 1200	On-Board-Graphics	Windows 11 Pro	35684	16 GB	262 GB	SSD	t	t	t
23283	\N	2.20 GHz	32	1024	\N	14 Zoll	\N	\N	Windows 11 Professional	35685	32 GB	1024 GB	\N	t	t	t
23284	255U	\N	32	512	SSD	14.0	2880 x 1800	On-Board-Graphics	Windows 11 Pro	35686	32 GB	512 GB	SSD	t	t	t
23285	1160G7	\N	16	262	SSD	12.0	1920 x 1280	On-Board-Graphics	Windows 11 Pro	35687	16 GB	262 GB	SSD M.2	t	t	t
23286	1140G7	\N	16	262	SSD	12.0	1920 x 1280	On-Board-Graphics	Windows 11 Home	35688	16 GB	262 GB	SSD M.2	t	t	t
23287	8840U	\N	16	512	SSD	14.0	1920 x 1200 WUXGA	AMD	Windows 11 Home	35689	16 GB	512 GB	SSD M.2	t	t	t
23288	7540U	\N	16	512	SSD	14.0	1920 x 1200 WUXGA	AMD	Windows 11 Home	35690	16 GB	512 GB	SSD M.2	t	t	t
23289	AMD Ryzen 5 3500U	\N	16	512	SSD	15,6 Zoll	\N	\N	Windows 10 Pro	35691	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
23317	AMD Ryzen 5 7000 Series	2,00 GHz	16	512	SSD	14 Zoll	1920 x 1200	AMD Radeon Graphics	Windows 11 Pro	35719	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
23332	8350U, Core i5	\N	8	256	SSD	13,3 Zoll	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	35734	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
23333	Intel Core Ultra 5 225U	\N	32	1024	SSD	16 Zoll	2560 x 1600	\N	Windows 11 Pro	35735	32 GB	1 TB	SSD (Solid State Drive)	t	t	t
23334	AMD Ryzen 5 220	3,20 GHz	32	512	SSD	16 Zoll	1920 x 1200	\N	Windows 11 Pro	35736	32 GB	512 GB	SSD (Solid State Drive)	t	t	t
23335	U5-135U	\N	16	512	SSD	14.0	1920 x 1200	On-Board-Graphics	Windows 11 Pro	35737	16 GB	512 GB	SSD M.2	t	t	t
23336	225U	\N	16	512	SSD	16.0	1920 x 1200	On-Board-Graphics	Windows 11 Pro	35738	16 GB	512 GB	SSD M.2	t	t	t
23337	Intel Core Ultra 7 255H	\N	32	2048	\N	14.0	1920 x 1200 WUXGA	On-Board-Graphics	Windows 11 Home	35739	32 GB	2.0 TB	\N	t	t	t
23338	Intel Core Ultra 7 255H	\N	16	512	SSD	14.0	3072 x 1920 (3K)	Intel(R) Arc(TM)	No OS	35740	16 GB	512 GB	SSD M.2	t	t	t
23339	Ryzen 7 Pro 8840HS	\N	32	1024	\N	14.0	1920 x 1200	AMD	Windows 11	35741	32 GB	1.0 TB	\N	t	t	t
23340	Ryzen 7 Pro 250	\N	32	1024	\N	13.0	1920 x 1200 WUXGA	AMD	Windows 11	35742	32 GB	1.0 TB	\N	t	t	t
23341	125U	\N	16	262	NVMe	14.0	1920 x 1200	On-Board-Graphics	Windows 11 Pro	35743	16 GB	262 GB	SSD NVMe M.2	t	t	t
23342	Intel Core i7 12. Gen	\N	16	1024	SSD	14 Zoll	1920 x 1200	Integrierte / On-Board-Grafik	Windows 11 Pro	35744	16 GB	1 TB	SSD (Solid State Drive)	t	t	t
23343	Intel Core i5 13. Gen	1,30 GHz	16	512	SSD	14 Zoll	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	35745	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
23344	Intel Core i7-6600U	2,8 GHz	12	128	SSD	15,6 Zoll	1920 x 1080	Intel® HD Graphics 520	Windows 11 Pro	35746	12 GB	128 GB	SSD (Solid State Drive)	t	t	t
23345	Intel Core i7 6600U	2,8 GHz	12	12	SSD	15,6 Zoll	1920 x 1080	Intel® HD Graphics 520	Windows 11 Pro	35747	12 GB	12 GB	SSD (Solid State Drive)	t	t	t
23347	Intel i7-10510u	1,80 GHz	32	512	SSD	14 Zoll	1920 x 1080	Integrated Intel UHD Graphics	Windows 11 Pro	35749	32 GB	512 GB	SSD (Solid State Drive)	t	t	t
23349	Intel Core i5-8250U	\N	8	240	SSD	14"	1920 x 1080	Intel	Windows 11 Pro	35751	8 GB	240 GB	SSD (wurde solide)	t	t	t
23350	AMD Ryzen 5	\N	256	512	\N	14 in	\N	\N	\N	35752	256 GB	512 GB	\N	t	t	t
23355	Intel Core i5 5th Gen.	2.60 GHz	8	256	SSD	14 in	2560 x 1440	Intel HD Graphics	Windows 11 Pro	35757	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
23356	Intel Core i5 6th Gen.	2.60 GHz	8	256	NVMe	14 in	\N	Intel HD Graphics	Windows 11 Pro	35758	8 GB	256 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23357	Intel Core i5 6th Gen.	2.60 GHz	8	256	NVMe	14 in	\N	Intel HD Graphics	Windows 11 Pro	35759	8 GB	256 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23358	Core i5	1.60 GHz	8	256	SSD	14 in	1920 x 1080	NA	Windows 11 Pro	35760	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
23359	intel	\N	32	1024	\N	14.5 in	\N	\N	\N	35761	32 GB	1 TB	\N	t	t	t
23360	See Title/Description	See Title/Description	\N	\N	\N	See Title/Description	See Title/Description	See Title/Description	See Title/Description	35762	See Title/Description	See Title/Description	See Title/Description	t	t	t
23361	Intel Core i5 10th Gen.	1.60 GHz	8	256	SSD	15.6 in	1920 x 1080	Integrated Intel UHD Graphics	Windows 10	35763	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
23362	Intel Core Ultra 7 (Series 2) - 255H up to 5.1 GHz / 24 MB Cache	\N	16	512	\N	Not Available	\N	Intel Arc Graphics 140T - up to 74 TOPS	Win 11 Pro - English	35764	16 GB DDR5 (1 x 16 GB)	512 GB SSD - TCG Opal Encryption 2, NVMe	\N	t	t	t
23363	Intel Core i7-9750H	2.60 GHz	16	512	SSD	15.6 in	1920 x 1080	\N	Not Included	35765	16 GB	512 GB	SSD	t	t	t
23364	i7-1165G7	2.80 GHz	32	512	NVMe	14 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	35766	32 GB	512 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23365	i7-13800H	2.5GHz	64	1024	SSD	16"	3840 x 2400	GeForce RTX 4080	Windows 11 Pro	35767	64GB RAM	1TB	SSD	t	t	t
23366	Intel Core i5 13th Gen.	\N	32	256	SSD	14 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	35768	32 GB	256 GB	SSD (Solid State Drive)	t	t	t
23367	Intel Core i7 11th Gen	2.30GHz	32	1024	SSD	15.6in.	1920 x 1080	NVIDIA T1200	None	35769	32GB	1TB	Solid State Drive (SSD)	t	t	t
23368	Intel Core i5 8th Gen.	1.60GHz	16	512	SSD	13 in.	1920 x 1080	Intel(R) UHD Graphics 620	Windows 11 Pro	35770	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
23369	Intel Core i5 11th Gen.	2.40 GHz	16	512	NVMe	13.3 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	35771	16 GB	512 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23370	Intel Core i5 6th Gen.	2.40 GHz	12	128	SSD	14 in	1920 x 1080	Intel HD Graphics	MX Linux	35772	12 GB	128 GB	SSD (Solid State Drive)	t	t	t
23371	Intel Core i5-7300U	\N	8	256	SSD	15.6 in	1920 x 1080	Integrated/On-Board Graphics	Windows 10 Pro	35773	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
23372	Intel Core I5-1335U	1.60 GHz	16	512	SSD	15.6 in	1920 x 1200	Intel UHD Graphics	Windows 11 Pro	35774	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
23373	Intel Core i5 10th Gen.	1.70 GHz	8	256	SSD	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	35775	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
23374	Intel Core i7 13th Gen.	1.70 GHz	16	1024	SSD	16 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Home	35776	16 GB	1 TB	SSD (Solid State Drive)	t	t	t
23375	AMD Ryzen 7 5000 Series	2.00 GHz	16	256	SSD	14 in	1920 x 1080	AMD Radeon Graphics	Windows 11 Pro	35777	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23376	Intel Core i7-1185G7	\N	48	1024	NVMe	14 in	1920 x 1080	NVIDIA Quadro T500	Windows 11 Pro	35778	48GB	1 TB	NVMe (Non-Volatile Memory Express)	t	t	t
23377	Core Ultra 5 235U	2.0GHz	16	256	SSD	14"	1920 x 1200	Intel Graphics	Windows 11 Pro	35779	16GB RAM	256GB	SSD	t	t	t
23378	Intel Core i5 12th Gen.	1.70 GHz	16	256	NVMe	16 in	1920 x 1200	Intel UHD Graphics	Windows 11 Pro	35780	16 GB	256 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23379	i5-1135G7	2.40 GHz	8	512	NVMe	15.6 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	35781	8 GB	512 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23380	i5-1135G7	2.40 GHz	8	512	NVMe	15.6 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	35782	8 GB	512 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23381	i5-1135G7	2.40 GHz	8	512	NVMe	15.6 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	35783	8 GB	512 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23382	Not Available	\N	32	512	\N	14.0 Inch	\N	\N	\N	35784	32 GB	512 GB	\N	t	t	t
23383	Not Available	\N	32	512	\N	14.0 Inch	\N	\N	\N	35785	32 GB	512 GB	\N	t	t	t
23384	i5-1135G7	2.40 GHz	16	512	NVMe	15.6 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	35786	16 GB	512 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23385	i5-1145G7	2.60 GHz	16	512	NVMe	15.6 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	35787	16 GB	512 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23386	i5-1145G7	2.60 GHz	16	512	NVMe	15.6 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	35788	16 GB	512 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23387	i7-1165G7	2.80 GHz	16	512	NVMe	15.6 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	35789	16 GB	512 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23388	Intel Core i5 11th Gen.	2.40 GHz	16	512	NVMe	15.6 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	35790	16 GB	512 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23389	i5-1135G7	2.40 GHz	16	512	NVMe	15.6 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	35791	16 GB	512 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23391	Intel Core i7-1185G7	\N	16	256	SSD	14 in	1920 x 1080	Intel Iris Xe Graphics	Not Included	35793	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23392	Intel Core i7 11th Gen.	3.00 GHz	32	256	NVMe	14 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Home	35794	32 GB	256 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23393	Intel Core i7 11th Gen.	3.00 GHz	32	256	NVMe	14 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Home	35795	32 GB	256 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23394	Intel i7-2640M CPU	2.80 GHz	8	500	HDD	12.5 in	1366 x 768	\N	Windows 10 Pro	35796	8 GB	500 GB	HDD (Hard Disk Drive)	t	t	t
23395	Intel Core i7 1165G7	2.80 GHz	16	512	SSD	14 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	35797	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
23396	Intel Core i7 11th Gen.	3.00 GHz	32	256	NVMe	14 in	\N	\N	Windows 11 Home	35798	32 GB	256 GB	nvme	t	t	t
23397	Intel Core i7 11th Gen.	\N	16	256	NVMe	14 in	1920 x 1080	Intel Iris Xe Graphics	Not Included	35799	16 GB	256 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23398	Intel Core i7 11th Gen.	3.00 GHz	16	256	NVMe	14 in	\N	\N	Windows 11 Home	35800	16 GB	256 GB	nvme	t	t	t
23399	Intel Core i7 12th Gen.	2.20 GHz	32	256	NVMe	14 in	1920 x 1200	Integrated/On-Board Graphics	Windows 11 Home	35801	32 GB	256 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23400	Intel Core i9 11th Gen	2.60 GHz	64	2048	SSD	16 in	3840 x 2400	NVIDIA GeForce RTX 3080	Windows 11 Pro	35802	64 GB	2 TB	SSD (Solid State Drive)	t	t	t
23401	Intel Core i5 M520	2.40 GHz	6	240	SSD	15.6 in	1280 x 800	NVIDIA	Linux	35803	6 GB	240GB	SSD (Solid State Drive)	t	t	t
23402	Intel Core i7 1165G7	2.80 GHz	16	512	SSD	14 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	35804	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
23403	Intel Core i7 8th Gen.	1.90 GHz	16	1024	SSD	13.3 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	35805	16 GB	1 TB	SSD (Solid State Drive)	t	t	t
23404	Intel Core i7 8th Gen.	2.20 GHz	16	512	SSD	15.6 in	1920 x 1080	NVIDIA GeForce GTX 1050 Ti	Windows 11 Pro	35806	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
23407	Intel Core i5 10th Gen.	1.60 GHz	8	256	SSD	15.6 in	1920 x 1080	Integrated Intel UHD Graphics	Windows 10	35809	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
23408	Intel Core i5-7300U	2.60 GHz	16	256	SSD	15.6 in	1920 x 1080	Intel HD Graphics 620	Windows 10 Pro	35810	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23409	Intel Core i5 2nd Gen.	2.50 GHz	4	120	SSD	14 in	1600 x 900	Intel HD Graphics 3000	Windows 7 Professional	35811	4 GB	120 GB	SSD (Solid State Drive)	t	t	t
23410	i7-11850H	2.50 GHz	32	2048	SSD	16 in	3840 x 2400	NVIDIA RTX A4000	Windows 11 Pro	35813	32 GB	2 TB	SSD (Solid State Drive)	t	t	t
23411	Intel Core i5-10210U	1.60 GHz	8	256	SSD	13.3 in	1920 x 1080	Intel UHD Graphics	Windows 11 Home	35814	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
23412	Intel Core i5-10210U	1.60 GHz	8	256	SSD	13.3 in	1920 x 1080	Intel UHD Graphics	Windows 11 Home	35815	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
23413	Intel Core i5-10210U	1.60 GHz	8	256	SSD	13.3 in	1920 x 1080	Intel UHD Graphics	Windows 11 Home	35816	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
23414	Intel(R) Core(TM) i5-8365U CPU @ 1.60GHz	1.60 GHz	8	256	SSD	14 in	1920 x 1080	Intel(R) UHD Graphics 620	Windows 11 Pro	35817	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
23416	Intel Core i5 8th Gen.	1.60 GHz	8	256	NVMe	13.3 in	1366 x 768	Intel UHD Graphics	Windows 11 Pro	35819	8 GB	256 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23417	Intel Core i5-6200U	2.30 GHz	12	256	SSD	15.6 in	1366 x 768	Intel HD Graphics	Windows 10 Pro	35820	12 GB	256 GB	SSD (Solid State Drive)	t	t	t
23418	Intel Core i5 8th Gen.	1.60 GHz	16	256	NVMe	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	35821	16 GB	256 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23419	Intel Core i7-1185G7	3.00 GHz	16	256	SSD	14 in	1920 x 1080	NVIDIA Quadro T500	Windows 11 Pro	35822	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23420	intel core i7 8th gen	1.90 GHz	16	1024	SSD	15.6	1920 x 1080p	Intel UHD Graphics 620	Windows 11 Pro	35823	16gb	1 TB	SSD (Solid State Drive)	t	t	t
23421	8350U, Core i5	\N	256	256	SSD	14 in	\N	Integrated/On-Board Graphics	Linux	35824	256 GB	256 GB	SSD (Solid State Drive)	t	t	t
23422	Intel Core i5-10310U	1.70 GHz	16	256	SSD	14 in	1920 x 1080	Intel UHD Graphics	Not Included	35825	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23423	Ryzen 5	2.30 GHz	16	256	NVMe	15.6 in	1920 x 1080	AMD Radeon Graphics	Windows 11 Pro	35826	16 GB	256 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23425	AMD Ryzen 5 PRO 4650U	2.10 GHz	16	256	NVMe	15.6 in	1920 x 1080	AMD Radeon Graphics	Windows 11 Pro	35828	16 GB	256GB NVme SSD	NVMe (Non-Volatile Memory Express)	t	t	t
23426	Intel i5-10310U	1.70 GHz	16	256	NVMe	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	35829	16 GB	256 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23428	Intel Core i5 13th Gen.	\N	16	512	SSD	14 in	1920 x 1080	Integrated/On-Board Graphics	Windows 11 Pro	35831	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
23429	Intel Core i5 3rd Gen.	2.60 GHz	8	256	HDD	14 in	\N	Type 2347-1E3	Windows 10	35832	8 GB	256 GB	HDD (Hard Disk Drive)	t	t	t
23430	Intel Ultra 5	\N	8	512	SSD	16 in	\N	\N	\N	35833	8 GB	512 GB	SSD (Solid State Drive)	t	t	t
23431	Intel Core i5 8th Gen.	1.7 GHz	16	256	SSD	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	35834	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23432	Intel Core i7 13th Gen.	1.70 GHz	16	512	\N	14 in	1920 x 1080	\N	\N	35835	16 GB	512 GB	\N	t	t	t
23433	Intel Core i7 7th Gen	2.80 GHz	8	256	SSD	17.3 in	1920 x 1080	NVIDIA Quadro M620	Windows 10 Pro	35836	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
23434	I7-10510U	1.80 GHz	16	256	SSD	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	35837	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23435	i7 10750H	\N	512	512	\N	15.6 in	\N	\N	Windows 11 Pro	35838	512 GB	512 GB	\N	t	t	t
23437	Intel Core i9 12th Gen	2.50 GHz	64	1024	SSD	16 in	1920 x 1080	Dedicated Graphics	Windows 11 Home	35841	64 GB	1 TB	SSD (Solid State Drive)	t	t	t
23438	Intel Pentium M	1.50-1.99GHz	1	100	HDD	14 in	\N	Integrated/On-Board Graphics	\N	35842	1024 mb	100 GB	HDD (Hard Disk Drive)	t	t	t
23440	Intel Core i5 8th Gen.	1.70GHz	16	256	NVMe	14"	1920 x 1080	Intel UHD Graphics	Windows 11 Pro	35844	16GB	256 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23441	Intel Core i5 6th Gen.	2.40 GHz	8	128	SSD	14 in	1920 x 1080	Intel HD Graphics	Windows 10 Pro	35845	8 GB	128 GB	SSD (Solid State Drive)	t	t	t
23442	i5-1135G7 (11th Gen)	1.3GHz	16	256	SSD	14 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	35846	16 GB	256GB	SSD (Solid State Drive)	t	t	t
23443	AMD Ryzen 7 7000 Series	\N	\N	500	SSD	14 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	35847	40	500 GB	SSD (Solid State Drive)	t	t	t
23444	i5-1235U (12th Gen)	1.3GHz	16	512	SSD	14 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	35848	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
23445	Snapdragon X Elite X1E-78-100	3.40 GHz	32	1024	SSD	14 in	1920 x 1200	Integrated Qualcomm Adreno GPU	Windows 11 Pro	35849	32 GB	1 TB	SSD (Solid State Drive)	t	t	t
23446	i7-9850H	2.6GHz	8	512	SSD	15.6"	1920 x 1080	NVIDIA Quadro T2000	Windows 11 Home	35850	8 GB	512 GB	SSD (Solid State Drive)	t	t	t
23448	Intel Core i7-8650U	1.9 GHz	8	256	SSD	13 in	3000 x 2000	Intel UHD Graphics 620	Windows 11 Pro	35852	8 GB	256 GB	SSD (Solid State Drive)	t	t	t
23449	Intel Core i7 11th Gen.	1.30 GHz	16	512	SSD	13 in	2160 x 1350	Intel Iris Xe Graphics	Windows 11 Home	35853	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
23450	Intel Core i5 11th Gen.	2.40 GHz	16	256	NVMe	14 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	35854	16 GB	256 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23451	Intel Core i5	2.60 GHz	8	320	HDD	14 in	1600 x 900	Intel HD Graphics 4000	Windows 10	35855	8 GB	320 GB	HDD (Hard Disk Drive)	t	t	t
23452	Intel Core i9 10th Gen.	2.40 GHz	16	512	NVMe	17.3 in	1920 x 1080	NVIDIA Quadro T2000	Not Included	35856	16 GB	512 GB	NVMe (Non-Volatile Memory Express)	t	t	t
23453	AMD Ryzen 7 PRO 250	Up to 5.10GHz	16	512	SSD	16" WUXGA (1920x1200) IPS touchscreen	\N	AMD Radeon 780M	Windows 11 Pro	35857	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
23454	Intel Core i7 12th Gen.	2.10 GHz	8	\N	NVMe	16 in	1920 x 1200	Integrated/On-Board Graphics	Not Included	35858	8GB	Not included	NVMe (Non-Volatile Memory Express)	t	t	t
23455	Intel Core i5-10310U	1.70 GHz	16	256	SSD	15.6 in	3840 x 2160	Intel UHD Graphics	Windows 11 Pro	35859	16 GB	256 GB	SSD (Solid State Drive)	t	t	t
23456	Intel Core i7 13th Gen.	3.90 GHz	16	512	SSD	14 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	35860	16 GB	512 GB	SSD (Solid State Drive)	t	t	t
\.


--
-- Data for Name: storage; Type: TABLE DATA; Schema: public; Owner: thinkpaduser
--

COPY public.storage (id, size) FROM stdin;
1	1TB
2	2TB
3	16GB
4	32GB
5	64GB
6	3TB
7	4TB
8	5TB
9	128GB
10	256GB
11	512GB
12	480GB
13	120GB
14	256gb
15	512
16	256 GB
17	512 GB
18	120 GB
19	128 GB
\.


--
-- Data for Name: temp_details; Type: TABLE DATA; Schema: public; Owner: thinkpaduser
--

COPY public.temp_details (id, cpu, cpu_freq, ram, storage, storage_type, screen_size, display, gpu, os, model, seller_username, seller_feedback_score, seller_feedback_percent, ebay_item_id, mpn) FROM stdin;
18119	AMD Ryzen 7 7735HS	\N	32 GB	1 TB	SSD (Solid State Drive)	16 in	\N	\N	\N	Lenovo ThinkPad R61	mic608767	0	0.00	v1|389781630846|0	\N
18120	AMD Ryzen 7	\N	16 GB	512 GB	SSD (Solid State Drive)	14 in	1920 x 1080	AMD Radeon Graphics	Windows 11 Pro	Lenovo ThinkPad T14s	aazpoo_37	1	100.00	v1|227267632017|0	20UH002WUS
18121	Intel Core i3 5th Gen.	2.00 GHz	4 GB	4 GB	\N	14 in	\N	Integrated/On-Board Graphics	Not Included	Lenovo Thinkpad E450	aree_sales	385	99.60	v1|389781610723|0	\N
18122	Intel Core i3 5th Gen.	2.00 GHz	4 GB	4 GB	\N	14 in	\N	Integrated/On-Board Graphics	Not Included	Lenovo Thinkpad E450	aree_sales	385	99.60	v1|389781573235|0	\N
18123	Not Available	\N	\N	\N	\N	Not Available	\N	\N	\N	Not Available	neobitsinc	552	98.20	v1|127762905661|0	21JN003YUS
18124	11th Generation Intel Core i7-11800H	\N	\N	\N	SSD (Solid State Drive)	17.3 in	\N	Dedicated Graphics	\N	Lenovo ThinkPad P17	suerte_4	0	0.00	v1|198213963251|0	\N
18125	Intel Core i7 10th Gen.	1.80 GHz	16 GB	512 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel UHD Graphics	Windows 11 Pro	Lenovo ThinkPad T14s	aazpoo_37	1	100.00	v1|227267597031|0	THINKPAD P14S
18126	AMD Ryzen 7 PRO 4750U	2.30 GHz	16 GB	512 GB	SSD (Solid State Drive)	14 in	1920 x 1080	AMD Radeon Graphics	Windows 11 Pro	Lenovo P14s Gen 1	webbdavidccc	77	100.00	v1|298149004893|0	\N
18127	\N	\N	\N	512 GB	\N	\N	\N	\N	\N	\N	arttere68	192	100.00	v1|227267574399|0	\N
18128	AMD Ryzen 7	2.70 GHz	16 GB	512 GB	SSD (Solid State Drive)	14 in	1920 x 1200	AMD Radeon 680M	Windows 11 Pro	Lenovo ThinkPad E14 Gen 6	dc-sn.llc	191	100.00	v1|157775688634|0	21M3000PUS
18129	Intel Core i7-10610U	2.30 GHz	48GB	1 TB	SSD (Solid State Drive)	14 in	1920 x 1080	NVIDIA Quadro P520	Windows 11 Pro	Lenovo P14S Gen 2	webbdavidccc	77	100.00	v1|298148964840|0	\N
18130	Intel Core i7-1185G7	3.00 GHz	48 GB	1 TB	SSD (Solid State Drive)	14 in	1920 x 1080	NVIDIA Quadro T500	Windows 11 Pro	Lenovo P14S Gen 2	webbdavidccc	77	100.00	v1|298148963865|0	\N
18131	\N	\N	\N	256 GB	\N	\N	\N	\N	\N	\N	arttere68	192	100.00	v1|227267562478|0	\N
18132	Intel Core i7 11th Gen.	3.00 GHz	32 GB	1 TB	SSD (Solid State Drive)	14 in	3840 x 2400	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad X1 Yoga	bournejason10	1301	100.00	v1|147217193867|0	\N
18133	Intel Core i7 11th Gen.	3.00 GHz	16 GB	1 TB	SSD (Solid State Drive)	14 in	3840 x 2400	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad X1 Yoga	bournejason10	1301	100.00	v1|147217191327|0	\N
18134	\N	\N	\N	512 GB	\N	\N	\N	\N	\N	\N	arttere68	192	100.00	v1|227267542622|0	\N
18135	Intel Core i7 11th Gen.	3.00 GHz	32 GB	1 TB	SSD (Solid State Drive)	14 in	3840 x 2400	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad X1 Yoga	bournejason10	1301	100.00	v1|147217178571|0	\N
18136	Intel Core i7 8th Gen.	1.90 GHz	32 GB	1 TB	SSD (Solid State Drive)	14 in	1920 x 1080	NVIDIA GeForce MX150	Windows 11 Pro	Lenovo ThinkPad T480	bournejason10	1301	100.00	v1|147217177384|0	\N
18137	Intel Core i5 3rd Gen.	\N	8 GB	128 GB	SSD (Solid State Drive)	14 in	\N	Intel HD Graphics 4000	Windows 11 Pro	\N	strvanm_0	510	99.00	v1|318041580966|0	\N
18138	Intel Core i5-8250U	1.70 GHz	16 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel UHD Graphics 620	Linux	Libreboot T480	respectsyoutech	668	100.00	v1|236704994677|0	T580
18139	i7-1165G7	2.80 GHz	16 GB	512 GB	SSD (Solid State Drive)	14 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad X1 Carbon 9th Gen	aazpoo_37	1	100.00	v1|227267528819|0	20XW004DUS
18140	Intel(R) Core(TM) i5-3427U CPU @ 1.80GHz	1.80GHz	4 GB	128 GB	Not Included	14 in.	1600 x 900	Intel HD Graphics 4000	Windows 10 Pro	ThinkPad X1 Carbon (1st Gen)	2014summertime	638	99.30	v1|127762804407|0	NA
18141	8840HS	3.3 GHz	\N	1.0TB	\N	14.0	1920 x 1200	AMD	Windows 11 Pro	Lenovo ThinkPad P14s Gen 5	itsupplyfusion	419	100.00	v1|188193653651|0	\N
18142	Core Ultra 135U	\N	\N	262GB	\N	13.0	1920 x 1200	\N	Windows 11 Pro	Lenovo ThinkPad X13 2-in-1 Gen 5	itsupplyfusion	419	100.00	v1|188193651206|0	\N
18143	i5-10210U	\N	16 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel UHD Graphics	Windows 11 Pro	Lenovo L14 Gen 1	kov5298	24	100.00	v1|358360507474|0	ThinkPad L14 Gen 1
18144	U5-135U	\N	\N	512GB	\N	14.0	1920 x 1200	\N	Windows 11 Pro	Lenovo ThinkPad T14 G5	itsupplyfusion	419	100.00	v1|188193635973|0	\N
18145	Intel Core i7 13th Gen.	2.10 GHz	32 GB	1 TB	SSD (Solid State Drive)	16 in	2560 x 1600	NVIDIA RTX 2000 Ada Generation	Windows 11 Pro	Lenovo ThinkPad P16 Gen 2	antonline	348388	99.50	v1|127762723300|0	21FA002TUS
18146	Intel Core i7 i7-13700HX	\N	\N	\N	\N	16 in	2560x1600	\N	\N	21FA002TUS+QQ2-00021	antonline	348388	99.50	v1|127762723301|0	21FA002TUS+QQ2-00021
18147	Intel Core Ultra 7 255H	\N	16 GB	\N	\N	14 in	1920x1200	\N	\N	21SX0038US	antonline	348388	99.50	v1|298148739828|0	21SX0038US
18148	AMD Ryzen 7 PRO 8840U	\N	32 GB	\N	\N	14 in	1920x1200	\N	\N	21MC000KUS	antonline	348388	99.50	v1|127762723287|0	21MC000KUS
18149	Intel Core i5-8350U	1.70 GHz	8 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	Lenovo ThinkPad T480s	imperialtw	753	99.70	v1|318041142340|0	ThinkPad T480S
18150	AMD Ryzen 7	5.00 GHz	96 gb	4 TB	SSD (Solid State Drive)	14 in	1920 x 1200	AMD Radeon Graphics	Windows 11 Pro	ThinkPad P14s Gen 6	laptopnycom	1357	100.00	v1|177980860292|477507823154	21QL
18151	AMD Ryzen AI 300 Series	\N	16 GB	512 GB	SSD (Solid State Drive)	14 in	1920 x 1200	AMD Radeon Graphics	Windows 11 Home	Lenovo Yoga 7	sbizh_55	168	97.40	v1|306835792090|0	83JR0002US
18152	Intel Core i5-8350U	1.70 GHz	8 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	Lenovo ThinkPad T480s	imperialtw	753	99.70	v1|318041087990|0	ThinkPad T480S
18153	Intel Core i5 11th Gen.	2.40 GHz	8 GB	256 GB	SSD (Solid State Drive)	15.6 in	1920 x 1080	Intel Iris Xe Graphics	Windows 10 Pro	V15 G2 ITL	leapana_0	0	0.00	v1|306835784773|0	82KB00C3US
18154	Intel Core i5-8250U	1.60 GHz	8 GB	500 GB	SSD (Solid State Drive)	13 in	3000 x 2000	Intel UHD Graphics 620	Windows 11 Pro	Lenovo ThinkPad X1	cemala18	2826	99.80	v1|127762634228|0	ThinkPad X1 Tablet Gen 3
18155	Intel Core i7 10th Gen.	1.80 GHz	16 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel UHD Graphics	Windows 11 Pro	Lenovo ThinkPad X1 Carbon Gen 8	vortech23	105	100.00	v1|397745316739|0	X1 Carbon Gen 8
18156	1140G7	\N	\N	262GB	\N	12.0	1920 x 1280	\N	Windows 11 Home	Lenovo ThinkPad X12 Detachable	itsupplyfusion	419	100.00	v1|188193374585|0	\N
18157	Intel Core i5 7th Gen.	\N	8 GB	256 GB	SSD (Solid State Drive)	15.6 in	1920 x 1080	Intel HD Graphics 620	Windows 10	Lenovo Yoga 710	rafa_1991	2	100.00	v1|406790122859|0	71015IKB
18158	Core Ultra 5	4.50 GHz	16 GB	512 GB	SSD (Solid State Drive)	14 in	1920 x 1200	INTEGRATED ARC GRAPHICS	Windows 11 Pro	ThinkPad X1 2-in-1 Gen 10	dawson_distributors	33	90.90	v1|198213384781|0	21NU
18250	NA	\N	NA	NA	NA	NA	\N	NA	NA	NA	japan_gearpro	134	98.40	v1|397744540144|0	NA
18159	Intel Core i7 11th Gen.	3.00 GHz	32 GB	512 GB	SSD (Solid State Drive)	14 in	1920X1200	Integrated/On-Board Graphics	Not Included	THINKPAD X1 CARBON (9TH GEN)	zyphrtradingcompany	1297	100.00	v1|267616103851|0	\N
18160	I5-10210U	\N	\N	262GB	\N	15.0	1920 x 1080 (FHD)	\N	Windows 11 Pro	Lenovo Thinkpad T15 G1	itsupplyfusion	419	100.00	v1|188193336224|0	\N
18161	I5-1245U	\N	\N	262GB	\N	14.0	1920 x 1200 WUXGA	\N	Windows 11 Pro	Lenovo ThinkPad T14 G3	itsupplyfusion	419	100.00	v1|188193336093|0	\N
18162	Ryzen 5 PRO 4650U	\N	\N	262GB	\N	14.0	1920 x 1080 (FHD)	\N	Windows 11 Pro	Lenovo Thinkpad T14 G1	itsupplyfusion	419	100.00	v1|188193336025|0	\N
18163	4650U	2.1 GHz	\N	512GB	\N	14.0	1920 x 1080	\N	Windows 11 Pro	Lenovo Thinkpad T14 G1	itsupplyfusion	419	100.00	v1|188193335394|0	\N
18164	Intel Core i7 11th Gen.	3.00 GHz	32 GB	512 GB	SSD (Solid State Drive)	14 in	1920X1200	Integrated/On-Board Graphics	Not Included	THINKPAD X1 CARBON (9TH GEN)	zyphrtradingcompany	1297	100.00	v1|267616099793|0	\N
18165	AMD Ryzen 5 PRO 5000 Series	2.30 GHz	16 GB	512 GB	SSD (Solid State Drive)	14 in	1920 x 1080	AMD Radeon Graphics	Windows 11 Pro	Lenovo ThinkPad T14	aazpoo_37	1	100.00	v1|227267371002|0	20XK0016US
18166	Intel Core i5 1st Gen.	\N	\N	500 GB	HDD (Hard Disk Drive)	14 in	\N	Intel HD Graphics	Windows 10	Lenovo ThinkPad T410	amazingvb	4	100.00	v1|198213341786|0	T410
18167	Intel Core i7 12th Gen.	3.40 GHz	16 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad X1 Carbon Gen 10	vortech23	105	100.00	v1|397745236967|0	21CB000CUS
18168	Intel Core i5 8th Gen.	1.90 GHz	16 GB	1 TB	SSD (Solid State Drive)	14 in	2560 x 1440	Intel HD Graphics	Windows 11 Pro	Lenovo ThinkPad X1 Yoga (3rd Gen)	junktardis	1914	100.00	v1|327061597907|0	x1, Yoga, ThinkPad X1 Yoga 3rd Gen, X1 YOGA
18169	Intel i5-1135G7	\N	\N	256 GB	SSD (Solid State Drive)	14 in	\N	\N	Windows 11 Pro	Lenovo E14 Gen 2	mbds837	889	100.00	v1|117100797060|0	\N
18170	Intel Core i7 7th Gen.	2.80 GHz	16 GB	512 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel HD Graphics 620	Windows 11 Pro	Lenovo ThinkPad T470	jkmart	217	95.20	v1|267616086624|0	\N
18171	Intel Core i5-8350U	1.70 GHz	8 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	Lenovo ThinkPad T480s	imperialtw	753	99.70	v1|318040858741|0	ThinkPad T480S
18172	Intel Core i5-8350U	1.70 GHz	8 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	Lenovo ThinkPad T480s	imperialtw	753	99.70	v1|318040845089|0	ThinkPad T480S
18173	Intel Core i5-8350U	1.70 GHz	8 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	Lenovo ThinkPad T480s	imperialtw	753	99.70	v1|318040807713|0	ThinkPad T480S
18174	Intel Core i7 11th Gen.	3.00 GHz	16 GB	512 GB	SSD (Solid State Drive)	14 in	\N	\N	Windows 10 Pro	Lenovo ThinkPad X1	bargdeals65	655	99.70	v1|318040796055|0	\N
18175	I5-1135G7	\N	\N	262GB	\N	14.0	1920 x 1080 (FHD)	\N	Windows 11 Pro	Lenovo ThinkPad X1 Carbon G9	itsupplyfusion	419	100.00	v1|188193172781|0	\N
18176	I5-10310U	\N	\N	512GB	\N	14.0	1920 x 1080	\N	Windows 11 Pro	Lenovo Thinkpad T14 G1	itsupplyfusion	419	100.00	v1|188193172836|0	\N
18177	228V	\N	\N	1.0TB	\N	14.0	2880 x 1800	Intel(R) Arc(TM)	Windows 11 Home	Lenovo ThinkPad X9-14 G1	itsupplyfusion	419	100.00	v1|188193172759|0	\N
18178	I5-10310U	\N	\N	262GB	\N	15.0	1920 x 1080 (FHD)	\N	Windows 10 Pro	Lenovo Thinkpad T15 G1	itsupplyfusion	419	100.00	v1|188193172579|0	\N
18179	Ryzen 7 Pro 4750U	\N	\N	512GB	\N	14.0	1920 x 1080	\N	Windows 10	Lenovo ThinkPad T14s Gen 1	itsupplyfusion	419	100.00	v1|188193172490|0	\N
18180	10210U	1.6 GHz	\N	512GB	\N	14.0	1920 x 1080	\N	Windows 11 Pro	Lenovo ThinkPad T14 G1	itsupplyfusion	419	100.00	v1|188193172322|0	\N
18181	4650U	\N	\N	262GB	\N	14.0	1920 x 1080 (FHD)	\N	Windows 11 Pro	Lenovo ThinkPad T14 G1	itsupplyfusion	419	100.00	v1|188193172263|0	\N
18182	4650U	2.1 GHz	\N	262GB	\N	14.0	1920 x 1080	AMD	Windows 11 Pro	Lenovo ThinkPad T14 G1	itsupplyfusion	419	100.00	v1|188193172175|0	\N
18183	258V	\N	\N	\N	\N	14.0	1920 x 1200	Intel	Windows 11 Home	Lenovo ThinkPad X1 Carbon G13	itsupplyfusion	419	100.00	v1|188193172204|0	\N
18184	1335U	\N	\N	512GB	\N	13.0	1920 x 1200	\N	Windows 11 Pro	Lenovo ThinkPad L13 Yoga Gen 4	itsupplyfusion	419	100.00	v1|188193172162|0	\N
18185	7730U	\N	\N	1.0TB	\N	13.0	1920 x 1200	\N	Windows 11	Lenovo ThinkPad L13 G4	itsupplyfusion	419	100.00	v1|188193172170|0	\N
18186	I5-1335U	\N	\N	512GB	\N	13.0	1920 x 1200 WUXGA	\N	Windows 11 Home	Lenovo ThinkPad X13 G4	itsupplyfusion	419	100.00	v1|188193171585|0	\N
18187	3015e	\N	\N	131GB	\N	14.0	1366 x 768 (HD)	\N	Windows	Lenovo 14W G2 DualCore AMD	itsupplyfusion	419	100.00	v1|188193171496|0	\N
18188	268V	\N	\N	2.0TB	\N	14.0	2880 x 1800	Intel(R) Arc(TM)	No OS	Lenovo ThinkPad X1 Carbon G13	itsupplyfusion	419	100.00	v1|188193171387|0	\N
18189	Intel Core i5-1035G1	1.00 GHz	8 GB	256 GB	SSD (Solid State Drive)	17.3 in	1920 x 1080	Intel UHD Graphics	Windows 11 Home	Lenovo IdeaPad 17IIL05	wheezy_sells251	20	100.00	v1|318040775053|0	81wf000hus
18190	Intel Core i5-8250U	\N	8GB	256 GB	SSD (Solid State Drive)	15.6 in	1920 x 1080	Intel UHD Graphics	Windows 11 Home	Lenovo Flex 5	theman71177	3090	100.00	v1|206157161837|0	IdeaPad 330S-15IKB 81F5
18191	i3-N305	1.8GHz	8GB RAM	128GB	SSD	15.8	1920 x 1080	UHD Graphics	Windows 11 Home	IdeaPad Slim 3	ronden-3724	6	100.00	v1|358359838782|0	\N
18192	Intel Core i7 10th Gen.	1.80 GHz	32 GB	1 TB	SSD (Solid State Drive)	14 in	\N	\N	Windows 11 Pro	Lenovo X13	bargdeals65	655	99.70	v1|318040666191|0	\N
18193	Intel Core Ultra 7	\N	32 GB	2 TB	SSD (Solid State Drive)	14 in	\N	\N	Windows 11 Pro	Lenovo ThinkPad X1	julyprum	231	100.00	v1|117100719751|0	\N
18194	Intel Core i5 11th Gen.	\N	8 GB	256 GB	SSD (Solid State Drive)	13.3 in	1920 x 1080	\N	Windows 11 Pro	THINKPAD L13 GEN2	wepcrcllc	3298	99.20	v1|137155218530|0	THINKPAD L13 GEN2
18195	Intel Core Ultra 7 155H	2.40 GHz	32 GB	1 TB	SSD (Solid State Drive)	16 in	2560 x 1600	NVIDIA RTX 2000 Ada Generation	Windows 11 Pro	Lenovo ThinkPad P1 Gen 7	levely13	19	100.00	v1|318040590232|0	21FV001PUS
18196	Intel Core i5 3rd Gen	1.70 GHz	\N	24GB	HDD + SSD	12.5 in	1366 x 768	Intel HD Graphics 4000	Windows 10	lenovo twist	baruhs-2	365	99.70	v1|236704529426|0	33474HU
18197	AMD Ryzen 5	\N	16 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	AMD Radeon Graphics	Windows 11 Pro	Lenovo ThinkPad T14s	damcclu	1767	100.00	v1|198213057265|0	T14S
18198	Intel Core i7 4th Gen.	2.90 GHz	16 GB	\N	SSD (Solid State Drive)	15.6 in	\N	\N	Windows 10 Pro	ThinkPad	rudela-1	3	100.00	v1|127762366351|0	\N
18199	AMD Ryzen 7 PRO 4750U	\N	16 GB	512 GB	NVMe (Non-Volatile Memory Express)	14 in	1920 x 1080	AMD Radeon Graphics	Windows 11 Pro	Lenovo ThinkPad T14s	damcclu	1767	100.00	v1|198213597767|0	\N
18200	Intel Core i7 @ 2.6GHz	\N	\N	\N	\N	15.6 in	\N	\N	\N	\N	automationplc89	212	99.50	v1|306835563225|0	\N
18201	i5-1135G7 (11th Gen)	1.3GHz	8GB	256GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	Thinkpad E14 G2	quicksilverwholesale	1330	99.30	v1|358359698817|0	20TA004GUS
18202	AMD Ryzen 7	\N	\N	512 GB	SSD (Solid State Drive)	16 in	1920 x 1200	Integrated/On-Board Graphics	Windows 11 Pro	Lenovo P16s Gen 4	openboxit	683	99.70	v1|327061450827|0	21QR0024US
18203	Intel Core i7 11th Gen.	3.00 GHz	32 GB	512 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad T14s	idalltaken	846	100.00	v1|177980411835|0	ThinkPad T14s Gen2, THINKPAD T14S GEN 2
18204	NONE	\N	\N	\N	\N	14 in	\N	\N	\N	\N	beachaudio	336673	99.60	v1|236704480417|0	21sx0038us
18205	i5-1135G7 (11th Gen)	1.3GHz	8GB	256GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	Thinkpad E14 G2	quicksilverwholesale	1330	99.30	v1|358359646277|0	20TA004GUS
18206	Intel Core Ultra 7	Intel Core Ultra 7 265U	32 GB	1 TB	SSD (Solid State Drive)	16 in	1920 x 1200	Intel Graphics	Windows 11 Pro	Lenovo T16 Gen 4	openboxit	683	99.70	v1|327061436083|0	ThinkPad T16 Gen 4, 21QE007TUS
18207	core i7-2620M	2.70 GHz	16 GB	256 GB	HDD + SSD	14 in	1600 x 900	Intel HD Graphics 3000	Windows 11 Pro	Lenovo ThinkPad T420	kewlusedstuff	365	100.00	v1|188192882731|0	T420
18208	Intel Core i5-1135G7	2.40 GHz	16 GB	256 GB	NVMe (Non-Volatile Memory Express)	14 in	1920 x 1080	Intel UHD Graphics	Windows 11 Pro	Lenovo ThinkPad T14 Gen 2	bradfo_4831	147	95.10	v1|318040449894|0	\N
18209	185H	2.3 GHz	\N	2.0TB	\N	16.0	2560 x 1600	NVIDIA	Windows 11 Pro	Lenovo ThinkPad P1 Gen 7 21KV	itsupplyfusion	419	100.00	v1|188192847597|0	\N
18210	1140G7	1.8 GHz	\N	256GB	\N	12.3	1920 x 1280	\N	No OS	Lenovo ThinkPad X12 Detachable 20UW	itsupplyfusion	419	100.00	v1|188192846645|0	\N
18211	Intel Core Ultra 5	1.60 GHz	16 GB	512 GB	SSD (Solid State Drive)	14 in	1920 x 1200	Intel Graphics	Windows 11 Pro	Lenovo ThinkPad T14 Gen 5	hustlebro-98	3	100.00	v1|397744623758|0	THINKPAD T14 GEN 5
18212	125U	\N	\N	262GB	\N	14.0	1920 x 1200	\N	Windows 11 Pro	Lenovo ThinkPad L14 Gen 5	itsupplyfusion	419	100.00	v1|188192843392|0	\N
18213	8840HS	3.3 GHz	\N	1.0TB	\N	14.0	1920 x 1200	AMD	Windows 11 Pro	Lenovo ThinkPad P14s Gen 5	itsupplyfusion	419	100.00	v1|188192843256|0	\N
18214	I5-10310U	\N	\N	512GB	\N	14.0	1920 x 1080 (FHD)	\N	Windows 11 Pro	Lenovo ThinkPad T14 G1	itsupplyfusion	419	100.00	v1|188192841603|0	\N
18215	4650U	\N	\N	262GB	\N	14.0	1920 x 1080 (FHD)	\N	Windows 11 Pro	Lenovo Thinkpad T14 G1	itsupplyfusion	419	100.00	v1|188192840972|0	\N
18216	I5-10310U	\N	\N	512GB	\N	14.0	1920 x 1080	\N	Windows 11 Pro	Lenovo Thinkpad T14 G1	itsupplyfusion	419	100.00	v1|188192840452|0	\N
18217	I7-1185G7	\N	\N	1.0TB	\N	14.0	1920 x 1200 WUXGA	\N	Windows 11 Pro	Lenovo ThinkPad X1 Carbon G9	itsupplyfusion	419	100.00	v1|188192839865|0	\N
18218	Ryzen 5 PRO 4650U	\N	\N	262GB	\N	14.0	1920 x 1080 (FHD)	\N	Windows 11 Pro	Lenovo Thinkpad T14s G1	itsupplyfusion	419	100.00	v1|188192838945|0	\N
18219	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	nextgen_essentials	2522	99.60	v1|306835512097|0	\N
18220	10310U	1.7 GHz	\N	262GB	\N	14.0	1920 x 1080	\N	Windows 11 Pro - Nordic	Lenovo Thinkpad T14 G1	itsupplyfusion	419	100.00	v1|188192837718|0	\N
18221	Intel Core Ultra 5 226V	\N	\N	512GB	\N	14.0	1920 x 1200 WUXGA	Intel(R) Arc(TM)	Windows 11 Home	Lenovo ThinkPad X9-14 G1	itsupplyfusion	419	100.00	v1|188192836919|0	\N
18222	I5-10310U	\N	\N	262GB	\N	14.0	1920 x 1080 (FHD)	\N	Windows 10 Pro	Lenovo Thinkpad T14 G1	itsupplyfusion	419	100.00	v1|188192836415|0	\N
18223	\N	\N	\N	\N	\N	\N	\N	\N	\N	ThinkPad E15 TP0117A	k-stargoods	1148	95.80	v1|188192809698|0	\N
18224	\N	\N	\N	\N	\N	\N	\N	\N	\N	ThinkPad E15 TP0117A	k-stargoods	1148	95.80	v1|188192809313|0	\N
18225	NA	\N	NA	NA	NA	NA	\N	NA	NA	NA	japan_gearpro	134	98.40	v1|397744540124|0	NA
18226	NA	\N	NA	NA	NA	NA	\N	NA	NA	NA	japan_gearpro	134	98.40	v1|397744540131|0	NA
18227	Intel Core i5-7200U	\N	NA	NA	NA	12.5 inches (please convert cm to inches)	\N	NA	Windows	ThinkPad X270	japan_gearpro	134	98.40	v1|397744540147|0	NA
18228	NA	\N	NA	NA	NA	NA	\N	NA	NA	NA	japan_gearpro	134	98.40	v1|397744540149|0	NA
18229	NA	\N	NA	NA	SSD	NA	\N	NA	Windows 11 Pro	ThinkPad L13	japan_gearpro	134	98.40	v1|397744540161|0	NA
18230	Intel Core i7-3520M (3rd Gen)	\N	NA	NA	SSD	NA	\N	NA	Windows 11 Pro	ThinkPad T430s	japan_gearpro	134	98.40	v1|397744540176|0	NA
18231	NA	\N	NA	NA	NVMe SSD	13.3 inches	\N	NA	Windows 11 Pro	ThinkPad X13 Gen 2	japan_gearpro	134	98.40	v1|397744540177|0	NA
18232	2.5GHz (exact model unspecified)	\N	NA	NA	NA	14 inches (please convert cm to inches)	\N	NA	Windows 10 Home	ThinkPad E480	japan_gearpro	134	98.40	v1|397744540180|0	NA
18233	Intel Core i7 1185	\N	NA	NA	NA	14 inches (please convert to cm: approximately 35.56 cm)	\N	NA	Windows 11 Pro	T14 Gen 2	japan_gearpro	134	98.40	v1|397744540183|0	NA
18234	NA	\N	NA	NA	NA	NA	\N	NA	NA	NA	japan_gearpro	134	98.40	v1|397744540189|0	NA
18235	Intel Core i5-8265U	\N	NA	NA	NA	NA	\N	NA	NA	ThinkPad E590	japan_gearpro	134	98.40	v1|397744540195|0	NA
18236	Intel Core i5-10210U (4 cores, 1.6GHz, up to 4.2GHz)	\N	NA	NA	NA	NA	\N	NA	Windows 11	ThinkPad L15 Gen1	japan_gearpro	134	98.40	v1|397744540206|0	NA
18237	Intel Core i7 (7GHz)	\N	NA	NA	NA	14 inches	\N	NA	NA	ThinkPad T14s Gen 1	japan_gearpro	134	98.40	v1|397744540080|0	NA
18238	Intel Core i5-10210U (Please convert cm to inches for size	\N	NA	NA	NA	NA	\N	NA	Optional, with recovery media available	ThinkPad E15 (20RES3LW00)	japan_gearpro	134	98.40	v1|397744540086|0	NA
18239	NA	\N	NA	NA	NA	NA	\N	NA	NA	NA	japan_gearpro	134	98.40	v1|397744540092|0	NA
18240	NA	\N	NA	NA	NA	NA	\N	NA	NA	ThinkPad L14 Gen3	japan_gearpro	134	98.40	v1|397744540099|0	NA
18241	NA	\N	NA	NA	NA	NA	\N	NA	NA	NA	japan_gearpro	134	98.40	v1|397744540101|0	NA
18242	Intel Core i5-1145G7 (2.6GHz)	\N	NA	NA	NA	NA	\N	NA	Windows 11 Pro 64-bit	ThinkPad X1 Carbon Gen9	japan_gearpro	134	98.40	v1|397744540102|0	NA
18243	NA	\N	NA	NA	NA	NA	\N	NA	NA	Not specified	japan_gearpro	134	98.40	v1|397744540105|0	NA
18244	Intel Core i5-1145G7 (11th Gen)	\N	NA	NA	SSD	14 inches	\N	NA	NA	ThinkPad T14 Gen2	japan_gearpro	134	98.40	v1|397744540106|0	NA
18245	Intel 60GHz	\N	NA	NA	NA	NA	\N	NA	Windows 11 Pro	NA	japan_gearpro	134	98.40	v1|397744540112|0	NA
18246	NA	\N	NA	NA	NA	NA	\N	NA	Windows 11	Not specified	japan_gearpro	134	98.40	v1|397744540113|0	NA
18247	NA	\N	NA	NA	SSD	15.6 inches (please convert to inches)	\N	NA	Windows 11 Pro	L570	japan_gearpro	134	98.40	v1|397744540122|0	NA
18248	AMD Ryzen 7	2.30 GHz	32 GB	512 GB	SSD (Solid State Drive)	14 in	1920 x 1080	AMD Radeon Graphics	Windows 11 Pro	Lenovo Thinkpad T495	pou-6902	202	100.00	v1|177976501588|0	\N
18249	Intel Core i5-1245	\N	NA	NA	NA	NA	\N	NA	NA	L13 GEN3	japan_gearpro	134	98.40	v1|397744540139|0	NA
18251	Intel Core i5 (11th Gen)	\N	NA	NA	NA	14 inches	\N	NA	Windows 11	ThinkPad E14 Gen 2	japan_gearpro	134	98.40	v1|397744540153|0	NA
18252	NA	\N	NA	NA	SSD	NA	\N	NA	NA	ThinkPad L390	japan_gearpro	134	98.40	v1|397744540155|0	NA
18253	Intel Core i5 (10th Gen)	\N	NA	NA	SSD (256GB)	13.3 inches	\N	NA	Windows 11 Pro	ThinkPad X13	japan_gearpro	134	98.40	v1|397744540170|0	NA
18254	i5-1035G4	\N	8 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Integrated/On-Board Graphics	Windows 11 Home	Lenovo Yoga	ideazguy	3530	100.00	v1|168252336312|0	C94014IIL
18255	Intel Core Ultra 7-155H	2.50 GHz	32 GB	1 TB	SSD (Solid State Drive)	16 in	2560 x 1600	NVIDIA RTX 2000 Ada Generation	Windows 11 Pro	Lenovo thinkpad p1 Gen 7	bobw-us2014	45	100.00	v1|327061377748|0	21KV0000US
18256	core i7-2640M	2.80 GHz	16 GB	128 GB	HDD + SSD	14 in	1600 x 900	Intel HD Graphics 3000	Windows 11 Pro	Lenovo ThinkPad T420	kewlusedstuff	365	100.00	v1|188192739843|0	T420
18257	Intel Core i5 11th Gen.	\N	16 GB	256GB	nvme	14"	1920 x 1080	Intel Iris Xe Graphics	Windows	ThinkPad E14 Gen 2	wepcrcllc	3298	99.20	v1|137155000309|0	LE31945C-B
18258	Intel Pentium M	1.86	2 GB	30 GB	\N	14 in	1400 x 1050	Dedicated Graphics	Windows XP	IBM ThinkPad T43	warrenscomputerclinic	1022	100.00	v1|177980258926|0	\N
18259	\N	\N	\N	\N	\N	\N	\N	\N	\N	ThinkPad E15 G4	k-stargoods	1148	95.80	v1|188192710030|0	\N
18260	Intel Core i7 8th Gen.	1.80 GHz	16 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	Lenovo T490	techsale78	4318	99.70	v1|177980195034|0	THINKPAD T490
18261	Intel Core Ultra 7 Series 2	\N	32 GB	512 gigabytes	SSD	14 in	2880 x 1800	Intel Arc	Windows 11 Pro	Lenovo ThinkPad X1	jwheelz76	206	100.00	v1|287222769974|0	21NS0014US
18262	Intel Core i7 1165G7	1.00 GHz	8 GB	256 GB	SSD (Solid State Drive)	15.6 in	1920 x 1080	Intel IRIS Graphics 940	Windows 11 Pro	Lenovo ThnkBook 15 IIL	techsale78	4318	99.70	v1|177980184657|0	\N
18263	\N	\N	\N	\N	\N	\N	\N	\N	\N	ThinkPad T14s Gen 1	k-stargoods	1148	95.80	v1|206156844593|0	\N
18264	Core i5-2520M	2.50 GHz	8 GB	120 GB	SSD (Solid State Drive)	14 in	1366 x 768	Intel HD Graphics 3000	Windows 11 Pro	Lenovo ThinkPad T420	kewlusedstuff	365	100.00	v1|188192646769|0	T420
18265	4650U	\N	\N	512GB	\N	14.0	1920 x 1080 (FHD)	\N	Windows 11 Pro	Lenovo Thinkpad T14 G1	itsupplyfusion	419	100.00	v1|188192646316|0	\N
18266	838	\N	\N	131GB	\N	11.0	1920 x 1200	\N	Chrome	Lenovo Chromebook Duet 11M889	itsupplyfusion	419	100.00	v1|188192644676|0	\N
18267	Ryzen 5 7530U	\N	\N	512GB	\N	13.0	1920 x 1200	\N	Windows 11 Pro	Lenovo ThinkPad L13 Yoga Gen 4	itsupplyfusion	419	100.00	v1|188192644250|0	\N
18268	120U	\N	\N	512GB	\N	16.0	1920 x 1200	\N	Windows 11 Home	Lenovo IdeaPad 5 2-in-1 16IRU9	itsupplyfusion	419	100.00	v1|188192644254|0	\N
18269	1355U	\N	\N	512GB	\N	14.0	1920 x 1080	\N	No OS	Lenovo IdeaPad Slim 3 14IRU8	itsupplyfusion	419	100.00	v1|188192644076|0	\N
18270	7840U	\N	\N	512GB	\N	14.0	1920 x 1200 WUXGA	AMD	No OS	Lenovo ThinkPad P14s G4	itsupplyfusion	419	100.00	v1|188192644031|0	\N
18271	13850HX	\N	\N	1.0TB	\N	16.0	2560 x 1600	NVIDIA	Windows 11 Pro	Lenovo ThinkPad P16 Gen 2	itsupplyfusion	419	100.00	v1|188192643977|0	\N
18272	I9-12950HX	\N	\N	1.0TB	\N	16.0	3840 x 2400 WQUXGA	\N	No OS	Lenovo ThinkPad P16 G1	itsupplyfusion	419	100.00	v1|188192643968|0	\N
18273	7535U	2.9 GHz	\N	512GB	\N	16.0	1920 x 1200	AMD	Windows 11 Pro	Lenovo ThinkPad L16 Gen 1	itsupplyfusion	419	100.00	v1|188192643654|0	\N
18274	AMD Ryzen 5 Pro 7535U	2.9 GHz	\N	512GB	\N	16.0	1920 x 1200	AMD	Windows 11 Pro (FR)	Lenovo ThinkPad L16 Gen 1	itsupplyfusion	419	100.00	v1|188192643608|0	\N
18275	1185G7	\N	\N	512GB	\N	14.0	1920 x 1200	\N	Windows 11 Pro	Lenovo ThinkPad X1 Yoga G6	itsupplyfusion	419	100.00	v1|188192643580|0	\N
18276	1185G7	\N	\N	256GB	\N	14.0	1920 x 1080	\N	Windows 11 Pro	Lenovo Thinkpad T14 G2	itsupplyfusion	419	100.00	v1|188192643492|0	\N
18277	225U	\N	\N	512GB	\N	16.0	1920 x 1200	\N	Windows 11 Pro	Lenovo ThinkPad T16 Gen 4	itsupplyfusion	419	100.00	v1|188192643148|0	\N
18278	4650U	2.1 GHz	\N	512GB	\N	14.0	1920 x 1080	AMD	Windows 11 Pro	Lenovo ThinkPad T14 G1	itsupplyfusion	419	100.00	v1|188192642586|0	\N
18279	4750U	1.7 GHz	\N	512GB	\N	14.0	1920 x 1080	\N	Windows 11 Pro	Lenovo Thinkpad T14 G1	itsupplyfusion	419	100.00	v1|188192642357|0	\N
18280	See Title/Description	See Title/Description	See Title/Description	See Title/Description	See Title/Description	See Title/Description	See Title/Description	See Title/Description	See Title/Description	See Title/Description	calgarycomputerwholesale	59224	99.70	v1|206156827418|0	See Title/Description
18281	i5-1135G7 (11th Gen)	1.3GHz	8GB	256GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	Thinkpad E14 G2	quicksilverwholesale	1330	99.30	v1|358359393624|0	20TA004GUS
18282	10210U	\N	\N	262GB	\N	14.0	1920 x 1080	\N	Windows 11 Pro	Lenovo Thinkpad T14 G1	itsupplyfusion	419	100.00	v1|188192638675|0	\N
18283	I5-10310U	\N	\N	262GB	\N	14.0	1920 x 1080 (FHD)	\N	Windows 11 Pro	Lenovo Thinkpad T14 G1	itsupplyfusion	419	100.00	v1|188192638350|0	\N
18284	Intel Core Ultra 7 256V	2.20 GHz	16 GB	1 TB	SSD (Solid State Drive)	14 in	1920 x 1200	Intel Arc 140V (8GB)	Windows 11 Home	Lenovo Yoga Slim 7i Aura Edition	no958952	0	0.00	v1|168252254155|0	MPNXB55130AM
18285	Ryzen 5 PRO 4650U	\N	\N	262GB	\N	14.0	1920 x 1080 (FHD)	\N	Windows 11 Pro	Lenovo ThinkPad T14 G1	itsupplyfusion	419	100.00	v1|188192638232|0	\N
18286	1145G7	\N	\N	256GB	\N	14.0	1920 x 1080	\N	Windows 11 Pro	Lenovo Thinkpad T14 G2	itsupplyfusion	419	100.00	v1|188192638219|0	\N
18287	I7-1165G7	\N	\N	512GB	\N	14.0	1920 x 1080 (FHD)	\N	Windows 11 Pro	Lenovo ThinkPad X1 Carbon G9	itsupplyfusion	419	100.00	v1|188192638180|0	\N
18288	I5-10310U	\N	\N	262GB	\N	14.0	1920 x 1080 (FHD)	\N	Windows 10 Pro	Lenovo Thinkpad T14 G1	itsupplyfusion	419	100.00	v1|188192638039|0	\N
18289	I5-10210U	\N	\N	512GB	\N	14.0	1920 x 1080 (FHD)	\N	Windows 11 Pro	Lenovo ThinkPad T14 G1	itsupplyfusion	419	100.00	v1|188192638032|0	\N
18290	I5-10210U	\N	\N	262GB	\N	15.0	1920 x 1080 (FHD)	\N	Windows 11 Pro	Lenovo Thinkpad T15 G1	itsupplyfusion	419	100.00	v1|188192637723|0	\N
18291	I5-10310U	\N	\N	262GB	\N	14.0	1920 x 1080 (FHD)	\N	Windows 10 Pro	Lenovo Thinkpad T14 G1	itsupplyfusion	419	100.00	v1|188192637675|0	\N
18292	I5-10310U	\N	\N	262GB	\N	15.0	1920 x 1080 (FHD)	\N	\N	Lenovo Thinkpad T15 G1	itsupplyfusion	419	100.00	v1|188192637558|0	\N
18293	I5-10210U	\N	\N	262GB	\N	14.0	1920 x 1080 (FHD)	\N	Windows 10 Pro	Lenovo ThinkPad T14 G1	itsupplyfusion	419	100.00	v1|188192637497|0	\N
18294	838	\N	\N	131GB	\N	11.0	1920 x 1200	\N	Chrome	Lenovo Chromebook Duet 11M889	itsupplyfusion	419	100.00	v1|188192637329|0	\N
18295	1135G7	\N	\N	262GB	\N	13.0	1920 x 1080	\N	Windows 10 Home	Lenovo ThinkPad L13 Yoga Gen 2	itsupplyfusion	419	100.00	v1|188192637260|0	\N
18296	\N	2.40 GHz	\N	0	\N	15.6"	\N	\N	\N	Lenovo ThinkPad T560	zyberdisk	5	100.00	v1|366294054053|0	THINKPAD T560
18297	Intel Core i7 13th Gen.	3.90 GHz	32 GB	512 GB	SSD (Solid State Drive)	14 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad X1 Carbon Gen 12	jomic-637173	0	0.00	v1|366294050070|0	21HM002FUS
18298	Intel Cor i7-5500U	2.40 GHz	8 GB	512 GB SSD	SSD (Solid State Drive)	14 in	1920 x 1080	AMD Radeon Graphics	Windows 10	Radeon	shaboicado	40	100.00	v1|306835407914|0	Lenovo Y40-70
18299	Intel Core i7-6600U	2.50-3.00 GHz	12 GB	180GB	SSD (Solid State Drive)	14 in	2560 x 1440	Intel HD Graphics	\N	Lenovo ThinkPad T460S	motown324	55	100.00	v1|327061308252|0	\N
18300	Not Available	\N	\N	\N	\N	Not Available	\N	\N	\N	\N	neobitsinc	552	98.20	v1|127762208297|0	21KS0027US
18301	Not Available	\N	\N	\N	\N	Not Available	\N	\N	\N	\N	neobitsinc	552	98.20	v1|127762207389|0	21RS0024US
18302	I5-1135G7	\N	\N	262GB	\N	14.0	1920 x 1080 (FHD)	\N	Windows 11 Pro	Lenovo Thinkpad T14s G2	itsupplyfusion	419	100.00	v1|188192577595|0	\N
18303	Ryzen 7 Pro 5850U	\N	\N	512GB	\N	14.0	1920 x 1080 (FHD)	\N	Windows 11	Lenovo Thinkpad T14s G2	itsupplyfusion	419	100.00	v1|188192577275|0	\N
18304	I5-10210U	\N	\N	262GB	\N	14.0	1920 x 1080 (FHD)	\N	Windows 10 Pro	Lenovo ThinkPad T14 G1	itsupplyfusion	419	100.00	v1|188192576972|0	\N
18305	AMD Ryzen 5 5600H	3.30 GHz	8 GB	512 GB	SSD (Solid State Drive)	15.6 in	1920 x 1080	NVIDIA GeForce RTX 3050	Windows 11 Home	Lenovo IdeaPad Gaming 3 15ACH6	andrewmfhn2011	47	100.00	v1|287222689703|0	15ACH6
18306	Intel Core m3 8th Gen.	\N	\N	\N	\N	11 in	\N	Integrated/On-Board Graphics	Windows for Education	ThinkPad 11e Yoga Gen 6	barcons_bay	16	100.00	v1|336493662601|0	\N
18307	Intel Pentium M	\N	1 GB	\N	\N	15 in	\N	\N	Windows XP	IBM ThinkPad T43	this-and-that-collectables-3	150	100.00	v1|389779930821|0	THINKPAD T43
18308	See Title/Description	See Title/Description	See Title/Description	See Title/Description	See Title/Description	See Title/Description	See Title/Description	See Title/Description	See Title/Description	See Title/Description	calgarycomputerwholesale	59224	99.70	v1|277823239569|0	See Title/Description
18309	i5-1135G7	2.40GHz	16 GB	512 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad T14 G2	quicksilverwholesale	1330	99.30	v1|358359276054|0	20W0003KUS
18310	Intel Core i7 13th Gen.	2.10 GHz	64 GB	512 GB	SSD (Solid State Drive)	16 in	2560 x 1600	NVIDIA RTX 2000 Ada Generation	Windows 11 Pro	Lenovo ThinkPad P16 Gen 2	inhimiamp413	3676	100.00	v1|277823236648|0	21FBS2UX00
18311	Intel Core i5-8250U	\N	8 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	Lenovo T480	hobby_deals341	1734	100.00	v1|397744188051|0	\N
18312	Intel Core i3-8145U	\N	8GB	128 GB	SSD (Solid State Drive)	15.6"	\N	\N	Windows 10 Home	IdeaPad S340-81N8	theman71177	3090	100.00	v1|198212673286|0	\N
18313	Intel Core i9-11950H	2.60 GHz	32 GB	1 TB	NVMe (Non-Volatile Memory Express)	15.6	3840 x 2160	NVIDIA RTX A2000	Windows 11 Pro	Lenovo ThinkPad P15v	personalhelpdesk	70	100.00	v1|117100431690|0	\N
18314	Intel Core i7 13th Gen.	1.70 GHz	16 GB	1 TB	SSD (Solid State Drive)	16 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Home	16iru9	swellcells	16061	98.70	v1|188192435834|0	16IRU9
18315	i7-8665U	1.90 GHz	32 GB	512 GB	SSD (Solid State Drive)	14 in	2560 x 1440	NVIDIA Quadro P520	Windows 11	Lenovo P43s	koko184	950	100.00	v1|227267077932|0	\N
18316	Intel Core i7 8th Gen.	1.90 GHz	8 GB	512 GB	SSD (Solid State Drive)	15.6 in	1920 x 1080	NVIDIA Quadro P520	Windows 11 Pro	Lenovo ThinkPad P53s	ecommercebroker	483	99.40	v1|306835346994|0	\N
18317	i5-1135G7	2.4GHz	8GB RAM	256GB	SSD	15.6"	\N	Intel Iris Xe Graphics	Windows 11 Home	ThinkPad E15 Gen 2	paymore_lees_summit	1869	99.40	v1|198212651340|0	20TD-003KUS
18318	i7-4810MQ	2.80 GHz	16 GB	1 TB	SSD (Solid State Drive)	14 in	1920 x 1080	Nvidia GeForce GT 730M	Windows 10	Lenovo T440P	koko184	950	100.00	v1|227267074635|0	\N
18319	258V	\N	\N	1.0TB	\N	14.0	2880x1800	\N	Windows 11	Lenovo ThinkPad X1 Yoga Gen 10 G10	itsupplyfusion	419	100.00	v1|188192425233|0	\N
18320	Intel Core i5 8. gene	1.60GHz	8GB	256GB	\N	14.5 inches (36.8cm)	1920 x 1080	\N	Windows 11 Pros	Lenovo ThinkPad T480	ebixx.120	15947	99.50	v1|147217120113|0	\N
18321	Intel Core i5 10. gene	1.70GHz	8 GB	256GB	\N	13,3 Zoll	1920 x 1080	\N	Windows 11 Pros	Lenovo ThinkPad 13	it-mixx	44083	99.90	v1|206157479179|0	\N
18322	Intel Core i7 9. gene	2.60GHz	32 GB	512GB	\N	15,6 Zoll	1920 x 1080	\N	Windows 11 Pros	Lenovo Thinkpad P15	it-mixx	44083	99.90	v1|127762725580|0	\N
18323	Core i5	1.60 GHz	8 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	NA	Windows 11 Pro	Lenovo X1CARBON	ms_japan_7	529	99.30	v1|318041167959|0	NAX1 CARBON
18324	Intel Core i5-1135G7	2.40 GHz	16 GB	256 GB	NVMe (Non-Volatile Memory Express)	13.3 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad L13 Yoga	sahad_masood	93	100.00	v1|168252383038|0	\N
18325	I5-4300U	\N	8 GB	\N	SSD (Solid State Drive)	14 in	1366 x 768	Intel HD Graphics	Not Included	Lenovo ThinkPad T440	louis2829	187	100.00	v1|336493791529|0	\N
18326	intel core i7 vpro 8th gen	\N	8 GB	1 TB	SSD (Solid State Drive)	14 in	1920 x 1080	Integrated/On-Board Graphics	Ubuntu	Lenovo ThinkPad X1 Yoga	chrile-676	307	97.10	v1|267615894517|0	\N
18327	Intel Core i5 8. gene	1.70GHz	8GB	256GB	\N	14.5 inches (36.8cm)	1920 x 1080	\N	Windows 11 Pros	Lenovo ThinkPad T480s	ebixx.120	15947	99.50	v1|147216520949|0	\N
18328	Intel Core i5 8. gene	1.70GHz	8GB	256GB	\N	14.5 inches (36.8cm)	1920 x 1080	\N	Windows 11 Pros	Lenovo ThinkPad T480s	ebixx.120	15947	99.50	v1|147216520952|0	\N
18329	Intel Core i5 8. gene	1.60GHz	8GB	256GB	\N	14,5 Zoll (36,8 cm)	1920 x 1080	\N	Windows 11 Pros	Lenovo ThinkPad T480s	it-mixx	44083	99.90	v1|127762163288|0	\N
18330	Intel Core i5 8. gene	1.70GHz	8GB	256GB	\N	14,5 Zoll (36,8 cm)	1920 x 1080	\N	Windows 11 Pros	Lenovo ThinkPad T480s	it-mixx	44083	99.90	v1|206156718657|0	\N
18331	Intel Core i3-10110U	2.10 GHz	8 GB	128 GB	\N	13,3 Zoll	1920 x 1080	\N	Windows 11 Pro	Lenovo ThinkPad L13	it-mixx	44083	99.90	v1|127762160729|0	\N
18332	AMD Ryzen 3500u	\N	8 GB	256 GB	NVMe (Non-Volatile Memory Express)	14 in	1920 x 1080	Integrated/On-Board Graphics	Windows 11 Pro	Thinkpad T495	international.exports	380	100.00	v1|127762154576|0	\N
18333	Inte Core i5 3320M 2.6 GHz	\N	\N	119GB	SSD (Solid State Drive)	14 in	1366 x 768	Intel HD Graphics 4000	Windows 10 Pro	Lenovo ThinkPad T430	lampligter-1234	135	100.00	v1|188192452623|0	\N
18334	Intel Core 2 Duo	\N	3 GB	250 GB	HDD (Hard Disk Drive)	14 in	1280 x 800	\N	Linux	Lenovo ThinkPad T61	andys-cs	10260	100.00	v1|277823188758|0	\N
18335	Intel Core i5 12th Gen.	1.70 GHz	16 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad X1 Yoga	tech2usales	903	100.00	v1|377047760667|0	21CD0032UK
18336	Intel Core i9 13th Gen.	2.60 GHz	32 GB	1 TB	Nvme	16 in	2560 x 1600	NVIDIA GeForce RTX 4090	Windows 11 Pro	Lenovo ThinkPad P1 Gen 6	ruslanasmatul	402	98.40	v1|358359092999|0	\N
18337	i7-12800H	2.40 GHz	64 GB	1.8TB	SSD (Solid State Drive)	16 in	2560 x 1600	NVIDIA RTX A4500	Windows 11 Home	Lenovo ThinkPad P1	calsc7286	3	100.00	v1|127761971196|0	\N
18338	Intel Core i5-4200U	1.60 GHz	\N	4 GB	\N	12.5 in	\N	\N	Windows 10 Pro	Lenovo ThinkPad X240	fireandwolf	7456	99.50	v1|336493407479|0	\N
18339	Snapdragon 8cx Gen 3	3.00 GHz	16 GB	256 GB	SSD (Solid State Drive)	13.3 in	1920 x 1200	Integrated/On-Board Graphics	Windows 11 Pro	Lenovo Thinkpad X13s	obidja-0	720	100.00	v1|318039460078|0	21EYS5MU00
18340	AMD Ryzen 5 PRO 4000 Series	2.10 GHz	16 GB	240GB	SSD (Solid State Drive)	13.3 in	1920 x 1080	AMD Radeon Vega 6	Windows 11 Pro	Lenovo X13 Gen 1	jackh0119	14	100.00	v1|177979646279|0	\N
18341	Intel Core i5 8th Gen.	1.60 GHz	16 GB	512 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	Lenovo Thinkpad T490	shopsmart2003	159	100.00	v1|389779310415|657069758753	Lenovo ThinkPad T480
18342	Intel Core i5-6300U	2.40 GHz	16 GB	512 GB	NVMe (Non-Volatile Memory Express)	14-14.9"	1920 x 1080	Intel HD Graphics	Windows 11 Pro	Lenovo ThinkPad T460S	dorminate-tech	60	100.00	v1|188191804080|0	\N
18343	Intel Core i5 10th Gen.	1.60 GHz	8 GB	256 GB	SSD (Solid State Drive)	15.6 in	1920 x 1080	Integrated Intel UHD Graphics	Windows 10	ThinkPad L15	japan.treasure.collection	754	100.00	v1|397743494678|0	20U3
18344	Intel Ultra 7	4.80 GHz	32 GB	1 TB	SSD (Solid State Drive)	13.3 in	1920 x 1200	Intel UHD Graphics	Windows 11 Pro	ThinkPad X13 Gen 5	techinspir	245	100.00	v1|206156284725|0	21LU0025UK
18345	AMD Ryzen 5	\N	16 GB	256 GB	SSD (Solid State Drive)	14 in	\N	AMD Radeon Graphics	Windows 11 Pro	Lenovo ThinkPad T14s	kakiking	229	100.00	v1|177979514495|0	\N
18346	Intel Core i5-1135G7	2.40 GHz	8 GB	512 GB	NVMe (Non-Volatile Memory Express)	13 in	1920 x 1080	Integrated/On-Board Graphics	Windows 11 Pro	Lenovo ThinkPad X13 Yoga	dorminate-tech	60	100.00	v1|188191748674|0	\N
18347	Intel Core i7 11th Gen.	\N	64 GB	1 TB	SSD (Solid State Drive)	15-15.9"	1920 x 1080	NVIDIA T600	Windows 11 Pro	Lenovo ThinkPad P15v	thinktechexchange	143	100.00	v1|389779169369|0	\N
18348	i5-M540	2.53GHz	4GB RAM	150GB	HDD	12.1"	1280 x 800	Intel HD Graphics	Windows 10 Pro	x201	paymore_luton	2972	99.90	v1|127761819995|0	\N
18349	Intel Core i5 12th Gen.	1.70 GHz	16 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad X1 Yoga	tech2usales	903	100.00	v1|377047767451|0	21CD0032UK
18350	Intel Core i5 6th Gen.	3.20 GHz - 3.60 GHz	8GB RAM	256 GB	SSD (Solid State Drive)	14"	FHD (1920 x 1080)	Intel HD Graphics 530	Windows 10 Pro 64Bit	ThinkPad Yoga 460	techrez	708	100.00	v1|397743388443|0	TP00079A
18351	intel i7 5600U	2.40 GHz	8 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel HD Graphics 5500	Windows 10 Pro	Lenovo ThinkPad X1 Carbon 3rd Gen	bluefruit75	2405	100.00	v1|168251689916|0	\N
18352	Intel Core i5 4th Gen.	2.90 GHz	8 GB	240GB	SSD (Solid State Drive)	12.5 in	\N	Intel HD Graphics	Windows 11 Pro	Lenovo ThinkPad X240	twolittlemice	1828	99.30	v1|287222120163|0	X240
18353	Intel Core i7 1165G7	\N	16 GB	500 GB	SSD (Solid State Drive)	14 in	\N	Integrated/On-Board Graphics	Windows 11 Pro	Lenovo ThinkPad X1 Carbon 9th Gen	bseeb4775	26	100.00	v1|206156188483|0	\N
18354	Intel Core i5-10210U	1.60GHz	8 GB	256GB	\N	13,3 Zoll	1920 x 1080	\N	Windows 11 Pros	Lenovo ThinkPad X13	it-mixx	44083	99.90	v1|206156131907|0	\N
18355	Intel Core i7-8550U	1.60GHz	8 GB	256GB	\N	13,3 Zoll	1920 x 1080	\N	Windows 11 Pros	Lenovo Thinkpad L13	it-mixx	44083	99.90	v1|206156131909|0	\N
18356	Intel Core i7-8565U	1.90GHz	16 GB	512GB	\N	15,6 Zoll	1920 x 1080	\N	Windows 11 Pros	Lenovo ThinkPad P53s	it-mixx	44083	99.90	v1|127761742027|0	\N
18357	Intel Core i5 5th Gen.	2.30 GHz	8 GB	240GB	SSD (Solid State Drive)	14 in	1366 x 768	Intel HD Graphics 5000	Windows 10 Pro	ThinkPad T450	kel-tel	45846	99.80	v1|287222001424|0	\N
18358	Intel Core i5 8th Gen.	1.60 GHz	16 GB	256 GB	NVMe (Non-Volatile Memory Express)	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	Lenovo L490	erkac_5480	3	100.00	v1|406788834165|0	20Q5S18N00
18359	Intel Celeron	\N	8 GB	16 GB	SSD (Solid State Drive)	11.6 in	\N	Integrated/On-Board Graphics	Chrome OS	Lenovo ThinkPad X131e	iwantthatcameraltd	547	99.80	v1|389757778621|0	\N
18360	Intel Core Ultra 7 165U	4.90 GHz	32 GB	1 TB	SSD (Solid State Drive)	14 in	1920 x 1200	Intel Graphics	Windows 11 Pro	ThinkPad T14 Gen 5	bass-technology	1088	100.00	v1|137153870478|0	21MMS2Ce0N
18361	Intel Core i7 11. Gen	2.00-2.49GHz	\N	1TB	\N	13.5"	2256 x 1504	\N	Windows 11 Pro	Lenovo Thinkpad X1 Titanium	rspective	80	100.00	v1|157773878712|0	\N
18362	Intel Core i5-6300U	\N	\N	256 GB	\N	14 in	1600 x 900	\N	\N	\N	zibi8071-uk	447	100.00	v1|188191171966|0	\N
18363	Intel Core i5-1035G1	1.00 GHz	8 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel UHD Graphics	Windows 11 Pro	V14-IIL	cashconverterskingstanding	14803	99.30	v1|157773876689|0	Does Not Apply, 82C401FFUS
18364	Intel Core i5-3230M	\N	8 GB	128 GB	\N	14 in	\N	\N	\N	Lenovo Thinkpad L430	zibi8071-uk	447	100.00	v1|188191065279|0	\N
18365	Intel i5-1135G7	2.42 GHz	8 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	intel iris Graphics	Windows 11 Pro	Lenovo ThinkPad E14 2nd Gen	pa-7477	246	98.70	v1|127761370136|0	\N
18366	Intel Core i5 3rd Gen.	\N	\N	\N	\N	12.5 in	\N	\N	Windows 10 LTSC	Lenovo ThinkPad X230	ivdjapitc-0	539	100.00	v1|227266548359|0	\N
18367	amd ryzen 7 7730U	\N	16 GB	512 GB	NVMe (Non-Volatile Memory Express)	14 in	1920 x 1280	Raptor Lake-P	Windows 11 Pro	ThinkPad E14 Gen 5	3855lynette	1432	100.00	v1|236703123660|0	\N
18368	Intel Core i7-8550U	1.80GHz	16GB	128 GB	Solid State Drive	14-inch	\N	Integrated Graphics	Windows 11 Home	Lenovo ThinkPad X1 Yoga	magdrax	2133	98.10	v1|236703123382|0	\N
18369	Intel Core i5 10th Gen.	1.70 GHz	16 GB	256	SSD (Solid State Drive)	14 in	1920 x 1080	Intel UHD Graphics	Windows 11 Pro	Lenovo ThinkPad T14s Gen 1	lookeylookeylove	461	100.00	v1|157773352089|0	20T1S4322L
18370	Intel Core i7 9th Gen.	2.60 GHz	32 GB	512 GB	SSD (Solid State Drive)	15.6 in	1920 x 1080	Intel UHD Graphics & NVIDIA Quadro T2000	Windows 11 Pro	Lenovo ThinkPad P53	it_me.mmc	455	100.00	v1|188189525481|0	20QQ-S2U300
18371	Intel Core i7 11th Gen.	\N	64 GB	1 TB	SSD (Solid State Drive)	14 in	\N	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad X1	mk4pf_01	0	0.00	v1|198210352937|0	\N
18372	Ultra 7	5.2Ghz	64 GB	1 TB	SSD (Solid State Drive)	14 in	1920 x 1200	Intel Graphics	Windows 11 Pro	Lenovo ThinkPad X1	mk4pf_01	0	0.00	v1|198210288038|0	\N
18373	Intel Core i5 5th Gen.	2.30 GHz	8 GB	240GB	SSD (Solid State Drive)	14 in	1366 x 768	Intel HD Graphics 5000	Windows 11 Pro	ThinkPad T450	flasm_2020	1449	100.00	v1|306834084724|0	\N
18374	Intel Core i5-8350U	\N	16 GB	256 GB	SSD (Solid State Drive)	12.5 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	Lenovo ThinkPad X280	keibalodin	703	100.00	v1|188189213581|0	ThinkPad X280
18375	Intel i5-7300u	2.60 GHz	8 GB	256 GB	SSD (Solid State Drive)	12.5 in	1366 x 768	Intel HD Graphics	Windows 11 Pro	Lenovo ThinkPad X270	ingeniousgeorge	979	100.00	v1|127760384464|0	\N
18376	Intel Core i5 3rd Gen.	2.60 GHz	8 GB	256 GB	SSD (Solid State Drive)	14 in	1600 x 900	Intel HD Graphics 4000	Windows 10 Pro	Lenovo ThinkPad T430	smit1080	734	100.00	v1|127760343087|0	\N
18377	Intel Core i5 8. gene	1.60GHz	\N	256GB	\N	14.5 inches (36.8cm)	1920 x 1080	\N	Windows 11 Pros	Lenovo ThinkPad T480	ebixx.120	15947	99.50	v1|267615072948|0	\N
18378	Intel Core i5 8. gene	1.60GHz	\N	256GB	\N	14.5 inches (36.8cm)	1920 x 1080	\N	Windows 11 Pros	Lenovo ThinkPad T480	ebixx.120	15947	99.50	v1|267615072951|0	\N
18379	Intel Core i5 3rd Gen.	3.30 GHz	8 GB	128 GB	SSD (Solid State Drive)	12.5 in	1366 x 768	Intel HD Graphics 4000	Linux Mint	Lenovo ThinkPad X230	su685654	14	100.00	v1|318035623892|0	X230
18380	Intel Core i5 7. gene	2.80GHz	16 GB	512GB	\N	14,5 Zoll	1920 x 1080	\N	Windows 11 Pros	Lenovo ThinkPad X1	it-mixx	44083	99.90	v1|206154392512|0	\N
18381	Intel Xeon E2176M	2.70GHz	32 GB	1TB	\N	15,6 Zoll	1920 x 1080	\N	Windows 11 Pros	Lenovo ThinkPad P1	it-mixx	44083	99.90	v1|127760262653|0	\N
18382	Intel Core i7 8. gene	2.20GHz	16 GB	\N	\N	15,6 Zoll	1920 x 1080	\N	Windows 11 Pros	Lenovo ThinkPad P1	it-mixx	44083	99.90	v1|127760262620|0	\N
18383	Intel Core i5 8. gene	1.60GHz	\N	256GB	\N	14,5 Zoll (36,8 cm)	1920 x 1080	\N	Windows 11 Pros	Lenovo ThinkPad T490	it-mixx	44083	99.90	v1|206154390171|0	\N
18384	Intel Core i5 8. gene	1.60GHz	\N	256GB	\N	14,5 Zoll (36,8 cm)	1920 x 1080	\N	Windows 11 Pros	Lenovo ThinkPad T490	it-mixx	44083	99.90	v1|127760260305|0	\N
18385	Intel Core i5 10th Gen.	\N	16 GB	512 GB	SSD (Solid State Drive)	14 in	\N	\N	Windows 11 Pro	Lenovo ThinkPad X1 Carbon 8th Gen	johnandomeda	60	100.00	v1|366291853075|0	\N
18386	Intel Core i5-10210U	2.20 GHz	16 GB	256 GB	SSD (Solid State Drive)	13.3 in	1920 x 1080	Intel UHD Graphics	Windows 11 Pro	Lenovo X13 Gen 1	linkcomputerrepair	2774	100.00	v1|267615042590|0	20T2
18387	Intel Core i5 3rd Gen.	2.60 GHz	8 GB	256 GB	\N	12.5 in	\N	\N	Windows10LTSC	Lenovo ThinkPad X230	ivdjapitc-0	539	100.00	v1|227265755956|0	\N
18388	Intel Core i3-1115G4	3 GHz	8GB	256 GB	Solid State Drive	14-inch	\N	Integrated Graphics	Windows 11 Pro	\N	magdrax	2133	98.10	v1|236702213908|0	\N
18389	Intel Core i5 12th Gen.	1.60 GHz	16 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad X1 Yoga	tech2usales	903	100.00	v1|377049980184|0	21CES2DM00
18390	Intel Core i7 10th Gen.	1.80 GHz	16 GB	512 GB	NVMe (Non-Volatile Memory Express)	14 in	3840 x 2160	Integrated/On-Board Graphics	Windows 11 Pro	Lenovo ThinkPad X1 Carbon Gen8	ms-comps	4831	100.00	v1|287220338394|0	\N
18391	Intel Core i7 13th Gen 1365U vPro	1.80 GHz	32 GB	512 GB	SSD (Solid State Drive)	13.3 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad X13 Gen 4	tech2usales	903	100.00	v1|377047487637|0	21EYS5MU00
18392	Intel Core i5 12th Gen.	1.70 GHz	16 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad X1 Yoga	tech2usales	903	100.00	v1|377047742761|0	21CD0032UK
18393	Intel Core i5 3rd Gen.	\N	8 GB	500 GB	SSD (Solid State Drive)	14 in	1366 x 768	Intel HD Graphics 4000	Linux	Lenovo ThinkPad T430	dowelman	433	100.00	v1|137151691569|0	\N
18394	Intel Core i5 3rd Gen.	2.60 GHz	16 GB	240GB	SSD (Solid State Drive)	12.5 in	1366 x 768	Intel HD Graphics 4000	Windows 11 Pro	X230	olnictul	1565	100.00	v1|117098720235|0	\N
18395	i7-4710MQ	2.50 GHz	16 GB	240GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel HD Graphics	Windows 10	Lenovo ThinkPad T440P	olnictul	1565	100.00	v1|117098720210|0	\N
18396	Intel Core i7 11th Gen.	3.00 GHz	32 GB	512 GB	NVMe (Non-Volatile Memory Express)	14 in	1920 x 1080	Integrated/On-Board Graphics	Windows 11 Pro	Lenovo ThinkPad T14 Gen 2	ms-comps	4831	100.00	v1|277820580921|0	\N
18397	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	sustainabletech4good	6770	99.00	v1|206154181658|0	\N
18398	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	sustainabletech4good	6770	99.00	v1|206154181674|0	\N
18399	Intel Core i7 11th Gen.	2.80 GHz	16 GB	512 GB	NVMe (Non-Volatile Memory Express)	14 in	1920 x 1080	Integrated/On-Board Graphics	Windows 11 Pro	Lenovo ThinkPad T14s Gen 2	ms-comps	4831	100.00	v1|277820553291|0	\N
18400	Intel Core i5-6300U	2.4 GHz	8 GB	256 GB	SSD (Solid State Drive)	12.5 in	1366 x 768	Intel HD Graphics 520	Windows 10 Pro	Lenovo ThinkPad X260	simplythebest-58	621	100.00	v1|298144543454|0	\N
18401	Intel Core i5 12th Gen.	1.30 GHz	24 GB	512 GB	NVMe (Non-Volatile Memory Express)	14 in	1920 x 1200	Integrated/On-Board Graphics	Windows 11 Pro	Lenovo ThinkPad T14s Gen 3	ms-comps	4831	100.00	v1|277820517047|0	\N
18402	i3 3110	2.40 GHz	4 GB	500 GB	\N	15.6 in	1366 x 768	Integrated/On-Board Graphics	Windows 10 Pro	Lenovo Thinkpad Edge	lentech-east	2010	100.00	v1|137151495336|0	\N
18403	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	sustainabletech4good	6770	99.00	v1|206154096352|0	\N
18404	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	sustainabletech4good	6770	99.00	v1|206154096331|0	\N
18405	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	sustainabletech4good	6770	99.00	v1|206154096177|0	\N
18406	Intel Core i5 13th Gen.	4.60 GHz	16 GB	256 GB	SSD (Solid State Drive)	13.3 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad X13 Gen 4	bhav05	200	100.00	v1|236701967417|0	21EX002XUK
18407	Intel Core i7 10th Gen.	1.80 GHz	16 GB	256 GB	SSD (Solid State Drive)	14 in	3840 x 2160	Intel UHD Graphics	Windows 11 Pro	ThinkPad X1 Yoga 5th Gen	greengreenstore	2358	100.00	v1|406786591265|0	20UCS0YB0E
18408	Intel Core i5 3rd Gen.	\N	8 GB	320 GB	HDD (Hard Disk Drive)	12.5 in	1366 x 768	Integrated/On-Board Graphics	Windows 10 Pro	Lenovo ThinkPad X230	aajibr0	318	100.00	v1|147214488738|0	\N
18409	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	sustainabletech4good	6770	99.00	v1|206153955060|0	\N
18410	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	sustainabletech4good	6770	99.00	v1|206153955071|0	\N
18411	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	sustainabletech4good	6770	99.00	v1|206153955034|0	\N
18412	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	sustainabletech4good	6770	99.00	v1|206153954974|0	\N
18413	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	sustainabletech4good	6770	99.00	v1|206153954978|0	\N
18414	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	sustainabletech4good	6770	99.00	v1|206153954980|0	\N
18415	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	sustainabletech4good	6770	99.00	v1|206153954960|0	\N
18416	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	sustainabletech4good	6770	99.00	v1|206153954962|0	\N
18417	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	sustainabletech4good	6770	99.00	v1|206153954911|0	\N
18418	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	sustainabletech4good	6770	99.00	v1|206153954928|0	\N
18419	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	sustainabletech4good	6770	99.00	v1|206153954889|0	\N
18420	Intel Core i5 11th Gen.	2.40 GHz	8 GB	256 GB	SSD (Solid State Drive)	13.4 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad L13 Yoga	punjraat	682	100.00	v1|137151294630|0	\N
18421	Intel Core i5 3rd Gen.	2.60 GHz	12 GB	128 GB	mSATA SSD + HDD	14.1 in	1366 x 768	Intel HD 4000	Windows 10 Professional 64 Bit	Lenovo ThinkPad T430	bunkilla	5479	100.00	v1|157771975322|0	2349-PZG
18422	Intel Core i5 5th Gen.	2.30 GHz	8 GB	240GB	SSD (Solid State Drive)	14 in	1366 x 768	Intel HD Graphics 5000	Windows 11 Pro	ThinkPad T450	rtsixtyfour	1663	99.70	v1|406786420948|0	\N
18423	Intel Core Ultra 5	\N	8 GB	256 GB	SSD	14 in	1920 x 1200	Intel Graphics	Windows 11 Pro Education	Everyday Laptops	quzo_uk	27028	99.60	v1|147214429623|0	21L2S88900
18424	Intel Core i5-4300U	1.90 GHz	4 GB	128 GB	SSD (Solid State Drive)	14.1 in	1600 x 900	Intel HD Graphics 4400	Windows 11 Pro	Lenovo ThinkPad T440	robk-21	2318	100.00	v1|267614816619|0	20B7A1P700
18425	Intel Pentium(R) Silver N5000 CPU @1.10GHz	\N	4 GB	128 GB	SSD (Solid State Drive)	11.6 in	1366 x 768	Integrated/On-Board Graphics	Windows 11	Lenovo Thinkpad Yoga 11e	metrobolist	1065	100.00	v1|147214406217|0	YOGA 11E
18426	Intel Core i7 11th Gen.	2.80 GHz	16 GB	256 GB	NVMe (Non-Volatile Memory Express)	14 in	\N	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad Carbon X1 Gen 9	revitalized_it_spares	10781	100.00	v1|168249416681|0	\N
18427	Intel Core i7 11th Gen.	3.00 GHz	16 GB	512 GB	SSD (Solid State Drive)	14 in	\N	\N	Windows 11 Pro	P14s	tecuk	34274	100.00	v1|277820081064|0	\N
18428	Intel Core i5-6200U	2.30 GHz	8 GB	\N	\N	15.6 in	\N	Intel HD Graphics 520	Not Included	Lenovo ThinkPad E560	epcbay	5693	100.00	v1|298144009507|0	\N
18429	i5-4210M	\N	4 GB	180GB	SSD (Solid State Drive)	14 in	\N	Intel HD Graphics 4000	Not Included	Lenovo Thinkpad L440	epcbay	5693	100.00	v1|298143999097|0	\N
18430	Intel Core i5-6300U	2.40 GHz	8 GB	500 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel HD Graphics	Not Included	Lenovo ThinkPad T460	epcbay	5693	100.00	v1|298143976733|0	\N
18431	Intel Core i7 10th Gen.	1.80 GHz	16 GB	512 GB	NVMe (Non-Volatile Memory Express)	14 in	1920 x 1080	Integrated Intel UHD Graphics	Windows 11 Pro	Lenovo ThinkPad T14s	bannaltd	3629	100.00	v1|206153772302|0	\N
18432	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	cbmcheshire	13635	100.00	v1|366291159598|0	\N
18433	AMD Ryzen 7	\N	8 GB	256 GB	\N	15.6 in	\N	\N	Windows 10	Lenovo ThinkPad E585	skyhigh2	977	99.90	v1|318034027603|0	\N
18434	AMD PRO A12-8830B R7	\N	\N	\N	\N	12.5 in	\N	\N	\N	\N	europesales	4937	99.50	v1|236701647219|0	\N
18435	AMD Ryzen 7	2.30 GHz	16 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	Lenovo T495-Ryzen 7 Pro	nisgi_28	11	100.00	v1|406786133490|0	LENOVO THINKPAD T495
18436	Intel Core i5 11th Gen.	1.70 GHz	32 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1200	\N	Windows 11 Home	Lenovo ThinkPad X1 Yoga Gen 7	an_219387	0	0.00	v1|358355026597|0	\N
18437	Intel Core i7 8th Gen.	1.90 GHz	16 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	Lenovo ThinkPad X1	thinkpadmike_com	1381	100.00	v1|117097993571|0	20KGSAH900
18438	Ultra 7 155H	\N	32 GB	1 TB	SSD (Solid State Drive)	16 in	\N	\N	\N	Lenovo p16s gen 3	graysccelectrical	1118	98.70	v1|257416347214|0	\N
18439	AMD Ryzen™ 5 PRO 215	3.20 GHz	16 GB	512 GB	SSD (Solid State Drive)	16 in	1920 x 1200	Radeon 740M	Windows 11 Pro	Lenovo ThinkPad L16 Gen 2	greengreenstore	2358	100.00	v1|406785864955|0	21SC0006UK
18440	AMD Ryzen AI 7 PRO 350	\N	\N	\N	\N	14 in	\N	\N	\N	\N	sebeam	2189	100.00	v1|206153386401|0	21TB002CUK
18441	Intel Core Ultra 9 275HX	\N	\N	\N	\N	16 in	\N	\N	\N	\N	sebeam	2189	100.00	v1|198208802616|0	21RQ000FUK
18442	AMD Ryzen AI 7 PRO 350	\N	\N	\N	\N	16 in	\N	\N	\N	\N	sebeam	2189	100.00	v1|198208801917|0	21QR0058UK
18443	AMD Ryzen AI 7 PRO 350	\N	\N	\N	\N	16 in	\N	\N	\N	\N	sebeam	2189	100.00	v1|198208801283|0	21QR0057UK
18444	AMD Ryzen AI 7 PRO 350	\N	\N	\N	\N	14 in	\N	\N	\N	\N	sebeam	2189	100.00	v1|206153383030|0	21QL006PUK
18445	AMD Ryzen AI 7 PRO 350	\N	\N	\N	\N	14 in	\N	\N	\N	\N	sebeam	2189	100.00	v1|206153381316|0	21QL006NUK
18446	Intel Core i5 11th Gen.	2.40 GHz	8 GB	256 GB	SSD (Solid State Drive)	13.3 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad X13 Yoga Gen 2	newandusedlaptops4u	93394	99.60	v1|377049244671|0	\N
18447	Intel Core i5 5th Gen.	2.30 GHz	8 GB	256 GB	SSD (Solid State Drive)	14.1 in	1366 x 768	Intel HD Graphics 520	Windows 11 Home	Lenovo Thinkpad L450	noo2yoo_uk	44378	99.70	v1|127759229682|0	\N
18448	AMD Ryzen™ 5 PRO 215	\N	\N	\N	\N	14 in	\N	\N	\N	\N	sebeam	2189	100.00	v1|206153360860|0	21S8003SUK
18449	Intel Core i5 8th Gen.	1.60 GHz	16 GB	512 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11	X1 Yoga Gen 4	bluecybercow	17010	99.90	v1|257416267307|0	\N
18450	Intel Core i7 11th Gen.	3.00 GHz	32 GB	512 GB	SSD (Solid State Drive)	14 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	ThinkPad X1 Yoga 6th Gen	greengreenstore	2358	100.00	v1|406785778773|0	20Y0S1KC1S
18451	Intel Core i7 13th Gen.	2.40 GHz	16 GB	512 GB	SSD (Solid State Drive)	16 in	2560 x 1600	NVIDIA RTX A1000	Windows 11 Pro	Lenovo ThinkPad P1 Gen 6	greengreenstore	2358	100.00	v1|406785777798|0	21FV0011UK
18452	Intel Core i7 8th Gen.	2.20 GHz	16 GB	512 GB	SSD (Solid State Drive)	15.6 in	1920 x 1080	NVIDIA Quadro P1000	Windows 11 Pro	Lenovo ThinkPad P52	greengreenstore	2358	100.00	v1|406785756464|0	20MAS16U00
18453	Intel Core i5 11th Gen.	2.60 GHz	16 GB	512 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad T14 Gen 2	greengreenstore	2358	100.00	v1|406785753117|0	20W1S2TW2E
18454	Intel Core i7 11th Gen.	3.00 GHz	32 GB	512 GB	SSD (Solid State Drive)	14 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	ThinkPad X1 Yoga 6th Gen	greengreenstore	2358	100.00	v1|406785745553|0	20Y0S1KC1K
18455	Intel Core i7 8th Gen.	1.90 GHz	16 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11	X1 YOGA Gen 4	bluecybercow	17010	99.90	v1|257416231422|0	\N
18456	Intel Core i7-6600U	3.60 GHz	20 GB	256 GB	SSD (Solid State Drive)	14.1 in	1920 x 1080	Intel HD Graphics	Windows 11 Pro	Lenovo ThinkPad T470S	noo2yoo_uk	44378	99.70	v1|366290737625|0	T470S
18457	Intel Core i7 6th Gen.	2.6 GHz	8 GB	256 GB	SSD (Solid State Drive)	15.6 in	1920 x 1080	Intel HD Graphics 520	Windows 11 Pro	Lenovo ThinkPad T570	noo2yoo_uk	44378	99.70	v1|127759135968|0	\N
18458	Intel Core i5 8th Gen.	1.70 GHz	\N	256 GB	NVMe (Non-Volatile Memory Express)	14 in	1920 x 1080	\N	Windows 11 Pro	Lenovo ThinkPad T480	icex_computers	14045	99.80	v1|389773907226|0	\N
18459	Intel Core i5-8265U	1.60 GHz	8 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel UHD Graphics	Windows 11 Pro	Thinkpad T490	laptopsparesshop	24971	99.60	v1|287219145939|0	T490
18460	Intel Core i5 11th Gen.	2.60 GHz	16 GB	512 GB	NVMe (Non-Volatile Memory Express)	13.3 in	2560 x 1600	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad X13 Yoga	absolute-resale	3871	100.00	v1|298143087735|0	\N
18461	AMD Ryzen 5 PRO 4000 Series	2.10 GHz	24 GB	256 GB	NVMe (Non-Volatile Memory Express)	14.1 in	1920 x 1080	AMD Radeon Graphics	Windows 11 Pro	Lenovo ThinkPad T14	laptopsparesshop	24971	99.60	v1|298143008304|0	T14 G1
18462	Intel Core i5 10th Gen.	1.70 GHz	16 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel UHD Graphics	Windows 11 Pro	Lenovo ThinkPad T14	re-com-uk	1170	99.70	v1|336491476565|0	\N
18463	Intel Core i5-10210U	\N	16 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel UHD Graphics	Windows 11 Pro	Lenovo ThinkPad T14	noo2yoo_uk	44378	99.70	v1|127759046758|0	\N
18464	AMD RYZEN 5 3500C WITH RADEON VEGA MOBILE GFX	\N	8 GB	128 GB	\N	Standard	\N	\N	\N	THINKPAD C13 YOGA GEN1 CHROMEBOOK	wisetek	1611	100.00	v1|287219062822|0	\N
18465	Intel Core i7 6th Gen.	2.6 GHz	16 GB	256 GB	SSD (Solid State Drive)	15.6 in	1920 x 1080	Intel HD Graphics 520	Windows 11 Pro	Lenovo ThinkPad T570	noo2yoo_uk	44378	99.70	v1|366290582553|0	\N
18466	Intel Ultra 7	5.00 GHz	32 GB	1 TB	SSD (Solid State Drive)	16 in	3840 x 2400	NVIDIA RTX 2000 Ada Generation	Windows 11 Pro	ZBook Studio G11	the-tech-saver	12045	100.00	v1|336491424058|0	B17GTUC
18467	Intel Core i5 4th Gen.	1.90 GHz	8 GB	256 GB	SSD (Solid State Drive)	12 in	1366 x 768	Intel HD Graphics 5500	Windows 10 Pro	Lenovo ThinkPad X250	buy-smart-guy	200	100.00	v1|287218956322|0	\N
18468	Intel Core I5-7200U	\N	8 GB	256 GB	Not included	13.3 in	1920 x 1080	\N	Windows 11 Home	Lenovo 13 2nd Gen	aaw_1989	1	100.00	v1|318032669933|0	\N
18469	Intel Core i7 9th Gen.	2.60 GHz	32 GB	512 GB	SSD (Solid State Drive)	15.6 in	1920 x 1080	NVIDIA Quadro T1000	Windows 11	ThinkPad P15 Gen 1	commquest-technologies-ltd	134	100.00	v1|406785185232|0	20ST001BUK
18470	Intel Core i7 2nd Gen.	1.40 GHz	32 GB	1 TB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad T14s	continuuminf-0	3	100.00	v1|406785114003|0	\N
18471	Intel Core Ultra 7 165U vPro Processor	4.90 GHz	512 GB	512 GB	SSD (Solid State Drive)	13.3 in	1920 x 1200	Intel Graphics	Windows 11 Pro	Lenovo Thinkpad X13	bass-technology	1088	100.00	v1|137149430610|0	21LVS7D900
18472	Intel Core i5-10210U	1.60GHz	8 GB	256GB	\N	13.3 inches	1920 x 1080	\N	Windows 11	Lenovo ThinkPad L13 Yoga	ebixx.120	15947	99.50	v1|147213500013|0	\N
18473	Intel Core i5 8. gene	1.70GHz	\N	256GB	\N	14.5 inches (36.8cm)	1920 x 1080	\N	Windows 11 Pros	Lenovo ThinkPad T480	ebixx.120	15947	99.50	v1|147213499988|0	\N
18474	Intel Pentium III	1.00 GHz	256 MB	\N	HDD (Hard Disk Drive)	14.1 in	1024 x 768	Integrated/On-Board Graphics	\N	IBM T23	le_577378	24	100.00	v1|137149204819|0	\N
18475	Intel Core i5-1135G7	\N	8 GB	256 GB	SSD (Solid State Drive)	13.3 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad X13 Yoga	jase2gud2b	69	100.00	v1|287218283512|0	X13 YOGA
18476	Intel Core i5-8250U	1.60 GHz	256 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	Lenovo ThinkPad X1	cl_8399044	2	100.00	v1|147213213248|0	\N
18477	AMD Ryzen 5	\N	8 GB	128 GB	SSD (Solid State Drive)	13.3 in	\N	AMD Radeon Graphics	Chrome OS	Lenovo Thinkpad C13 Yoga	omnia_trading	6	100.00	v1|336490811197|0	\N
18478	11th Gen Intel Core i5-1135G7 @2.40GHz	2.40 GHz	16 GB	2 TB	NVMe (Non-Volatile Memory Express)	14 in	3840 x 2400	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad X1	wilnich11	18	100.00	v1|198207070720|0	\N
18479	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	sustainabletech4good	6770	99.00	v1|206151787390|0	\N
18480	Intel Core i5 10th Gen.	\N	8 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel UHD Graphics	Windows 11 Pro	Lenovo ThinkPad L13 Yoga	keetz111	114	100.00	v1|327057584332|0	REFURBISHED LAPTOPS
18481	Intel Core i7 13th Gen 1365U vPro	1.80 GHz	32 GB	512 GB	SSD (Solid State Drive)	13.3 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad X13 Gen 4	tech2usales	903	100.00	v1|377047480515|0	21EYS5MU00
18482	Intel Core i5 12th Gen.	1.70 GHz	16 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad X1 Yoga	tech2usales	903	100.00	v1|377047622748|0	21CD0032UK
18483	Intel i5-1345GU	1.60 GHz	32 GB	512 GB	SSD (Solid State Drive)	14 in	1920 x 1200	Intel® Iris® Xe Graphics	Windows 11 Pro	Lenovo ThinkPad X1 Yoga	tech2usales	903	100.00	v1|377047598309|0	21HRS2GT00
18484	Intel Core i5-1135G7	1.60GHz	8 GB	256GB	\N	13,3 Zoll	1920 x 1080	\N	Windows 11	Lenovo ThinkPad L13	it-mixx	44083	99.90	v1|206151750627|0	\N
18485	Intel Core i7 13th Gen.	1.80 GHz	32 GB	512 GB	SSD (Solid State Drive)	14 in	1920 x 1200	Intel® Iris® Xe Graphics	Windows 11 Pro	Lenovo ThinkPad X1 Yoga (8th Gen)	tech2usales	903	100.00	v1|377047549610|0	\N
18486	Intel Core i5 12th Gen.	1.70 GHz	16 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad X1 Yoga	tech2usales	903	100.00	v1|377047602278|0	21CD0032UK
18487	Core I5	\N	4 GB	500 GB	HDD (Hard Disk Drive)	15.6 in	\N	Integrated/On-Board Graphics	Windows 11 Pro	\N	rob-400525	375	100.00	v1|377047647851|0	\N
18488	Intel Core i5-6300U	\N	\N	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel HD Graphics	\N	Lenovo ThinkPad T460S	leszeszur0	1019	100.00	v1|298141011461|0	ThinkPad T460s
18489	Intel Core i5 8th Gen.	\N	\N	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Integrated/On-Board Graphics	Windows 11 Pro	\N	leszeszur0	1019	100.00	v1|298140992462|0	\N
18490	Intel Core i5 4300U	1.90 GHz	4 GB	120 GB	SSD (Solid State Drive)	12.5 in	1366 x 768	Intel HD 4400	Windows 10 Pro	Lenovo ThinkPad X240	bunkilla	5479	100.00	v1|157769780739|0	20AMA1BK00
18491	Intel Core i5 8th Gen.	1.60 GHz	8 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	Lenovo ThinkPad T490s	arront0	212	100.00	v1|227264182636|0	20NX002SUK
18492	Intel Core i5 4th Gen.	\N	8 GB	0	SSD (Solid State Drive)	14 in	1920 x 1080	Intel HD Graphics	\N	Lenovo ThinkPad T440P	yahsha1304	57	100.00	v1|358351389726|0	\N
18493	AMD Ryzen 7 6000 Series	\N	32 GB	1 TB	\N	16 in	1920 x 1200	AMD Radeon 680M	Windows 11 Pro	Lenovo ThinkPad P16s Gen 1	geoff_lee367	5016	100.00	v1|267613858858|0	Thinkpad P16S Gen 1
18494	Intel Ultra 9 185H	\N	64 GB	1 TB	SSD (Solid State Drive)	16 in	1920 x 1200	Intel Arc Graphics	Windows 11 Home	Lenovo ThinkPad P16s G3	takeonlineltd	1560	100.00	v1|287217696930|0	21KS
18495	Intel Core i5 8th Gen.	1.60 GHz	16 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	LENOVO T490 8TH GEN	solaris_bloke	362	100.00	v1|327057412767|0	\N
18496	Intel Core i7-6600U	\N	8 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Integrated/On-Board Graphics	Windows 11 Pro	Lenovo ThinkPad X1	budj_93	1	100.00	v1|236700011428|0	\N
18497	Intel Core Ultra 7 255U	5.2 GHz	32 GB	512 GB	SSD (Solid State Drive)	14 in	1920 x 1200	Intel Arc Graphics	Windows 11 Pro	Lenovo ThinkPad T14s 2-in-1 Gen 1	takeonlineltd	1560	100.00	v1|287217673694|0	\N
18498	Intel Core i7 8th Gen.	1.90 GHz	16 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	Lenovo ThinkPad X1	thinkpadmike_com	1381	100.00	v1|117096571651|0	20KGSAH900
18499	Intel Core i7-6600U	3.60 GHz	20 GB	256 GB	SSD (Solid State Drive)	14.1 in	1920 x 1080	Intel HD Graphics	Windows 11 Pro	Lenovo ThinkPad T470S	noo2yoo_uk	44378	99.70	v1|127757671640|0	T470S
18500	intel core ultra 7	1.40 GHz	24 GB	512 GB	SSD (Solid State Drive)	14.5 in	1920 x 1080	Dedicated Graphics	Windows 11 Pro	lenovo thinkpad P14s Gen 5	continuuminf-0	3	100.00	v1|406785087313|0	\N
18501	Intel Core Ultra 7 265U	\N	64 GB	1 TB	\N	14 in	2.8K (2880x1800) OLED	Integrated/On-Board Graphics	Windows 11 Pro	Lenovo ThinkPad X1 Carbon Gen 13 Aura	ewix	3864	100.00	v1|287217614228|0	\N
18502	Intel Core Ultra 7 268V	\N	32 GB	2TB	\N	14 in	1920 x 1200	Integrated/On-Board Graphics	Windows 11 Pro	Lenovo ThinkPad X1 Carbon Gen 13 Aura	ewix	3864	100.00	v1|358351249069|0	\N
18503	Intel Core i5 8th Gen.	1.70 GHz	16 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	Lenovo ThinkPad T480s	solaris_bloke	362	100.00	v1|327057362387|0	\N
18504	Intel Core i7 10th Gen.	1.80 GHz	16 GB	512 GB	SSD (Solid State Drive)	15.6 in	1920 x 1080	Intel UHD Graphics	Windows 11 Pro	Lenovo ThinkPad E15	noo2yoo_uk	44378	99.70	v1|366289080574|0	\N
18505	Intel Core i7 10th Gen.	2.50 GHz	8 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel UHD Graphics for 10th Gen Intel Processors	Windows 11 Pro	Lenovo ThinkPad X1	it-specialist-uk	827	100.00	v1|177974379295|0	\N
18506	Intel Core Ultra 7 155U	\N	32 GB	512 GB	NVMe (Non-Volatile Memory Express)	13.3 in	1920 x 1200	\N	Windows 11 Pro	Lenovo ThinkPad X13 2-in-1 Gen 5	pc4online	4228	100.00	v1|198206532359|0	\N
18507	AMD Ryzen 7	2.30 GHz	8 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Integrated/On-Board Graphics	Windows 11 Pro	Lenovo Thinkpad T495	techlabzltd	13143	99.90	v1|117096466493|0	\N
18508	AMD Ryzen 7 Pro 3000 Series	2.30 GHz	16 GB	256 GB	SSD (Solid State Drive)	13.3 in	1920 x 1080	Radeon Vega Mobile Gfx	Windows 11 Pro	Lenovo ThinkPad X395	techlabzltd	13143	99.90	v1|117096459850|0	\N
18509	Intel Core i5-10210U	1.60 GHz	8 GB	256 GB	NVMe (Non-Volatile Memory Express)	14 in	1920 x 1080	Intel UHD Graphics	Windows 11 Pro	Lenovo ThinkPad T14s	it-specialist-uk	827	100.00	v1|177974324616|0	\N
18510	AMD Ryzen 7 Pro 3000 Series	2.30 GHz	16 GB	256 GB	SSD (Solid State Drive)	13.3 in	1920 x 1080	Radeon Vega Mobile Gfx	Windows 11 Pro	Lenovo ThinkPad X395	techlabzltd	13143	99.90	v1|117096457112|0	\N
18511	AMD Ryzen 7 Pro 3000 Series	2.30 GHz	16 GB	256 GB	SSD (Solid State Drive)	13.3 in	1920 x 1080	Radeon Vega Mobile Gfx	Windows 11 Pro	Lenovo ThinkPad X395	techlabzltd	13143	99.90	v1|117096452287|0	\N
18512	Intel i5-1135G7	1.80 GHz	16gb	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel® Iris® Xe Graphics	Windows 11 Pro	Lenovo ThinkPad X1 Yoga	boskon88	159	100.00	v1|318029598979|0	\N
18513	Intel Core i5 8th Gen.	1.60 GHz	8GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	Lenovo ThinkPad X1 Yoga	lookeylookeylove	461	100.00	v1|157769539662|0	20QGS1C600
18514	Intel Core Ultra 7 165U	4.30 GHz	16 GB	512 GB	SSD (Solid State Drive)	14 in	1920 x 1200	Integrated Intel Graphics	Windows 11 Pro	Lenovo ThinkPad X1 Carbon Gen 12	bestproductsuk1	257	100.00	v1|358351014724|0	\N
18515	intel i7 10510U	1.80 GHz	16 GB	480GB	SSD (Solid State Drive)	14 in	1920 x 1080	intel iris Graphics	Windows 11 Pro	lenovo Thinkpad E14	pa-7477	246	98.70	v1|127757514713|0	\N
18516	Intel Core i5-10210U	\N	8 GB	256 GB	NVMe (Non-Volatile Memory Express)	15.6 in	1920 x 1080	Intel UHD Graphics	Win 11	Lenovo ThinkPad E15	la.recycling	948	99.90	v1|377047313393|0	\N
18517	Intel Core i5 11th Gen.	2.20 GHz	16 GB	256 GB	SSD (Solid State Drive)	15.6 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad E15 Gen 2	discountedlaptops	4991	99.20	v1|389770479162|0	\N
18518	Not Available	\N	\N	\N	\N	Not Available	\N	\N	\N	\N	youritdelivered	141661	99.90	v1|406783306369|0	21SA001UUK
18519	215	\N	16 GB	512 GB	SSD M.2	16.0	1920 x 1200	AMD	Windows 11	Lenovo ThinkPad L16 Gen 2	itsupplyfusion	419	100.00	v1|188194036563|0	\N
18520	AMD Ryzen 3	\N	16 GB	256 GB	NVM Express (nichtflüchtige Speicher)	15,6 Zoll	\N	Intel Core i5 11th Gen.	Windows 11 Pro	Lenovo Thinkpad E595	djkay0221	790	100.00	v1|127762890379|0	\N
18521	Intel Core i7 8. Gen	\N	16 GB	500 GB	SSD (Solid State Drive)	14 Zoll	2160 x 1440	NVIDIA GeForce MX250	Windows 11 Pro	Lenovo ThinkPad T490	philo-de2015	232	100.00	v1|287223675010|0	T460p T470p T470 T470s T480 T480s T490 T490s T14 T14s
18522	Core i5	1,60 GHz	8 GB	256 GB	\N	14 Zoll	1920 x 1080	NA	Windows 11 Pro	Lenovo X1CARBON	ms_japan_7	529	99.30	v1|318041484537|0	NAX1 CARBON
18523	8840HS	3.3 GHz	32 GB	1.0 TB	SSD	14.0	1920 x 1200	AMD	Windows 11 Pro	Lenovo ThinkPad P14s Gen 5	itsupplyfusion	419	100.00	v1|188193551864|0	\N
18524	Intel Celeron	\N	16 GB	512 GB	SSD (Solid State Drive)	15,6 Zoll	1920 x 1080	Intel UHD Graphics	Windows 11 Pro	Lenovo V15 G2 IJL 82QY	ar459790	0	0.00	v1|358359762305|0	\N
18525	Intel Core i5 6. Gen	2,40 GHz	8 GB	128 GB	SSD (Solid State Drive)	14 Zoll	1920 x 1080	Intel HD Graphics	Windows 11 Pro	Lenovo ThinkPad T460	nikgn69	152	100.00	v1|147216742325|0	T460
18526	Intel Core I5-7200U	\N	\N	\N	\N	15,6 Zoll	\N	\N	Windows 10	Lenovo Thinkpad E570	technik.freunde	86	100.00	v1|236704486715|0	\N
18527	Intel Core i7-8665U	1,60 GHz	16 GB	256 GB	SSD (Solid State Drive)	13,3 Zoll (33,8 cm)	1920 x 1080	Integrierte Grafik	Windows 11 Pro	Lenovo ThinkPad X390	liberator!	176	100.00	v1|257418588476|0	\N
18528	Intel Core i5-1135G7	\N	32 GB	250 GB	SSD (Solid State Drive)	15,6 Zoll	1920 x 1080	Intel UHD Graphics	Windows 11 Pro	Lenovo ThinkPad E15 2nd Gen	mijo_jfwg	38	100.00	v1|287222809191|0	\N
18529	Intel i7-1355U	\N	16 GB	512 GB SSD	SSD (Solid State Drive)	14 Zoll	\N	\N	Windows 11	\N	elitech-electronic	51	100.00	v1|127762220284|0	\N
18530	7535U	2.9 GHz	16 GB	512 GB	SSD	16.0	1920 x 1200	AMD	Windows 11 Pro	Lenovo ThinkPad L16 Gen 1	itsupplyfusion	419	100.00	v1|188192578228|0	\N
18531	AMD Ryzen 5 Pro 7535U	2.9 GHz	16 GB	512 GB	SSD	16.0	1920 x 1200	AMD	Windows 11 Pro (FR)	Lenovo ThinkPad L16 Gen 1	itsupplyfusion	419	100.00	v1|188192578033|0	\N
18532	225U	\N	16 GB	512 GB	SSD	16.0	1920 x 1200	On-Board-Graphics	Windows 11 Pro	Lenovo ThinkPad T16 Gen 4	itsupplyfusion	419	100.00	v1|188192577852|0	\N
18533	125U	\N	16 GB	262 GB	SSD	14.0	1920 x 1200	On-Board-Graphics	Windows 11 Pro	Lenovo ThinkPad L14 Gen 5	itsupplyfusion	419	100.00	v1|188192577451|0	\N
18534	8840HS	3.3 GHz	32 GB	1.0 TB	SSD	14.0	1920 x 1200	AMD	Windows 11 Pro	Lenovo ThinkPad P14s Gen 5	itsupplyfusion	419	100.00	v1|188192577151|0	\N
18535	268V	\N	32 GB	2.0 TB	SSD	14.0	2880 x 1800	Intel(R) Arc(TM)	No OS	Lenovo ThinkPad X1 Carbon G13	itsupplyfusion	419	100.00	v1|188192574393|0	\N
18536	Intel Core Ultra 5 226V	\N	16 GB	512 GB	SSD M.2	14.0	1920 x 1200 WUXGA	Intel(R) Arc(TM)	Windows 11 Home	Lenovo ThinkPad X9-14 G1	itsupplyfusion	419	100.00	v1|188192561490|0	\N
18537	1135G7	\N	8 GB	262 GB	SSD	13.0	1920 x 1080	On-Board-Graphics	Windows 10 Home	Lenovo ThinkPad L13 Yoga Gen 2	itsupplyfusion	419	100.00	v1|188192559016|0	\N
18538	Intel Pentium 3 P3 Mobile	866 MHz	256 MB	80 GB	HDD (Hard Disk Drive)	14,1 Zoll	1024 x 768	S3 SuperSavage IXC 1014	Windows XP Pro 32bit deutsch	Lenovo ThinkPad T23	bitte-kaufe-mich	27345	99.60	v1|327061273640|0	\N
18539	Intel Core i5-1140G7	1,80 GHz	16 GB	512 GB	SSD (Solid State Drive)	12,3 Zoll	1920 x 1280	Intel Iris Xe Graphics	Windows 11 Pro	X12 Detachable Gen 1	sl-tiptop	9392	100.00	v1|137154770517|0	\N
18540	258V	\N	32 GB	\N	SSD	14.0	1920 x 1200	Intel	Windows 11 Home	Lenovo ThinkPad X1 Carbon G13	itsupplyfusion	419	100.00	v1|188192436778|0	\N
18541	Ryzen 5 7530U	\N	16 GB	512 GB	SSD M.2	13.0	1920 x 1200	On-Board-Graphics	Windows 11 Pro	Lenovo ThinkPad L13 Yoga Gen 4	itsupplyfusion	419	100.00	v1|188192434586|0	\N
18542	1335U	\N	8 GB	512 GB	SSD M.2	13.0	1920 x 1200	On-Board-Graphics	Windows 11 Pro	Lenovo ThinkPad L13 Yoga Gen 4	itsupplyfusion	419	100.00	v1|188192434454|0	\N
18543	13850HX	\N	32 GB	1.0 TB	\N	16.0	2560 x 1600	NVIDIA	Windows 11 Pro	Lenovo ThinkPad P16 Gen 2	itsupplyfusion	419	100.00	v1|188192434232|0	\N
18544	228V	\N	32 GB	1.0 TB	SSD	14.0	2880 x 1800	Intel(R) Arc(TM)	Windows 11 Home	Lenovo ThinkPad X9-14 G1	itsupplyfusion	419	100.00	v1|188192433854|0	\N
18545	i5-1335U	\N	16 GB	512 GB	SSD M.2	13.0	1920 x 1200 WUXGA	On-Board-Graphics	Windows 11 Home	Lenovo ThinkPad X13 G4	itsupplyfusion	419	100.00	v1|188192433239|0	\N
18546	i5-1245U	\N	16 GB	262 GB	\N	14.0	1920 x 1200 WUXGA	On-Board-Graphics	Windows 11 Pro	Lenovo ThinkPad T14 G3	itsupplyfusion	419	100.00	v1|188192433151|0	\N
18547	i9-12950HX	\N	16 GB	1.0 TB	SSD	16.0	3840 x 2400 WQUXGA	On-Board-Graphics	No OS	Lenovo ThinkPad P16 G1	itsupplyfusion	419	100.00	v1|188192432897|0	\N
18548	7730U	\N	32 GB	1.0 TB	\N	13.0	1920 x 1200	On-Board-Graphics	Windows 11	Lenovo ThinkPad L13 G4	itsupplyfusion	419	100.00	v1|188192432498|0	\N
18549	Intel Core i5-1140G7	1,80 GHz	16 GB	512 GB	SSD (Solid State Drive)	12,3 Zoll	1920 x 1280	Intel Iris Xe Graphics	Windows 11 Pro	X12 Detachable Gen 1	sl-tiptop	9392	100.00	v1|147216409855|0	\N
18550	Ryzen 5 7533HS	\N	16 GB	512 GB	SSD	14.0	1920x1200	On-Board-Graphics	Windows 11 Pro	Lenovo ThinkPad 14 Gen 7	itsupplyfusion	419	100.00	v1|188192230989|0	\N
18551	258V	\N	32 GB	1.0 TB	SSD	14.0	2880x1800	On-Board-Graphics	Windows 11	Lenovo ThinkPad X1 Yoga Gen 10 G10	itsupplyfusion	419	100.00	v1|188192230443|0	\N
18552	Ryzen 5	\N	\N	\N	\N	13 Zoll	\N	\N	\N	\N	remarkt_eu	912	95.60	v1|257418183884|0	lenovo_thinkpad_x13_r5_pro_4..
18553	Ryzen 3	\N	\N	\N	\N	13 Zoll	\N	\N	\N	\N	remarkt_eu	912	95.60	v1|257418183889|0	lenovo_thinkpad_x13_r3_pro_4..
18554	Core i5	\N	\N	\N	\N	13 Zoll	\N	\N	\N	\N	remarkt_eu	912	95.60	v1|257418183877|0	lenovo_thinkpad_l13_gen_2_i5..
18555	Ryzen 5	\N	\N	\N	\N	13 Zoll	\N	\N	\N	\N	remarkt_eu	912	95.60	v1|257418183883|0	lenovo_thinkpad_x13_r5_pro_4..
18556	i7-1165G7	2.8 – 4.7 GHz	16 GB	256 GB	SSD (Solid State Drive)	15,6 Zoll	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad E15 Gen 2	kev21.06	29	100.00	v1|397743839123|0	\N
18557	Pentium M 1,4Ghz	\N	\N	\N	HDD (Hard Disk Drive)	15 Zoll	\N	\N	Windows XP	Thinkpad R40	the-big-boiler	47	100.00	v1|406789214957|0	\N
18558	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|287222307277|0	21M3002BGE
18559	Intel® Core™ Ultra 5 125U Processor(Core™ Ultra 5 125U	Intel Core Ultra 5 135U	16 GB	512 GB	SSD (Solid State Drive)	16 Zoll	\N	Intel® Graphics	\N	Lenovo ThinkPad L16 Gen 1.	elko_8995	59	100.00	v1|389779373984|0	\N
18560	Intel Core i7 7. Gen	\N	16 GB	500	SSD (Solid State Drive)	15-15,9 Zoll	\N	\N	Windows 10 Pro	Lenovo ThinkPad T570	crisundada	437	100.00	v1|117100212389|0	\N
18561	Intel Core i7-8550U	1,80 GHz	16 GB	512 GB	NVM Express (nichtflüchtige Speicher)	15,6 Zoll	1920 x 1080	\N	Windows 11 Pro	Lenovo Thinkpad T580	nikgn69	152	100.00	v1|147216224178|0	\N
18562	Intel Core i7 7. Gen	2,80 GHz	16 GB	256 GB	SSD (Solid State Drive)	14 Zoll	2560 x 1440	NVIDIA GeForce 940MX	Windows 11 Pro	Lenovo T470p	cs-kom	9036	99.60	v1|227266895790|0	\N
18563	Intel Core i7-8550U	\N	\N	256 GB	SSD (Solid State Drive)	15,6 Zoll	1920 x 1080	\N	\N	\N	konsta_6989	19	100.00	v1|188191871905|0	\N
18564	Intel Core i3-10110U	2,10 GHz	8 GB	256 GB	SSD (Solid State Drive)	15,6 Zoll	1920 x 1080	Intel UHD Graphics	Windows 10 Pro	\N	jelda_22	25	100.00	v1|358358712767|0	\N
18565	Intel Core i5-8350U	1,70 GHz	\N	256 GB	SSD (Solid State Drive)	14 Zoll	1920 x 1080	Intel HD Graphics 620	Windows 11 Pro	Lenovo ThinkPad T480	i_co_ver-24_7	29	100.00	v1|206156262241|0	\N
18566	Intel Core 2 Extreme	\N	8 GB	240 GB	HDD + SSD	17 Zoll	1920 x 1200	\N	Windows 10	Lenovo Thinkpad W700ds	oguglt0	462	99.40	v1|318039081823|0	\N
18567	Intel Core i5-2520M	2,5 GHz	6 GB	256 GB	SSD (Solid State Drive)	14 Zoll	1366 x 768	Intel HD Graphics 3000	Windows 10 Pro	Lenovo ThinkPad T420	mchacker-7	1814	100.00	v1|188191657970|0	\N
18568	Intel Core i5-2520M	2,5 GHz	4 GB	500 GB	HDD (Hard Disk Drive)	14 Zoll	1366 x 768	Intel HD Graphics 3000	Linux	Lenovo ThinkPad T420	mchacker-7	1814	100.00	v1|188191612826|0	\N
18569	Intel Core i5 8. Gen	\N	8 GB	256 GB	SSD (Solid State Drive)	14 Zoll	1920 x 1080	Integrierte / On-Board-Grafik	Windows 11 Pro	Lenovo ThinkPad T490s	quweem	20	100.00	v1|397743271551|0	\N
18570	i5-1135G7	2,40 GHz	16 GB	256 GB	SSD (Solid State Drive)	15 Zoll	1920 x 1080	TigerLake-LP GT2 [Iris Xe Graphics]	Windows 11 Pro	Lenovo ThinkPad L15	smse_64	414	99.70	v1|389778901534|0	PF3D7E5M
18571	Intel Core i7-8550U	1,80 GHz	DDR 4	512 GB	SSD (Solid State Drive)	15,6 Zoll (39,6 cm)	1920 x 1080	NVIDIA Quadro P500	Windows 11 Pro	Lenovo ThinkPad P52s	think-concept	879	100.00	v1|117100012230|0	20LC-S1AJ00
18572	Intel i7-1355U	\N	16 GB	512 GB	SSD (Solid State Drive)	13,3 Zoll	\N	Integrated Intel UHD Graphics	Windows 11 Pro	Lenovo Thinkpad Plus G4	teu-4013	64	98.50	v1|298147099601|0	\N
18573	i5-7200U	\N	8 GB	256 GB	SSD (Solid State Drive)	12,5 Zoll	\N	Integrierte / On-Board-Grafik	WIN 11	Lenovo ThinkPad X280	the-big-boiler	47	100.00	v1|406788911872|0	\N
18574	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|298147081977|0	21V50001GE
18575	Intel Pentium M	1,50 GHz	\N	40 GB	HDD (Hard Disk Drive)	12,1 Zoll	1024 x 768	\N	Windows XP	IBM ThinkPad X41	simezg	385	0.00	v1|188191408438|0	\N
18576	Intel Core i7 6. Gen	\N	\N	512 GB	SSD (Solid State Drive)	14 Zoll	1920 x 1080	\N	Windows 11 Pro	Lenovo ThinkPad T470S	taycag_0	5	100.00	v1|227266711754|0	20HGS30X00
18577	Intel Ultra 7 155U	1,70 GHz	32 GB	512 GB	SSD (Solid State Drive)	14 Zoll	\N	\N	Windows 11 Pro	Lenovo ThinkPad X1	papagwyn	14	100.00	v1|397743071865|0	\N
18578	Intel Core i5	2,40 GHz	16 GB	1 TB	\N	15,6 Zoll	1920 x 1080	Intel HD Graphics	Windows 11 Pro	Lenovo ThinkPad L570	lhumax29l	1197	100.00	v1|298146981603|0	\N
18579	Intel Core i5-10310U	\N	\N	512 GB	\N	14-14,9 Zoll	\N	\N	Windows 11 Pro	Lenovo ThinkPad X1 Yoga	fritzsche_9n	274	100.00	v1|188191377547|0	\N
18580	Intel Core 2 Duo	1,86 GHz	4 GB	4 GB	SSD (Solid State Drive)	12,1 Zoll	1280 x 800	Integrierte / On-Board-Grafik	Ubuntu	Lenovo ThinkPad X200	avnier-0	94	98.60	v1|318038588436|0	X200S
18581	Intel Core i5 11. Gen	2,80 GHz	16 GB	512 GB	SSD (Solid State Drive)	13,3 Zoll	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad X13 Yoga	ersatzteil129	19	100.00	v1|358358153565|0	\N
18582	Intel Core i5 5. Gen	2,90 GHz	8 GB	256 GB	SSD (Solid State Drive)	14 Zoll	1600 x 900	Intel HD Graphics	Windows 10 Pro	Lenovo ThinkPad T450	naseohr	575	100.00	v1|227266626351|0	THINKPADT450
18583	Intel Core Ultra 7 255H	2,00 GHz	32 GB	1 TB	SSD (Solid State Drive)	16 Zoll	2560 x 1600	Intel Arc Graphics 140T	ohne Betriebssystem!	Lenovo ThinkPad E16 G3	mobileglobe24	25239	100.00	v1|147215943697|0	21SSS00E00
18584	AMD Ryzen 5	\N	16 GB	256 GB	SSD (Solid State Drive)	14 Zoll	1920 x 1080	AMD Radeon Graphics	Windows 11 Pro	Lenovo ThinkPad T14	jasonlebaerwal_0	70	100.00	v1|147215928153|0	ThinkPad T14 G1
18585	Intel Core i7 6. Gen	\N	16 GB	500 GB	SSD (Solid State Drive)	15-15,9 Zoll	1920 x 1080	Intel HD Graphics	Windows 11 Home	Lenovo ThinkPad T560	sch-prv	437	100.00	v1|227266609352|0	\N
18586	Intel Core i7 8. Gen	\N	\N	16 GB	\N	15 Zoll	\N	\N	Nicht enthalten	Lenovo ThinkPad P52	aber_2000	1263	94.70	v1|117099823896|0	\N
18587	Intel Core i5-8350U	1,70 GHz	\N	256 GB	SSD (Solid State Drive)	14 Zoll	1920 x 1080	Intel HD Graphics 620	Windows 11 Pro	Lenovo ThinkPad T480	i_co_ver-24_7	29	100.00	v1|206155853587|0	\N
18588	Intel Core i5 8. Gen	\N	16 GB	512 GB	NVM Express (nichtflüchtige Speicher)	14 Zoll	\N	\N	Windows 11 Pro	Lenovo ThinkPad X1	elektro-deals24	524	100.00	v1|389778342212|0	\N
18589	i7 8565U	1,80 GHz	16 GB	256 GB	SSD (Solid State Drive)	15,6 Zoll (39,6 cm)	1920 x 1080	Intel Corporation UHD Graphics 620	Windows 11 Pro	L590	rainbuch1216	680	100.00	v1|397742576783|0	\N
18590	Intel Core Ultra 7 258V	2,20 GHz	32 GB	256 GB	SSD (Solid State Drive)	14 Zoll	1920 x 1200	Intel Arc Graphics 140V	Windows 11 Pro	Lenovo ThinkPad T14s G6	techglobe24	9241	100.00	v1|306834645950|0	21QXCTO1WW
18591	Intel Core i7 11. Gen	2,00-2,49 GHz	16 GB	1 TB	SSD (Solid State Drive)	13,5 Zoll	2256 x 1504	\N	Windows 11 Pro	Lenovo Thinkpad X1 Titanium	rspective	80	100.00	v1|157773710058|0	\N
18592	Intel Core i5 10. Gen	1,60 GHz	16 GB	256 GB	SSD (Solid State Drive)	15,6 Zoll	1920 x 1080	Intel UHD Graphics	Windows 11 Pro	Lenovo ThinkPad E15	321verkauft_nun	452	100.00	v1|127761167786|0	20TD-0004GE
18593	Intel Core i5 11. Gen	3GHz	32gb	512 GB	NVM Express (nichtflüchtige Speicher)	14 Zoll	3840x2400	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad X1 Carbon 9. Generation	homepc_de	368	98.80	v1|147215646415|0	20XX001XGE
18594	i7-6500U	2,50 GHz	8 GB	256 GB	SSD (Solid State Drive)	14 Zoll	1920 x 1080	Intel UHD Graphics	Linux	Lenovo Yoga 460	feseib_44	7	100.00	v1|389777823033|0	\N
18595	i5	\N	16 GB	256 GB	SSD (Solid State Drive)	14 Zoll	\N	Integrierte / On-Board-Grafik	Windows 10	Lenovo ThinkPad X1	master_iphone2	81	96.50	v1|198211231145|0	\N
18596	Intel Core i5-1135G7	2,40 GHz	8 GB	480GB	SSD (Solid State Drive)	14 Zoll	1920 x 1080	Intel HD Graphics	Windows 11 Pro	Lenovo ThinkPad E14 2nd Gen	211mercedes	1432	100.00	v1|117099543574|0	\N
18597	8840U	\N	32 GB	512 GB	SSD M.2	14.0	2880 x 1800	AMD	Windows 11 Home	Lenovo ThinkPad T14 G5	itsupplyfusion	419	100.00	v1|188190496573|0	\N
18598	8840U	\N	32 GB	512 GB	SSD M.2	14.0	1920 x 1200	AMD	\N	Lenovo ThinkPad T14 G5	itsupplyfusion	419	100.00	v1|188190492416|0	\N
18599	7840HS	\N	16 GB	512 GB	HDD	16.0	1920 x 1200 WUXGA	nVIDIA	Windows 11	Lenovo ThinkPad P16v G1	itsupplyfusion	419	100.00	v1|188190480107|0	\N
18600	258V	\N	32 GB	512 GB	SSD	14.0	1920 x 1200	Intel(R) Arc(TM)	Windows 11 Home	Lenovo ThinkPad X1 Carbon G13	itsupplyfusion	419	100.00	v1|188190456846|0	\N
18601	8840HS	\N	32 GB	512 GB	HDD	14.0	1920 x 1200 WUXGA	AMD	No OS	Lenovo ThinkPad P14s G5	itsupplyfusion	419	100.00	v1|188190451369|0	\N
18602	13850HX	\N	64 GB	1.0 TB	SSD M.2	16.0	2560 x 1600	NVIDIA	Windows 11 Pro	Lenovo ThinkPad P16 Gen 2	itsupplyfusion	419	100.00	v1|188190404423|0	\N
18603	i7 13850HX	\N	64 GB	1.0 TB	SSD M.2	16.0	2560 x 1600	NVIDIA	Windows 11 Pro	Lenovo ThinkPad P16 Gen 2	itsupplyfusion	419	100.00	v1|188190402181|0	\N
18604	13850HX	\N	64 GB	1.0 TB	SSD M.2	16.0	2560 x 1600	NVIDIA	Windows 11 Pro	Lenovo ThinkPad P16 Gen 2	itsupplyfusion	419	100.00	v1|188190399807|0	\N
18605	13850HX	\N	64 GB	1.0 TB	SSD M.2	16.0	2560 x 1600	NVIDIA	Windows 11 Pro	Lenovo ThinkPad P16 Gen 2	itsupplyfusion	419	100.00	v1|188190398581|0	\N
18606	215	\N	16 GB	512 GB	SSD	16.0	1920x1200	On-Board-Graphics	Windows 11	Lenovo Thinkpad L16 G2	itsupplyfusion	419	100.00	v1|188190367229|0	\N
18607	1165G7	\N	8 GB	512 GB	SSD M.2	14.0	1920 x 1080	On-Board-Graphics	Windows 10 Pro	Lenovo ThinkPad T14s Gen 2 20WN	itsupplyfusion	419	100.00	v1|188190361750|0	\N
18608	8540U	\N	16 GB	512 GB	SSD M.2	14.0	1920 x 1200	AMD	Windows 11	Lenovo ThinkPad T14 Gen 5	itsupplyfusion	419	100.00	v1|188190356719|0	\N
18609	i7 13850HX	\N	64 GB	1.0 TB	SSD M.2	16.0	2560 x 1600	NVIDIA	Windows 11 Pro	Lenovo ThinkPad P16 Gen 2	itsupplyfusion	419	100.00	v1|188190354160|0	\N
18610	8540U	\N	16 GB	512 GB	SSD M.2	14.0	1920 x 1200	AMD	Windows 11	Lenovo ThinkPad T14 Gen 5	itsupplyfusion	419	100.00	v1|188190334169|0	\N
18611	8540U	\N	16 GB	512 GB	SSD M.2	14.0	1920 x 1200	AMD	Windows 11	Lenovo ThinkPad T14 Gen 5	itsupplyfusion	419	100.00	v1|188190327497|0	\N
18612	228V	\N	32 GB	512 GB	HDD	14.0	1920 x 1200 WUXGA	Intel(R) Arc(TM)	Windows 11 Home	Lenovo ThinkPad X9-14 G1	itsupplyfusion	419	100.00	v1|188190318695|0	\N
18613	8540U	\N	16 GB	512 GB	SSD M.2	14.0	1920 x 1200	AMD	Windows 11	Lenovo ThinkPad T14 Gen 5	itsupplyfusion	419	100.00	v1|188190317752|0	\N
18614	Intel Core Ultra 7 255U	\N	16 GB	512 GB	HDD	13.0	1920 x 1200 WUXGA	On-Board-Graphics	Windows 11 Pro	Lenovo ThinkPad L13 G6	itsupplyfusion	419	100.00	v1|188190309264|0	\N
18615	8540U	\N	16 GB	512 GB	SSD M.2	14.0	1920 x 1200	AMD	Windows 11	Lenovo ThinkPad T14 Gen 5	itsupplyfusion	419	100.00	v1|188190286170|0	\N
18616	8540U	\N	16 GB	512 GB	SSD M.2	14.0	1920 x 1200	AMD	Windows 11	Lenovo ThinkPad T14 Gen 5	itsupplyfusion	419	100.00	v1|188190278883|0	\N
18617	8540U	\N	16 GB	512 GB	SSD M.2	14.0	1920 x 1200	AMD	Windows 11	Lenovo ThinkPad T14 Gen 5	itsupplyfusion	419	100.00	v1|188190277912|0	\N
18618	1160G7	\N	16 GB	262 GB	SSD M.2	12.0	1920 x 1280	On-Board-Graphics	Windows 11 Pro	Lenovo ThinkPad X12 Detachable	itsupplyfusion	419	100.00	v1|188190272390|0	\N
18619	1140G7	\N	16 GB	262 GB	SSD M.2	12.0	1920 x 1280	On-Board-Graphics	Windows 11 Home	Lenovo ThinkPad X12 Detachable	itsupplyfusion	419	100.00	v1|188190271981|0	\N
18620	258V	\N	32 GB	512 GB	SSD	14.0	1920 x 1200	Intel(R) Arc(TM)	Windows 11 Home	Lenovo ThinkPad X1 Carbon G13	itsupplyfusion	419	100.00	v1|188190269285|0	\N
18621	i7-8550U	\N	16 GB	512 GB	SSD M.2	13.0	3000 x 2000 QHD+	On-Board-Graphics	Windows 10 Pro	Lenovo ThinkPad X1 Tablet G3	itsupplyfusion	419	100.00	v1|188190262917|0	\N
18622	7540U	\N	16 GB	512 GB	SSD M.2	14.0	1920 x 1200 WUXGA	AMD	No OS	Lenovo ThinkPad T14s G4	itsupplyfusion	419	100.00	v1|188190259362|0	\N
18623	1140G7	\N	16 GB	262 GB	SSD M.2	12.0	1920 x 1280	On-Board-Graphics	Windows 11 Home	Lenovo ThinkPad X12 Detachable	itsupplyfusion	419	100.00	v1|188190240430|0	\N
18624	Core Ultra 7	\N	32.768 MB	\N	\N	40,6 cm	\N	NVIDIA RTX 1000	\N	\N	alternate.gmbh	577254	99.60	v1|267615332066|0	21KX004XGE
18625	Core Ultra 9	\N	98.304 MB	\N	\N	40,6 cm	\N	NVIDIA RTX PRO 5000	\N	\N	alternate.gmbh	577254	99.60	v1|287221180674|0	21RQ003WGE
18626	Core Ultra 9	\N	98.304 MB	\N	\N	40,6 cm	\N	NVIDIA RTX PRO 4000	\N	\N	alternate.gmbh	577254	99.60	v1|267615332041|0	21RQ000MGE
18627	Core Ultra 9	\N	98.304 MB	\N	\N	40,6 cm	\N	NVIDIA RTX PRO 3000	\N	\N	alternate.gmbh	577254	99.60	v1|267615332044|0	21RQ003QGE
18628	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|287221158534|0	21QE0035GE
18629	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|298145828113|0	21Q8003NGE
18630	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|358357024562|0	21QR005BGE
18631	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|358357023738|0	21G20063GE
18632	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|298145825755|0	21NS004NGE
18633	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|358357021902|0	21ST001TGE
18634	Ryzen 5 PRO 6650U	bis zu 4.5 GHz	16 GB	256 GB	SSD (Solid State Drive)	14 Zoll	1920 x 1200	AMD Radeon Graphics	Windows 11 Pro	Lenovo Thinkpad t14 G3	techhuus	6	87.50	v1|406787906626|0	21CF002TGE
18635	Core Ultra 135U	\N	16 GB	262 GB	SSD	13.0	1920 x 1200	On-Board-Graphics	Windows 11 Pro	Lenovo ThinkPad X13 2-in-1 Gen 5	itsupplyfusion	419	100.00	v1|188190151643|0	\N
18636	\N	2.20 GHz	32 GB	1024 GB	\N	14 Zoll	\N	\N	Windows 11 Professional	Lenovo ThinkPad X1 2-in-1 G10 21NU007MGE 14" WUXGA Core Ultr	computeruniverse	237656	99.40	v1|198210916138|0	21NU007MGE
18637	255U	\N	32 GB	512 GB	SSD	14.0	2880 x 1800	On-Board-Graphics	Windows 11 Pro	Lenovo ThinkPad X1 Carbon G13	itsupplyfusion	419	100.00	v1|188190121909|0	\N
18638	1160G7	\N	16 GB	262 GB	SSD M.2	12.0	1920 x 1280	On-Board-Graphics	Windows 11 Pro	Lenovo ThinkPad X12 Detachable	itsupplyfusion	419	100.00	v1|188190119064|0	\N
18639	1140G7	\N	16 GB	262 GB	SSD M.2	12.0	1920 x 1280	On-Board-Graphics	Windows 11 Home	Lenovo ThinkPad X12 Detachable	itsupplyfusion	419	100.00	v1|188190111440|0	\N
18640	8840U	\N	16 GB	512 GB	SSD M.2	14.0	1920 x 1200 WUXGA	AMD	Windows 11 Home	Lenovo ThinkPad T14 G5	itsupplyfusion	419	100.00	v1|188190109446|0	\N
18641	7540U	\N	16 GB	512 GB	SSD M.2	14.0	1920 x 1200 WUXGA	AMD	Windows 11 Home	Lenovo ThinkPad T14s G4	itsupplyfusion	419	100.00	v1|188190092690|0	\N
18642	AMD Ryzen 5 3500U	\N	16 GB	512 GB	SSD (Solid State Drive)	15,6 Zoll	\N	\N	Windows 10 Pro	Lenovo ThinkPad E595	ro_mi_sch	511	100.00	v1|277821459997|0	\N
18643	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|287221029434|0	22AY003WGE
18644	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|358356707528|0	21QC00ANGE
18645	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|358356659056|0	21QT006QGE
18646	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|358356652803|0	21QG009QGE
18647	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|298145591912|0	22AY001UGE
18648	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|298145591530|0	21S80031GE
18649	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|358356650332|0	21SC0028GE
18650	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|287220999330|0	21QE008DGE
18651	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|287220999055|0	21U20020GE
18652	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|298145590592|0	21S80013GE
18653	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|358356649633|0	21SA0016GE
18654	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|287220998394|0	21R50006GE
18655	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|298145590181|0	21QC0037GE
18656	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|298145590071|0	21NS00MLGE
18657	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|298145589715|0	21NX008PGE
18658	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|298145588035|0	21QX003CGE
18659	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|358356643137|0	21Q6001DGE
18660	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|287220989509|0	21QG009RGE
18661	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|358356635519|0	21QG009NGE
18662	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|298145571029|0	21SR007BGE
18663	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|287220985552|0	21QC0045GE
18664	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|298145566499|0	21Q8000GGE
18665	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|287220978123|0	21U2002QGE
18666	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|298145556499|0	21S6001EGE
18667	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|287220970983|0	21NS00MMGE
18668	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|358356612266|0	21QX00GVGE
18669	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|298145546942|0	21RQ000MGE
18670	AMD Ryzen 5 7000 Series	2,00 GHz	16 GB	512 GB	SSD (Solid State Drive)	14 Zoll	1920 x 1200	AMD Radeon Graphics	Windows 11 Pro	Lenovo ThinkPad E14 Gen 5	heinzsoft	19162	99.70	v1|287220961643|0	21JR0006GE, 21JR000CGE, 21JS0000GE
18671	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|358356300749|0	21R3005XGE
18672	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|358356300490|0	21R3005WGE
18673	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|298145302381|0	21RQ000GGE
18674	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|358356294592|0	21U20027GE
18675	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|298145299518|0	21QG003MGE
18676	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|287220808300|0	21SA004BGE
18677	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|287220808135|0	21SA004AGE
18678	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|287220807993|0	21QR003TGE
18679	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|287220807897|0	21QN005KGE
18680	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|358356291471|0	21NX007GGE
18681	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|287220806449|0	21QC0063GE
18682	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|287220796547|0	21QG003PGE
18683	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|358356282361|0	21SR0041GE
18684	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	heinzsoft	19162	99.70	v1|287220794811|0	21QA001PGE
18685	8350U, Core i5	\N	8 GB	256 GB	SSD (Solid State Drive)	13,3 Zoll	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	Lenovo ThinkPad X380 Yoga	peter_p43	32	100.00	v1|298145013972|0	\N
18686	Intel Core Ultra 5 225U	\N	32 GB	1 TB	SSD (Solid State Drive)	16 Zoll	2560 x 1600	\N	Windows 11 Pro	ThinkPad E16 Gen 3 (Intel)	ao-projekt-gmbh	162049	99.30	v1|227265815210|0	21SR007BGE
18687	AMD Ryzen 5 220	3,20 GHz	32 GB	512 GB	SSD (Solid State Drive)	16 Zoll	1920 x 1200	\N	Windows 11 Pro	ThinkPad E16 Gen 3 (AMD)	ao-projekt-gmbh	162049	99.30	v1|327059533051|0	21ST004DGE
18688	U5-135U	\N	16 GB	512 GB	SSD M.2	14.0	1920 x 1200	On-Board-Graphics	Windows 11 Pro	Lenovo ThinkPad T14 G5	itsupplyfusion	419	100.00	v1|188188833096|0	\N
18689	225U	\N	16 GB	512 GB	SSD M.2	16.0	1920 x 1200	On-Board-Graphics	Windows 11 Pro	Lenovo ThinkPad L16 Gen 2	itsupplyfusion	419	100.00	v1|188188831455|0	\N
18690	Intel Core Ultra 7 255H	\N	32 GB	2.0 TB	\N	14.0	1920 x 1200 WUXGA	On-Board-Graphics	Windows 11 Home	Lenovo ThinkPad P14s G6	itsupplyfusion	419	100.00	v1|188188830764|0	\N
18691	Intel Core Ultra 7 255H	\N	16 GB	512 GB	SSD M.2	14.0	3072 x 1920 (3K)	Intel(R) Arc(TM)	No OS	Lenovo ThinkPad P14s G6	itsupplyfusion	419	100.00	v1|188188818200|0	\N
18692	Ryzen 7 Pro 8840HS	\N	32 GB	1.0 TB	\N	14.0	1920 x 1200	AMD	Windows 11	Lenovo ThinkPad P14s Gen 5	itsupplyfusion	419	100.00	v1|188188815799|0	\N
18693	Ryzen 7 Pro 250	\N	32 GB	1.0 TB	\N	13.0	1920 x 1200 WUXGA	AMD	Windows 11	Lenovo ThinkPad L13 G6	itsupplyfusion	419	100.00	v1|188188811266|0	\N
18694	125U	\N	16 GB	262 GB	SSD NVMe M.2	14.0	1920 x 1200	On-Board-Graphics	Windows 11 Pro	Lenovo ThinkPad L14 Gen 5	itsupplyfusion	419	100.00	v1|188188806533|0	\N
18695	Intel Core i7 12. Gen	\N	16 GB	1 TB	SSD (Solid State Drive)	14 Zoll	1920 x 1200	Integrierte / On-Board-Grafik	Windows 11 Pro	Lenovo ThinkPad X1	kartoffelxd	31	100.00	v1|267615065261|0	\N
18696	Intel Core i5 13. Gen	1,30 GHz	16 GB	512 GB	SSD (Solid State Drive)	14 Zoll	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad T14	kartoffelxd	31	100.00	v1|267615042090|0	\N
18697	Intel Core i7-6600U	2,8 GHz	12 GB	128 GB	SSD (Solid State Drive)	15,6 Zoll	1920 x 1080	Intel® HD Graphics 520	Windows 11 Pro	Lenovo ThinkPad T560	niktes33	103	99.00	v1|366291789910|0	\N
18698	Intel Core i7 6600U	2,8 GHz	12 GB	12 GB	SSD (Solid State Drive)	15,6 Zoll	1920 x 1080	Intel® HD Graphics 520	Windows 11 Pro	Lenovo ThinkPad T560	niktes33	103	99.00	v1|366291781199|0	\N
18699	6300U, Core i5	2,40 GHz	\N	512 GB	\N	12,5 Zoll	\N	Intel HD Graphics	Linux	Lenovo ThinkPad X260	isman8996	10	100.00	v1|318035435319|0	\N
18700	Intel i7-10510u	1,80 GHz	32 GB	512 GB	SSD (Solid State Drive)	14 Zoll	1920 x 1080	Integrated Intel UHD Graphics	Windows 11 Pro	Lenovo ThinkPad T14	teuto-remarketing	2904	99.70	v1|177977297612|0	Lenovo ThinkPad T14, Lenovo ThinkPad T14 Gen 1, Lenovo ThinkPad T14 G1, ThinkPad T14 G1, ThinkPad T14 Gen 1
18701	AMD Ryzen 5 PRO	\N	\N	\N	\N	14 Zoll	1920x1080	\N	\N	20UE	pollinelectronic	137612	99.80	v1|147214688799|0	20UE
18702	Intel Core i5-8250U	\N	8 GB	240 GB	SSD (wurde solide)	14"	1920 x 1080	Intel	Windows 11 Pro	Lenovo ThinkPad L480	exnovocomputer	7408	99.70	v1|198209717842|0	\N
18703	AMD Ryzen 5	\N	256 GB	512 GB	\N	14 in	\N	\N	\N	\N	it-supplying	488	100.00	v1|277824378106|0	\N
18704	Intel Core i5 6th Gen.	\N	\N	256 GB	SSD (Solid State Drive)	12.5 in	\N	Intel HD Graphics	Windows 11 Pro	Lenovo ThinkPad X250	quigstar	7596	98.80	v1|127762849490|0	\N
18705	Intel Core i5 6th Gen.	\N	\N	256 GB	SSD (Solid State Drive)	12.5 in	\N	Intel HD Graphics	Windows 11 Pro	Lenovo ThinkPad X250	quigstar	7596	98.80	v1|117101022015|0	\N
18706	Intel Core i7 6th Gen.	\N	\N	256 GB	SSD (Solid State Drive)	12.5 in	\N	Intel HD Graphics	Windows 11 Pro	lenovo X260	quigstar	7596	98.80	v1|117101013847|0	\N
18707	Intel Core i7 6th Gen.	\N	\N	256 GB	SSD (Solid State Drive)	12.5 in	\N	Intel HD Graphics	Windows 11 Pro	lenovo X260	quigstar	7596	98.80	v1|117101011167|0	\N
18708	Intel Core i5 5th Gen.	2.60 GHz	8 GB	256 GB	SSD (Solid State Drive)	14 in	2560 x 1440	Intel HD Graphics	Windows 11 Pro	Lenovo ThinkPad X1 Carbon 3 Gen	quigstar	7596	98.80	v1|127762833258|0	\N
18709	Intel Core i5 6th Gen.	2.60 GHz	8 GB	256 GB	NVMe (Non-Volatile Memory Express)	14 in	\N	Intel HD Graphics	Windows 11 Pro	Lenovo Carbon X1 Gen 4	quigstar	7596	98.80	v1|127762832266|0	\N
18710	Intel Core i5 6th Gen.	2.60 GHz	8 GB	256 GB	NVMe (Non-Volatile Memory Express)	14 in	\N	Intel HD Graphics	Windows 11 Pro	Lenovo Carbon X1 Gen 4	quigstar	7596	98.80	v1|127762830074|0	\N
18711	Core i5	1.60 GHz	8 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	NA	Windows 11 Pro	Lenovo X1CARBON	ms_japan_7	529	99.30	v1|318041490172|0	NAX1 CARBON
18712	intel	\N	32 GB	1 TB	\N	14.5 in	\N	\N	\N	\N	rugame8383	516	100.00	v1|177980422996|0	\N
18713	See Title/Description	See Title/Description	See Title/Description	See Title/Description	See Title/Description	See Title/Description	See Title/Description	See Title/Description	See Title/Description	See Title/Description	calgarycomputerwholesale	59224	99.70	v1|277823171131|0	See Title/Description
18714	Intel Core i5 10th Gen.	1.60 GHz	8 GB	256 GB	SSD (Solid State Drive)	15.6 in	1920 x 1080	Integrated Intel UHD Graphics	Windows 10	ThinkPad L15	japan.treasure.collection	754	100.00	v1|397744094972|0	20U3
18715	Intel Core Ultra 7 (Series 2) - 255H up to 5.1 GHz / 24 MB Cache	\N	16 GB DDR5 (1 x 16 GB)	512 GB SSD - TCG Opal Encryption 2, NVMe	\N	Not Available	\N	Intel Arc Graphics 140T - up to 74 TOPS	Win 11 Pro - English	\N	inetsupply	981	100.00	v1|267615826953|0	21SX0038US
18716	Intel Core i7-9750H	2.60 GHz	16 GB	512 GB	SSD	15.6 in	1920 x 1080	\N	Not Included	ThinkPad X1 Extreme 2nd Gen	kira.1307	150	100.00	v1|206156571814|0	ThinkPad X1 Extreme 2nd
18717	i7-1165G7	2.80 GHz	32 GB	512 GB	NVMe (Non-Volatile Memory Express)	14 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo E14 Gen 2	metalgirl6667	126	100.00	v1|137154556819|0	\N
18718	i7-13800H	2.5GHz	64GB RAM	1TB	SSD	16"	3840 x 2400	GeForce RTX 4080	Windows 11 Pro	ThinkPad P1 Gen 6	paymore_university_city	2810	99.60	v1|188192112977|0	21FW-SBAJ00
18719	Intel Core i5 13th Gen.	\N	32 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo L14 Gen 4	chferg_6185	22	100.00	v1|336493440356|0	THINKPAD L14
18720	Intel Core i7 11th Gen	2.30GHz	32GB	1TB	Solid State Drive (SSD)	15.6in.	1920 x 1080	NVIDIA T1200	None	P15v Gen 2i	webuyyourjunk	4242	99.30	v1|298147617542|0	ThinkPad P15v Gen 2i -2f1ae18U
18721	Intel Core i5 8th Gen.	1.60GHz	16 GB	512 GB	SSD (Solid State Drive)	13 in.	1920 x 1080	Intel(R) UHD Graphics 620	Windows 11 Pro	ThinkPad L390 Yoga	minnovetechnogies	237	100.00	v1|406789281658|0	NA, THINKPAD L390
18722	Intel Core i5 11th Gen.	2.40 GHz	16 GB	512 GB	NVMe (Non-Volatile Memory Express)	13.3 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo X13 Gen 2i	winmacs	2048	100.00	v1|389779535465|0	\N
18723	Intel Core i5 6th Gen.	2.40 GHz	12 GB	128 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel HD Graphics	MX Linux	Lenovo ThinkPad T460	ezdrivesupply	1946	99.50	v1|306835202185|0	T460
18724	Intel Core i5-7300U	\N	8 GB	256 GB	SSD (Solid State Drive)	15.6 in	1920 x 1080	Integrated/On-Board Graphics	Windows 10 Pro	Lenovo ThinkPad T570	ybywis	758	100.00	v1|227266943970|0	T570
18725	Intel Core I5-1335U	1.60 GHz	16 GB	512 GB	SSD (Solid State Drive)	15.6 in	1920 x 1200	Intel UHD Graphics	Windows 11 Pro	Lenovo ThinkPad T16 Gen 2	solution7619	1427	100.00	v1|267615764690|0	\N
18726	Intel Core i5 10th Gen.	1.70 GHz	8 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	Lenovo ThinkPad T14 Gen 1	theman71177	3090	100.00	v1|206156410151|0	PF-2GJ1M5, 20S1S7VJ00
18727	Intel Core i7 13th Gen.	1.70 GHz	16 GB	1 TB	SSD (Solid State Drive)	16 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Home	16iru9	swellcells	16061	98.70	v1|188191937432|0	16IRU9
18728	AMD Ryzen 7 5000 Series	2.00 GHz	16 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	AMD Radeon Graphics	Windows 11 Pro	Lenovo ThinkPad E14 Gen 4	sl1111	1875	100.00	v1|157774363348|0	21EB0021US
18729	Intel Core i7-1185G7	\N	48GB	1 TB	NVMe (Non-Volatile Memory Express)	14 in	1920 x 1080	NVIDIA Quadro T500	Windows 11 Pro	ThinkPad P14s Gen 2	ebrainszhu	264	100.00	v1|127761898676|0	\N
18730	Core Ultra 5 235U	2.0GHz	16GB RAM	256GB	SSD	14"	1920 x 1200	Intel Graphics	Windows 11 Pro	ThinkPad T14 Gen 6	paymore_greenacres	2916	99.90	v1|257418101344|0	21QDS3601Q
18731	Intel Core i5 12th Gen.	1.70 GHz	16 GB	256 GB	NVMe (Non-Volatile Memory Express)	16 in	1920 x 1200	Intel UHD Graphics	Windows 11 Pro	Lenovo T16 Gen 1 16	paleomaxx	10074	99.60	v1|397743513548|0	\N
18732	i5-1135G7	2.40 GHz	8 GB	512 GB	NVMe (Non-Volatile Memory Express)	15.6 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad T15 Gen 2i	paleomaxx	10074	99.60	v1|206156289898|0	\N
18733	i5-1135G7	2.40 GHz	8 GB	512 GB	NVMe (Non-Volatile Memory Express)	15.6 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad T15 Gen 2i	paleomaxx	10074	99.60	v1|206156289391|0	\N
18734	i5-1135G7	2.40 GHz	8 GB	512 GB	NVMe (Non-Volatile Memory Express)	15.6 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad T15 Gen 2i	paleomaxx	10074	99.60	v1|206156288637|0	\N
18735	Not Available	\N	32 GB	512 GB	\N	14.0 Inch	\N	\N	\N	21Q0001YAU	jw_computers	14690	99.70	v1|227266871735|0	21Q0001YAU
18736	Not Available	\N	32 GB	512 GB	\N	14.0 Inch	\N	\N	\N	21NX0028AU	jw_computers	14690	99.70	v1|227266871663|0	21NX0028AU
18737	i5-1135G7	2.40 GHz	16 GB	512 GB	NVMe (Non-Volatile Memory Express)	15.6 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad T15 Gen 2i	paleomaxx	10074	99.60	v1|206156287991|0	\N
18738	i5-1145G7	2.60 GHz	16 GB	512 GB	NVMe (Non-Volatile Memory Express)	15.6 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad T15 Gen 2i	paleomaxx	10074	99.60	v1|397743497857|0	\N
18739	i5-1145G7	2.60 GHz	16 GB	512 GB	NVMe (Non-Volatile Memory Express)	15.6 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad T15 Gen 2i	paleomaxx	10074	99.60	v1|397743492006|0	\N
18740	i7-1165G7	2.80 GHz	16 GB	512 GB	NVMe (Non-Volatile Memory Express)	15.6 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad T15 Gen 2i	paleomaxx	10074	99.60	v1|206156283312|0	\N
18741	Intel Core i5 11th Gen.	2.40 GHz	16 GB	512 GB	NVMe (Non-Volatile Memory Express)	15.6 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad T15 Gen 2i	paleomaxx	10074	99.60	v1|397743487534|0	\N
18742	i5-1135G7	2.40 GHz	16 GB	512 GB	NVMe (Non-Volatile Memory Express)	15.6 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad T15 Gen 2i	paleomaxx	10074	99.60	v1|397743485376|0	\N
18743	Intel Core i7 11th Gen.	2.80 GHz	\N	256 GB	NVMe (Non-Volatile Memory Express)	14 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Home	Lenovo ThinkPad T14	highland-performance-systems	12816	100.00	v1|287222123929|0	T14 gen2
18744	Intel Core i7-1185G7	\N	16 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel Iris Xe Graphics	Not Included	Lenovo ThinkPad T14s	bargainbytes	4406	100.00	v1|168251689577|0	\N
18745	Intel Core i7 11th Gen.	3.00 GHz	32 GB	256 GB	NVMe (Non-Volatile Memory Express)	14 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Home	Lenovo ThinkPad T14	highland-performance-systems	12816	100.00	v1|287222108337|0	T14 gen2
18746	Intel Core i7 11th Gen.	3.00 GHz	32 GB	256 GB	NVMe (Non-Volatile Memory Express)	14 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Home	Lenovo ThinkPad T14s	highland-performance-systems	12816	100.00	v1|287222104464|0	\N
18747	Intel i7-2640M CPU	2.80 GHz	8 GB	500 GB	HDD (Hard Disk Drive)	12.5 in	1366 x 768	\N	Windows 10 Pro	Lenovo ThinkPad X220	lee9-7	13	100.00	v1|206156174902|0	\N
18748	Intel Core i7 1165G7	2.80 GHz	16 GB	512 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad T14s	usa.computer.store1	471	98.40	v1|206156171474|0	\N
18749	Intel Core i7 11th Gen.	3.00 GHz	32 GB	256 GB	nvme	14 in	\N	\N	Windows 11 Home	ThinkPad X1 Carbon Gen 9	highland-performance-systems	12816	100.00	v1|287222079940|0	\N
18750	Intel Core i7 11th Gen.	\N	16 GB	256 GB	NVMe (Non-Volatile Memory Express)	14 in	1920 x 1080	Intel Iris Xe Graphics	Not Included	Lenovo ThinkPad T14s Gen 2	bargainbytes	4406	100.00	v1|157774163731|0	\N
18751	Intel Core i7 11th Gen.	3.00 GHz	16 GB	256 GB	nvme	14 in	\N	\N	Windows 11 Home	ThinkPad X1 Carbon Gen 9	highland-performance-systems	12816	100.00	v1|287222041075|0	\N
18752	Intel Core i7 12th Gen.	2.20 GHz	32 GB	256 GB	NVMe (Non-Volatile Memory Express)	14 in	1920 x 1200	Integrated/On-Board Graphics	Windows 11 Home	Lenovo ThinkPad T14	highland-performance-systems	12816	100.00	v1|287222032857|0	T14 gen3
18753	Intel Core i9 11th Gen	2.60 GHz	64 GB	2 TB	SSD (Solid State Drive)	16 in	3840 x 2400	NVIDIA GeForce RTX 3080	Windows 11 Pro	Lenovo ThinkPad P1	milleniumman6	3086	98.90	v1|206156116798|0	20Y4S0SE00
18754	Intel Core i5 M520	2.40 GHz	6 GB	240GB	SSD (Solid State Drive)	15.6 in	1280 x 800	NVIDIA	Linux	Lenovo ThinkPad T410	twothreeturbo	333	100.00	v1|177979377616|0	2537FP5
18755	Intel Core i7 1165G7	2.80 GHz	16 GB	512 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad T14s	usa.computer.store1	471	98.40	v1|206156082478|0	\N
18756	Intel Core i7 8th Gen.	1.90 GHz	16 GB	1 TB	SSD (Solid State Drive)	13.3 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	x390 8665u	zic_07	15	100.00	v1|358358370741|0	X390
18757	Intel Core i7 8th Gen.	2.20 GHz	16 GB	512 GB	SSD (Solid State Drive)	15.6 in	1920 x 1080	NVIDIA GeForce GTX 1050 Ti	Windows 11 Pro	Lenovo ThinkPad X1 Extreme 1st Gen	computerbegone	9556	99.90	v1|198211902707|0	THINKPAD X1 EXTREME
18758	See Title/Description	See Title/Description	\N	See Title/Description	See Title/Description	See Title	See Title/Description	\N	Not Included	See Title/Description	calgarycomputerwholesale	59224	99.70	v1|267615639283|0	W2-2-B-Mar26210G64Y
18759	See Title/Description	See Title/Description	\N	See Title/Description	See Title/Description	See Title	See Title/Description	\N	Not Included	See Title/Description	calgarycomputerwholesale	59224	99.70	v1|267615637836|0	Y9-C-Mar26150M48D
18760	Intel Core i5 10th Gen.	1.60 GHz	8 GB	256 GB	SSD (Solid State Drive)	15.6 in	1920 x 1080	Integrated Intel UHD Graphics	Windows 10	ThinkPad L15	fansp2525	203	100.00	v1|287221729614|0	20U3
18761	Intel Core i5-7300U	2.60 GHz	16 GB	256 GB	SSD (Solid State Drive)	15.6 in	1920 x 1080	Intel HD Graphics 620	Windows 10 Pro	Lenovo ThinkPad T570	qltyproducts	183	100.00	v1|287221914206|0	T570
18762	Intel Core i5 2nd Gen.	2.50 GHz	4 GB	120 GB	SSD (Solid State Drive)	14 in	1600 x 900	Intel HD Graphics 3000	Windows 7 Professional	Lenovo ThinkPad T430	weight185	3215	100.00	v1|236703574782|0	\N
18763	Intel Core i5 10th Gen.	\N	\N	256 GB	\N	14 in	\N	\N	\N	\N	thda_4438	26	100.00	v1|389778637303|0	\N
18764	i7-11850H	2.50 GHz	32 GB	2 TB	SSD (Solid State Drive)	16 in	3840 x 2400	NVIDIA RTX A4000	Windows 11 Pro	Lenovo ThinkPad P1 Gen 4	syncpcparts	209	100.00	v1|227266622660|0	20Y30067US, 20Y3
18765	Intel Core i5-10210U	1.60 GHz	8 GB	256 GB	SSD (Solid State Drive)	13.3 in	1920 x 1080	Intel UHD Graphics	Windows 11 Home	Lenovo ThinkPad L13 Yoga	marscot-mvdiqjq8	6172	99.40	v1|277822159521|0	B101
18766	Intel Core i5-10210U	1.60 GHz	8 GB	256 GB	SSD (Solid State Drive)	13.3 in	1920 x 1080	Intel UHD Graphics	Windows 11 Home	Lenovo ThinkPad L13 Yoga	marscot-mvdiqjq8	6172	99.40	v1|287221604734|0	B101
18767	Intel Core i5-10210U	1.60 GHz	8 GB	256 GB	SSD (Solid State Drive)	13.3 in	1920 x 1080	Intel UHD Graphics	Windows 11 Home	Lenovo ThinkPad L13 Yoga	marscot-mvdiqjq8	6172	99.40	v1|287221593760|0	B101
18768	Intel(R) Core(TM) i5-8365U CPU @ 1.60GHz	1.60 GHz	8 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel(R) UHD Graphics 620	Windows 11 Pro	Lenovo ThinkPad X1 Yoga	icanziiravor	49	100.00	v1|188190836100|0	\N
18769	Intel Core i5-6200U	2.40 GHz	\N	\N	\N	14 in	\N	Intel HD Graphics	Not Included	Lenovo ThinkPad T460	tech_jason5	650	98.90	v1|406788301266|0	\N
18770	Intel Core i5 8th Gen.	1.60 GHz	8 GB	256 GB	NVMe (Non-Volatile Memory Express)	13.3 in	1366 x 768	Intel UHD Graphics	Windows 11 Pro	Lenovo ThinkPad X390	clearcyclellc	49	100.00	v1|318037494358|0	X390
18771	Intel Core i5-6200U	2.30 GHz	12 GB	256 GB	SSD (Solid State Drive)	15.6 in	1366 x 768	Intel HD Graphics	Windows 10 Pro	Lenovo ThinkPad T560	clearcyclellc	49	100.00	v1|318037465746|0	THINKPAD T560
18772	Intel Core i5 8th Gen.	1.60 GHz	16 GB	256 GB	NVMe (Non-Volatile Memory Express)	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	Lenovo T490	clearcyclellc	49	100.00	v1|318037407176|0	T490
18773	Intel Core i7-1185G7	3.00 GHz	16 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	NVIDIA Quadro T500	Windows 11 Pro	Lenovo P14S Gen 2	faulenroc-4	1568	99.70	v1|257417562364|0	\N
18774	intel core i7 8th gen	1.90 GHz	16gb	1 TB	SSD (Solid State Drive)	15.6	1920 x 1080p	Intel UHD Graphics 620	Windows 11 Pro	Lenovo Thinkpad T580	simongyamfi	1037	98.10	v1|188190110490|0	20JXS0FH00
18775	8350U, Core i5	\N	256 GB	256 GB	SSD (Solid State Drive)	14 in	\N	Integrated/On-Board Graphics	Linux	Lenovo ThinkPad T480s	wyrdinc	113	100.00	v1|358356929500|0	\N
18776	Intel Core i5-10310U	1.70 GHz	16 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel UHD Graphics	Not Included	Lenovo ThinkPad T14s	wcy41gtc	213	100.00	v1|206155108228|0	\N
18777	Ryzen 5	2.30 GHz	16 GB	256 GB	NVMe (Non-Volatile Memory Express)	15.6 in	1920 x 1080	AMD Radeon Graphics	Windows 11 Pro	Leonovo Ryzen L15	clearcyclellc	49	100.00	v1|318036763076|0	s.F_9 20250726 zs.09
18778	\N	\N	\N	\N	\N	\N	\N	\N	\N	ThinkPad Extreme Gen3	k-stargoods	1148	95.80	v1|389777048063|0	\N
18779	AMD Ryzen 5 PRO 4650U	2.10 GHz	16 GB	256GB NVme SSD	NVMe (Non-Volatile Memory Express)	15.6 in	1920 x 1080	AMD Radeon Graphics	Windows 11 Pro	Lenovo ThinkPad L15 Gen 1	clearcyclellc	49	100.00	v1|318036715350|0	\N
18780	Intel i5-10310U	1.70 GHz	16 GB	256 GB	NVMe (Non-Volatile Memory Express)	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	ThinkPad X1 Carbon Gen 8	clearcyclellc	49	100.00	v1|318036650827|0	\N
18781	\N	2.10 GHz	16 GB	\N	SSD (Solid State Drive)	15.6	\N	Intel HD Graphics 620	Not Included	\N	alldayeverydayonbay	1046	100.00	v1|277821392011|0	THINKPAD E15
18782	Intel Core i5 13th Gen.	\N	16 GB	512 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Integrated/On-Board Graphics	Windows 11 Pro	Lenovo ThinkPad T14	bobby-hox	523	100.00	v1|198212954302|0	\N
18783	Intel Core i5 3rd Gen.	2.60 GHz	8 GB	256 GB	HDD (Hard Disk Drive)	14 in	\N	Type 2347-1E3	Windows 10	Lenovo ThinkPad T430	texacan1resell	2493	98.90	v1|257417343284|0	\N
18784	Intel Ultra 5	\N	8 GB	512 GB	SSD (Solid State Drive)	16 in	\N	\N	\N	Lenovo ThinkPad L16 Gen 2	ucarryz	8098	100.00	v1|227266091215|0	21SBS2C900
18785	Intel Core i5 8th Gen.	1.7 GHz	16 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	Lenovo Thinkpad X1 Carbon 6th Gen	clearcyclellc	49	100.00	v1|318036470332|0	\N
18786	Intel Core i7 13th Gen.	1.70 GHz	16 GB	512 GB	\N	14 in	1920 x 1080	\N	\N	lenovo e14 gen 5	wayward_technology	380	100.00	v1|236702623432|0	\N
18787	Intel Core i7 7th Gen	2.80 GHz	8 GB	256 GB	SSD (Solid State Drive)	17.3 in	1920 x 1080	NVIDIA Quadro M620	Windows 10 Pro	Lenovo P71	tungsten*ware	1013	100.00	v1|206154830237|0	ThinkPad P71
18788	I7-10510U	1.80 GHz	16 GB	256 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	Lenovo T490	clearcyclellc	49	100.00	v1|318036409694|0	\N
18789	i7 10750H	\N	512 GB	512 GB	\N	15.6 in	\N	\N	Windows 11 Pro	ThinkPad P15 Gen 1	gizmo_gecko	5	100.00	v1|366292279230|0	\N
18790	Intel Core i7 8th Gen.	1.90 GHz	16 GB	512 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel UHD Graphics 620	Windows 11 Pro	Lenovo ThinkPad T480s	matsa-laptops-parts	3684	99.70	v1|198210349824|0	LENOVO THINKPAD T480S
18791	\N	\N	\N	32 GB	\N	\N	\N	\N	\N	\N	jklph	382	100.00	v1|236702532575|0	\N
18792	Intel Core i9 12th Gen	2.50 GHz	64 GB	1 TB	SSD (Solid State Drive)	16 in	1920 x 1080	Dedicated Graphics	Windows 11 Home	Lenovo ThinkPad P1	raskobeinc	1487	99.60	v1|277821182343|0	THINKPAD P1
18793	Intel Pentium M	1.50-1.99GHz	1024 mb	100 GB	HDD (Hard Disk Drive)	14 in	\N	Integrated/On-Board Graphics	\N	IBM ThinkPad T42	tyme-4-books	897	100.00	v1|177977853729|0	IBM THINKPAD T42
18794	Intel Celeron	\N	\N	\N	\N	11 in	\N	\N	Chrome OS	Samsung ChromeBook	steryotype	276	99.60	v1|177977844915|0	\N
18795	Intel Core i5 8th Gen.	1.70GHz	16GB	256 GB	NVMe (Non-Volatile Memory Express)	14"	1920 x 1080	Intel UHD Graphics	Windows 11 Pro	Lenovo ThinkPad X1	chrisjaqu	628	100.00	v1|267615205503|0	\N
18796	Intel Core i5 6th Gen.	2.40 GHz	8 GB	128 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel HD Graphics	Windows 10 Pro	Lenovo ThinkPad T460S	wachman2003	655	100.00	v1|306834100035|0	20F90038US
18797	i5-1135G7 (11th Gen)	1.3GHz	16 GB	256GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	Thinkpad E14 G2	quicksilverwholesale	1330	99.30	v1|358356254498|0	20TA004GUS
18798	AMD Ryzen 7 7000 Series	\N	40	500 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo E14 Gen 5	quantumtek_usa	33	100.00	v1|397741005836|0	15F004WM
18799	i5-1235U (12th Gen)	1.3GHz	16 GB	512 GB	SSD (Solid State Drive)	14 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	Thinkpad E14 G4	quicksilverwholesale	1330	99.30	v1|358356151709|0	21E3008SUS
18800	Snapdragon X Elite X1E-78-100	3.40 GHz	32 GB	1 TB	SSD (Solid State Drive)	14 in	1920 x 1200	Integrated Qualcomm Adreno GPU	Windows 11 Pro	Lenovo ThinkPad T14s Gen 6	pumabreadstore	262	100.00	v1|306834033689|0	21N1X001US-R
18801	i7-9850H	2.6GHz	8 GB	512 GB	SSD (Solid State Drive)	15.6"	1920 x 1080	NVIDIA Quadro T2000	Windows 11 Home	ThinkPad	theanechoicchamber	202	100.00	v1|188189238690|0	P53
18802	Intel Xeon	2.80 GHz	32 GB	\N	SSD (Solid State Drive)	15.6 in	\N	\N	\N	Lenovo Thinkpad P50	gus6743	1290	98.50	v1|257417149899|0	LENOVO P50
18803	Intel Core i7-8650U	1.9 GHz	8 GB	256 GB	SSD (Solid State Drive)	13 in	3000 x 2000	Intel UHD Graphics 620	Windows 11 Pro	Lenovo ThinkPad X1	cemala18	2826	99.80	v1|127760404449|0	ThinkPad X1 Tablet Gen 3
18804	Intel Core i7 11th Gen.	1.30 GHz	16 GB	512 GB	SSD (Solid State Drive)	13 in	2160 x 1350	Intel Iris Xe Graphics	Windows 11 Home	Lenovo X1 Nano	bournejason10	1301	100.00	v1|147214919012|0	X1 Nano
18805	Intel Core i5 11th Gen.	2.40 GHz	16 GB	256 GB	NVMe (Non-Volatile Memory Express)	14 in	1920 x 1080	Intel Iris Xe Graphics	Windows 11 Pro	Lenovo ThinkPad E14 Gen 2	sonomaresale	14344	99.70	v1|188189060679|0	Lenovo ThinkPad E14 Gen 2
18806	Intel Core i5	2.60 GHz	8 GB	320 GB	HDD (Hard Disk Drive)	14 in	1600 x 900	Intel HD Graphics 4000	Windows 10	Lenovo ThinkPad T430S	ejaik71	1822	100.00	v1|336492313497|0	T430s
18807	Intel Core i9 10th Gen.	2.40 GHz	16 GB	512 GB	NVMe (Non-Volatile Memory Express)	17.3 in	1920 x 1080	NVIDIA Quadro T2000	Not Included	Lenovo ThinkPad P17 Gen 1	1pc-tom	4428	99.90	v1|198210037480|0	\N
18808	AMD Ryzen 7 PRO 250	Up to 5.10GHz	16 GB	512 GB	SSD (Solid State Drive)	16" WUXGA (1920x1200) IPS touchscreen	\N	AMD Radeon 780M	Windows 11 Pro	Lenovo ThinkPad L16 Gen 2	computerdealsdirect	962	100.00	v1|177977583846|0	21SC001AUS
18809	Intel Core i7 12th Gen.	2.10 GHz	8GB	Not included	NVMe (Non-Volatile Memory Express)	16 in	1920 x 1200	Integrated/On-Board Graphics	Not Included	Lenovo ThinkPad T16 Gen 1	vegas-electronics	1430	100.00	v1|127760331127|0	\N
18810	Intel Core i5-10310U	1.70 GHz	16 GB	256 GB	SSD (Solid State Drive)	15.6 in	3840 x 2160	Intel UHD Graphics	Windows 11 Pro	Lenovo ThinkPad T15 Gen 1	marley1372by9x	4057	100.00	v1|306833869153|0	\N
18811	Intel Core i7 13th Gen.	3.90 GHz	16 GB	512 GB	SSD (Solid State Drive)	14 in	1920 x 1200	Intel Iris Xe Graphics	Windows 11 Pro	ThinkPad T14 Gen 4	trepachka	21926	100.00	v1|137152039502|0	21HE-SC3T00
\.


--
-- Data for Name: temp_summaries; Type: TABLE DATA; Schema: public; Owner: thinkpaduser
--

COPY public.temp_summaries (id, category_id, ebay_item_id, title, price, currency, condition, listing_type, marketplace, item_url, creation_date, first_seen, last_seen, sold_at, last_updated, item_country) FROM stdin;
20720	177	v1|389781630846|0	Lenovo ThinkPad E16 G2 16 inch FHD+ Ryzen 7 7735HS 32GB DDR5 1TB SSD WiFi 6E Win	349.00	USD	New	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/389781630846?_skw=thinkpad&hash=item5ac0cbaf7e:g:nokAAeSwfcVpv5iz	2026-03-22 18:30:43+11	2026-03-22 18:52:18.588851+11	2026-03-22 18:52:18.588855+11	\N	2026-03-22 18:52:18.588857+11	US
20721	177	v1|227267632017|0	Lenovo ThinkPad T14s Gen 1 Ryzen 7 PRO 4750U 16GB 512GB SSD Touch 14" Win11 Pro	259.99	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/227267632017?_skw=thinkpad&hash=item34ea34db91:g:Gz8AAeSwJFBpv5Yk	2026-03-22 18:24:02+11	2026-03-22 18:52:18.591559+11	2026-03-22 18:52:18.591564+11	\N	2026-03-22 18:52:18.591565+11	US
20722	177	v1|389781610723|0	Lenovo ThinkPad E550 (LOT OF 6) 14" Intel Core i3-5005U 2GHz 4GB RAM Working*	359.00	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/389781610723?_skw=thinkpad&hash=item5ac0cb60e3:g:J3gAAeSwLW1pv5Zk	2026-03-22 18:23:10+11	2026-03-22 18:52:18.593073+11	2026-03-22 18:52:18.593078+11	\N	2026-03-22 18:52:18.593081+11	US
20723	177	v1|389781573235|0	Lenovo ThinkPad E550 (LOT OF 5) 14" Intel Core i3-5005U 2GHz 4GB RAM Working*	295.00	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/389781573235?_skw=thinkpad&hash=item5ac0cace73:g:GZEAAeSwGBxpv5UQ	2026-03-22 18:09:31+11	2026-03-22 18:52:18.594432+11	2026-03-22 18:52:18.594437+11	\N	2026-03-22 18:52:18.594439+11	US
20724	177	v1|127762905661|0	Lenovo - 21JN003YUS - Lenovo ThinkPad E16 Gen 1 21JN003YUS 16 Notebook - WUXGA	1005.03	USD	New	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/127762905661?_skw=thinkpad&hash=item1dbf433a3d:g:BzcAAeSwLW1pv5Js	2026-03-22 17:53:34+11	2026-03-22 18:52:18.595617+11	2026-03-22 18:52:18.595621+11	\N	2026-03-22 18:52:18.595622+11	US
20725	177	v1|198213963251|0	Lenovo ThinkPad P17 Gen 2 Intel Laptop, 17.3" FHD IPS LED , 11th Generation Inte	599.99	USD	New	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/198213963251?_skw=thinkpad&hash=item2e26790df3:g:v2QAAeSwNF1pv5Cj	2026-03-22 17:51:41+11	2026-03-22 18:52:18.596697+11	2026-03-22 18:52:18.596703+11	\N	2026-03-22 18:52:18.596705+11	US
20726	177	v1|227267597031|0	Lenovo ThinkPad P14s Gen 1 i7-10510U 16GB 512GB SSD Quadro P520 Touch Win11 Pro	279.99	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/227267597031?_skw=thinkpad&hash=item34ea3452e7:g:s0AAAeSwZUtpv4x0	2026-03-22 17:45:20+11	2026-03-22 18:52:18.597787+11	2026-03-22 18:52:18.59779+11	\N	2026-03-22 18:52:18.597791+11	US
20727	177	v1|298149004893|0	Lenovo ThinkPad P14S Gen 1 AMD Ryzen 7 Pro 4750U, 16GB RAM 512GB SSD 14" Touch	275.00	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/298149004893?_skw=thinkpad&hash=item456b10c65d:g:2XUAAeSwsTFpv408	2026-03-22 17:45:13+11	2026-03-22 18:52:18.598643+11	2026-03-22 18:52:18.598646+11	\N	2026-03-22 18:52:18.598647+11	US
20728	177	v1|227267574399|0	Lenovo ThinkPad T15 Gen 2 15.6" i5 11th - 16GB Ram - 512GB SSD	468.32	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/227267574399?_skw=thinkpad&hash=item34ea33fa7f:g:OPQAAeSwZdFpv4ri	2026-03-22 17:26:13+11	2026-03-22 18:52:18.599468+11	2026-03-22 18:52:18.599471+11	\N	2026-03-22 18:52:18.599473+11	US
20729	177	v1|157775688634|0	Lenovo ThinkPad E14 Gen 6 /14"/ AMD Ryzen 7- 7735U/ 16 GB RAM /512 GB SSD/ Win11	861.44	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/157775688634?_skw=thinkpad&hash=item24bc29f3ba:g:XcEAAeSwCBdpYwdW	2026-03-22 17:22:47+11	2026-03-22 18:52:18.600329+11	2026-03-22 18:52:18.600332+11	\N	2026-03-22 18:52:18.600333+11	US
20730	177	v1|298148964840|0	Lenovo ThinkPad P14S Gen 1- Intel i7-10610U, 48GB RAM, 1TB SSD NVIDIA P520 Touch	345.00	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/298148964840?_skw=thinkpad&hash=item456b1029e8:g:8UUAAeSw1yRpv4pR	2026-03-22 17:22:08+11	2026-03-22 18:52:18.601174+11	2026-03-22 18:52:18.601176+11	\N	2026-03-22 18:52:18.601177+11	US
20731	177	v1|298148963865|0	Lenovo ThinkPad P14S Gen 2 Intel i7-1185G7, 48GB RAM, 1TB SSD NVIDIA T500 Touch	450.00	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/298148963865?_skw=thinkpad&hash=item456b102619:g:MSEAAeSwZdFpv4mn	2026-03-22 17:19:01+11	2026-03-22 18:52:18.602008+11	2026-03-22 18:52:18.602011+11	\N	2026-03-22 18:52:18.602013+11	US
20732	177	v1|227267562478|0	Lenovo ThinkPad T15 Gen 2 15.6" i5 11th 16GB Ram 256GB SSD	468.32	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/227267562478?_skw=thinkpad&hash=item34ea33cbee:g:GdUAAeSwo41pv4a3	2026-03-22 17:10:49+11	2026-03-22 18:52:18.60286+11	2026-03-22 18:52:18.602863+11	\N	2026-03-22 18:52:18.602864+11	US
20733	177	v1|147217193867|0	Lenovo ThinkPad X1 Yoga Gen 6 (i7-1185G7 CPU, 32 GB RAM 1 TB SSD) 14" 4K Touch	939.77	AUD	Open box	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/147217193867?_skw=thinkpad&hash=item2246d41b8b:g:PkQAAeSwsgtpv4Q4	2026-03-22 16:56:30+11	2026-03-22 18:52:18.603686+11	2026-03-22 18:52:18.603689+11	\N	2026-03-22 18:52:18.60369+11	US
20734	177	v1|147217191327|0	Lenovo ThinkPad X1 Yoga Gen 6 (i7-1185G7 CPU, 16 GB RAM 1 TB SSD) 14" 4K Touch	900.61	AUD	Open box	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/147217191327?_skw=thinkpad&hash=item2246d4119f:g:Ag8AAeSwo41pv4KC	2026-03-22 16:50:59+11	2026-03-22 18:52:18.604502+11	2026-03-22 18:52:18.604506+11	\N	2026-03-22 18:52:18.604507+11	US
20735	177	v1|227267542622|0	Lenovo ThinkPad T15 Gen 2 15.6" i5 11th - 16GB Ram - 512GB SSD	468.32	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/227267542622?_skw=thinkpad&hash=item34ea337e5e:g:jMQAAeSw-Ehpv4Eo	2026-03-22 16:46:41+11	2026-03-22 18:52:18.605321+11	2026-03-22 18:52:18.605324+11	\N	2026-03-22 18:52:18.605326+11	US
20736	177	v1|147217178571|0	Lenovo ThinkPad X1 Yoga Gen 6 (i7-1185G7 CPU, 32 GB RAM 1 TB SSD) 14" 4K Touch	939.77	AUD	Open box	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/147217178571?_skw=thinkpad&hash=item2246d3dfcb:g:NLUAAeSwS5Zpv4G-	2026-03-22 16:45:24+11	2026-03-22 18:52:18.606132+11	2026-03-22 18:52:18.606135+11	\N	2026-03-22 18:52:18.606136+11	US
20737	177	v1|147217177384|0	Lenovo ThinkPad T480 (i7-8th 32GB RAM 1TB SSD) 14" Touch NVIDIA GeForce 2GB GPU	783.14	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/147217177384?_skw=thinkpad&hash=item2246d3db28:g:~D4AAeSwyw5pv4DK	2026-03-22 16:42:10+11	2026-03-22 18:52:18.606941+11	2026-03-22 18:52:18.606944+11	\N	2026-03-22 18:52:18.606945+11	US
20738	177	v1|318041580966|0	Thinkpad T430, 8gb ram 128gb ssd	125.00	USD	Used	FIXED_PRICE,AUCTION	EBAY_US	https://www.ebay.com/itm/318041580966?_skw=thinkpad&hash=item4a0cc165a6:g:aoIAAeSwPKtpv36d	2026-03-22 16:36:19+11	2026-03-22 18:52:18.607748+11	2026-03-22 18:52:18.607751+11	\N	2026-03-22 18:52:18.607752+11	US
20739	177	v1|236704994677|0	Libreboot T580 Thinkpad +UPGRADED: Great New Battery | +NEW Backlit Keyboard	499.79	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/236704994677?_skw=thinkpad&hash=item371cb79575:g:DXoAAeSwEE5pv32v	2026-03-22 16:30:14+11	2026-03-22 18:52:18.608593+11	2026-03-22 18:52:18.608596+11	\N	2026-03-22 18:52:18.608597+11	US
20740	177	v1|227267528819|0	Lenovo ThinkPad X1 Carbon Gen 9 i7-1165G7 16GB 512GB SSD 14" WUXGA Win11 Pro	379.99	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/227267528819?_skw=thinkpad&hash=item34ea334873:g:9HEAAeSwkBlpv3jK	2026-03-22 16:29:52+11	2026-03-22 18:52:18.609702+11	2026-03-22 18:52:18.609706+11	\N	2026-03-22 18:52:18.609707+11	US
20741	177	v1|127762804407|0	LENOVO ThinkPad X1 Carbon 1st Gen 14" I5-3427U 4GB  128 SSD  *READ*	145.00	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/127762804407?_skw=thinkpad&hash=item1dbf41aeb7:g:XMsAAeSwzONpv3mW	2026-03-22 16:19:32+11	2026-03-22 18:52:18.6107+11	2026-03-22 18:52:18.610703+11	\N	2026-03-22 18:52:18.610704+11	US
20742	177	v1|188193653651|0	Lenovo ThinkPad P14s Gen 5 Ryzen 7 Pro 8840HS Radeon 780M 1TB 32GB 1920 x 1200	2364.72	USD	New	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193653651?_skw=thinkpad&hash=item2bd1374393:g:3n0AAeSws~Jpv3NW	2026-03-22 15:27:50+11	2026-03-22 18:52:18.611655+11	2026-03-22 18:52:18.611659+11	\N	2026-03-22 18:52:18.61166+11	DE
20743	177	v1|188193651206|0	Lenovo ThinkPad X13 2-in-1 Gen 5 Core Ultra 13th Gen 135U 262GB 16GB 1920 x 1200	1424.37	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193651206?_skw=thinkpad&hash=item2bd1373a06:g:rp0AAeSw3x1pv3NZ	2026-03-22 15:27:37+11	2026-03-22 18:52:18.61258+11	2026-03-22 18:52:18.612583+11	\N	2026-03-22 18:52:18.612585+11	DE
20744	177	v1|358360507474|0	Lenovo ThinkPad L14 Gen 1 Laptop | I5-10210U | 16gb RAM | 256gb SSD | Black	189.99	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/358360507474?_skw=thinkpad&hash=item536ff36452:g:JLoAAeSw3rtpv25~	2026-03-22 15:22:51+11	2026-03-22 18:52:18.613579+11	2026-03-22 18:52:18.613582+11	\N	2026-03-22 18:52:18.613584+11	US
20745	177	v1|188193635973|0	Lenovo ThinkPad T14 G5 Core Ultra U5-135U 512GB 16GB 1920 x 1200 14.0" inch	1702.84	USD	New	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193635973?_skw=thinkpad&hash=item2bd136fe85:g:TKwAAeSw95tpv24b	2026-03-22 15:16:42+11	2026-03-22 18:52:18.614416+11	2026-03-22 18:52:18.614419+11	\N	2026-03-22 18:52:18.61442+11	DE
20746	177	v1|127762723300|0	Lenovo ThinkPad P16 Gen 2 21FA002TUS 16  Mobile Workstation - WQXGA - 165 Hz - I	3108.14	USD	New	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/127762723300?_skw=thinkpad&hash=item1dbf4071e4:g:EDMAAeSwIKBpv2rv	2026-03-22 15:05:06+11	2026-03-22 18:52:18.615244+11	2026-03-22 18:52:18.615247+11	\N	2026-03-22 18:52:18.615248+11	US
20747	177	v1|127762723301|0	Lenovo ThinkPad 21FA002TUS EDGE 16  Mobile Workstation - WQX + Microsoft 365 Bun	3138.14	USD	New	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/127762723301?_skw=thinkpad&hash=item1dbf4071e5:g:CzgAAeSweh9pv2su	2026-03-22 15:05:06+11	2026-03-22 18:52:18.617363+11	2026-03-22 18:52:18.617367+11	\N	2026-03-22 18:52:18.617368+11	US
20748	177	v1|298148739828|0	Lenovo ThinkPad E14 Gen 7 21SX0038US 14  Touchscreen Notebook - WUXGA - 60 Hz -	2789.04	AUD	New	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/298148739828?_skw=thinkpad&hash=item456b0cbaf4:g:8uAAAeSwAu9pv2tg	2026-03-22 15:05:06+11	2026-03-22 18:52:18.618272+11	2026-03-22 18:52:18.618275+11	\N	2026-03-22 18:52:18.618276+11	US
20749	177	v1|127762723287|0	Lenovo ThinkPad T14 Gen 5 21MC000KUS 14  Touchscreen Notebook - WUXGA - 60 Hz -	3853.95	AUD	New	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/127762723287?_skw=thinkpad&hash=item1dbf4071d7:g:ir0AAeSw4R1pv2uj	2026-03-22 15:05:05+11	2026-03-22 18:52:18.619123+11	2026-03-22 18:52:18.619126+11	\N	2026-03-22 18:52:18.619127+11	US
20750	177	v1|318041142340|0	Lenovo  ThinkPad T480s 14" Touch i5-8350U 1.70GHz 8GB RAM 256GB SSD WIN 11 PRO	189.00	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/318041142340?_skw=thinkpad&hash=item4a0cbab444:g:210AAeSw6JZpv14n	2026-03-22 14:14:10+11	2026-03-22 18:52:18.619944+11	2026-03-22 18:52:18.619947+11	\N	2026-03-22 18:52:18.619948+11	US
20751	177	v1|177980860292|477507823154	NEW Lenovo ThinkPad P14s Gen 6 Touch Ryzen AI 7 350 96GB 4TB Win 11 Pro	1644.60	AUD	New	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/177980860292?_skw=thinkpad&hash=item29707c6784:g:41UAAeSwOvZpv15j	2026-03-22 14:13:55+11	2026-03-22 18:52:18.620759+11	2026-03-22 18:52:18.620762+11	\N	2026-03-22 18:52:18.620763+11	US
20752	177	v1|306835792090|0	Lenovo Yoga 7 2-in-1 14" 2K OLED Touch Laptop Ryzen AI 5 340 16GB 512GB	539.99	USD	Open box	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/306835792090?_skw=thinkpad&hash=item4770d6a0da:g:fIwAAeSwr1Zpv1ki	2026-03-22 14:11:19+11	2026-03-22 18:52:18.621564+11	2026-03-22 18:52:18.621567+11	\N	2026-03-22 18:52:18.621568+11	US
20753	177	v1|318041087990|0	Lenovo  ThinkPad T480s 14" Touch i5-8350U 1.70GHz 8GB RAM 256GB SSD WIN 11 PRO	199.00	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/318041087990?_skw=thinkpad&hash=item4a0cb9dff6:g:RWUAAeSwBfhpv1wV	2026-03-22 14:04:12+11	2026-03-22 18:52:18.622386+11	2026-03-22 18:52:18.622388+11	\N	2026-03-22 18:52:18.62239+11	US
20754	177	v1|306835784773|0	Lenovo V15 G2 ITL 15.6" (256GB SSD, Intel Core i5 11th Gen., 2.40 GHz, 8GB)...	479.99	USD	New	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/306835784773?_skw=thinkpad&hash=item4770d68445:g:3kwAAeSwLoxpv1pJ	2026-03-22 14:01:28+11	2026-03-22 18:52:18.6232+11	2026-03-22 18:52:18.623203+11	\N	2026-03-22 18:52:18.623204+11	US
20755	177	v1|127762634228|0	Lenovo ThinkPad X1 Tablet Gen 3 i5-8250U 1.6GHz 8GB RAM 500GB - BAD TOUCH SCREEN	149.95	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/127762634228?_skw=thinkpad&hash=item1dbf3f15f4:g:XRAAAeSwwThpv1qd	2026-03-22 13:58:20+11	2026-03-22 18:52:18.62401+11	2026-03-22 18:52:18.624013+11	\N	2026-03-22 18:52:18.624014+11	US
20756	177	v1|397745316739|0	Lenovo ThinkPad X1 Carbon Gen 8 14" Touch (i7-10610U 16GB RAM 256GB SSD) Win11	388.44	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397745316739?_skw=thinkpad&hash=item5c9b77e383:g:q40AAeSwkk9pv1Rh	2026-03-22 13:35:21+11	2026-03-22 18:52:18.624818+11	2026-03-22 18:52:18.624821+11	\N	2026-03-22 18:52:18.624822+11	US
20757	177	v1|188193374585|0	Lenovo ThinkPad X12 Detachable Core i5 11th Gen 1140G7 262GB 16GB 1920 x 1280	1037.59	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193374585?_skw=thinkpad&hash=item2bd1330179:g:Q0UAAeSwLTlpv1Tj	2026-03-22 13:32:03+11	2026-03-22 18:52:18.626137+11	2026-03-22 18:52:18.626142+11	\N	2026-03-22 18:52:18.626145+11	DE
20758	177	v1|406790122859|0	Lenovo Yoga 710-15ikb	159.99	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/406790122859?_skw=thinkpad&hash=item5eb694ad6b:g:BEwAAeSwVxhpv1Kr	2026-03-22 13:28:17+11	2026-03-22 18:52:18.627209+11	2026-03-22 18:52:18.627212+11	\N	2026-03-22 18:52:18.627213+11	US
20759	177	v1|198213384781|0	NEW Lenovo ThinkPad X1 2-in-1 Gen 10 14 Touch Ultra 5 226V 16GB 512GB W11 Pen	1722.91	AUD	Open box	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/198213384781?_skw=thinkpad&hash=item2e26703a4d:g:NYoAAeSw4rppsdkY	2026-03-22 13:27:59+11	2026-03-22 18:52:18.628079+11	2026-03-22 18:52:18.628081+11	\N	2026-03-22 18:52:18.628083+11	US
20760	177	v1|267616103851|0	Lenovo ThinkPad X1 Carbon Gen 9 i7-1185G7 32GB RAM 512GB SSD Battery 99%	354.95	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/267616103851?_skw=thinkpad&hash=item3e4f29adab:g:ZJMAAeSwAu9pv1H2	2026-03-22 13:25:06+11	2026-03-22 18:52:18.628909+11	2026-03-22 18:52:18.628912+11	\N	2026-03-22 18:52:18.628913+11	US
20761	177	v1|188193336224|0	Lenovo Thinkpad T15 G1 Core i5 10th Gen i5-10210U 262GB 16GB 1920 x 1080 (FHD)	1009.71	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193336224?_skw=thinkpad&hash=item2bd1326ba0:g:rxwAAeSwDz9pv1KW	2026-03-22 13:20:13+11	2026-03-22 18:52:18.629734+11	2026-03-22 18:52:18.629736+11	\N	2026-03-22 18:52:18.629737+11	DE
20762	177	v1|188193336093|0	Lenovo ThinkPad T14 G3 Core i5 12th Gen i5-1245U 262GB 16GB 1920 x 1200 WUXGA	1206.40	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193336093?_skw=thinkpad&hash=item2bd1326b1d:g:d-sAAeSwtnBpv1IV	2026-03-22 13:20:05+11	2026-03-22 18:52:18.630557+11	2026-03-22 18:52:18.630559+11	\N	2026-03-22 18:52:18.63056+11	DE
20763	177	v1|188193336025|0	Lenovo Thinkpad T14 G1 Ryzen 5 PRO 4650U 262GB 16GB 1920 x 1080 (FHD) 14.0" inch	760.98	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193336025?_skw=thinkpad&hash=item2bd1326ad9:g:h2gAAeSwSIxpv1MA	2026-03-22 13:20:03+11	2026-03-22 18:52:18.631367+11	2026-03-22 18:52:18.63137+11	\N	2026-03-22 18:52:18.631371+11	DE
20764	177	v1|188193335394|0	Lenovo Thinkpad T14 G1 Ryzen 5 Pro 4650U 512GB 16GB 1920 x 1080 14.0" inch	791.64	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193335394?_skw=thinkpad&hash=item2bd1326862:g:-vwAAeSw3x1pv1Iu	2026-03-22 13:19:34+11	2026-03-22 18:52:18.632176+11	2026-03-22 18:52:18.632179+11	\N	2026-03-22 18:52:18.63218+11	DE
20765	177	v1|267616099793|0	Lenovo ThinkPad X1 Carbon Gen 9 i7-1185G7 32GB RAM 512GB SSD Battery 99%	384.95	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/267616099793?_skw=thinkpad&hash=item3e4f299dd1:g:mcQAAeSwfKJpv1Dx	2026-03-22 13:18:39+11	2026-03-22 18:52:18.633047+11	2026-03-22 18:52:18.633049+11	\N	2026-03-22 18:52:18.633051+11	US
20766	177	v1|227267371002|0	Lenovo ThinkPad T14 Gen 2 Ryzen 5 PRO 16GB RAM 512GB SSD 14" Win11 Pro Grade A	279.99	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/227267371002?_skw=thinkpad&hash=item34ea30dffa:g:VUQAAeSwl~dpv0vF	2026-03-22 13:13:01+11	2026-03-22 18:52:18.633866+11	2026-03-22 18:52:18.633869+11	\N	2026-03-22 18:52:18.63387+11	US
20767	177	v1|198213341786|0	black lenovo thinkpad t410	52.00	USD	Used	FIXED_PRICE,AUCTION	EBAY_US	https://www.ebay.com/itm/198213341786?_skw=thinkpad&hash=item2e266f925a:g:jNoAAeSwW0Vpv01H	2026-03-22 13:07:28+11	2026-03-22 18:52:18.634674+11	2026-03-22 18:52:18.634678+11	\N	2026-03-22 18:52:18.634679+11	US
20768	177	v1|397745236967|0	Lenovo ThinkPad X1 Carbon Gen 10 14" (256GB, Intel Core i7 1265U Gen 16GB DDR5..	626.51	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397745236967?_skw=thinkpad&hash=item5c9b76abe7:g:lnkAAeSwWNVpv00q	2026-03-22 13:06:47+11	2026-03-22 18:52:18.635477+11	2026-03-22 18:52:18.635481+11	\N	2026-03-22 18:52:18.635482+11	US
20769	177	v1|327061597907|0	Lenovo ThinkPad X1 Yoga 3rd Gen Laptop i7  16GB 1TB i5 14" Touchscreen + Pen	548.18	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/327061597907?_skw=thinkpad&hash=item4c2663eed3:g:PeQAAeSwt0Npv0br	2026-03-22 12:53:13+11	2026-03-22 18:52:18.636285+11	2026-03-22 18:52:18.636288+11	\N	2026-03-22 18:52:18.636289+11	US
20770	177	v1|117100797060|0	Lenovo ThinkPad E14 Gen 2, Intel i5-1135G7, 256GB SSD, 8GB RAM, Windows 11 Pro	266.25	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/117100797060?_skw=thinkpad&hash=item1b43c05c84:g:TzkAAeSwU0Zpv0qg	2026-03-22 12:52:48+11	2026-03-22 18:52:18.637103+11	2026-03-22 18:52:18.637106+11	\N	2026-03-22 18:52:18.637107+11	US
20771	177	v1|267616086624|0	Lenovo ThinkPad T470 Dual Battery 14" Touch, 16 GB RAM i7, 512 GB SSD Win 11 Pro	249.00	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/267616086624?_skw=thinkpad&hash=item3e4f296a60:g:TssAAeSwQQ9pv0pf	2026-03-22 12:52:18+11	2026-03-22 18:52:18.637906+11	2026-03-22 18:52:18.637909+11	\N	2026-03-22 18:52:18.63791+11	US
20772	177	v1|318040858741|0	Lenovo  ThinkPad T480s 14" Touch i5-8350U 1.70GHz 8GB RAM 256GB SSD WIN 11 PRO	199.00	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/318040858741?_skw=thinkpad&hash=item4a0cb66075:g:0WYAAeSw3x1pv0mR	2026-03-22 12:45:23+11	2026-03-22 18:52:18.638715+11	2026-03-22 18:52:18.638717+11	\N	2026-03-22 18:52:18.638718+11	US
20773	177	v1|318040845089|0	Lenovo  ThinkPad T480s 14" Touch i5-8350U 1.70GHz 8GB RAM 256GB SSD WIN 11 PRO	199.00	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/318040845089?_skw=thinkpad&hash=item4a0cb62b21:g:al0AAeSwMbVpv0d7	2026-03-22 12:36:32+11	2026-03-22 18:52:18.639689+11	2026-03-22 18:52:18.639692+11	\N	2026-03-22 18:52:18.639694+11	US
20774	177	v1|318040807713|0	Lenovo  ThinkPad T480s 14" Touch i5-8350U 1.70GHz 8GB RAM 256GB SSD WIN 11 PRO	199.00	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/318040807713?_skw=thinkpad&hash=item4a0cb59921:g:ysMAAeSwY0ppv0Sp	2026-03-22 12:26:26+11	2026-03-22 18:52:18.640546+11	2026-03-22 18:52:18.640548+11	\N	2026-03-22 18:52:18.640549+11	US
20775	177	v1|318040796055|0	Lenovo ThinkPad X1 16GB RAM, i7-1185G7, 3.0GHz, 512GB SSD Windows 10 Pro	299.99	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/318040796055?_skw=thinkpad&hash=item4a0cb56b97:g:33wAAeSwXslpv0NC	2026-03-22 12:18:32+11	2026-03-22 18:52:18.641353+11	2026-03-22 18:52:18.641356+11	\N	2026-03-22 18:52:18.641358+11	US
20776	177	v1|188193172781|0	Lenovo ThinkPad X1 Carbon G9 Core i5 11th Gen i5-1135G7 262GB 16GB	1071.63	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193172781?_skw=thinkpad&hash=item2bd12fed2d:g:KOwAAeSwSO9pv0QV	2026-03-22 12:17:21+11	2026-03-22 18:52:18.642598+11	2026-03-22 18:52:18.642602+11	\N	2026-03-22 18:52:18.642603+11	DE
20777	177	v1|188193172836|0	Lenovo Thinkpad T14 G1 Core i5 10th Gen i5-10310U 512GB 16GB 1920 x 1080	885.98	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193172836?_skw=thinkpad&hash=item2bd12fed64:g:L-cAAeSw8otpv0Ng	2026-03-22 12:17:21+11	2026-03-22 18:52:18.643517+11	2026-03-22 18:52:18.64352+11	\N	2026-03-22 18:52:18.643521+11	DE
20778	177	v1|188193172759|0	Lenovo ThinkPad X9-14 G1 Core Ultra 5 228V 130V 1TB 32GB 2880 x 1800 14.0" inch	1541.93	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193172759?_skw=thinkpad&hash=item2bd12fed17:g:1HoAAeSwiAFpv0RN	2026-03-22 12:17:20+11	2026-03-22 18:52:18.644349+11	2026-03-22 18:52:18.644352+11	\N	2026-03-22 18:52:18.644354+11	DE
20779	177	v1|188193172579|0	Lenovo Thinkpad T15 G1 Core i5 10th Gen i5-10310U 262GB 8GB 1920 x 1080 (FHD)	799.21	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193172579?_skw=thinkpad&hash=item2bd12fec63:g:3doAAeSwF8Rpv0OZ	2026-03-22 12:17:17+11	2026-03-22 18:52:18.645161+11	2026-03-22 18:52:18.645164+11	\N	2026-03-22 18:52:18.645165+11	DE
20780	177	v1|188193172490|0	Lenovo ThinkPad T14s Gen 1 Ryzen 7 Pro 4th Gen 4750U 512GB 16GB 1920 x 1080	997.99	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193172490?_skw=thinkpad&hash=item2bd12fec0a:g:4moAAeSw8rRpv0RL	2026-03-22 12:17:15+11	2026-03-22 18:52:18.64597+11	2026-03-22 18:52:18.645973+11	\N	2026-03-22 18:52:18.645975+11	DE
20781	177	v1|188193172322|0	Lenovo ThinkPad T14 G1 Core i5 10th Gen 10210U 512GB 16GB 1920 x 1080 14.0" inch	882.47	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193172322?_skw=thinkpad&hash=item2bd12feb62:g:mFwAAeSws~Jpvw6i	2026-03-22 12:17:12+11	2026-03-22 18:52:18.646777+11	2026-03-22 18:52:18.64678+11	\N	2026-03-22 18:52:18.646781+11	DE
20782	177	v1|188193172263|0	Lenovo ThinkPad T14 G1 Ryzen 5 PRO 4650U 262GB 16GB 1920 x 1080 (FHD) 14.0" inch	895.27	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193172263?_skw=thinkpad&hash=item2bd12feb27:g:aCgAAeSwXbFpv0QN	2026-03-22 12:17:10+11	2026-03-22 18:52:18.647599+11	2026-03-22 18:52:18.647603+11	\N	2026-03-22 18:52:18.647604+11	DE
20783	177	v1|188193172175|0	Lenovo ThinkPad T14 G1 Ryzen 5 Pro 4650U Radeon Graphics 262GB 16GB 1920 x 1080	760.98	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193172175?_skw=thinkpad&hash=item2bd12feacf:g:YjYAAeSwK9Rpv0QM	2026-03-22 12:17:09+11	2026-03-22 18:52:18.648402+11	2026-03-22 18:52:18.648405+11	\N	2026-03-22 18:52:18.648406+11	DE
20784	177	v1|188193172204|0	Lenovo ThinkPad X1 Carbon G13 Core Ultra 7 258V Arc 140V 32GB 1920 x 1200	3097.30	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193172204?_skw=thinkpad&hash=item2bd12feaec:g:wYIAAeSwIRVpv0OU	2026-03-22 12:17:09+11	2026-03-22 18:52:18.649205+11	2026-03-22 18:52:18.649207+11	\N	2026-03-22 18:52:18.649208+11	DE
20785	177	v1|188193172162|0	Lenovo ThinkPad L13 Yoga Gen 4 Core i5 13th Gen 1335U 512GB 8GB 1920 x 1200	1022.14	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193172162?_skw=thinkpad&hash=item2bd12feac2:g:tg8AAeSw6Ytpv0QH	2026-03-22 12:17:08+11	2026-03-22 18:52:18.650318+11	2026-03-22 18:52:18.650321+11	\N	2026-03-22 18:52:18.650322+11	DE
20786	177	v1|188193172170|0	Lenovo ThinkPad L13 G4 Ryzen 7 Pro 7730U 1TB 32GB 1920 x 1200 13.0" inch touch	1419.72	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193172170?_skw=thinkpad&hash=item2bd12feaca:g:6mcAAeSwcoBpv0PL	2026-03-22 12:17:08+11	2026-03-22 18:52:18.651186+11	2026-03-22 18:52:18.651189+11	\N	2026-03-22 18:52:18.651191+11	DE
20787	177	v1|188193171585|0	Lenovo ThinkPad X13 G4 Core i5 13th Gen i5-1335U 512GB 16GB 1920 x 1200 WUXGA	1302.25	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193171585?_skw=thinkpad&hash=item2bd12fe881:g:JuQAAeSwSO9pv0PA	2026-03-22 12:16:56+11	2026-03-22 18:52:18.651992+11	2026-03-22 18:52:18.651995+11	\N	2026-03-22 18:52:18.651996+11	DE
20788	177	v1|188193171496|0	Lenovo 14W G2 DualCore AMD DualCore 3015e 131GB 8GB 1366 x 768 (HD) 14.0" inch	583.91	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193171496?_skw=thinkpad&hash=item2bd12fe828:g:YtgAAeSwLoxpv0NK	2026-03-22 12:16:54+11	2026-03-22 18:52:18.652799+11	2026-03-22 18:52:18.652802+11	\N	2026-03-22 18:52:18.652803+11	DE
20789	177	v1|188193171387|0	Lenovo ThinkPad X1 Carbon G13 Core Ultra 7 268V 140V 2TB 32GB 2880 x 1800	3388.97	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188193171387?_skw=thinkpad&hash=item2bd12fe7bb:g:WqUAAeSw1yRpv0Q4	2026-03-22 12:16:52+11	2026-03-22 18:52:18.653601+11	2026-03-22 18:52:18.653604+11	\N	2026-03-22 18:52:18.653605+11	DE
20790	177	v1|318040775053|0	Lenovo IdeaPad 3 17.3” Laptop Intel Inside 17ITL6 / 17ALC6 w/ Charger	220.00	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/318040775053?_skw=thinkpad&hash=item4a0cb5198d:g:TZkAAeSwIIFpv0Bb	2026-03-22 12:09:13+11	2026-03-22 18:52:18.654426+11	2026-03-22 18:52:18.654429+11	\N	2026-03-22 18:52:18.65443+11	US
20791	177	v1|206157161837|0	Lenovo Ideapad 330S-15IKB 81F5 15.6" FHD - i5-8250U CPU✔8GB RAM✔256GB SSD 91130	175.00	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/206157161837?_skw=thinkpad&hash=item2fffeca56d:g:OQYAAeSwm7Jpvz7D	2026-03-22 11:59:33+11	2026-03-22 18:52:18.655261+11	2026-03-22 18:52:18.655264+11	\N	2026-03-22 18:52:18.655265+11	US
20792	177	v1|358359838782|0	Lenovo IdeaPad Slim 3 Laptop Windows 11 15 .8 Inch I3	275.00	USD	Open box	FIXED_PRICE,AUCTION	EBAY_US	https://www.ebay.com/itm/358359838782?_skw=thinkpad&hash=item536fe9303e:g:3cEAAeSwdVJpvzrD	2026-03-22 11:49:46+11	2026-03-22 18:52:18.656068+11	2026-03-22 18:52:18.656071+11	\N	2026-03-22 18:52:18.656072+11	US
20793	177	v1|318040666191|0	Lenovo ThinkPad X13 32GB RAM, i7-10510U, 1.80GHz, 1TB SSD Windows 11 Pro	399.99	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/318040666191?_skw=thinkpad&hash=item4a0cb3704f:g:-mAAAeSwsTFpvzwN	2026-03-22 11:47:49+11	2026-03-22 18:52:18.656868+11	2026-03-22 18:52:18.65687+11	\N	2026-03-22 18:52:18.656871+11	US
20794	177	v1|117100719751|0	Lenovo 14" ThinkPad X1 Carbon Gen 12	1487.97	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/117100719751?_skw=thinkpad&hash=item1b43bf2e87:g:2YQAAeSwEvxpvzsP	2026-03-22 11:43:18+11	2026-03-22 18:52:18.657853+11	2026-03-22 18:52:18.657857+11	\N	2026-03-22 18:52:18.657858+11	US
20795	177	v1|137155218530|0	Lenovo ThinkPad L13 Gen 2 13.3" FHD i5-1135G7 8GB 256GB SSD Windows 11 Pro Touch	225.53	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/137155218530?_skw=thinkpad&hash=item1fef168c62:g:AbcAAeSwIIFpvzS5	2026-03-22 11:19:59+11	2026-03-22 18:52:18.658929+11	2026-03-22 18:52:18.658933+11	\N	2026-03-22 18:52:18.658934+11	US
20796	177	v1|318040590232|0	Lenovo ThinkPad P1 Gen 7 165H Intel Core Ultra 7 155H, 32GB, 1TB, RTX 2000 ADA	1500.00	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/318040590232?_skw=thinkpad&hash=item4a0cb24798:g:WaYAAeSw4whpvzLf	2026-03-22 11:17:20+11	2026-03-22 18:52:18.659807+11	2026-03-22 18:52:18.659809+11	\N	2026-03-22 18:52:18.65981+11	US
20797	177	v1|236704529426|0	Lenovo ThinkPad Twist S230u  Intel Core i5 #38 Blocked	62.65	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/236704529426?_skw=thinkpad&hash=item371cb07c12:g:gosAAeSwHPBpvzM2	2026-03-22 11:12:44+11	2026-03-22 18:52:18.660619+11	2026-03-22 18:52:18.660621+11	\N	2026-03-22 18:52:18.660622+11	US
20798	177	v1|198213057265|0	Lenovo ThinkPad T14s Gen 1 – AMD Ryzen 5 PRO 4650U, 16GB, 256GB NVMe, W11P	311.69	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/198213057265?_skw=thinkpad&hash=item2e266b3af1:g:eTEAAeSw5RBpvzLd	2026-03-22 11:10:10+11	2026-03-22 18:52:18.661421+11	2026-03-22 18:52:18.661423+11	\N	2026-03-22 18:52:18.661425+11	US
20799	177	v1|127762366351|0	Lenovo ThinkPad Black Laptop Built-in Webcam Casual Computing Workstation	200.00	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/127762366351?_skw=thinkpad&hash=item1dbf3aff8f:g:s3cAAeSwTGBpvzAg	2026-03-22 11:07:03+11	2026-03-22 18:52:18.662483+11	2026-03-22 18:52:18.662487+11	\N	2026-03-22 18:52:18.662488+11	US
20800	177	v1|198213597767|0	Lenovo ThinkPad T14s Gen 1 – AMD Ryzen 7 PRO 4750U, 16GB, 512GB NVMe, W11P Hello	368.08	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/198213597767?_skw=thinkpad&hash=item2e26737a47:g:rIsAAeSwJFBpvzGM	2026-03-22 14:46:16+11	2026-03-22 18:52:18.663322+11	2026-03-22 18:52:18.663324+11	\N	2026-03-22 18:52:18.663325+11	US
20801	177	v1|306835563225|0	ThinkPad P1 15.6-inch W73 CPU Intel Core i7 @ 2.6GHz RAM 32.0GB DDR4 1TB M.2	2885.95	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/306835563225?_skw=thinkpad&hash=item4770d322d9:g:QagAAeSwBkhpvzG3	2026-03-22 10:58:57+11	2026-03-22 18:52:18.664132+11	2026-03-22 18:52:18.664135+11	\N	2026-03-22 18:52:18.664136+11	US
20802	177	v1|358359698817|0	Lenovo ThinkPad 14" E14 G2 i5-1135G7 8GB 256GB NVMe Windows 11 Pro	264.70	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/358359698817?_skw=thinkpad&hash=item536fe70d81:g:sxkAAeSw~U5pvzBI	2026-03-22 10:57:45+11	2026-03-22 18:52:18.664932+11	2026-03-22 18:52:18.664935+11	\N	2026-03-22 18:52:18.664936+11	US
20803	177	v1|327061450827|0	Lenovo ThinkPad T16 P16s 16" Touch Ryzen AI 7 PRO 350 32GB 512GB 21QR0024US	2144.24	AUD	Open box	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/327061450827?_skw=thinkpad&hash=item4c2661b04b:g:nM4AAeSww8ppvy51	2026-03-22 10:51:27+11	2026-03-22 18:52:18.665733+11	2026-03-22 18:52:18.665736+11	\N	2026-03-22 18:52:18.665737+11	US
20804	177	v1|177980411835|0	Lenovo ThinkPad T14s Gen 2 14" Touch | i7-1185G7 | 32GB RAM | 512GB SSD | Win 11	524.69	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/177980411835?_skw=thinkpad&hash=item2970758fbb:g:VckAAeSwrw5pvy2R	2026-03-22 10:50:42+11	2026-03-22 18:52:18.666532+11	2026-03-22 18:52:18.666535+11	\N	2026-03-22 18:52:18.666536+11	US
20805	177	v1|236704480417|0	Lenovo ThinkPad E14 Gen 7 21SX0038US 14" Touchscreen Notebook - WUXGA - 60 Hz -	2831.23	AUD	New	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/236704480417?_skw=thinkpad&hash=item371cafbca1:g:yBAAAeSwjKxpvywr	2026-03-22 10:38:19+11	2026-03-22 18:52:18.667329+11	2026-03-22 18:52:18.667332+11	\N	2026-03-22 18:52:18.667333+11	US
20806	177	v1|358359646277|0	Lenovo ThinkPad 14" E14 G2 i5-1135G7 8GB 256GB NVMe Windows 11 Pro	264.70	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/358359646277?_skw=thinkpad&hash=item536fe64045:g:kgQAAeSwOFhpvyuc	2026-03-22 10:38:04+11	2026-03-22 18:52:18.668119+11	2026-03-22 18:52:18.668121+11	\N	2026-03-22 18:52:18.668122+11	US
20807	177	v1|327061436083|0	Lenovo ThinkPad T16 Gen 4 16" Touch Ultra 7 265U 32GB 1TB 21QE007TUS	2582.80	AUD	Open box	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/327061436083?_skw=thinkpad&hash=item4c266176b3:g:pb8AAeSwWB5pvynu	2026-03-22 10:36:34+11	2026-03-22 18:52:18.668945+11	2026-03-22 18:52:18.668949+11	\N	2026-03-22 18:52:18.66895+11	US
20808	177	v1|188192882731|0	ThinkPad T420 Core i7-2620M 14"/ 16GB RAM/ 256GB SSD+1TB HDD/Win 11P+Linux	501.21	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/188192882731?_skw=thinkpad&hash=item2bd12b802b:g:LUkAAeSws~JpvycX	2026-03-22 10:34:58+11	2026-03-22 18:52:18.669744+11	2026-03-22 18:52:18.669747+11	\N	2026-03-22 18:52:18.669748+11	US
20809	177	v1|318040449894|0	Lenovo ThinkPad T14 Gen 2 FHD Laptop Intel Core i5-1135G7 16 GB RAM 256 GB SSD	459.00	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/318040449894?_skw=thinkpad&hash=item4a0cb02366:g:e~kAAeSwpHtpvyec	2026-03-22 10:27:57+11	2026-03-22 18:52:18.670544+11	2026-03-22 18:52:18.670547+11	\N	2026-03-22 18:52:18.670548+11	US
20810	177	v1|188192847597|0	Lenovo ThinkPad P1 Gen 7 21KV Core Ultra 9 185H GeForce RTX 4070 2TB 64GB	3077.61	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192847597?_skw=thinkpad&hash=item2bd12af6ed:g:NLIAAeSwykZpvymd	2026-03-22 10:26:24+11	2026-03-22 18:52:18.671346+11	2026-03-22 18:52:18.67135+11	\N	2026-03-22 18:52:18.671351+11	DE
20811	177	v1|188192846645|0	Lenovo ThinkPad X12 Detachable 20UW Core i5 label 1140G7 256GB 16GB 1920 x 1280	1170.73	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192846645?_skw=thinkpad&hash=item2bd12af335:g:FTIAAeSwqLFpvym5	2026-03-22 10:25:52+11	2026-03-22 18:52:18.672146+11	2026-03-22 18:52:18.672148+11	\N	2026-03-22 18:52:18.672149+11	DE
20812	177	v1|397744623758|0	Lenovo ThinkPad T14 Gen 5 Black FHD 1.6GHz Ultra 5 135U 16GB 512GB SSD Excellent	540.00	USD	Open box	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/397744623758?_skw=thinkpad&hash=item5c9b6d508e:g:--gAAeSwkGZpvybq	2026-03-22 10:25:12+11	2026-03-22 18:52:18.672945+11	2026-03-22 18:52:18.672947+11	\N	2026-03-22 18:52:18.672948+11	US
20813	177	v1|188192843392|0	Lenovo ThinkPad L14 Gen 5 Core Ultra 5 125U 262GB 16GB 1920 x 1200 14.0" inch	1495.69	USD	New	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192843392?_skw=thinkpad&hash=item2bd12ae680:g:qzwAAeSwrmFpvykA	2026-03-22 10:24:47+11	2026-03-22 18:52:18.674077+11	2026-03-22 18:52:18.674081+11	\N	2026-03-22 18:52:18.674082+11	DE
20814	177	v1|188192843256|0	Lenovo ThinkPad P14s Gen 5 Ryzen 7 Pro 8840HS Radeon 780M 1TB 32GB 1920 x 1200	2085.88	USD	New	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192843256?_skw=thinkpad&hash=item2bd12ae5f8:g:nT0AAeSwFWxpvymx	2026-03-22 10:24:43+11	2026-03-22 18:52:18.675016+11	2026-03-22 18:52:18.675019+11	\N	2026-03-22 18:52:18.675021+11	DE
20815	177	v1|188192841603|0	Lenovo ThinkPad T14 G1 Core i5 10th Gen i5-10310U 512GB 16GB 1920 x 1080 (FHD)	885.98	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192841603?_skw=thinkpad&hash=item2bd12adf83:g:gB0AAeSwTGBpvylR	2026-03-22 10:24:07+11	2026-03-22 18:52:18.675846+11	2026-03-22 18:52:18.675849+11	\N	2026-03-22 18:52:18.67585+11	DE
20816	177	v1|188192840972|0	Lenovo Thinkpad T14 G1 Ryzen 5 PRO 4650U 262GB 16GB 1920 x 1080 (FHD) 14.0" inch	895.27	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192840972?_skw=thinkpad&hash=item2bd12add0c:g:dHcAAeSwAu9pvylD	2026-03-22 10:23:54+11	2026-03-22 18:52:18.676676+11	2026-03-22 18:52:18.676679+11	\N	2026-03-22 18:52:18.67668+11	DE
20817	177	v1|188192840452|0	Lenovo Thinkpad T14 G1 Core i5 10th Gen i5-10310U 512GB 16GB 1920 x 1080	947.90	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192840452?_skw=thinkpad&hash=item2bd12adb04:g:plAAAeSwdAJpvyj5	2026-03-22 10:23:43+11	2026-03-22 18:52:18.677478+11	2026-03-22 18:52:18.677481+11	\N	2026-03-22 18:52:18.677482+11	DE
20818	177	v1|188192839865|0	Lenovo ThinkPad X1 Carbon G9 Core i7 11th Gen i7-1185G7 1TB 16GB	1180.03	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192839865?_skw=thinkpad&hash=item2bd12ad8b9:g:CBYAAeSw8y5pvylk	2026-03-22 10:23:30+11	2026-03-22 18:52:18.678279+11	2026-03-22 18:52:18.678282+11	\N	2026-03-22 18:52:18.678283+11	DE
20819	177	v1|188192838945|0	Lenovo Thinkpad T14s G1 Ryzen 5 PRO 4650U 262GB 16GB 1920 x 1080 (FHD)	760.98	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192838945?_skw=thinkpad&hash=item2bd12ad521:g:nwEAAeSwPOhpvyke	2026-03-22 10:23:18+11	2026-03-22 18:52:18.679074+11	2026-03-22 18:52:18.679077+11	\N	2026-03-22 18:52:18.679078+11	DE
20820	177	v1|306835512097|0	3PCS Trackpoint Caps 3.0mm Red for Lenovo Thinkpad T14s Gen 2,3,4|T14 Gen 4,3|T1	16.49	USD	New	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/306835512097?_skw=thinkpad&hash=item4770d25b21:g:fJMAAeSw591pvyif	2026-03-22 10:23:06+11	2026-03-22 18:52:18.679888+11	2026-03-22 18:52:18.679891+11	\N	2026-03-22 18:52:18.679892+11	US
20821	177	v1|188192837718|0	Lenovo Thinkpad T14 G1 Core i5 10th Gen 10310U 262GB 16GB 1920 x 1080 14.0" inch	864.25	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192837718?_skw=thinkpad&hash=item2bd12ad056:g:oWYAAeSw7-tpvyl7	2026-03-22 10:22:53+11	2026-03-22 18:52:18.680684+11	2026-03-22 18:52:18.680687+11	\N	2026-03-22 18:52:18.680688+11	DE
20822	177	v1|188192836919|0	Lenovo ThinkPad X9-14 G1 Core Ultra 5 Intel 226V 130V 512GB 16GB	1538.91	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192836919?_skw=thinkpad&hash=item2bd12acd37:g:fi0AAeSwVhJpvyjX	2026-03-22 10:22:08+11	2026-03-22 18:52:18.681482+11	2026-03-22 18:52:18.681485+11	\N	2026-03-22 18:52:18.681486+11	DE
20823	177	v1|188192836415|0	Lenovo Thinkpad T14 G1 Core i5 10th Gen i5-10310U 262GB 8GB 1920 x 1080 (FHD)	619.69	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192836415?_skw=thinkpad&hash=item2bd12acb3f:g:cI0AAeSwPKtpvyiG	2026-03-22 10:21:46+11	2026-03-22 18:52:18.682285+11	2026-03-22 18:52:18.682287+11	\N	2026-03-22 18:52:18.682288+11	DE
20824	177	v1|188192809698|0	Lenovo ThinkPad E15 TP0117A 8GB SSD256GB Laptop	1011.23	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/188192809698?_skw=thinkpad&hash=item2bd12a62e2:g:BbQAAeSwMBxpvyYN	2026-03-22 10:11:06+11	2026-03-22 18:52:18.683107+11	2026-03-22 18:52:18.68311+11	\N	2026-03-22 18:52:18.68311+11	KR
20825	177	v1|188192809313|0	Lenovo ThinkPad E15 TP0117A Laptop with 8GB RAM and SSD 128GB	1011.23	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/188192809313?_skw=thinkpad&hash=item2bd12a6161:g:RVkAAeSwXzBpvyZ8	2026-03-22 10:11:00+11	2026-03-22 18:52:18.684064+11	2026-03-22 18:52:18.684067+11	\N	2026-03-22 18:52:18.684068+11	KR
20826	177	v1|397744540124|0	Lenovo ThinkPad X280 Core i5 8GB RAM SSD256GB Windows 11 Lightweight Used Japan	432.28	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540124?_skw=thinkpad&hash=item5c9b6c09dc:g:S7wAAeSweFppvyTP	2026-03-22 10:02:48+11	2026-03-22 18:52:18.684907+11	2026-03-22 18:52:18.68491+11	\N	2026-03-22 18:52:18.684912+11	JP
20827	177	v1|397744540131|0	Lenovo ThinkPad X280 Core i5 8GB RAM SSD256GB Windows 11 Lightweight Used Japan	471.44	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540131?_skw=thinkpad&hash=item5c9b6c09e3:g:WR8AAeSwIKBpvyRS	2026-03-22 10:02:48+11	2026-03-22 18:52:18.685719+11	2026-03-22 18:52:18.685722+11	\N	2026-03-22 18:52:18.685723+11	JP
20828	177	v1|397744540147|0	Lenovo ThinkPad X270 Laptop i5 SSD 256GB Used Japan Genuine	471.44	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540147?_skw=thinkpad&hash=item5c9b6c09f3:g:D0YAAeSwcOdpvyPW	2026-03-22 10:02:48+11	2026-03-22 18:52:18.686518+11	2026-03-22 18:52:18.686521+11	\N	2026-03-22 18:52:18.686522+11	JP
20829	177	v1|397744540149|0	Lenovo ThinkPad X280 i5 8GB SSD256GB Windows 11 Used Japan Genuine	529.39	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540149?_skw=thinkpad&hash=item5c9b6c09f5:g:RzAAAeSwr1ZpvyRR	2026-03-22 10:02:48+11	2026-03-22 18:52:18.687327+11	2026-03-22 18:52:18.68733+11	\N	2026-03-22 18:52:18.687331+11	JP
20830	177	v1|397744540161|0	Lenovo ThinkPad L13 i3 10th Gen 8GB 128GB SSD Used Japan Genuine	371.19	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540161?_skw=thinkpad&hash=item5c9b6c0a01:g:VGYAAeSwbKlpvySO	2026-03-22 10:02:48+11	2026-03-22 18:52:18.688132+11	2026-03-22 18:52:18.688135+11	\N	2026-03-22 18:52:18.688136+11	JP
20831	177	v1|397744540176|0	Lenovo ThinkPad T430s Core i7-3520M 8GB SSD 500GB Used Japan Genuine	355.53	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540176?_skw=thinkpad&hash=item5c9b6c0a10:g:-i4AAeSw1pFpvyQS	2026-03-22 10:02:48+11	2026-03-22 18:52:18.68894+11	2026-03-22 18:52:18.688943+11	\N	2026-03-22 18:52:18.688944+11	JP
20832	177	v1|397744540177|0	Lenovo ThinkPad X13 Gen 2a Ryzen 3 PRO 5450U 16GB 256GB SSD Used Japan Genuine	718.91	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540177?_skw=thinkpad&hash=item5c9b6c0a11:g:kRUAAeSwUMZpvyQS	2026-03-22 10:02:48+11	2026-03-22 18:52:18.689867+11	2026-03-22 18:52:18.689871+11	\N	2026-03-22 18:52:18.689872+11	JP
20833	177	v1|397744540180|0	Lenovo ThinkPad E480 Laptop i5 8GB RAM 128GB SSD Windows 10 Genuine	375.89	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540180?_skw=thinkpad&hash=item5c9b6c0a14:g:UQkAAeSwdVJpvyS9	2026-03-22 10:02:48+11	2026-03-22 18:52:18.690692+11	2026-03-22 18:52:18.690695+11	\N	2026-03-22 18:52:18.690696+11	JP
20834	177	v1|397744540183|0	Lenovo ThinkPad T14 11th Gen i7 Used Japan Genuine	969.51	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540183?_skw=thinkpad&hash=item5c9b6c0a17:g:FckAAeSws~lpvyRR	2026-03-22 10:02:48+11	2026-03-22 18:52:18.691496+11	2026-03-22 18:52:18.691499+11	\N	2026-03-22 18:52:18.6915+11	JP
20835	177	v1|397744540189|0	Lenovo ThinkPad X250 i5-5300U 8GB RAM 128GB SSD + 32GB Used Japan Genuine	336.74	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540189?_skw=thinkpad&hash=item5c9b6c0a1d:g:jv4AAeSwZcNpvyTA	2026-03-22 10:02:48+11	2026-03-22 18:52:18.692305+11	2026-03-22 18:52:18.692307+11	\N	2026-03-22 18:52:18.692309+11	JP
20836	177	v1|397744540195|0	Lenovo ThinkPad E590 i5-8265U 8GB SSD256GB 15.6" HD Used Japan Genuine	566.98	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540195?_skw=thinkpad&hash=item5c9b6c0a23:g:4EMAAeSw17hpvyQg	2026-03-22 10:02:48+11	2026-03-22 18:52:18.693111+11	2026-03-22 18:52:18.693113+11	\N	2026-03-22 18:52:18.693114+11	JP
20837	177	v1|397744540206|0	Lenovo ThinkPad L15 Gen1 10th Gen Used Japan Genuine	557.58	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540206?_skw=thinkpad&hash=item5c9b6c0a2e:g:FA8AAeSws~lpvyQV	2026-03-22 10:02:48+11	2026-03-22 18:52:18.693908+11	2026-03-22 18:52:18.693912+11	\N	2026-03-22 18:52:18.693913+11	JP
20838	177	v1|397744540080|0	Lenovo ThinkPad T14s Gen1 i5-10310U 16GB RAM 256GB NVMe SSD Used Japan Genuine	701.68	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540080?_skw=thinkpad&hash=item5c9b6c09b0:g:TU8AAeSwJFBpvyRM	2026-03-22 10:02:47+11	2026-03-22 18:52:18.694708+11	2026-03-22 18:52:18.694711+11	\N	2026-03-22 18:52:18.694712+11	JP
20839	177	v1|397744540086|0	Lenovo ThinkPad E15 i5-10210U 15.6" Full HD Used Japan Genuine	374.33	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540086?_skw=thinkpad&hash=item5c9b6c09b6:g:VjUAAeSw7s5pvyRU	2026-03-22 10:02:47+11	2026-03-22 18:52:18.695505+11	2026-03-22 18:52:18.695508+11	\N	2026-03-22 18:52:18.695509+11	JP
20840	177	v1|397744540092|0	ThinkPad P1 Gen4 Xeon W-11855M 32GB 512GB RTX A2000 16" WQXGA Used Japan	1769.88	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540092?_skw=thinkpad&hash=item5c9b6c09bc:g:EocAAeSwH~dpvyRP	2026-03-22 10:02:47+11	2026-03-22 18:52:18.696311+11	2026-03-22 18:52:18.696314+11	\N	2026-03-22 18:52:18.696315+11	JP
20841	177	v1|397744540099|0	Lenovo ThinkPad L14 Gen3 Core i5-1245U 16GB 512GB SSD 14" Windows 11 Used Japan	1046.26	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540099?_skw=thinkpad&hash=item5c9b6c09c3:g:-BkAAeSwGMNpvyRY	2026-03-22 10:02:47+11	2026-03-22 18:52:18.697136+11	2026-03-22 18:52:18.697139+11	\N	2026-03-22 18:52:18.69714+11	JP
20842	177	v1|397744540101|0	Lenovo ThinkPad L13 Gen4 Core i5-1335U 16GB 512GB Win11 Used Japan Genuine	1351.26	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540101?_skw=thinkpad&hash=item5c9b6c09c5:g:YvgAAeSwP5NpvySG	2026-03-22 10:02:47+11	2026-03-22 18:52:18.69794+11	2026-03-22 18:52:18.697943+11	\N	2026-03-22 18:52:18.697944+11	JP
20843	177	v1|397744540102|0	Lenovo ThinkPad X1 Carbon Gen9 Core i5 2.6GHz 8GB SSD256GB 14" Wi-Fi6 Used	1057.94	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540102?_skw=thinkpad&hash=item5c9b6c09c6:g:VA8AAeSw9nRpvyTC	2026-03-22 10:02:47+11	2026-03-22 18:52:18.698743+11	2026-03-22 18:52:18.698745+11	\N	2026-03-22 18:52:18.698746+11	JP
20844	177	v1|397744540105|0	Lenovo ThinkPad L590 Core i5 8GB RAM SSD256GB Web Camera 15.6" Used Japan	447.94	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540105?_skw=thinkpad&hash=item5c9b6c09c9:g:WDwAAeSwWv5pvyRQ	2026-03-22 10:02:47+11	2026-03-22 18:52:18.69955+11	2026-03-22 18:52:18.699552+11	\N	2026-03-22 18:52:18.699553+11	JP
20845	177	v1|397744540106|0	Lenovo ThinkPad T14 Gen2 14" Laptop Core i5 11th Gen 16GB SSD Windows11 Used	969.51	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540106?_skw=thinkpad&hash=item5c9b6c09ca:g:jZ0AAeSw6zhpvyTG	2026-03-22 10:02:47+11	2026-03-22 18:52:18.700352+11	2026-03-22 18:52:18.700355+11	\N	2026-03-22 18:52:18.700356+11	JP
20846	177	v1|397744540112|0	Lenovo ThinkPad L13 Gen 2 Core i5-1145G7 RAM 16GB SSD 512GB Wi-Fi 6 Used Japan	1014.94	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540112?_skw=thinkpad&hash=item5c9b6c09d0:g:j4UAAeSwo3VpvyQU	2026-03-22 10:02:47+11	2026-03-22 18:52:18.701151+11	2026-03-22 18:52:18.701153+11	\N	2026-03-22 18:52:18.701154+11	JP
20847	177	v1|397744540113|0	Lenovo ThinkPad L13 Core i3 10110U 256GB SSD 4GB Bluetooth Used Japan Genuine	404.09	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540113?_skw=thinkpad&hash=item5c9b6c09d1:g:SxEAAeSwJqhpvyPZ	2026-03-22 10:02:47+11	2026-03-22 18:52:18.701957+11	2026-03-22 18:52:18.701959+11	\N	2026-03-22 18:52:18.70196+11	JP
20848	177	v1|397744540122|0	Lenovo ThinkPad L570 Laptop i5-6th Gen 8GB SSD Windows 11 Pro Used Japan	375.89	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540122?_skw=thinkpad&hash=item5c9b6c09da:g:kWoAAeSw4XJpvyPZ	2026-03-22 10:02:47+11	2026-03-22 18:52:18.70276+11	2026-03-22 18:52:18.702763+11	\N	2026-03-22 18:52:18.702764+11	JP
21053	177	v1|177976501588|0	Lenovo T14 Ryzen 7 Pro	567.70	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/177976501588?_skw=thinkpad&hash=item297039e554:g:5HsAAeSw95tpvSNR	2026-03-20 21:40:10+11	2026-03-22 18:52:18.879167+11	2026-03-22 18:52:18.879169+11	\N	2026-03-22 18:52:18.87917+11	GB
20849	177	v1|397744540139|0	Lenovo ThinkPad L13 GEN3 Core i5 1245U 16GB 256GB NVMe Used Japan Genuine	850.48	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540139?_skw=thinkpad&hash=item5c9b6c09eb:g:SzcAAeSwPZBpvyRP	2026-03-22 10:02:47+11	2026-03-22 18:52:18.703581+11	2026-03-22 18:52:18.703583+11	\N	2026-03-22 18:52:18.703585+11	JP
20850	177	v1|397744540144|0	Lenovo ThinkPad X280 i5 8GB SSD256GB Windows 11 Used Lightweight Compact Camera	529.39	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540144?_skw=thinkpad&hash=item5c9b6c09f0:g:SnUAAeSwNF1pvySO	2026-03-22 10:02:47+11	2026-03-22 18:52:18.704536+11	2026-03-22 18:52:18.704539+11	\N	2026-03-22 18:52:18.70454+11	JP
20851	177	v1|397744540153|0	Lenovo Thinkpad E14 Gen 2 11th Gen i5 NVMe 512GB Used Japan Genuine	830.12	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540153?_skw=thinkpad&hash=item5c9b6c09f9:g:XrsAAeSwHXlpvyS-	2026-03-22 10:02:47+11	2026-03-22 18:52:18.705542+11	2026-03-22 18:52:18.705546+11	\N	2026-03-22 18:52:18.705547+11	JP
20852	177	v1|397744540155|0	Lenovo ThinkPad L390 Laptop Black 8GB RAM 256GB SSD Used Japan Genuine	432.28	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540155?_skw=thinkpad&hash=item5c9b6c09fb:g:k1sAAeSwihRpvyTB	2026-03-22 10:02:47+11	2026-03-22 18:52:18.706443+11	2026-03-22 18:52:18.706445+11	\N	2026-03-22 18:52:18.706446+11	JP
20853	177	v1|397744540170|0	Lenovo ThinkPad X13 10th Gen i5 8GB RAM 256GB SSD Lightweight Used Japan	839.51	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397744540170?_skw=thinkpad&hash=item5c9b6c0a0a:g:-ZMAAeSwfg1pvyRQ	2026-03-22 10:02:47+11	2026-03-22 18:52:18.707255+11	2026-03-22 18:52:18.707257+11	\N	2026-03-22 18:52:18.707258+11	JP
20854	177	v1|168252336312|0	Lenovo Yoga C940-14iiL i5-1035G4 256GB SSD, 8GB Ram Windows 11	189.99	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/168252336312?_skw=thinkpad&hash=item272c9ee8b8:g:L0MAAeSwU0Zpvx2Q	2026-03-22 09:47:29+11	2026-03-22 18:52:18.708068+11	2026-03-22 18:52:18.70807+11	\N	2026-03-22 18:52:18.708071+11	US
20855	177	v1|327061377748|0	Lenovo Thinkpad P1 Gen 7 - 16" Intel Ultra 7-155H NVIDIA RTX 2000 32GB/1TB SSD	2191.23	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/327061377748?_skw=thinkpad&hash=item4c266092d4:g:4SYAAeSwLlxpvx99	2026-03-22 09:45:55+11	2026-03-22 18:52:18.708885+11	2026-03-22 18:52:18.708887+11	\N	2026-03-22 18:52:18.708889+11	US
20856	177	v1|188192739843|0	ThinkPad T420 Core i7-2640M 14"/ 16GB RAM/ 128GB SSD+500GB HDD/Win 11P/1600x900	374.34	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/188192739843?_skw=thinkpad&hash=item2bd1295203:g:FnkAAeSw7s5pvxqz	2026-03-22 09:44:56+11	2026-03-22 18:52:18.709688+11	2026-03-22 18:52:18.709691+11	\N	2026-03-22 18:52:18.709692+11	US
20857	177	v1|137155000309|0	Lenovo ThinkPad E14 Gen 2 I5 11th GEN 16GB 256GB SSD Black - Used	331.27	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/137155000309?_skw=thinkpad&hash=item1fef1337f5:g:UdYAAeSwYQdpvx4z	2026-03-22 09:43:49+11	2026-03-22 18:52:18.710515+11	2026-03-22 18:52:18.710518+11	\N	2026-03-22 18:52:18.710519+11	US
20858	177	v1|177980258926|0	IBM ThinkPad T43 14" 1.86ghz Pentium 1400x1050 ATI X300 Windows XP PRO LAPTOP	156.63	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/177980258926?_skw=thinkpad&hash=item2970733a6e:g:uroAAeSw3x1pvx3W	2026-03-22 09:42:30+11	2026-03-22 18:52:18.711312+11	2026-03-22 18:52:18.711314+11	\N	2026-03-22 18:52:18.711316+11	US
20859	177	v1|188192710030|0	Lenovo ThinkPad E15 G4 i5 12th Gen Laptop 16GB RAM 512GB SSD Windows 11	1378.88	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/188192710030?_skw=thinkpad&hash=item2bd128dd8e:g:t68AAeSwBkhpvx0y	2026-03-22 09:30:27+11	2026-03-22 18:52:18.712114+11	2026-03-22 18:52:18.712117+11	\N	2026-03-22 18:52:18.712118+11	KR
20860	177	v1|177980195034|0	Lenovo Thinkpad T490 i7-8565U 1.80GHz 16GB 256SSD Win 11 Pro	313.24	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/177980195034?_skw=thinkpad&hash=item29707240da:g:y8oAAeSwM29pveGf	2026-03-22 09:20:45+11	2026-03-22 18:52:18.712915+11	2026-03-22 18:52:18.712917+11	\N	2026-03-22 18:52:18.712919+11	US
20861	177	v1|287222769974|0	Lenovo ThinkPad X1 Carbon Gen 13 Aura 14" Ultra 7 32GB 512GB OLED Win11 Pro	2427.74	AUD	New	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/287222769974?_skw=thinkpad&hash=item42dfcfa936:g:AjYAAeSwKeRpvxO-	2026-03-22 09:17:31+11	2026-03-22 18:52:18.713713+11	2026-03-22 18:52:18.713716+11	\N	2026-03-22 18:52:18.713717+11	US
20862	177	v1|177980184657|0	Lenovo Thinkbook 15 i5-1035G1 1.00Ghz 8GB 256 SSD  Win 11 Pro	149.99	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/177980184657?_skw=thinkpad&hash=item2970721851:g:sBAAAeSwMWJpudIC	2026-03-22 09:13:33+11	2026-03-22 18:52:18.714511+11	2026-03-22 18:52:18.714514+11	\N	2026-03-22 18:52:18.714515+11	US
20863	177	v1|206156844593|0	Lenovo ThinkPad T14s Gen 1 i5 10th Gen Laptop with 16GB RAM 250GB SSD Windows 11	1117.80	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/206156844593?_skw=thinkpad&hash=item2fffe7ce31:g:KgEAAeSwrIBpvxfI	2026-03-22 09:10:23+11	2026-03-22 18:52:18.71531+11	2026-03-22 18:52:18.715313+11	\N	2026-03-22 18:52:18.715313+11	KR
20864	177	v1|188192646769|0	Lenovo ThinkPad T420 Core i5-2520M 14"/ 8GB RAM/ 120GB SSD/Win 11P/GRADE D+	139.40	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/188192646769?_skw=thinkpad&hash=item2bd127e671:g:3ccAAeSwV2Fpvw9l	2026-03-22 09:06:23+11	2026-03-22 18:52:18.716104+11	2026-03-22 18:52:18.716106+11	\N	2026-03-22 18:52:18.716107+11	US
20865	177	v1|188192646316|0	Lenovo Thinkpad T14 G1 Ryzen 5 PRO 4th Gen 4650U 512GB 16GB 1920 x 1080 (FHD)	910.72	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192646316?_skw=thinkpad&hash=item2bd127e4ac:g:~2gAAeSw-Qxpvxd3	2026-03-22 09:06:00+11	2026-03-22 18:52:18.716897+11	2026-03-22 18:52:18.7169+11	\N	2026-03-22 18:52:18.716901+11	DE
20866	177	v1|188192644676|0	Lenovo Chromebook Duet 11M889 Kompanio 838 131GB 8GB 1920 x 1200 11.0" inch	697.02	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192644676?_skw=thinkpad&hash=item2bd127de44:g:GH4AAeSwOp1pvxbZ	2026-03-22 09:04:23+11	2026-03-22 18:52:18.71772+11	2026-03-22 18:52:18.717723+11	\N	2026-03-22 18:52:18.717724+11	DE
20867	177	v1|188192644250|0	Lenovo ThinkPad L13 Yoga Gen 4 Ryzen 5 7530U 512GB 16GB 1920 x 1200 13.0" inch	1197.00	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192644250?_skw=thinkpad&hash=item2bd127dc9a:g:Lq0AAeSwxnBpvwMN	2026-03-22 09:04:03+11	2026-03-22 18:52:18.718519+11	2026-03-22 18:52:18.718522+11	\N	2026-03-22 18:52:18.718523+11	DE
20868	177	v1|188192644254|0	Lenovo IdeaPad 5 2-in-1 16IRU9 Core 5 120U 512GB 8GB 1920 x 1200 16.0" inch	896.78	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192644254?_skw=thinkpad&hash=item2bd127dc9e:g:oCkAAeSwDXtpvxaL	2026-03-22 09:04:03+11	2026-03-22 18:52:18.719319+11	2026-03-22 18:52:18.719322+11	\N	2026-03-22 18:52:18.719323+11	DE
20869	177	v1|188192644076|0	Lenovo IdeaPad Slim 3 14IRU8 Core i7 1355U 512GB 16GB 1920 x 1080 14.0" inch	844.15	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192644076?_skw=thinkpad&hash=item2bd127dbec:g:-I4AAeSw9-9pvxcs	2026-03-22 09:03:54+11	2026-03-22 18:52:18.720115+11	2026-03-22 18:52:18.720118+11	\N	2026-03-22 18:52:18.720119+11	DE
20870	177	v1|188192644031|0	Lenovo ThinkPad P14s G4 Ryzen 7 Pro 7840U Radeon 780M 512GB 16GB	1634.76	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192644031?_skw=thinkpad&hash=item2bd127dbbf:g:JuIAAeSwDz9pvxZ~	2026-03-22 09:03:52+11	2026-03-22 18:52:18.720931+11	2026-03-22 18:52:18.720934+11	\N	2026-03-22 18:52:18.720936+11	DE
20871	177	v1|188192643977|0	Lenovo ThinkPad P16 Gen 2 Core i7 13th Gen 13850HX RTX 3500 Ada 1TB 32GB	3986.59	USD	New	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192643977?_skw=thinkpad&hash=item2bd127db89:g:9mQAAeSwEvxpvxb0	2026-03-22 09:03:49+11	2026-03-22 18:52:18.721806+11	2026-03-22 18:52:18.721809+11	\N	2026-03-22 18:52:18.72181+11	DE
20872	177	v1|188192643968|0	Lenovo ThinkPad P16 G1 Core i9 12th Gen i9-12950HX 1TB 16GB 3840 x 2400 WQUXGA	2246.82	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192643968?_skw=thinkpad&hash=item2bd127db80:g:CsYAAeSwGkFpvxa3	2026-03-22 09:03:48+11	2026-03-22 18:52:18.722612+11	2026-03-22 18:52:18.722615+11	\N	2026-03-22 18:52:18.722616+11	DE
20873	177	v1|188192643654|0	Lenovo ThinkPad L16 Gen 1 Ryzen 5 Pro 7535U Radeon 660M 512GB 16GB 1920 x 1200	1557.50	USD	New	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192643654?_skw=thinkpad&hash=item2bd127da46:g:BbQAAeSwGkFpvxX4	2026-03-22 09:03:33+11	2026-03-22 18:52:18.723405+11	2026-03-22 18:52:18.723408+11	\N	2026-03-22 18:52:18.723409+11	DE
20874	177	v1|188192643608|0	Lenovo ThinkPad L16 Gen 1 Ryzen 5 Pro 7535U AMD Radeon 660M 512GB 16GB	1557.50	USD	New	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192643608?_skw=thinkpad&hash=item2bd127da18:g:AboAAeSwtgZpvxYv	2026-03-22 09:03:29+11	2026-03-22 18:52:18.72422+11	2026-03-22 18:52:18.724223+11	\N	2026-03-22 18:52:18.724224+11	DE
20875	177	v1|188192643580|0	Lenovo ThinkPad X1 Yoga G6 Core i7 11th Gen 1185G7 512GB 32GB 1920 x 1200	1193.85	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192643580?_skw=thinkpad&hash=item2bd127d9fc:g:L6MAAeSwH8RpvxYw	2026-03-22 09:03:27+11	2026-03-22 18:52:18.725019+11	2026-03-22 18:52:18.725021+11	\N	2026-03-22 18:52:18.725022+11	DE
20876	177	v1|188192643492|0	Lenovo Thinkpad T14 G2 Core i7 11th Gen 1185G7 256GB 16GB 1920 x 1080 14.0" inch	1051.53	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192643492?_skw=thinkpad&hash=item2bd127d9a4:g:-hIAAeSw2FppvxYn	2026-03-22 09:03:23+11	2026-03-22 18:52:18.725978+11	2026-03-22 18:52:18.725981+11	\N	2026-03-22 18:52:18.725983+11	DE
20877	177	v1|188192643148|0	Lenovo ThinkPad T16 Gen 4 Core Ultra 5 225U 512GB 16GB 1920 x 1200 16.0" inch	2201.83	USD	New	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192643148?_skw=thinkpad&hash=item2bd127d84c:g:vboAAeSwQBFpvxbJ	2026-03-22 09:03:06+11	2026-03-22 18:52:18.726816+11	2026-03-22 18:52:18.726819+11	\N	2026-03-22 18:52:18.72682+11	DE
20878	177	v1|188192642586|0	Lenovo ThinkPad T14 G1 Ryzen 5 Pro 4650U Radeon Graphics 512GB 16GB 1920 x 1080	812.10	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192642586?_skw=thinkpad&hash=item2bd127d61a:g:87AAAeSwNF1pvxZr	2026-03-22 09:02:34+11	2026-03-22 18:52:18.727621+11	2026-03-22 18:52:18.727624+11	\N	2026-03-22 18:52:18.727625+11	DE
20879	177	v1|188192642357|0	Lenovo Thinkpad T14 G1 Ryzen 7 Pro 4750U 512GB 32GB 1920 x 1080 14.0" inch	906.08	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192642357?_skw=thinkpad&hash=item2bd127d535:g:HdAAAeSw95tpvxZc	2026-03-22 09:02:23+11	2026-03-22 18:52:18.728427+11	2026-03-22 18:52:18.72843+11	\N	2026-03-22 18:52:18.728431+11	DE
20880	177	v1|206156827418|0	Lenovo ThinkPad T14 Gen 3 i5-1250P CPU|16GB DDR4|256GB W/AC	569.52	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/206156827418?_skw=thinkpad&hash=item2fffe78b1a:g:9U4AAeSw5JVpvxYV	2026-03-22 09:02:08+11	2026-03-22 18:52:18.729214+11	2026-03-22 18:52:18.729217+11	\N	2026-03-22 18:52:18.729218+11	CA
20881	177	v1|358359393624|0	Lenovo ThinkPad 14" E14 G2 i5-1135G7 8GB 256GB NVMe Windows 11 Pro Screen issue	217.71	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/358359393624?_skw=thinkpad&hash=item536fe26558:g:yPAAAeSwQQ9pvw9Z	2026-03-22 09:01:56+11	2026-03-22 18:52:18.730015+11	2026-03-22 18:52:18.730018+11	\N	2026-03-22 18:52:18.730019+11	US
20882	177	v1|188192638675|0	Lenovo Thinkpad T14 G1 Core i5 10th Gen 10210U 262GB 16GB 1920 x 1080 14.0" inch	926.18	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192638675?_skw=thinkpad&hash=item2bd127c6d3:g:j-QAAeSw6YtpvxX1	2026-03-22 09:00:38+11	2026-03-22 18:52:18.7308+11	2026-03-22 18:52:18.730802+11	\N	2026-03-22 18:52:18.730803+11	DE
20883	177	v1|188192638350|0	Lenovo Thinkpad T14 G1 Core i5 10th Gen i5-10310U 262GB 16GB 1920 x 1080 (FHD)	864.25	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192638350?_skw=thinkpad&hash=item2bd127c58e:g:BfcAAeSwGVBpvxXq	2026-03-22 09:00:30+11	2026-03-22 18:52:18.731617+11	2026-03-22 18:52:18.73162+11	\N	2026-03-22 18:52:18.731621+11	DE
20884	177	v1|168252254155|0	Lenovo Yoga Slim 7i Aura Edition 14" Laptop 2025	760.00	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/168252254155?_skw=thinkpad&hash=item272c9da7cb:g:YcgAAeSwHVhpvw2d	2026-03-22 09:00:26+11	2026-03-22 18:52:18.732421+11	2026-03-22 18:52:18.732424+11	\N	2026-03-22 18:52:18.732425+11	US
20885	177	v1|188192638232|0	Lenovo ThinkPad T14 G1 Ryzen 5 PRO 4650U 262GB 16GB 1920 x 1080 (FHD) 14.0" inch	760.98	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192638232?_skw=thinkpad&hash=item2bd127c518:g:tOwAAeSweElpvxXy	2026-03-22 09:00:26+11	2026-03-22 18:52:18.733215+11	2026-03-22 18:52:18.733218+11	\N	2026-03-22 18:52:18.733219+11	DE
20886	177	v1|188192638219|0	Lenovo Thinkpad T14 G2 Core i5 value not present 1145G7 256GB 16GB 1920 x 1080	926.18	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192638219?_skw=thinkpad&hash=item2bd127c50b:g:xW0AAeSwUrVpvxWz	2026-03-22 09:00:25+11	2026-03-22 18:52:18.734011+11	2026-03-22 18:52:18.734013+11	\N	2026-03-22 18:52:18.734014+11	DE
20887	177	v1|188192638180|0	Lenovo ThinkPad X1 Carbon G9 Core i7 11th Gen i7-1165G7 512GB 16GB	1101.03	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192638180?_skw=thinkpad&hash=item2bd127c4e4:g:NPgAAeSwfyxpvxXr	2026-03-22 09:00:23+11	2026-03-22 18:52:18.734809+11	2026-03-22 18:52:18.734812+11	\N	2026-03-22 18:52:18.734813+11	DE
20888	177	v1|188192638039|0	Lenovo Thinkpad T14 G1 Core i5 10th Gen i5-10310U 262GB 24GB 1920 x 1080 (FHD)	663.03	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192638039?_skw=thinkpad&hash=item2bd127c457:g:6UcAAeSwdLdpvxWm	2026-03-22 09:00:16+11	2026-03-22 18:52:18.735606+11	2026-03-22 18:52:18.735608+11	\N	2026-03-22 18:52:18.73561+11	DE
20889	177	v1|188192638032|0	Lenovo ThinkPad T14 G1 Core i5 10th Gen i5-10210U 512GB 16GB 1920 x 1080 (FHD)	885.98	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192638032?_skw=thinkpad&hash=item2bd127c450:g:FTwAAeSwkk9pvxXi	2026-03-22 09:00:15+11	2026-03-22 18:52:18.736398+11	2026-03-22 18:52:18.736401+11	\N	2026-03-22 18:52:18.736402+11	DE
20890	177	v1|188192637723|0	Lenovo Thinkpad T15 G1 Core i5 10th Gen i5-10210U 262GB 16GB 1920 x 1080 (FHD)	1071.63	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192637723?_skw=thinkpad&hash=item2bd127c31b:g:-1QAAeSwAu9pvxYM	2026-03-22 08:59:59+11	2026-03-22 18:52:18.738834+11	2026-03-22 18:52:18.738839+11	\N	2026-03-22 18:52:18.738841+11	DE
20891	177	v1|188192637675|0	Lenovo Thinkpad T14 G1 Core i5 10th Gen i5-10310U 262GB 16GB 1920 x 1080 (FHD)	663.03	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192637675?_skw=thinkpad&hash=item2bd127c2eb:g:vd8AAeSwcoBpvxXO	2026-03-22 08:59:58+11	2026-03-22 18:52:18.739949+11	2026-03-22 18:52:18.739953+11	\N	2026-03-22 18:52:18.739954+11	DE
20892	177	v1|188192637558|0	Lenovo Thinkpad T15 G1 Core i5 10th Gen i5-10310U 262GB 8GB 1920 x 1080 (FHD)	799.21	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192637558?_skw=thinkpad&hash=item2bd127c276:g:63gAAeSwQiVpvxXL	2026-03-22 08:59:51+11	2026-03-22 18:52:18.740796+11	2026-03-22 18:52:18.740799+11	\N	2026-03-22 18:52:18.740801+11	DE
20893	177	v1|188192637497|0	Lenovo ThinkPad T14 G1 Core i5 10th Gen i5-10210U 262GB 16GB 1920 x 1080 (FHD)	663.03	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192637497?_skw=thinkpad&hash=item2bd127c239:g:~wQAAeSw5wdpvxYA	2026-03-22 08:59:46+11	2026-03-22 18:52:18.741617+11	2026-03-22 18:52:18.74162+11	\N	2026-03-22 18:52:18.741621+11	DE
20894	177	v1|188192637329|0	Lenovo Chromebook Duet 11M889 Kompanio 838 131GB 8GB 1920 x 1200 11.0" inch	697.02	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192637329?_skw=thinkpad&hash=item2bd127c191:g:8KwAAeSwPZBpvxV7	2026-03-22 08:59:33+11	2026-03-22 18:52:18.742437+11	2026-03-22 18:52:18.74244+11	\N	2026-03-22 18:52:18.742441+11	DE
20895	177	v1|188192637260|0	Lenovo ThinkPad L13 Yoga Gen 2 Core i5 11th Gen 1135G7 262GB 8GB 1920 x 1080	864.25	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192637260?_skw=thinkpad&hash=item2bd127c14c:g:n4sAAeSwfg1pvxXx	2026-03-22 08:59:28+11	2026-03-22 18:52:18.74325+11	2026-03-22 18:52:18.743252+11	\N	2026-03-22 18:52:18.743253+11	DE
20896	177	v1|366294054053|0	Lot of 8 LENOVO THINKPAD T560 Intel Core i5 6th Gen 2.40 GHZ + 4 GB/8GB | No HD	560.00	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/366294054053?_skw=thinkpad&hash=item5548d3b4a5:g:59gAAeSwV2FpvxD7	2026-03-22 08:57:05+11	2026-03-22 18:52:18.744059+11	2026-03-22 18:52:18.744062+11	\N	2026-03-22 18:52:18.744063+11	US
20897	177	v1|366294050070|0	Lenovo ThinkPad X1 Carbon 12th Gen Laptop – Intel Core Ultra 7, 32GB RAM, 512GB	1300.00	USD	Used	FIXED_PRICE,AUCTION	EBAY_US	https://www.ebay.com/itm/366294050070?_skw=thinkpad&hash=item5548d3a516:g:Db8AAeSwo3Vpvci9	2026-03-22 08:53:49+11	2026-03-22 18:52:18.744868+11	2026-03-22 18:52:18.744871+11	\N	2026-03-22 18:52:18.744872+11	US
20898	177	v1|306835407914|0	Lenovo Gaming Laptop Y40-80 (14.0" FHD-Intel Core i7 5500U-8GB RAM- 512GB SSD)	135.00	USD	Used	FIXED_PRICE,AUCTION	EBAY_US	https://www.ebay.com/itm/306835407914?_skw=thinkpad&hash=item4770d0c42a:g:4tMAAeSwpAtpvxID	2026-03-22 08:48:49+11	2026-03-22 18:52:18.74568+11	2026-03-22 18:52:18.745682+11	\N	2026-03-22 18:52:18.745683+11	US
20899	177	v1|327061308252|0	Lenovo ThinkPad T460s i7 12GB QHD + Ultra Dock 40A2 & Charger Bundle	269.99	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/327061308252?_skw=thinkpad&hash=item4c265f835c:g:iB0AAeSwIRVpvxD-	2026-03-22 08:46:28+11	2026-03-22 18:52:18.746504+11	2026-03-22 18:52:18.746507+11	\N	2026-03-22 18:52:18.746508+11	US
20900	177	v1|127762208297|0	Lenovo - 21KS0027US - Lenovo ThinkPad P16s Gen 3 21KS0027US 16 Mobile	3155.49	USD	New	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/127762208297?_skw=thinkpad&hash=item1dbf389629:g:sJIAAeSwUrVpvxGU	2026-03-22 08:41:52+11	2026-03-22 18:52:18.747306+11	2026-03-22 18:52:18.747309+11	\N	2026-03-22 18:52:18.74731+11	US
20901	177	v1|127762207389|0	Lenovo - 21RS0024US - P16v G3 4.50 GHz W11P64 32.0GB 1TB G5Perf 16 - ThinkPad	5100.03	USD	New	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/127762207389?_skw=thinkpad&hash=item1dbf38929d:g:49QAAeSww8ppvxED	2026-03-22 08:41:29+11	2026-03-22 18:52:18.748104+11	2026-03-22 18:52:18.748107+11	\N	2026-03-22 18:52:18.748108+11	US
20902	177	v1|188192577595|0	Lenovo Thinkpad T14s G2 Core i5 11th Gen i5-1135G7 262GB 16GB 1920 x 1080 (FHD)	926.18	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192577595?_skw=thinkpad&hash=item2bd126d83b:g:BnwAAeSwK6Vpvw57	2026-03-22 08:31:39+11	2026-03-22 18:52:18.749061+11	2026-03-22 18:52:18.749065+11	\N	2026-03-22 18:52:18.749066+11	DE
20903	177	v1|188192577275|0	Lenovo Thinkpad T14s G2 Ryzen 7 Pro 5850U 512GB 16GB 1920 x 1080 (FHD)	961.84	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192577275?_skw=thinkpad&hash=item2bd126d6fb:g:xY0AAeSw3YRpvw8o	2026-03-22 08:31:32+11	2026-03-22 18:52:18.74989+11	2026-03-22 18:52:18.749893+11	\N	2026-03-22 18:52:18.749894+11	DE
20904	177	v1|188192576972|0	Lenovo ThinkPad T14 G1 Core i5 10th Gen i5-10210U 262GB 24GB 1920 x 1080 (FHD)	663.03	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192576972?_skw=thinkpad&hash=item2bd126d5cc:g:2MQAAeSw5wdpvw7i	2026-03-22 08:31:25+11	2026-03-22 18:52:18.75069+11	2026-03-22 18:52:18.750693+11	\N	2026-03-22 18:52:18.750695+11	DE
20905	177	v1|287222689703|0	Legion S7-15ACH6 Laptop (Lenovo) - Type 82K8 - HIGH SPEC GAMING LAPTOP	650.00	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/287222689703?_skw=thinkpad&hash=item42dfce6fa7:g:nVMAAeSwGSRpsG31	2026-03-22 08:23:42+11	2026-03-22 18:52:18.7515+11	2026-03-22 18:52:18.751503+11	\N	2026-03-22 18:52:18.751504+11	US
20906	177	v1|336493662601|0	Lenovo ThinkPad 11e Yoga Gen 6 Laptop Intel Core m3 11" Black Touch Win Edu	100.00	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/336493662601?_skw=thinkpad&hash=item4e5895d189:g:kyMAAeSweFppvwf7	2026-03-22 08:09:31+11	2026-03-22 18:52:18.752295+11	2026-03-22 18:52:18.752298+11	\N	2026-03-22 18:52:18.752299+11	US
20907	177	v1|389779930821|0	Vintage IBM ThinkPad T43 Laptop Win XP	140.97	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/389779930821?_skw=thinkpad&hash=item5ac0b1bec5:g:dQ0AAeSw2SVpvv6y	2026-03-22 08:00:02+11	2026-03-22 18:52:18.753567+11	2026-03-22 18:52:18.753571+11	\N	2026-03-22 18:52:18.753572+11	US
20908	177	v1|277823239569|0	ThinkPad T14 Gen 3 Ryzen 5 Pro 6650U|16GB DDR5|256GB NVME W/AC	467.96	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/277823239569?_skw=thinkpad&hash=item40af8e3591:g:pgcAAeSwTGBpvwbh	2026-03-22 07:57:15+11	2026-03-22 18:52:18.754561+11	2026-03-22 18:52:18.754564+11	\N	2026-03-22 18:52:18.754565+11	CA
20909	177	v1|358359276054|0	(LOT of 2) Lenovo ThinkPad T14 Gen2 i5-1135G7 16GB RAM 512GB SSD Windows 11 Pro	750.25	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/358359276054?_skw=thinkpad&hash=item536fe09a16:g:VHQAAeSwiAFpvwWc	2026-03-22 07:56:45+11	2026-03-22 18:52:18.75546+11	2026-03-22 18:52:18.755463+11	\N	2026-03-22 18:52:18.755464+11	US
20910	177	v1|277823236648|0	Lenovo ThinkPad P16 Gen 2 --- i7-13850HX / 64GB Ram / 512GB SSD / RTX 2000 Ada	2661.11	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/277823236648?_skw=thinkpad&hash=item40af8e2a28:g:ybgAAeSw4XJpvwQF	2026-03-22 07:52:08+11	2026-03-22 18:52:18.756354+11	2026-03-22 18:52:18.756358+11	\N	2026-03-22 18:52:18.756359+11	US
20911	177	v1|397744188051|0	Lenovo Thingkpad T480 Intel Core i5-8250U 8GB Ram 256GB SSD Windows 11 Pro	170.99	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/397744188051?_skw=thinkpad&hash=item5c9b66aa93:g:GqAAAeSwuAxpvwCA	2026-03-22 07:49:04+11	2026-03-22 18:52:18.757276+11	2026-03-22 18:52:18.75728+11	\N	2026-03-22 18:52:18.757281+11	US
20912	177	v1|198212673286|0	Lenovo IdeaPad S340-81N8 i3 8145U 8GB RAM 128GB SSD	175.00	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/198212673286?_skw=thinkpad&hash=item2e26655f06:g:h5EAAeSwPZBpvwNF	2026-03-22 07:48:44+11	2026-03-22 18:52:18.75829+11	2026-03-22 18:52:18.758293+11	\N	2026-03-22 18:52:18.758294+11	US
20913	177	v1|117100431690|0	Lenovo ThinkPad P15v Gen 2 i9-11950H 32GB 500GB W11 RTX A2000 UHD 12 Cycle Count	1644.60	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/117100431690?_skw=thinkpad&hash=item1b43bac94a:g:gKcAAeSwOyxpvwE8	2026-03-22 07:47:18+11	2026-03-22 18:52:18.75914+11	2026-03-22 18:52:18.759143+11	\N	2026-03-22 18:52:18.759144+11	US
20914	177	v1|188192435834|0	Lenovo IdeaPad Slim 5 16IRU9 16" Touch (1TB SSD, Intel Core 7 150u 16 gb Bb	469.88	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/188192435834?_skw=thinkpad&hash=item2bd124ae7a:g:HgYAAeSw17hpvwIg	2026-03-22 07:40:51+11	2026-03-22 18:52:18.759957+11	2026-03-22 18:52:18.75996+11	\N	2026-03-22 18:52:18.759961+11	US
20915	177	v1|227267077932|0	Lenovo P43S 14” laptop i7-8665U 32GB memory 512GB nvme SSD 4k display	299.99	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/227267077932?_skw=thinkpad&hash=item34ea2c672c:g:et8AAeSwuMNpvwFK	2026-03-22 07:40:51+11	2026-03-22 18:52:18.760762+11	2026-03-22 18:52:18.760765+11	\N	2026-03-22 18:52:18.760766+11	US
20916	177	v1|306835346994|0	Lenovo ThinkPad P53s 15.6" i7-8565U 8GB RAM 512GB SSD Nvidia GPU |Windows 11 Pro	249.00	USD	Used	FIXED_PRICE,BEST_OFFER	EBAY_US	https://www.ebay.com/itm/306835346994?_skw=thinkpad&hash=item4770cfd632:g:frgAAeSwNQlpvwGB	2026-03-22 07:40:48+11	2026-03-22 18:52:18.76159+11	2026-03-22 18:52:18.761593+11	\N	2026-03-22 18:52:18.761594+11	US
20917	177	v1|198212651340|0	Lenovo ThinkPad E15 Gen 2 20TD-003KUS 15.6" i5-1135G7 2.4GHz 8GB RAM 256GB SSD	313.24	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/198212651340?_skw=thinkpad&hash=item2e2665094c:g:ihMAAeSw8M1pvwGS	2026-03-22 07:37:49+11	2026-03-22 18:52:18.762394+11	2026-03-22 18:52:18.762397+11	\N	2026-03-22 18:52:18.762398+11	US
20918	177	v1|227267074635|0	Lenovo T440P 14” laptop 16GB memory 1tb SSD i7-4810MQ FHD 1080P display	249.99	USD	Used	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/227267074635?_skw=thinkpad&hash=item34ea2c5a4b:g:ohAAAeSw5m5pvv7n	2026-03-22 07:35:31+11	2026-03-22 18:52:18.763191+11	2026-03-22 18:52:18.763194+11	\N	2026-03-22 18:52:18.763195+11	US
20919	177	v1|188192425233|0	Lenovo ThinkPad X1 Yoga Gen 10 G10 Core Ultra 7 258V 1TB 32GB 2880x1800	2254.97	USD	Open box	FIXED_PRICE	EBAY_US	https://www.ebay.com/itm/188192425233?_skw=thinkpad&hash=item2bd1248511:g:u0EAAeSwUMZpvwGM	2026-03-22 07:33:40+11	2026-03-22 18:52:18.76399+11	2026-03-22 18:52:18.763993+11	\N	2026-03-22 18:52:18.763994+11	DE
20920	177	v1|147217120113|0	Lenovo THINKPAD T490s Core i5-8365U 8GB 256GB SSD 14″ FHD Windows 11 Pro	227.87	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/147217120113?_skw=thinkpad&hash=item2246d2fb71:g:wdsAAeSwmWFpvwvC	2026-03-22 15:26:38+11	2026-03-22 18:52:18.764791+11	2026-03-22 18:52:18.764794+11	\N	2026-03-22 18:52:18.764795+11	DE
20921	177	v1|206157479179|0	Lenovo THINKPAD L13 Core i5-10310U 13,3 " FHD, 8GB RAM,256GB SSD,Windows 11	241.35	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/206157479179?_skw=thinkpad&hash=item2ffff17d0b:g:wGcAAeSwuMNpvw0L	2026-03-22 15:09:22+11	2026-03-22 18:52:18.765599+11	2026-03-22 18:52:18.765602+11	\N	2026-03-22 18:52:18.765603+11	DE
20922	177	v1|127762725580|0	Lenovo THINKPAD P15 Generation 1 Core i7-10750H 32GB 512GB SSD T2000 Win11 Pro	635.83	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/127762725580?_skw=thinkpad&hash=item1dbf407acc:g:kUkAAeSwG~Rpvw0M	2026-03-22 15:08:15+11	2026-03-22 18:52:18.766394+11	2026-03-22 18:52:18.766397+11	\N	2026-03-22 18:52:18.766398+11	DE
20923	177	v1|318041167959|0	Lenovo ThinkPad X1 Carbon Gen 10 i5 8GB 256GB SSD 14" Laptop Used	436.54	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/318041167959?_skw=thinkpad&hash=item4a0cbb1857:g:0ygAAeSwkoppv2Fs	2026-03-22 14:25:28+11	2026-03-22 18:52:18.767185+11	2026-03-22 18:52:18.767188+11	\N	2026-03-22 18:52:18.767189+11	JP
20924	177	v1|168252383038|0	Lenovo ThinkPad L13 Yoga Gen 2 13.3" 2n1 Laptop Core i5-1135G7 16GB 256GB Win 11	208.70	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/168252383038?_skw=thinkpad&hash=item272c9f9f3e:g:klEAAeSwKyRpvyQZ	2026-03-22 10:16:06+11	2026-03-22 18:52:18.768002+11	2026-03-22 18:52:18.768004+11	\N	2026-03-22 18:52:18.768005+11	GB
20925	177	v1|336493791529|0	Lenovo ThinkPad T440 I5-4300U	73.50	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/336493791529?_skw=thinkpad&hash=item4e5897c929:g:2VcAAeSwIRVpvx9j	2026-03-22 09:46:43+11	2026-03-22 18:52:18.769206+11	2026-03-22 18:52:18.769211+11	\N	2026-03-22 18:52:18.769212+11	GB
20926	177	v1|267615894517|0	Lenovo Thinkpad X1 Yoga -used 2019 Made	312.70	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/267615894517?_skw=thinkpad&hash=item3e4f267bf5:g:5j4AAeSwFWxpvw4e	2026-03-22 08:41:29+11	2026-03-22 18:52:18.770305+11	2026-03-22 18:52:18.77031+11	\N	2026-03-22 18:52:18.770311+11	GB
20927	177	v1|147216520949|0	Lenovo THINKPAD T480s Core i5-1, 7GHz 8GB 256GB 14 " FHD 1920x1080 Wind11	192.90	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/147216520949?_skw=thinkpad&hash=item2246c9d6f5:g:hiEAAeSw8kRpvwVr	2026-03-22 08:19:13+11	2026-03-22 18:52:18.771214+11	2026-03-22 18:52:18.771217+11	\N	2026-03-22 18:52:18.771218+11	DE
20928	177	v1|147216520952|0	Lenovo THINKPAD T480s Core i5-8350U 8GB 256GB 14 " FHD Touch Windows 11	220.69	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/147216520952?_skw=thinkpad&hash=item2246c9d6f8:g:jz4AAeSwJFBpvwa2	2026-03-22 08:19:13+11	2026-03-22 18:52:18.772295+11	2026-03-22 18:52:18.772298+11	\N	2026-03-22 18:52:18.772299+11	DE
20929	177	v1|127762163288|0	Lenovo THINKPAD T480s Core i5-8350U 8GB 256GB 14 " FHD 1920x1080 Windows 11	218.03	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/127762163288?_skw=thinkpad&hash=item1dbf37e658:g:ugcAAeSwLf5pvwV0	2026-03-22 07:59:20+11	2026-03-22 18:52:18.77314+11	2026-03-22 18:52:18.773143+11	\N	2026-03-22 18:52:18.773144+11	DE
20930	177	v1|206156718657|0	Lenovo THINKPAD T480s Core i5-8350U 8GB RAM 256GB SSD 14 " FHD Touch Windows 11	219.83	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/206156718657?_skw=thinkpad&hash=item2fffe5e241:g:gqIAAeSwQiVpvwQo	2026-03-22 07:59:16+11	2026-03-22 18:52:18.77395+11	2026-03-22 18:52:18.773953+11	\N	2026-03-22 18:52:18.773954+11	DE
20931	177	v1|127762160729|0	Lenovo THINKPAD L13 Core i5-10110U-2100 13,3 " FHD 4GB RAM 128GB SSD Windows 11	199.21	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/127762160729?_skw=thinkpad&hash=item1dbf37dc59:g:FhgAAeSw6IJpsA9l	2026-03-22 07:57:44+11	2026-03-22 18:52:18.774749+11	2026-03-22 18:52:18.774752+11	\N	2026-03-22 18:52:18.774753+11	DE
20932	177	v1|127762154576|0	ThinkPad T495 8GB 256GB FHD Windows 11 Pro - Great condition	161.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/127762154576?_skw=thinkpad&hash=item1dbf37c450:g:iD4AAeSwzOtpvwSb	2026-03-22 07:51:49+11	2026-03-22 18:52:18.775547+11	2026-03-22 18:52:18.775549+11	\N	2026-03-22 18:52:18.775551+11	GB
20933	177	v1|188192452623|0	Lenovo Thinkpad T430 Laptop	58.94	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/188192452623?_skw=thinkpad&hash=item2bd124f00f:g:Q4MAAeSwo71pvv8b	2026-03-22 07:47:59+11	2026-03-22 18:52:18.77637+11	2026-03-22 18:52:18.776373+11	\N	2026-03-22 18:52:18.776374+11	GB
20934	177	v1|277823188758|0	LENOVO THINKPAD T61 14" LAPTOP MX LINUX CORE2 DUO 3GB 250GB CHARGER CHEAP #2	49.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/277823188758?_skw=thinkpad&hash=item40af8d6f16:g:F5UAAeSw-BZpvQsg	2026-03-22 07:27:18+11	2026-03-22 18:52:18.777171+11	2026-03-22 18:52:18.777173+11	\N	2026-03-22 18:52:18.777174+11	GB
20935	177	v1|377047760667|0	Lenovo ThinkPad X1 Yoga G7 i5 16GB Ram 256GB SSD 2-in-1 Win 11 Pro Battery 100%	349.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/377047760667?_skw=thinkpad&hash=item57c9cc3f1b:g:AwQAAeSwARJpvFPl	2026-03-22 07:00:01+11	2026-03-22 18:52:18.777974+11	2026-03-22 18:52:18.777977+11	\N	2026-03-22 18:52:18.777978+11	GB
20936	177	v1|358359092999|0	Lenovo ThinkPad P1 Gen6, i9-13900H 32GB RAM 1TB SSD QHD+165Hz RTX™ 4090	2556.70	GBP	Opened – never used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/358359092999?_skw=thinkpad&hash=item536fddcf07:g:5KIAAeSwqGNpvFke	2026-03-22 06:18:48+11	2026-03-22 18:52:18.778774+11	2026-03-22 18:52:18.778777+11	\N	2026-03-22 18:52:18.778778+11	GB
20937	177	v1|127761971196|0	Lenovo ThinkPad P1 Gen 5 / 64GB RAM / RTX A4500 / 1.8TB SSD / i7-12800H	1689.70	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/127761971196?_skw=thinkpad&hash=item1dbf34f7fc:g:v8cAAeSwW9tpvt~P	2026-03-22 05:23:59+11	2026-03-22 18:52:18.779586+11	2026-03-22 18:52:18.779588+11	\N	2026-03-22 18:52:18.77959+11	GB
20938	177	v1|336493407479|0	Lenovo THINKPAD X240 Laptop Intel i5 4200U 1.60ghz 4gb Win 10 Pro + Charger	113.98	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/336493407479?_skw=thinkpad&hash=item4e5891ecf7:g:RRUAAeSwnVlpvtuc	2026-03-22 04:55:59+11	2026-03-22 18:52:18.780396+11	2026-03-22 18:52:18.780399+11	\N	2026-03-22 18:52:18.7804+11	GB
20939	177	v1|318039460078|0	Lenovo ThinkPad X13s Snapdragon 3 Processor 16Gb Ram 256Gb SSD 5G	1044.79	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/318039460078?_skw=thinkpad&hash=item4a0ca108ee:g:6cwAAeSwWD5pvtYf	2026-03-22 04:32:35+11	2026-03-22 18:52:18.781196+11	2026-03-22 18:52:18.781199+11	\N	2026-03-22 18:52:18.7812+11	GB
20940	177	v1|177979646279|0	Lenovo ThinkPad X13 Gen 1 Laptop Ryzen 5 Pro 16gb Ram 240gb SSD Windows 11 Pro	290.86	GBP	Used	FIXED_PRICE,AUCTION	EBAY_GB	https://www.ebay.co.uk/itm/177979646279?_skw=thinkpad&hash=item297069e147:g:XkMAAeSwK9RpvtQh	2026-03-22 04:30:07+11	2026-03-22 18:52:18.781998+11	2026-03-22 18:52:18.782001+11	\N	2026-03-22 18:52:18.782002+11	GB
20941	177	v1|389779310415|657069758753	Lenovo ThinkPad T490 i5-8265U 8GB 16GB RAM 256GB 512GB SSD Win 11 FHD Laptop	379.90	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/389779310415?_skw=thinkpad&hash=item5ac0a8474f:g:B9UAAeSwdVJpvsb4	2026-03-22 04:04:36+11	2026-03-22 18:52:18.782819+11	2026-03-22 18:52:18.782822+11	\N	2026-03-22 18:52:18.782823+11	GB
20942	177	v1|188191804080|0	Lenovo Thinkpad T460s Intel Core I5-6300U,16Gb DDR4,512Gb NMVe,win11 Pro	229.50	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/188191804080?_skw=thinkpad&hash=item2bd11b0ab0:g:z8IAAeSwCI1pvsg4	2026-03-22 03:37:32+11	2026-03-22 18:52:18.783622+11	2026-03-22 18:52:18.783624+11	\N	2026-03-22 18:52:18.783625+11	GB
20943	177	v1|397743494678|0	Lenovo ThinkPad L15 Laptop Core i5-10210U 8GB RAM 256GB SSD 15.6" Win 10 Japan	156.09	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/397743494678?_skw=thinkpad&hash=item5c9b5c1616:g:GTIAAeSwpAtpvslI	2026-03-22 03:35:27+11	2026-03-22 18:52:18.784509+11	2026-03-22 18:52:18.784513+11	\N	2026-03-22 18:52:18.784514+11	JP
20944	177	v1|206156284725|0	Lenovo ThinkPad X13 Gen 5 13.3" Touchscreen - Intel Ultra 7 165U - 32GB -1TB SSD	999.99	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/206156284725?_skw=thinkpad&hash=item2fffdf4335:g:qrUAAeSwQA1pvsJj	2026-03-22 03:34:32+11	2026-03-22 18:52:18.785371+11	2026-03-22 18:52:18.785374+11	\N	2026-03-22 18:52:18.785375+11	GB
20945	177	v1|177979514495|0	Lenovo ThinkPad T14s Gen 4 AMD Ryzen 5 PRO 7540U, 16GB RAM, 256GB Touch Screen	516.70	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/177979514495?_skw=thinkpad&hash=item297067de7f:g:CEgAAeSw2nhpvsV2	2026-03-22 03:21:51+11	2026-03-22 18:52:18.786174+11	2026-03-22 18:52:18.786177+11	\N	2026-03-22 18:52:18.786177+11	GB
20946	177	v1|188191748674|0	Lenovo ThinkPad X13 Yoga 11 Gen  Intel Core I5-1135G7,8Gb,512Gb NVMe,Win11 Pro	168.78	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/188191748674?_skw=thinkpad&hash=item2bd11a3242:g:-ecAAeSwy6ZpvsSu	2026-03-22 03:19:31+11	2026-03-22 18:52:18.786968+11	2026-03-22 18:52:18.786971+11	\N	2026-03-22 18:52:18.786972+11	GB
20947	177	v1|389779169369|0	4k Lenovo p15v gen 2 -  i7-11850H - 64GB Ram - Nvidia T600 4GB	499.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/389779169369?_skw=thinkpad&hash=item5ac0a62059:g:098AAeSwfKJpvsBW	2026-03-22 03:09:01+11	2026-03-22 18:52:18.788439+11	2026-03-22 18:52:18.788443+11	\N	2026-03-22 18:52:18.788444+11	GB
20948	177	v1|127761819995|0	Lenovo x201 12.1" i5-M540 2.53GHz 4GB RAM 150GB HDD with Thinkpad X200 UltraBase	99.99	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/127761819995?_skw=thinkpad&hash=item1dbf32a95b:g:wnsAAeSwCnlpvsF4	2026-03-22 03:04:17+11	2026-03-22 18:52:18.789336+11	2026-03-22 18:52:18.789339+11	\N	2026-03-22 18:52:18.78934+11	GB
20949	177	v1|377047767451|0	Lenovo ThinkPad X1 Yoga G7 i5 16GB Ram 256GB SSD 2-in-1 Convertible Battery 88%	349.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/377047767451?_skw=thinkpad&hash=item57c9cc599b:g:PjsAAeSwdThpvFXx	2026-03-22 03:00:01+11	2026-03-22 18:52:18.790153+11	2026-03-22 18:52:18.790156+11	\N	2026-03-22 18:52:18.790157+11	GB
20950	177	v1|397743388443|0	Lenovo Thinkpad Yoga 460 2-in-1 14" Laptop┃Intel Core i5 6200U┃8GB RAM┃256GB SSD	89.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/397743388443?_skw=thinkpad&hash=item5c9b5a771b:g:e7IAAeSw2FBpKZYi	2026-03-22 02:49:41+11	2026-03-22 18:52:18.790956+11	2026-03-22 18:52:18.790958+11	\N	2026-03-22 18:52:18.79096+11	GB
20951	177	v1|168251689916|0	Lenovo ThinkPad X1 Carbon 3rd Gen core i7-5600U 14" 8GB Ram 150Gb SSD Win 10	227.04	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/168251689916?_skw=thinkpad&hash=item272c950bbc:g:xsEAAeSwdVJpvr0C	2026-03-22 02:46:59+11	2026-03-22 18:52:18.791763+11	2026-03-22 18:52:18.791766+11	\N	2026-03-22 18:52:18.791767+11	GB
20952	177	v1|287222120163|0	Lenovo ThinkPad X240 i5-4300U @ 2.90GHz 240GB SSD 8GB RAM Windows 11 Pro	69.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/287222120163?_skw=thinkpad&hash=item42dfc5bee3:g:aS8AAeSwCI1pvrma	2026-03-22 02:46:37+11	2026-03-22 18:52:18.792563+11	2026-03-22 18:52:18.792565+11	\N	2026-03-22 18:52:18.792567+11	GB
20953	177	v1|206156188483|0	ThinkPad X1 Carbon Gen 9 | i7-1165G7 | 16GB Ram | 500GB NVME	350.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206156188483?_skw=thinkpad&hash=item2fffddcb43:g:ddsAAeSwEJppvrh5	2026-03-22 02:38:02+11	2026-03-22 18:52:18.793521+11	2026-03-22 18:52:18.793524+11	\N	2026-03-22 18:52:18.793525+11	GB
20954	177	v1|206156131907|0	Lenovo THINKPAD X13 i5-10210U 8GB RAM 256GB SSD Win11 pro Business Lap	236.86	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/206156131907?_skw=thinkpad&hash=item2fffdcee43:g:ICUAAeSwSZBpvmXe	2026-03-22 02:02:59+11	2026-03-22 18:52:18.794343+11	2026-03-22 18:52:18.794346+11	\N	2026-03-22 18:52:18.794347+11	DE
20955	177	v1|206156131909|0	Lenovo THINKPAD L380 Core i7-8550u 1,8Ghz 8GB 256Gb 13 " FHD W11	244.93	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/206156131909?_skw=thinkpad&hash=item2fffdcee45:g:8YsAAeSwGVBpvmSS	2026-03-22 02:02:59+11	2026-03-22 18:52:18.795149+11	2026-03-22 18:52:18.795152+11	\N	2026-03-22 18:52:18.795153+11	DE
20956	177	v1|127761742027|0	Lenovo THINKPAD P53s Core I7-8565U 16GB 512GB SSD 15 Inch FHD, Nvidia P520 Wind	378.52	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/127761742027?_skw=thinkpad&hash=item1dbf3178cb:g:HCEAAeSw7MRpvmSY	2026-03-22 02:02:58+11	2026-03-22 18:52:18.795968+11	2026-03-22 18:52:18.795971+11	\N	2026-03-22 18:52:18.795972+11	DE
20957	177	v1|287222001424|0	LENOVO THINPAD T450 14" i5-5200U 2.30 GHz 8GB RAM 240GB SSD Windows 10 Pro	123.25	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/287222001424?_skw=thinkpad&hash=item42dfc3ef10:g:RqAAAeSwOvZpvqyl	2026-03-22 01:37:37+11	2026-03-22 18:52:18.796772+11	2026-03-22 18:52:18.796775+11	\N	2026-03-22 18:52:18.796776+11	GB
20958	177	v1|406788834165|0	Lenovo ThinkPad L490 14" | Intel i5-8265U |16GB RAM | 256GB SSD | Windows 11 Pro	172.30	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/406788834165?_skw=thinkpad&hash=item5eb6810375:g:484AAeSwWNVpvp1D	2026-03-22 01:02:34+11	2026-03-22 18:52:18.797562+11	2026-03-22 18:52:18.797565+11	\N	2026-03-22 18:52:18.797566+11	GB
20959	177	v1|389757778621|0	Lenovo Thinkpad x131e Laptop - Chomebook, chome os. 8gb ram, 16GB SSD 500GB HD	176.66	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/389757778621?_skw=thinkpad&hash=item5abf5fbabd:g:mx0AAeSwwRlpuEH8	2026-03-22 01:00:01+11	2026-03-22 18:52:18.798358+11	2026-03-22 18:52:18.79836+11	\N	2026-03-22 18:52:18.798361+11	GB
20960	177	v1|137153870478|0	Lenovo ThinkPad T14 Gen 5 - Ultra 7 165U, 32GB RAM, 1TB SSD, AI, 2YR Warranty	1650.77	AUD	Opened – never used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/137153870478?_skw=thinkpad&hash=item1fef01fa8e:g:e9EAAeSwl8FpvpeS	2026-03-22 00:08:35+11	2026-03-22 18:52:18.799159+11	2026-03-22 18:52:18.799162+11	\N	2026-03-22 18:52:18.799163+11	GB
20961	177	v1|157773878712|0	Lenovo ThinkPad X1 Titanium Touch i7-1160G7 11th 16GB 1TB NVMe Win11 "Yoga"	562.03	GBP	Opened – never used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/157773878712?_skw=thinkpad&hash=item24bc0e55b8:g:TrkAAeSwSoJpvo63	2026-03-21 23:24:27+11	2026-03-22 18:52:18.799963+11	2026-03-22 18:52:18.799982+11	\N	2026-03-22 18:52:18.799984+11	NL
20962	177	v1|188191171966|0	Lenovo ThinkPad T470s , Intel Core i5-6300U , 256GB SSD , 8GB Ram , Win 11 Pro	156.70	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/188191171966?_skw=thinkpad&hash=item2bd111657e:g:F4IAAOSwBzRnIXfV	2026-03-21 23:23:30+11	2026-03-22 18:52:18.800947+11	2026-03-22 18:52:18.800951+11	\N	2026-03-22 18:52:18.800951+11	GB
20963	177	v1|157773876689|0	Lenovo V14 IIL 14 inch  i5-1035G1 8GB RAM 256GB SSD  Windows 11 Pro	189.94	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/157773876689?_skw=thinkpad&hash=item24bc0e4dd1:g:IBsAAeSwu5tpvo1J	2026-03-21 23:22:16+11	2026-03-22 18:52:18.801773+11	2026-03-22 18:52:18.801776+11	\N	2026-03-22 18:52:18.801777+11	GB
20964	177	v1|188191065279|0	Lenovo ThinkPad L430 , 14” ,Intel Core i5-3230M, 2,6GHz, memory 8GB, Win 11 Pro	125.50	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/188191065279?_skw=thinkpad&hash=item2bd10fc4bf:g:sE0AAeSw2tNob~IS	2026-03-21 22:57:02+11	2026-03-22 18:52:18.802605+11	2026-03-22 18:52:18.802607+11	\N	2026-03-22 18:52:18.802608+11	GB
20965	177	v1|127761370136|0	Lenovo Thinkpad E14 Gen 2 Intel i5, 8GB RAM 256GB SSD, 2021, Win11 Pro, RRP 1100	254.21	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/127761370136?_skw=thinkpad&hash=item1dbf2bcc18:g:M84AAeSw1gJpvoO3	2026-03-21 22:51:19+11	2026-03-22 18:52:18.803418+11	2026-03-22 18:52:18.803422+11	\N	2026-03-22 18:52:18.803423+11	GB
20966	177	v1|227266548359|0	ThinkPad X230/8GB/Windows10LTSC/	135.90	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/227266548359?_skw=thinkpad&hash=item34ea245287:g:zvgAAeSwpyZpvoDq	2026-03-21 22:33:02+11	2026-03-22 18:52:18.80423+11	2026-03-22 18:52:18.804233+11	\N	2026-03-22 18:52:18.804234+11	GB
20967	177	v1|236703123660|0	Lenovo ThinkPad E14 Gen 5 AMD RYZEN 7 16GB RAM 512GB SSD Win 11 Pro	759.85	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/236703123660?_skw=thinkpad&hash=item371c9b08cc:g:BCkAAeSwzntpvlqu	2026-03-21 19:49:57+11	2026-03-22 18:52:18.805041+11	2026-03-22 18:52:18.805044+11	\N	2026-03-22 18:52:18.805045+11	GB
20968	177	v1|236703123382|0	Lenovo ThinkPad X1 Yoga Intel Core i7-8550U - 16GB RAM - 128GB SSD	169.99	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/236703123382?_skw=thinkpad&hash=item371c9b07b6:g:x4sAAeSw5m5pvltY	2026-03-21 19:49:40+11	2026-03-22 18:52:18.805856+11	2026-03-22 18:52:18.805859+11	\N	2026-03-22 18:52:18.80586+11	GB
20969	177	v1|157773352089|0	Lenovo ThinkPad T14s Gen 1 Touchscreen Laptop i5  G10 256GB, 16GB Good condition	346.24	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/157773352089?_skw=thinkpad&hash=item24bc064c99:g:amYAAeSwsaBphfcx	2026-03-21 17:07:18+11	2026-03-22 18:52:18.80666+11	2026-03-22 18:52:18.806662+11	\N	2026-03-22 18:52:18.806663+11	GB
20970	177	v1|188189525481|0	Lenovo-Thinkpad-P53-15.6-i7-9750H+NVIDIA Q T2000-32GB-DDR4-2x256Gb-NVMe-1TB-HDD	721.85	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/188189525481?_skw=thinkpad&hash=item2bd0f845e9:g:04MAAeSw3rtpver6	2026-03-21 12:09:57+11	2026-03-22 18:52:18.807457+11	2026-03-22 18:52:18.80746+11	\N	2026-03-22 18:52:18.807461+11	GB
20971	177	v1|198210352937|0	Lenovo Thinkpad X1 carbon gen 13 - 64GB - 1TB - 3 years warranty - Sealed	1638.70	GBP	New	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/198210352937?_skw=thinkpad&hash=item2e2641f729:g:TUsAAeSwHPBpveyu	2026-03-21 11:59:27+11	2026-03-22 18:52:18.80826+11	2026-03-22 18:52:18.808263+11	\N	2026-03-22 18:52:18.808264+11	GB
20972	177	v1|198210288038|0	Lenovo X1 Carbon Gen11 Ultra7 265U 64GB RAM 1TB SSD14" FHD+  5G Warranty Laptop	771.70	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/198210288038?_skw=thinkpad&hash=item2e2640f9a6:g:nJoAAeSwSIxpveTe	2026-03-21 11:26:11+11	2026-03-22 18:52:18.809476+11	2026-03-22 18:52:18.80948+11	\N	2026-03-22 18:52:18.809481+11	GB
20973	177	v1|306834084724|0	Lenovo ThinkPad T450 14" i5-5300U 2.30 GHz 8GB RAM 120GB SSD Windows 10	113.98	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/306834084724?_skw=thinkpad&hash=item4770bc9374:g:stoAAeSwRqppveHq	2026-03-21 11:18:50+11	2026-03-22 18:52:18.810358+11	2026-03-22 18:52:18.810361+11	\N	2026-03-22 18:52:18.810362+11	GB
20974	177	v1|188189213581|0	Lenovo ThinkPad X280,i5-8350U,16GB RAM, SSD 256GB/FHD/BAT 82%/WIN 11pro/BAG	302.04	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/188189213581?_skw=thinkpad&hash=item2bd0f3838d:g:QJwAAeSwOyxpvdXN	2026-03-21 10:29:19+11	2026-03-22 18:52:18.811166+11	2026-03-22 18:52:18.81117+11	\N	2026-03-22 18:52:18.811171+11	GB
20975	177	v1|127760384464|0	LENOVO X270 ~i5-7th, 8GB, 256GB SSD, 2xBatteries, 12.5", Win11+Office21, Backlit	99.95	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/127760384464?_skw=thinkpad&hash=item1dbf1cc1d0:g:DqEAAeSwXzBpvbyj	2026-03-21 09:45:41+11	2026-03-22 18:52:18.811968+11	2026-03-22 18:52:18.811971+11	\N	2026-03-22 18:52:18.811972+11	GB
20976	177	v1|127760343087|0	Lenovo ThinkPad T430 Laptop i5 2.6GHz 8GB 238GB SSD 14" HD DVD-RW Win 10 Pro	80.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/127760343087?_skw=thinkpad&hash=item1dbf1c202f:g:1dkAAeSwIIFpvcS-	2026-03-21 09:13:58+11	2026-03-22 18:52:18.812766+11	2026-03-22 18:52:18.812768+11	\N	2026-03-22 18:52:18.812769+11	GB
20977	177	v1|267615072948|0	Lenovo THINKPAD T490 Core i5-8365U 1,6GHz 8GB 256GB 14 " FHD Win 11	222.66	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/267615072948?_skw=thinkpad&hash=item3e4f19f2b4:g:TmwAAeSw5A9psBPD	2026-03-21 08:15:00+11	2026-03-22 18:52:18.813573+11	2026-03-22 18:52:18.813576+11	\N	2026-03-22 18:52:18.813577+11	DE
20978	177	v1|267615072951|0	Lenovo THINKPAD T490 Core i5 1,60Ghz 16GBRAM 256GB SSD Win 11 14 " FHD Wind 11	231.01	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/267615072951?_skw=thinkpad&hash=item3e4f19f2b7:g:Ml0AAeSwPgVpsBPI	2026-03-21 08:15:00+11	2026-03-22 18:52:18.814527+11	2026-03-22 18:52:18.81453+11	\N	2026-03-22 18:52:18.814531+11	DE
20979	177	v1|318035623892|0	Lenovo ThinkPad X230 i5-3320M @  3.30GHz 128GB SSD 8GB RAM Laptop	125.50	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/318035623892?_skw=thinkpad&hash=item4a0c667fd4:g:-goAAeSw1hlpvbb8	2026-03-21 08:10:44+11	2026-03-22 18:52:18.815346+11	2026-03-22 18:52:18.815349+11	\N	2026-03-22 18:52:18.81535+11	GB
20980	177	v1|206154392512|0	Lenovo X1 Carbon 5 Core i7-7600u 2,80Ghz 16GB 512Gb SSD 1920x1080 Wind11 LTE	251.21	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/206154392512?_skw=thinkpad&hash=item2fffc263c0:g:XZYAAeSwSO9pvWba	2026-03-21 08:05:11+11	2026-03-22 18:52:18.816361+11	2026-03-22 18:52:18.816365+11	\N	2026-03-22 18:52:18.816366+11	DE
20981	177	v1|127760262653|0	Lenovo THINKPAD P1 G1 Xeon E2176M 2,7GHz 15,6 " 32GB 1TB SSD Nvidia P2000 Max-Q	568.58	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/127760262653?_skw=thinkpad&hash=item1dbf1ae5fd:g:~DsAAeSw3x1pvWbf	2026-03-21 08:03:40+11	2026-03-22 18:52:18.817405+11	2026-03-22 18:52:18.817408+11	\N	2026-03-22 18:52:18.81741+11	DE
20982	177	v1|127760262620|0	Lenovo THINKPAD P1 G1 Core i7-8850H 2,20GHz 15,6 " 16GB 512GB Nvidia P1000	393.76	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/127760262620?_skw=thinkpad&hash=item1dbf1ae5dc:g:NcYAAeSwFKhpvbPB	2026-03-21 08:03:37+11	2026-03-22 18:52:18.818235+11	2026-03-22 18:52:18.818238+11	\N	2026-03-22 18:52:18.818239+11	DE
20983	177	v1|206154390171|0	Lenovo THINKPAD T490 Core i5-8365U 16GB 256GB Touchs Win 11 FHD W11	259.27	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/206154390171?_skw=thinkpad&hash=item2fffc25a9b:g:XHcAAeSwk6RpsBYU	2026-03-21 08:02:07+11	2026-03-22 18:52:18.819037+11	2026-03-22 18:52:18.81904+11	\N	2026-03-22 18:52:18.819041+11	DE
20984	177	v1|127760260305|0	Lenovo THINKPAD T490 Core i5-8365U 1,6GHz 8GB 256GB 14 " FHD Win 11 LTE	253.90	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/127760260305?_skw=thinkpad&hash=item1dbf1adcd1:g:XYcAAeSwFd1pldWB	2026-03-21 08:02:00+11	2026-03-22 18:52:18.81984+11	2026-03-22 18:52:18.819842+11	\N	2026-03-22 18:52:18.819843+11	DE
20985	177	v1|366291853075|0	Used ThinkPad X1 Carbon Gen 8 - i5 10th Gen - 16GB - 256GB SSD - FHD	199.99	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/366291853075?_skw=thinkpad&hash=item5548b21f13:g:QF8AAeSwGkFpvbRr	2026-03-21 07:57:43+11	2026-03-22 18:52:18.820639+11	2026-03-22 18:52:18.820641+11	\N	2026-03-22 18:52:18.820642+11	GB
20986	177	v1|267615042590|0	Lenovo ThinkPad X13 Gen 1 Laptop FHD i5 16GB RAM 256GB SSD Windows 11 Pro	179.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/267615042590?_skw=thinkpad&hash=item3e4f197c1e:g:z3oAAeSwuMNpvana	2026-03-21 07:25:46+11	2026-03-22 18:52:18.821444+11	2026-03-22 18:52:18.821447+11	\N	2026-03-22 18:52:18.821448+11	GB
20987	177	v1|227265755956|0	Lenovo ThinkPad X230/8GB/Windows10LTSC/	135.90	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/227265755956?_skw=thinkpad&hash=item34ea183b34:g:z6AAAeSw9-9pvapA	2026-03-21 07:19:00+11	2026-03-22 18:52:18.822245+11	2026-03-22 18:52:18.822248+11	\N	2026-03-22 18:52:18.822249+11	GB
20988	177	v1|236702213908|0	Lenovo ThinkPad E14 Gen 2 - Intel Core i3-1115G4 - 8GB RAM - 256GB SSD	149.99	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/236702213908?_skw=thinkpad&hash=item371c8d2714:g:-BkAAeSwNW5pvaop	2026-03-21 07:18:17+11	2026-03-22 18:52:18.823046+11	2026-03-22 18:52:18.823049+11	\N	2026-03-22 18:52:18.82305+11	GB
20989	177	v1|377049980184|0	Lenovo ThinkPad X1 Yoga G7 i5 16GB Ram 256GB SSD 14" WUXGA 2-in-1 Privacy Screen	349.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/377049980184?_skw=thinkpad&hash=item57c9ee1d18:g:PEEAAeSw3nppvYmr	2026-03-21 07:15:01+11	2026-03-22 18:52:18.823845+11	2026-03-22 18:52:18.823848+11	\N	2026-03-22 18:52:18.823849+11	GB
20990	177	v1|287220338394|0	Lenovo ThinkPad X1 Carbon 8. Gen + UHD Display/i7/16GB/512GB + 6Monate GARANTIE	344.71	EUR	Used	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/287220338394?_skw=thinkpad&hash=item42dfaa8eda:g:MSAAAeSwySxpvaB~	2026-03-21 06:32:58+11	2026-03-22 18:52:18.824674+11	2026-03-22 18:52:18.824677+11	\N	2026-03-22 18:52:18.824678+11	GB
20991	177	v1|377047487637|0	Lenovo ThinkPad X13 Gen 4 - i7 32GB Ram 512GB SSD 13.3" Touch WTY 08/27 Not Yoga	579.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/377047487637?_skw=thinkpad&hash=item57c9c81495:g:9oEAAeSwmelpvCmr	2026-03-21 06:30:01+11	2026-03-22 18:52:18.825472+11	2026-03-22 18:52:18.825475+11	\N	2026-03-22 18:52:18.825476+11	GB
20992	177	v1|377047742761|0	Lenovo ThinkPad X1 Yoga G7 i5 16GB RAM 256GB SSD 14" Convertible battery 100%	369.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/377047742761?_skw=thinkpad&hash=item57c9cbf929:g:JkcAAeSwsH9pvFJp	2026-03-21 06:30:01+11	2026-03-22 18:52:18.826278+11	2026-03-22 18:52:18.826281+11	\N	2026-03-22 18:52:18.826282+11	GB
20993	177	v1|137151691569|0	Lenovo Thinkpad T430, i5 3rd Gen, 8GB RAM, 500GB SSD, Linux Mint	78.70	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/137151691569?_skw=thinkpad&hash=item1feee0bb31:g:CnIAAeSwoolpvZ16	2026-03-21 06:23:26+11	2026-03-22 18:52:18.827083+11	2026-03-22 18:52:18.827086+11	\N	2026-03-22 18:52:18.827087+11	GB
20994	177	v1|117098720235|0	Lenovo X230 Tablet i5 2.60Ghz | 16GB RAM | 240GB SSD | IPS Screen | Linux Mint	414.69	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/117098720235?_skw=thinkpad&hash=item1b43a0abeb:g:UDoAAeSwR09pp3NO	2026-03-21 06:03:17+11	2026-03-22 18:52:18.827887+11	2026-03-22 18:52:18.82789+11	\N	2026-03-22 18:52:18.827891+11	GB
20995	177	v1|117098720210|0	Lenovo ThinkPad T440p i7-4710MQ | 16GB RAM | 240GB NVMe + 1TB SSD | FHD IPS	260.69	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/117098720210?_skw=thinkpad&hash=item1b43a0abd2:g:XJ4AAeSwenpppMuB	2026-03-21 06:03:14+11	2026-03-22 18:52:18.828691+11	2026-03-22 18:52:18.828694+11	\N	2026-03-22 18:52:18.828695+11	GB
20996	177	v1|277820580921|0	Grade A Lenovo ThinkPad P14s Gen 2 + i7/32GB/512GB/nVidia + 6 months WARRANTY	399.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/277820580921?_skw=thinkpad&hash=item40af65a439:g:4T4AAeSw6stpvZkx	2026-03-21 06:01:23+11	2026-03-22 18:52:18.829494+11	2026-03-22 18:52:18.829497+11	\N	2026-03-22 18:52:18.829498+11	GB
20997	177	v1|206154181658|0	Lenovo ThinkPad E14 Gen 3 Spares: 14", Ryzen 5 5500U, 8GB RAM, 256GB SSD, W11	179.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206154181658?_skw=thinkpad&hash=item2fffbf2c1a:g:wWUAAeSw5RBpvZZf	2026-03-21 05:48:32+11	2026-03-22 18:52:18.830296+11	2026-03-22 18:52:18.830298+11	\N	2026-03-22 18:52:18.830299+11	GB
20998	177	v1|206154181674|0	Lenovo ThinkPad L14 Gen 2 Spares: 14" Screen i5 11th Gen 16GB RAM 256GB SSD W11	149.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206154181674?_skw=thinkpad&hash=item2fffbf2c2a:g:Q9YAAeSw8otpvZZp	2026-03-21 05:48:32+11	2026-03-22 18:52:18.831117+11	2026-03-22 18:52:18.83112+11	\N	2026-03-22 18:52:18.831121+11	GB
20999	177	v1|277820553291|0	Lenovo ThinkPad T14s Gen 2 - core i7/16GB/512GB/WWAN eSIM + 6 months WARRANTY	329.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/277820553291?_skw=thinkpad&hash=item40af65384b:g:9AUAAeSwM3VpvZTy	2026-03-21 05:45:59+11	2026-03-22 18:52:18.832097+11	2026-03-22 18:52:18.8321+11	\N	2026-03-22 18:52:18.832101+11	GB
21000	177	v1|298144543454|0	Lenovo Thinkpad X260 - Intel Core i5-6300U 2.4GHz - 8GB DDR4 - 120GB SSD	70.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/298144543454?_skw=thinkpad&hash=item456accb2de:g:VbMAAeSwgHVpn0pm	2026-03-21 05:26:18+11	2026-03-22 18:52:18.833069+11	2026-03-22 18:52:18.833072+11	\N	2026-03-22 18:52:18.833073+11	GB
21001	177	v1|277820517047|0	Grade A Lenovo ThinkPad T14 Gen 3 - core i5/6 core/24GB/512GB +6 months WARRANTY	449.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/277820517047?_skw=thinkpad&hash=item40af64aab7:g:Ib4AAeSw2nhpvZAd	2026-03-21 05:23:00+11	2026-03-22 18:52:18.833876+11	2026-03-22 18:52:18.833878+11	\N	2026-03-22 18:52:18.833879+11	GB
21002	177	v1|137151495336|0	Lenovo Thinkpad Edge E531 Laptop - i3 3rd Gen - 4GB RAM - Windows 10 pro	45.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/137151495336?_skw=thinkpad&hash=item1feeddbca8:g:YU0AAeSw3mtpvYX5	2026-03-21 05:00:25+11	2026-03-22 18:52:18.834671+11	2026-03-22 18:52:18.834674+11	\N	2026-03-22 18:52:18.834675+11	GB
21003	177	v1|206154096352|0	Lenovo ThinkPad L390 Yoga Spares: 13" Touch i5 8th Gen 16GB RAM 256GB SSD W11	79.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206154096352?_skw=thinkpad&hash=item2fffbddee0:g:IJAAAeSwxnBpvYlJ	2026-03-21 04:52:25+11	2026-03-22 18:52:18.835618+11	2026-03-22 18:52:18.83562+11	\N	2026-03-22 18:52:18.835622+11	GB
21004	177	v1|206154096331|0	Lenovo ThinkPad L390 Yoga Spares 13.3" Touch i5 8th Gen 8GB RAM 256GB SSD W11	79.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206154096331?_skw=thinkpad&hash=item2fffbddecb:g:gQUAAeSwibZpvYlI	2026-03-21 04:52:24+11	2026-03-22 18:52:18.836436+11	2026-03-22 18:52:18.836438+11	\N	2026-03-22 18:52:18.83644+11	GB
21005	177	v1|206154096177|0	Lenovo ThinkPad L480 | 14" | i5 8th Gen | 16GB RAM | 256GB SSD | W11 | Grade C	79.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206154096177?_skw=thinkpad&hash=item2fffbdde31:g:vjQAAeSwZgVpvYkF	2026-03-21 04:52:18+11	2026-03-22 18:52:18.837242+11	2026-03-22 18:52:18.837245+11	\N	2026-03-22 18:52:18.837246+11	GB
21006	177	v1|236701967417|0	Lenovo ThinkPad X13 Gen 4  13.3" 16GB RAM 256GB SSD M.2 Intel Core i5 13th Gen	311.84	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/236701967417?_skw=thinkpad&hash=item371c896439:g:uUIAAeSwMBxpvXif	2026-03-21 03:51:56+11	2026-03-22 18:52:18.838065+11	2026-03-22 18:52:18.838068+11	\N	2026-03-22 18:52:18.838069+11	GB
21007	177	v1|406786591265|0	Lenovo ThinkPad X1 Yoga G5 Laptop: Core i7-10610U 256GB 16GB, Warranty VAT	525.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/406786591265?_skw=thinkpad&hash=item5eb65eca21:g:qtwAAeSwKONpvXUN	2026-03-21 03:25:58+11	2026-03-22 18:52:18.838872+11	2026-03-22 18:52:18.838875+11	\N	2026-03-22 18:52:18.838876+11	GB
21008	177	v1|147214488738|0	Lenovo Thinkpad X230 Laptop i5 8GB RAM 320GB HDD 12.5" Win 10 Pro	79.99	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/147214488738?_skw=thinkpad&hash=item2246aad4a2:g:rTcAAeSwLTlpvXS~	2026-03-21 03:25:35+11	2026-03-22 18:52:18.839679+11	2026-03-22 18:52:18.839682+11	\N	2026-03-22 18:52:18.839683+11	GB
21009	177	v1|206153955060|0	Lenovo ThinkPad L480 Spares: 14" FHD, No M/B, No CPU, No RAM, No SSD, No OS	39.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206153955060?_skw=thinkpad&hash=item2fffbbb6f4:g:3J4AAeSwM3VpvXO5	2026-03-21 03:20:23+11	2026-03-22 18:52:18.840486+11	2026-03-22 18:52:18.840489+11	\N	2026-03-22 18:52:18.84049+11	GB
21010	177	v1|206153955071|0	Lenovo ThinkPad L490 | 14" FHD | i5 8th Gen | 16GB RAM | 256GB SSD | W11 |	89.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206153955071?_skw=thinkpad&hash=item2fffbbb6ff:g:1s8AAeSw5JVpvXO5	2026-03-21 03:20:23+11	2026-03-22 18:52:18.841291+11	2026-03-22 18:52:18.841293+11	\N	2026-03-22 18:52:18.841294+11	GB
21011	177	v1|206153955034|0	Lenovo ThinkPad T580 Spares: 15.6" FHD, No M/B, No CPU, No RAM, No SSD, No OS	39.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206153955034?_skw=thinkpad&hash=item2fffbbb6da:g:nW4AAeSwQBFpvXO2	2026-03-21 03:20:22+11	2026-03-22 18:52:18.842095+11	2026-03-22 18:52:18.842097+11	\N	2026-03-22 18:52:18.842098+11	GB
21012	177	v1|206153954974|0	Lenovo ThinkPad L480 Spares: 14" FHD, i5 8th Gen 16GB RAM, 256GB SSD, W11	79.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206153954974?_skw=thinkpad&hash=item2fffbbb69e:g:DM8AAeSwGkFpvXOx	2026-03-21 03:20:21+11	2026-03-22 18:52:18.842907+11	2026-03-22 18:52:18.84291+11	\N	2026-03-22 18:52:18.842911+11	GB
21013	177	v1|206153954978|0	Lenovo ThinkPad L480 Spares: 14" FHD, i5 8th Gen CPU, 16GB RAM 256GB SSD, W11	69.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206153954978?_skw=thinkpad&hash=item2fffbbb6a2:g:3JMAAeSwSO9pvXOv	2026-03-21 03:20:21+11	2026-03-22 18:52:18.843704+11	2026-03-22 18:52:18.843707+11	\N	2026-03-22 18:52:18.843708+11	GB
21014	177	v1|206153954980|0	Lenovo ThinkPad L380 Yoga | 13.3" | i5 8th Gen | 16GB RAM | 128GB SSD | W11 |	79.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206153954980?_skw=thinkpad&hash=item2fffbbb6a4:g:DzQAAeSwKRtpvXOz	2026-03-21 03:20:21+11	2026-03-22 18:52:18.844505+11	2026-03-22 18:52:18.844508+11	\N	2026-03-22 18:52:18.844509+11	GB
21015	177	v1|206153954960|0	Lenovo ThinkPad L480 Spares: 14" FHD, i5 8th Gen CPU, 16GB RAM, 256GB SSD W11	89.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206153954960?_skw=thinkpad&hash=item2fffbbb690:g:JAcAAeSwYC5pvXOu	2026-03-21 03:20:20+11	2026-03-22 18:52:18.845332+11	2026-03-22 18:52:18.845335+11	\N	2026-03-22 18:52:18.845336+11	GB
21016	177	v1|206153954962|0	Lenovo ThinkPad L480 | 14" FHD | i5 8th Gen | 16GB RAM | 256GB SSD | W11 |	79.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206153954962?_skw=thinkpad&hash=item2fffbbb692:g:CIAAAeSwGBxpvXOs	2026-03-21 03:20:20+11	2026-03-22 18:52:18.846138+11	2026-03-22 18:52:18.846141+11	\N	2026-03-22 18:52:18.846142+11	GB
21017	177	v1|206153954911|0	Lenovo ThinkPad L14 Gen 1 Spares: 14" FHD, No M/B, No CPU No RAM, No SSD, No OS	39.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206153954911?_skw=thinkpad&hash=item2fffbbb65f:g:JesAAeSw7MRpvXOm	2026-03-21 03:20:19+11	2026-03-22 18:52:18.846947+11	2026-03-22 18:52:18.84695+11	\N	2026-03-22 18:52:18.846951+11	GB
21018	177	v1|206153954928|0	Lenovo ThinkPad L380 Yoga | 13.3" Touch | i5 8th Gen | 8GB RAM | 256GB SSD | W11	79.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206153954928?_skw=thinkpad&hash=item2fffbbb670:g:CWAAAeSwe35pvXOp	2026-03-21 03:20:19+11	2026-03-22 18:52:18.848869+11	2026-03-22 18:52:18.84888+11	\N	2026-03-22 18:52:18.848887+11	GB
21019	177	v1|206153954889|0	Lenovo ThinkPad L14 Gen 1 Spares: 14" FHD, No M/B, No CPU, No RAM, No SSD, No OS	44.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206153954889?_skw=thinkpad&hash=item2fffbbb649:g:Dc4AAeSwP4ZpvXOl	2026-03-21 03:20:18+11	2026-03-22 18:52:18.850402+11	2026-03-22 18:52:18.850407+11	\N	2026-03-22 18:52:18.850409+11	GB
21020	177	v1|137151294630|0	Lenovo ThinkPad L13 YogaGen2, i5-2.4GHz, 8GB , 256GB, Win 11, 13.4" Touch Screen	167.10	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/137151294630?_skw=thinkpad&hash=item1feedaaca6:g:jQwAAeSwAtNpscS7	2026-03-21 02:58:26+11	2026-03-22 18:52:18.851595+11	2026-03-22 18:52:18.851599+11	\N	2026-03-22 18:52:18.851601+11	GB
21021	177	v1|157771975322|0	Thinkpad T430 Laptop 2.60 GHz Core i5 12GB RAM - 2 Drives - W10 Pro - Lovely!!	135.90	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/157771975322?_skw=thinkpad&hash=item24bbf14a9a:g:ipAAAeSweLNpvUr3	2026-03-21 02:51:37+11	2026-03-22 18:52:18.852575+11	2026-03-22 18:52:18.852579+11	\N	2026-03-22 18:52:18.85258+11	GB
21022	177	v1|406786420948|0	Lenovo ThinkPad T450 14" i5-5300U 2.30 GHz 8GB RAM 240GB SSD Windows 11 Pro	79.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/406786420948?_skw=thinkpad&hash=item5eb65c30d4:g:KGYAAeSw52Vpt~qA	2026-03-21 02:41:38+11	2026-03-22 18:52:18.853419+11	2026-03-22 18:52:18.853422+11	\N	2026-03-22 18:52:18.853423+11	GB
21023	177	v1|147214429623|0	Lenovo ThinkPad L14 Gen 5 (Intel) Intel Core Ultra 5 125U Laptop 35.6 cm (14i...	783.22	GBP	New	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/147214429623?_skw=thinkpad&hash=item2246a9edb7:g:CNsAAeSwbKlpv5Vx	2026-03-21 02:27:21+11	2026-03-22 18:52:18.854263+11	2026-03-22 18:52:18.854266+11	\N	2026-03-22 18:52:18.854268+11	GB
21024	177	v1|267614816619|0	Lenovo ThinkPad T440 / Core i5-4300U / 4GB RAM / 128GB SSD / 4G LTE / WIN 11 PRO	62.95	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/267614816619?_skw=thinkpad&hash=item3e4f16096b:g:T2QAAeSwYqFpvWHK	2026-03-21 02:09:30+11	2026-03-22 18:52:18.855084+11	2026-03-22 18:52:18.855087+11	\N	2026-03-22 18:52:18.855088+11	GB
21025	177	v1|147214406217|0	Lenovo ThinkPad Yoga 11e 5th Gen 11” 2-in-1 Touchscreen Laptop Windows 11	149.97	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/147214406217?_skw=thinkpad&hash=item2246a99249:g:uYoAAeSwlYJpvApH	2026-03-21 02:02:27+11	2026-03-22 18:52:18.855897+11	2026-03-22 18:52:18.8559+11	\N	2026-03-22 18:52:18.855901+11	GB
21026	177	v1|168249416681|0	Lenovo ThinkPad Carbon X1 Gen 9 Intel i7 1165G7 16GB RAM 256GB SSD Windows 11	350.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/168249416681?_skw=thinkpad&hash=item272c725be9:g:IQsAAeSwBfVpvUuD	2026-03-21 01:53:59+11	2026-03-22 18:52:18.856707+11	2026-03-22 18:52:18.85671+11	\N	2026-03-22 18:52:18.856711+11	GB
21027	177	v1|277820081064|0	Lenovo Thinkpad P14s Gen2 i7-1185G7 3.0Ghz 16GB 512SSD 14" Laptop - USB-C FAULT	150.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/277820081064?_skw=thinkpad&hash=item40af5e03a8:g:jUYAAOSwxtZm0aIK	2026-03-21 01:45:10+11	2026-03-22 18:52:18.857516+11	2026-03-22 18:52:18.857519+11	\N	2026-03-22 18:52:18.85752+11	GB
21028	177	v1|298144009507|0	Lenovo ThinkPad E560 - i5-6200U - 8GB Ram - No Storage	57.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/298144009507?_skw=thinkpad&hash=item456ac48d23:g:DlsAAeSwmWFpvVrx	2026-03-21 01:37:27+11	2026-03-22 18:52:18.85848+11	2026-03-22 18:52:18.858484+11	\N	2026-03-22 18:52:18.858485+11	GB
21029	177	v1|298143999097|0	Lenvo ThinkPad L440 - i5-4210M - 4GB Ram - 180GB SSD - No OS	54.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/298143999097?_skw=thinkpad&hash=item456ac46479:g:BK4AAeSwl2hpvVm0	2026-03-21 01:32:47+11	2026-03-22 18:52:18.859306+11	2026-03-22 18:52:18.859309+11	\N	2026-03-22 18:52:18.85931+11	GB
21030	177	v1|298143976733|0	Lenovo Thinkpad T460 - i5-6300U - 8GB Ram - 500GB SSD - No OS	89.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/298143976733?_skw=thinkpad&hash=item456ac40d1d:g:FyYAAeSwWNVpvViZ	2026-03-21 01:27:48+11	2026-03-22 18:52:18.860111+11	2026-03-22 18:52:18.860114+11	\N	2026-03-22 18:52:18.860115+11	GB
21031	177	v1|206153772302|0	Fast Lenovo ThinkPad T14s Gen 1 Core i7 10th 16GB 512GB NVme SSD 14" Win 11 Pro	299.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206153772302?_skw=thinkpad&hash=item2fffb8ed0e:g:xGQAAeSwQGJpc2if	2026-03-21 01:01:28+11	2026-03-22 18:52:18.860936+11	2026-03-22 18:52:18.860939+11	\N	2026-03-22 18:52:18.86094+11	GB
21032	177	v1|366291159598|0	Lenovo ThinkPad E14 Gen3 AMD Ryzen 5 5500U 16GB RAM 256GB NVME SSD 14" Full HD W	299.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/366291159598?_skw=thinkpad&hash=item5548a78a2e:g:kYAAAeSwnahpuDSM	2026-03-21 00:59:01+11	2026-03-22 18:52:18.861749+11	2026-03-22 18:52:18.861752+11	\N	2026-03-22 18:52:18.861753+11	GB
21033	177	v1|318034027603|0	Lenovo Thinkpad E585 15.6” AMD Ryzen 7 256GB SSD/8GB Ram Window 10 Laptop	190.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/318034027603?_skw=thinkpad&hash=item4a0c4e2453:g:NyMAAeSws~lpvUpU	2026-03-21 00:26:29+11	2026-03-22 18:52:18.862571+11	2026-03-22 18:52:18.862574+11	\N	2026-03-22 18:52:18.862575+11	GB
21034	177	v1|236701647219|0	Lenovo ThinkPad A275 Laptop – 12.5" – Windows 10	130.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/236701647219?_skw=thinkpad&hash=item371c848173:g:nTEAAeSw0y9pvVFb	2026-03-21 00:22:52+11	2026-03-22 18:52:18.863457+11	2026-03-22 18:52:18.863462+11	\N	2026-03-22 18:52:18.863464+11	GB
21035	177	v1|406786133490|0	Lenovo ThinkPad T495-Ryzen 7 Pro - Fast Business LAPTOP-GREAT Condition Veryfast	290.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/406786133490?_skw=thinkpad&hash=item5eb657cdf2:g:NjIAAeSw1sBpvUZq	2026-03-21 00:13:09+11	2026-03-22 18:52:18.864572+11	2026-03-22 18:52:18.864576+11	\N	2026-03-22 18:52:18.864577+11	GB
21036	177	v1|358355026597|0	Lenovo ThinkPad X1 Yoga Gen 6 14 256GB SSD Intel Core i5-1145G7, 2.6GHz 32GB Ram	300.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/358355026597?_skw=thinkpad&hash=item536f9fc2a5:g:uUwAAeSw0x5pvVrv	2026-03-22 15:20:59+11	2026-03-22 18:52:18.865435+11	2026-03-22 18:52:18.865438+11	\N	2026-03-22 18:52:18.865439+11	GB
21037	177	v1|117097993571|0	Lenovo ThinkPad X1 Carbon 6th Gen i7-8650U | 16GB RAM 256GB SSD | FHD  (1315)	301.26	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/117097993571?_skw=thinkpad&hash=item1b43959563:g:V~YAAeSwHVhpvTmf	2026-03-20 23:15:06+11	2026-03-22 18:52:18.866245+11	2026-03-22 18:52:18.866249+11	\N	2026-03-22 18:52:18.86625+11	GB
21038	177	v1|257416347214|0	Lenovo thinkpad p16s gen 3 / Ultra 7 155H / 32GB RAM / 1TB SSD / NVIDIA RTX 500	1199.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/257416347214?_skw=thinkpad&hash=item3bef35be4e:g:cpQAAeSwWNVpvTKm	2026-03-20 22:43:35+11	2026-03-22 18:52:18.867051+11	2026-03-22 18:52:18.867054+11	\N	2026-03-22 18:52:18.867055+11	GB
21039	177	v1|406785864955|0	Lenovo ThinkPad L16 Gen 2 Laptop: AMD Ryzen 5 Pro, 512GB SSD, 16GB RAM, Warranty	849.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/406785864955?_skw=thinkpad&hash=item5eb653b4fb:g:TXIAAeSwkoppvTIp	2026-03-20 22:40:33+11	2026-03-22 18:52:18.867878+11	2026-03-22 18:52:18.867882+11	\N	2026-03-22 18:52:18.867883+11	GB
21040	177	v1|206153386401|0	Lenovo ThinkPad T14s Gen 6 (AMD) Copilot+ PC AMD Ryzen AI 7 PRO 350 Laptop 35.6	1912.00	GBP	New	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/206153386401?_skw=thinkpad&hash=item2fffb309a1:g:H1IAAeSwaItpvTGy	2026-03-20 22:38:57+11	2026-03-22 18:52:18.868684+11	2026-03-22 18:52:18.868687+11	\N	2026-03-22 18:52:18.868688+11	GB
21041	177	v1|198208802616|0	Lenovo ThinkPad P16 Gen 3 Intel Core Ultra 9 275HX Laptop 40.6 cm (16") WUXGA 32	3855.00	GBP	New	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/198208802616?_skw=thinkpad&hash=item2e262a4f38:g:SXYAAeSwPKtpvTGM	2026-03-20 22:38:23+11	2026-03-22 18:52:18.869479+11	2026-03-22 18:52:18.869482+11	\N	2026-03-22 18:52:18.869483+11	GB
21042	177	v1|198208801917|0	Lenovo ThinkPad P16s Gen 4 (AMD) Copilot+ PC AMD Ryzen AI 7 PRO 350 Mobile works	2279.00	GBP	New	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/198208801917?_skw=thinkpad&hash=item2e262a4c7d:g:ZbIAAeSww8ppvTFW	2026-03-20 22:37:42+11	2026-03-22 18:52:18.870287+11	2026-03-22 18:52:18.870291+11	\N	2026-03-22 18:52:18.870292+11	GB
21043	177	v1|198208801283|0	Lenovo ThinkPad P16s Gen 4 (AMD) Copilot+ PC AMD Ryzen AI 7 PRO 350 Mobile works	1804.00	GBP	New	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/198208801283?_skw=thinkpad&hash=item2e262a4a03:g:SgAAAeSwnc1pvTEW	2026-03-20 22:36:48+11	2026-03-22 18:52:18.871083+11	2026-03-22 18:52:18.871086+11	\N	2026-03-22 18:52:18.871087+11	GB
21044	177	v1|206153383030|0	Lenovo ThinkPad P14s Gen 6 (AMD) AMD Ryzen AI 7 PRO 350 Mobile workstation 35.6	1778.00	GBP	New	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/206153383030?_skw=thinkpad&hash=item2fffb2fc76:g:PscAAeSwVhJpvTDb	2026-03-20 22:35:44+11	2026-03-22 18:52:18.871884+11	2026-03-22 18:52:18.871887+11	\N	2026-03-22 18:52:18.871888+11	GB
21045	177	v1|206153381316|0	Lenovo ThinkPad P14s Gen 6 (AMD) AMD Ryzen AI 7 PRO 350 Mobile workstation 35.6	2207.00	GBP	New	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/206153381316?_skw=thinkpad&hash=item2fffb2f5c4:g:ZVsAAeSwIIFpvTCa	2026-03-20 22:34:45+11	2026-03-22 18:52:18.87269+11	2026-03-22 18:52:18.872692+11	\N	2026-03-22 18:52:18.872693+11	GB
21046	177	v1|377049244671|0	Lenovo ThinkPad X13 Yoga Gen 2 Core i5-1135G7 8GB 256GB Touchscreen Laptop	219.99	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/377049244671?_skw=thinkpad&hash=item57c9e2e3ff:g:dXkAAOSwu0hnUbQN	2026-03-20 22:32:14+11	2026-03-22 18:52:18.87349+11	2026-03-22 18:52:18.873493+11	\N	2026-03-22 18:52:18.873494+11	GB
21047	177	v1|127759229682|0	Lenovo ThinkPad L450 i5-5200U 2.30GHz 8GB Ram 256GB SSD Win11Pro(J204)	74.99	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/127759229682?_skw=thinkpad&hash=item1dbf0b22f2:g:KEcAAeSw-EhpvS7g	2026-03-20 22:26:32+11	2026-03-22 18:52:18.874295+11	2026-03-22 18:52:18.874298+11	\N	2026-03-22 18:52:18.874299+11	GB
21048	177	v1|206153360860|0	Lenovo ThinkPad L14 Gen 6 (AMD) AMD Ryzen™ 5 PRO 215 Laptop 35.6 cm (14") WUXGA	1270.00	GBP	New	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/206153360860?_skw=thinkpad&hash=item2fffb2a5dc:g:BeMAAeSwmsVpvS6v	2026-03-20 22:26:11+11	2026-03-22 18:52:18.875114+11	2026-03-22 18:52:18.875117+11	\N	2026-03-22 18:52:18.875118+11	GB
21049	177	v1|257416267307|0	Lenovo X1 Yoga Intel i5 Windows 11 2 in 1 Touch Laptop 14 in 16GB RAM 512GB SSD	219.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/257416267307?_skw=thinkpad&hash=item3bef34862b:g:y8QAAeSw0y9pvSbk	2026-03-20 21:52:41+11	2026-03-22 18:52:18.87593+11	2026-03-22 18:52:18.875932+11	\N	2026-03-22 18:52:18.875933+11	GB
21050	177	v1|406785778773|0	Lenovo ThinkPad X1 Yoga G6 Laptop: i7-1185G7 Touch 32GB 512GB Warranty VAT	589.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/406785778773?_skw=thinkpad&hash=item5eb6526455:g:6koAAeSw5tRpvSZC	2026-03-20 21:49:49+11	2026-03-22 18:52:18.876744+11	2026-03-22 18:52:18.876746+11	\N	2026-03-22 18:52:18.876747+11	GB
21051	177	v1|406785777798|0	Lenovo ThinkPad P1 Gen 6 Laptop: i7-13700H 16GB RAM NVIDIA RTX A1000 Warranty	1489.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/406785777798?_skw=thinkpad&hash=item5eb6526086:g:zIoAAeSwuMNpvSYe	2026-03-20 21:49:13+11	2026-03-22 18:52:18.877556+11	2026-03-22 18:52:18.877558+11	\N	2026-03-22 18:52:18.877559+11	GB
21052	177	v1|406785756464|0	Lenovo ThinkPad P52 Laptop i7-8750H 512GB SSD 16GB RAM Quadro P1000 Warranty VAT	489.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/406785756464?_skw=thinkpad&hash=item5eb6520d30:g:pQcAAeSwHVhpvSRe	2026-03-20 21:41:42+11	2026-03-22 18:52:18.87836+11	2026-03-22 18:52:18.878363+11	\N	2026-03-22 18:52:18.878364+11	GB
21054	177	v1|406785753117|0	Lenovo ThinkPad T14 Gen 2 Laptop: Intel i5 11th Gen, 512GB 16GB RAM Warranty VAT	539.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/406785753117?_skw=thinkpad&hash=item5eb652001d:g:8FcAAeSwR0tpvSN~	2026-03-20 21:37:58+11	2026-03-22 18:52:18.880403+11	2026-03-22 18:52:18.880408+11	\N	2026-03-22 18:52:18.880409+11	GB
21055	177	v1|406785745553|0	Lenovo ThinkPad X1 Yoga G6 Laptop: i7-1185G7 32GB RAM 512GB SSD Warranty VAT	639.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/406785745553?_skw=thinkpad&hash=item5eb651e291:g:6RAAAeSwXERpvSHD	2026-03-20 21:30:36+11	2026-03-22 18:52:18.881456+11	2026-03-22 18:52:18.881459+11	\N	2026-03-22 18:52:18.88146+11	GB
21056	177	v1|257416231422|0	Lenovo Thinkpad X1 YOGA Gen 4 i7 2 in 1 Windows 11 Intel 8665u 16GB 256GB SSD	189.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/257416231422?_skw=thinkpad&hash=item3bef33f9fe:g:wlEAAeSw7MRpvR8o	2026-03-20 21:19:42+11	2026-03-22 18:52:18.882327+11	2026-03-22 18:52:18.88233+11	\N	2026-03-22 18:52:18.882331+11	GB
21057	177	v1|366290737625|0	Lenovo Thinkpad T470S Laptop i7-6600u 20GB RAM 256GB SSD Win11Pro(J201)	149.99	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/366290737625?_skw=thinkpad&hash=item5548a119d9:g:obwAAeSwkk9pvR3x	2026-03-20 21:15:14+11	2026-03-22 18:52:18.883152+11	2026-03-22 18:52:18.883155+11	\N	2026-03-22 18:52:18.883156+11	GB
21058	177	v1|127759135968|0	Lenovo ThinkPad T570, Intel Core i5 7200u  256GB SSD 8GB RAM Win11Pro(J200)	79.99	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/127759135968?_skw=thinkpad&hash=item1dbf09b4e0:g:lkoAAeSwyKBpvRzH	2026-03-20 21:09:39+11	2026-03-22 18:52:18.883963+11	2026-03-22 18:52:18.883965+11	\N	2026-03-22 18:52:18.883966+11	GB
21059	177	v1|389773907226|0	Lenovo ThinkPad T480 Laptop i5-8350U 8GB 256GB Windows 11 Pro- READ DESCRIPTION	149.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/389773907226?_skw=thinkpad&hash=item5ac055d51a:g:hqkAAeSwj0RpvRs3	2026-03-20 21:03:59+11	2026-03-22 18:52:18.884772+11	2026-03-22 18:52:18.884774+11	\N	2026-03-22 18:52:18.884775+11	GB
21060	177	v1|287219145939|0	Lenovo Thinkpad T490 core i5-8365U 16GB 256GB 14ins FHD Touch Win 11 Pro	199.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/287219145939?_skw=thinkpad&hash=item42df985cd3:g:PjMAAeSw5m5pvZNN	2026-03-20 20:38:52+11	2026-03-22 18:52:18.885581+11	2026-03-22 18:52:18.885584+11	\N	2026-03-22 18:52:18.885585+11	GB
21061	177	v1|298143087735|0	Lenovo X13 Yoga Gen 2 i5-1145G7 16GB 512GB 2.5K 2560x1600 Touch Win 11 Pro B	359.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/298143087735?_skw=thinkpad&hash=item456ab67c77:g:Ej8AAeSwbKlpvRJq	2026-03-20 20:28:31+11	2026-03-22 18:52:18.886396+11	2026-03-22 18:52:18.886399+11	\N	2026-03-22 18:52:18.8864+11	GB
21062	177	v1|298143008304|0	Lenovo ThinkPad T14 Laptop Gen 1 Ryzen 5 Pro 4650U 4 Ghz 14" 24GB 256GB	247.99	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/298143008304?_skw=thinkpad&hash=item456ab54630:g:-vsAAeSwCI1pvS3c	2026-03-20 20:17:51+11	2026-03-22 18:52:18.887203+11	2026-03-22 18:52:18.887206+11	\N	2026-03-22 18:52:18.887207+11	GB
21063	177	v1|336491476565|0	Lenovo ThinkPad T14 Gen 1 Core i5-10310U 1.70 GHz 16GB RAM 256GB SSD (read desc)	180.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/336491476565?_skw=thinkpad&hash=item4e58747655:g:A~0AAeSwNF1pvQ1m	2026-03-20 20:12:11+11	2026-03-22 18:52:18.888+11	2026-03-22 18:52:18.888003+11	\N	2026-03-22 18:52:18.888004+11	GB
21064	177	v1|127759046758|0	Lenovo ThinkPad T14 Gen  i5-10210U 16GB RAM 256GB SSD 14” FHD Win 11 Pro(J197)	144.99	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/127759046758?_skw=thinkpad&hash=item1dbf085866:g:550AAeSwqLFpvQv5	2026-03-20 19:57:47+11	2026-03-22 18:52:18.888812+11	2026-03-22 18:52:18.888815+11	\N	2026-03-22 18:52:18.888816+11	GB
21065	177	v1|287219062822|0	Lenovo THINKPAD C13 YOGA GEN1 CHROMEBOOK AMD 8 GB RAM 128 GB ENGLISH US	163.70	GBP	Used	FIXED_PRICE,AUCTION	EBAY_GB	https://www.ebay.co.uk/itm/287219062822?_skw=thinkpad&hash=item42df971826:g:5UEAAeSwMoRpvQnr	2026-03-20 20:04:17+11	2026-03-22 18:52:18.889642+11	2026-03-22 18:52:18.889645+11	\N	2026-03-22 18:52:18.889646+11	IE
21066	177	v1|366290582553|0	Lenovo ThinkPad T570, Intel Core i5 7200u  256GB SSD 16GB RAM Win11Pro(J196)	129.99	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/366290582553?_skw=thinkpad&hash=item55489ebc19:g:0hoAAeSwGMhpvQeE	2026-03-20 19:38:55+11	2026-03-22 18:52:18.890445+11	2026-03-22 18:52:18.890448+11	\N	2026-03-22 18:52:18.890449+11	GB
21067	177	v1|336491424058|0	HP ZBook Studio G11 16" 4K+ Screen Ultra 7-165H 32GB RAM 1TB SSD RTX 2000 Ada	1699.90	GBP	New	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/336491424058?_skw=thinkpad&hash=item4e5873a93a:g:0CkAAOSwrdRnqw2Z	2026-03-20 19:06:04+11	2026-03-22 18:52:18.891245+11	2026-03-22 18:52:18.891248+11	\N	2026-03-22 18:52:18.891249+11	GB
21068	177	v1|287218956322|0	Lenovo ThinkPad X250 Laptop / Intel Core i5-4300 / 8GB-RAM / 256GB-SSD / Win 10	59.95	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/287218956322?_skw=thinkpad&hash=item42df957822:g:hDAAAeSwOjppvPxe	2026-03-20 18:51:38+11	2026-03-22 18:52:18.892038+11	2026-03-22 18:52:18.892041+11	\N	2026-03-22 18:52:18.892042+11	GB
21069	177	v1|318032669933|0	The Lenovo ThinkPad 13 (2nd Gen) laptop (Type 20J1-004DUK).	98.46	GBP	Used	FIXED_PRICE,AUCTION	EBAY_GB	https://www.ebay.co.uk/itm/318032669933?_skw=thinkpad&hash=item4a0c396ced:g:41kAAeSwCexpvO5p	2026-03-20 17:59:41+11	2026-03-22 18:52:18.892842+11	2026-03-22 18:52:18.892845+11	\N	2026-03-22 18:52:18.892846+11	GB
21070	177	v1|406785185232|0	Lenovo Thinkpad P15 Gen 1 Core i7 9th gen 32gb RAM 512gb SSD - Grade A	499.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/406785185232?_skw=thinkpad&hash=item5eb64955d0:g:TQEAAeSw6zhpvNxv	2026-03-20 16:34:02+11	2026-03-22 18:52:18.893657+11	2026-03-22 18:52:18.89366+11	\N	2026-03-22 18:52:18.893661+11	GB
21071	177	v1|406785114003|0	Lenovo T14s Gen 2 i7 512GB 16GB 14"	550.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/406785114003?_skw=thinkpad&hash=item5eb6483f93:g:4CIAAeSwHKtpvNCP	2026-03-20 15:49:05+11	2026-03-22 18:52:18.894462+11	2026-03-22 18:52:18.894465+11	\N	2026-03-22 18:52:18.894466+11	GB
21072	177	v1|137149430610|0	Lenovo Thinkpad X13 Gen 5, Core Ultra 7 165U, 32GB RAM, 512GB SSD UK	899.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/137149430610?_skw=thinkpad&hash=item1feebe3b52:g:5FEAAeSwAu9pvKTt	2026-03-20 12:40:30+11	2026-03-22 18:52:18.895266+11	2026-03-22 18:52:18.895269+11	\N	2026-03-22 18:52:18.89527+11	GB
21073	177	v1|147213500013|0	Lenovo ThinkPad L13 Yoga Gen.1 Core i5-10210u 1,6GHz 8GB 256GB FHD Touch Win11	233.24	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/147213500013?_skw=thinkpad&hash=item22469bbe6d:g:gtwAAeSwdRtpvGJ2	2026-03-20 12:35:30+11	2026-03-22 18:52:18.896466+11	2026-03-22 18:52:18.89647+11	\N	2026-03-22 18:52:18.896471+11	DE
21074	177	v1|147213499988|0	Lenovo ThinkPad T480s i5-8350U 1.7GHz 8GB 256GB 14" FHD Touch Win11 Pro	233.24	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/147213499988?_skw=thinkpad&hash=item22469bbe54:g:zCIAAeSwlYJpsBIC	2026-03-20 12:35:28+11	2026-03-22 18:52:18.897389+11	2026-03-22 18:52:18.897392+11	\N	2026-03-22 18:52:18.897393+11	DE
21075	177	v1|137149204819|0	RARE IBM Thinkpad T23 Pentium III 1Ghz 256MB ram 1024x768 Healthy Battery	145.26	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/137149204819?_skw=thinkpad&hash=item1feebac953:g:F6EAAeSwWpxpvIxE	2026-03-20 10:53:24+11	2026-03-22 18:52:18.898211+11	2026-03-22 18:52:18.898214+11	\N	2026-03-22 18:52:18.898215+11	GB
21076	177	v1|287218283512|0	Lenovo ThinkPad X13 Yoga Gen 2 Laptop  I5 8GB	239.90	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/287218283512?_skw=thinkpad&hash=item42df8b33f8:g:ktAAAeSw52VpvIM2	2026-03-20 10:23:33+11	2026-03-22 18:52:18.899031+11	2026-03-22 18:52:18.899033+11	\N	2026-03-22 18:52:18.899034+11	GB
21077	177	v1|147213213248|0	Lenovo ThinkPad X1 Carbon (6th Gen) Intel Core I5-8250U, 8GB RAM, 256GB SSD	95.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/147213213248?_skw=thinkpad&hash=item2246975e40:g:vXMAAeSwnNBpvHUv	2026-03-20 09:23:21+11	2026-03-22 18:52:18.899844+11	2026-03-22 18:52:18.899847+11	\N	2026-03-22 18:52:18.899848+11	GB
21078	177	v1|336490811197|0	Lenovo Thinkpad C13 Yoga G1 Chromebook AMD Ryzen 5 3500c 8GB RAM 128GB SSD 13.3"	99.99	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/336490811197?_skw=thinkpad&hash=item4e586a4f3d:g:hYgAAeSwlXFpraXr	2026-03-20 08:15:57+11	2026-03-22 18:52:18.900656+11	2026-03-22 18:52:18.900659+11	\N	2026-03-22 18:52:18.90066+11	GB
21079	177	v1|198207070720|0	Lenovo ThinkPad X1 Carbon Gen 9	599.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/198207070720?_skw=thinkpad&hash=item2e260fe200:g:IiIAAeSwxQtpvFKV	2026-03-20 08:08:22+11	2026-03-22 18:52:18.901463+11	2026-03-22 18:52:18.901466+11	\N	2026-03-22 18:52:18.901467+11	GB
21080	177	v1|206151787390|0	Lenovo ThinkPad L13 Yoga Gen 2 Spares 13 Touch No M/B No CPU No RAM No SSD No OS	39.99	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/206151787390?_skw=thinkpad&hash=item2fff9aa37e:g:7HIAAeSw~QlpvFBo	2026-03-20 06:37:37+11	2026-03-22 18:52:18.90227+11	2026-03-22 18:52:18.902273+11	\N	2026-03-22 18:52:18.902274+11	GB
21081	177	v1|327057584332|0	Lenovo ThinkPad L13 Yoga | i5-10210U 10th Gen | 8GB RAM | 256GB M.2 SSD | Touchs	225.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/327057584332?_skw=thinkpad&hash=item4c2626b0cc:g:D9UAAeSwxxJpu~2q	2026-03-20 06:34:33+11	2026-03-22 18:52:18.903233+11	2026-03-22 18:52:18.903236+11	\N	2026-03-22 18:52:18.903237+11	GB
21082	177	v1|377047480515|0	Lenovo ThinkPad X13 Gen 4 - i7 32GB Ram 512GB 13.3" Touch WTY 08/27 - Not Yoga	579.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/377047480515?_skw=thinkpad&hash=item57c9c7f8c3:g:ZjQAAeSwCGppvCcT	2026-03-20 06:30:01+11	2026-03-22 18:52:18.904084+11	2026-03-22 18:52:18.904087+11	\N	2026-03-22 18:52:18.904088+11	GB
21083	177	v1|377047622748|0	Lenovo ThinkPad X1 Yoga G7 i5 16GB Ram 2-in-1 lid casing has marks Battery 90%	329.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/377047622748?_skw=thinkpad&hash=item57c9ca245c:g:ZBYAAeSwAVppvD0v	2026-03-20 06:30:01+11	2026-03-22 18:52:18.9049+11	2026-03-22 18:52:18.904903+11	\N	2026-03-22 18:52:18.904904+11	GB
21084	177	v1|377047598309|0	Lenovo ThinkPad X1 Yoga Gen 8 i5 32GB Ram 512GB SSD 14" Touch 2-in-1 Win 11 Pro	549.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/377047598309?_skw=thinkpad&hash=item57c9c9c4e5:g:A2IAAeSw3RlpvDhq	2026-03-20 06:15:01+11	2026-03-22 18:52:18.905706+11	2026-03-22 18:52:18.905708+11	\N	2026-03-22 18:52:18.90571+11	GB
21085	177	v1|206151750627|0	Lenovo ThinkPad L13 Yoga Gen.2 Core i5-1135G7 2.4 GHz 8GB 256GB FHD Touch	281.69	GBP	Seller refurbished	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/206151750627?_skw=thinkpad&hash=item2fff9a13e3:g:~cMAAeSwxgZpvE2a	2026-03-20 06:10:55+11	2026-03-22 18:52:18.906522+11	2026-03-22 18:52:18.906525+11	\N	2026-03-22 18:52:18.906526+11	DE
21086	177	v1|377047549610|0	Lenovo ThinkPad X1 Yoga Gen 8 i7-1365U 32GB RAM 512GB 14" 2-in-1 Privacy Screen	579.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/377047549610?_skw=thinkpad&hash=item57c9c906aa:g:J0oAAeSwDKxpvDDT	2026-03-20 06:00:01+11	2026-03-22 18:52:18.907335+11	2026-03-22 18:52:18.907338+11	\N	2026-03-22 18:52:18.907339+11	GB
21087	177	v1|377047602278|0	Lenovo ThinkPad X1 Yoga G7 i5 16GB Ram 256GB SSD Convertible 2-in-1 battery 100%	369.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/377047602278?_skw=thinkpad&hash=item57c9c9d466:g:g2kAAeSwpPhpvDsN	2026-03-20 06:00:01+11	2026-03-22 18:52:18.90814+11	2026-03-22 18:52:18.908143+11	\N	2026-03-22 18:52:18.908144+11	GB
21088	177	v1|377047647851|0	Lenovo ThinkPad 15.6” Laptop Windows 11 Pro 4GB RAM Core Intel I5 500GB HDD	63.10	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/377047647851?_skw=thinkpad&hash=item57c9ca866b:g:tDAAAeSwEVVpvEIH	2026-03-20 05:40:34+11	2026-03-22 18:52:18.908946+11	2026-03-22 18:52:18.90895+11	\N	2026-03-22 18:52:18.908951+11	GB
21089	177	v1|298141011461|0	Lenovo ThinkPad T460s Laptop 14-inch, I5-6300U 2.4GHz	73.50	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/298141011461?_skw=thinkpad&hash=item456a96ce05:g:b6sAAeSwwYxpvDyE	2026-03-20 05:14:24+11	2026-03-22 18:52:18.909762+11	2026-03-22 18:52:18.909765+11	\N	2026-03-22 18:52:18.909766+11	GB
21090	177	v1|298140992462|0	Lenovo ThinkPad T490 Laptop 8GB. 256GB SSD, Windows 11 Pro. touscreen	94.30	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/298140992462?_skw=thinkpad&hash=item456a9683ce:g:UmkAAeSwYOVpvDsH	2026-03-20 05:07:59+11	2026-03-22 18:52:18.910596+11	2026-03-22 18:52:18.910599+11	\N	2026-03-22 18:52:18.9106+11	GB
21091	177	v1|157769780739|0	Thinkpad X240 1.90 GHz Core i5 4GB RAM 120GB SSD Dual Battery - Windows 10 Pro!!	109.90	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/157769780739?_skw=thinkpad&hash=item24bbcfce03:g:3tAAAeSwW15pvDXD	2026-03-20 05:07:07+11	2026-03-22 18:52:18.911466+11	2026-03-22 18:52:18.91147+11	\N	2026-03-22 18:52:18.911471+11	GB
21092	177	v1|227264182636|0	Lenovo ThinkPad T490s , 14" Full HD i5-8265U, 8GB RAM, 256GB SSD Windows 11	167.10	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/227264182636?_skw=thinkpad&hash=item34ea00396c:g:a6EAAeSwmelpvDjY	2026-03-20 04:58:49+11	2026-03-22 18:52:18.912366+11	2026-03-22 18:52:18.912369+11	\N	2026-03-22 18:52:18.91237+11	GB
21093	177	v1|358351389726|0	Lenovo ThinkPad T440p Laptop 8GB RAM, No SSD, No OS *READ DESCRIPTION*	73.50	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/358351389726?_skw=thinkpad&hash=item536f68441e:g:89IAAeSwFJtpvDiM	2026-03-20 04:57:20+11	2026-03-22 18:52:18.91318+11	2026-03-22 18:52:18.913183+11	\N	2026-03-22 18:52:18.913184+11	GB
21094	177	v1|267613858858|0	Lenovo ThinkPad P16s Gen 1 Ryzen 7 PRO 6850U 680M 32GB 1TB FHD+ Laptop	499.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/267613858858?_skw=thinkpad&hash=item3e4f076c2a:g:4bYAAeSwPvlpvDVN	2026-03-20 04:47:43+11	2026-03-22 18:52:18.913991+11	2026-03-22 18:52:18.913994+11	\N	2026-03-22 18:52:18.913995+11	GB
21095	177	v1|287217696930|0	Lenovo ThinkPad P16s Gen 3 16" WUXGA Intel Core Ultra 9 185H RAM 64GB SSD 1TB	1850.00	GBP	Opened – never used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/287217696930?_skw=thinkpad&hash=item42df8240a2:g:xdwAAeSwadlpPXqk	2026-03-20 04:31:57+11	2026-03-22 18:52:18.914801+11	2026-03-22 18:52:18.914803+11	\N	2026-03-22 18:52:18.914805+11	GB
21096	177	v1|327057412767|0	LENOVO THINPAD T490 8TH GEN CORE I5 16GB RAM 256GB SSD WIN11	182.70	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/327057412767?_skw=thinkpad&hash=item4c2624129f:g:kTMAAeSwW3RpvC53	2026-03-20 04:24:51+11	2026-03-22 18:52:18.91562+11	2026-03-22 18:52:18.915623+11	\N	2026-03-22 18:52:18.915624+11	GB
21097	177	v1|236700011428|0	Lenovo ThinkPad X1 Carbon 4th Gen Laptop 14-inch I7 6600U 8GB RAM 256GB SSD	94.26	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/236700011428?_skw=thinkpad&hash=item371c6b8ba4:g:FOIAAeSwciBpvC-z	2026-03-20 04:21:00+11	2026-03-22 18:52:18.916432+11	2026-03-22 18:52:18.916435+11	\N	2026-03-22 18:52:18.916436+11	GB
21098	177	v1|287217673694|0	Lenovo ThinkPad T14s 2in1 Gen 1 14" Intel Core Ultra 7 255U RAM 32GB SSD 512GB	1550.00	GBP	Opened – never used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/287217673694?_skw=thinkpad&hash=item42df81e5de:g:tVAAAeSw3nxpoEab	2026-03-20 04:20:25+11	2026-03-22 18:52:18.917262+11	2026-03-22 18:52:18.917265+11	\N	2026-03-22 18:52:18.917266+11	GB
21099	177	v1|117096571651|0	Lenovo ThinkPad X1 Carbon 6th Gen i7-8650U | 16GB | FHD Ultralight (1314)	301.26	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/117096571651?_skw=thinkpad&hash=item1b437fe303:g:w8oAAeSwiBBpvCAV	2026-03-20 04:16:09+11	2026-03-22 18:52:18.918072+11	2026-03-22 18:52:18.918075+11	\N	2026-03-22 18:52:18.918076+11	GB
21100	177	v1|127757671640|0	Lenovo Thinkpad T470S Laptop i7-6600u 20GB RAM 256GB SSD Win11Pro(J195)	149.99	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/127757671640?_skw=thinkpad&hash=item1dbef35cd8:g:5-YAAeSwUztpvC9F	2026-03-20 04:16:04+11	2026-03-22 18:52:18.918879+11	2026-03-22 18:52:18.918882+11	\N	2026-03-22 18:52:18.918883+11	GB
21101	177	v1|406785087313|0	lenovo thinkpad p14s gen 5 Intel Ultra Core Ultral 7	700.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/406785087313?_skw=thinkpad&hash=item5eb647d751:g:cvMAAeSwn-FpvCqc	2026-03-20 15:34:08+11	2026-03-22 18:52:18.919683+11	2026-03-22 18:52:18.919685+11	\N	2026-03-22 18:52:18.919686+11	GB
21102	177	v1|287217614228|0	Lenovo ThinkPad X1 Carbon Gen 13/2.8K Touch/ Intel Ultra 7 265U/64GB RAM/1TB SSD	2499.00	GBP	Opened – never used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/287217614228?_skw=thinkpad&hash=item42df80fd94:g:JC8AAeSwpxZofzxs	2026-03-20 03:51:52+11	2026-03-22 18:52:18.920486+11	2026-03-22 18:52:18.920489+11	\N	2026-03-22 18:52:18.920489+11	GB
21103	177	v1|358351249069|0	Lenovo ThinkPad X1 Carbon Gen 13 Aura/Touch/ Intel Ultra 7 268V/32GB RAM/2TB SSD	1950.00	GBP	Opened – never used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/358351249069?_skw=thinkpad&hash=item536f661ead:g:JC8AAeSwpxZofzxs	2026-03-20 03:51:13+11	2026-03-22 18:52:18.921294+11	2026-03-22 18:52:18.921297+11	\N	2026-03-22 18:52:18.921298+11	GB
21104	177	v1|327057362387|0	Lenovo ThinkPad T480s 8th Gen I5, 16GB RAM, 256GB SSD, Win 11 Pro	182.70	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/327057362387?_skw=thinkpad&hash=item4c26234dd3:g:hRMAAeSwFOBpvCJH	2026-03-20 03:42:41+11	2026-03-22 18:52:18.922104+11	2026-03-22 18:52:18.922106+11	\N	2026-03-22 18:52:18.922107+11	GB
21105	177	v1|366289080574|0	Lenovo ThinkPad E15 i7-10510U Radeon RX 640 16GB Ram 512GB SSD Win11Pro(J193)	259.99	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/366289080574?_skw=thinkpad&hash=item554887d0fe:g:1KcAAeSw8o5pvCXc	2026-03-20 03:37:12+11	2026-03-22 18:52:18.922896+11	2026-03-22 18:52:18.922899+11	\N	2026-03-22 18:52:18.9229+11	GB
21106	177	v1|177974379295|0	Lenovo ThinkPad X1 Carbon 4th Gen 14" Laptop i7 6th Gen 8GB RAM 256GB SSD Win 11	159.61	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/177974379295?_skw=thinkpad&hash=item297019831f:g:t9MAAeSwlCtpvCTv	2026-03-20 03:31:59+11	2026-03-22 18:52:18.923861+11	2026-03-22 18:52:18.923864+11	\N	2026-03-22 18:52:18.923865+11	GB
21107	177	v1|198206532359|0	Lenovo ThinkPad X13 2-in-1 Gen 5 Ultra 7 155U 32GB 512GB Touch Win11 + Charger	1100.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/198206532359?_skw=thinkpad&hash=item2e2607ab07:g:xlsAAeSwDFNpvCGA	2026-03-20 03:22:38+11	2026-03-22 18:52:18.924702+11	2026-03-22 18:52:18.924705+11	\N	2026-03-22 18:52:18.924706+11	GB
21108	177	v1|117096466493|0	Lenovo ThinkPad T495 14" Laptop - Ryzen 7 Pro - 8GB RAM - 256GB SSD (OFFERS OK)	195.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/117096466493?_skw=thinkpad&hash=item1b437e483d:g:d3cAAeSw~QlpvB3f	2026-03-20 03:07:44+11	2026-03-22 18:52:18.925509+11	2026-03-22 18:52:18.925512+11	\N	2026-03-22 18:52:18.925513+11	GB
21109	177	v1|117096459850|0	Lenovo ThinkPad X395 13.3" Laptop -Ryzen 7 Pro - 16GB RAM- 256GB SSD (OFFERS OK)	210.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/117096459850?_skw=thinkpad&hash=item1b437e2e4a:g:Xm0AAeSwG55pvBz9	2026-03-20 02:58:45+11	2026-03-22 18:52:18.926315+11	2026-03-22 18:52:18.926317+11	\N	2026-03-22 18:52:18.926318+11	GB
21110	177	v1|177974324616|0	Lenovo ThinkPad T14s Gen 1 14" Laptop i5-10210U Gen 8GB RAM 256GB SSD Windows 11	149.71	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/177974324616?_skw=thinkpad&hash=item297018ad88:g:A-AAAeSw-6ZpvBzp	2026-03-20 02:57:45+11	2026-03-22 18:52:18.927235+11	2026-03-22 18:52:18.927239+11	\N	2026-03-22 18:52:18.92724+11	GB
21111	177	v1|117096457112|0	Lenovo ThinkPad X395 13.3" Laptop -Ryzen 7 Pro - 16GB RAM- 256GB SSD (OFFERS OK)	210.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/117096457112?_skw=thinkpad&hash=item1b437e2398:g:bAkAAeSwxf5pvBwL	2026-03-20 02:54:59+11	2026-03-22 18:52:18.928214+11	2026-03-22 18:52:18.928217+11	\N	2026-03-22 18:52:18.928219+11	GB
21112	177	v1|117096452287|0	Lenovo ThinkPad X395 13.3" Laptop -Ryzen 7 Pro - 16GB RAM- 256GB SSD (OFFERS OK)	210.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/117096452287?_skw=thinkpad&hash=item1b437e10bf:g:WDcAAeSwMnNpvBmw	2026-03-20 02:50:57+11	2026-03-22 18:52:18.929035+11	2026-03-22 18:52:18.929038+11	\N	2026-03-22 18:52:18.929039+11	GB
21113	177	v1|318029598979|0	Lenovo ThinkPad X1 Yoga Gen 8 i5-1335  16GB RAM 256GB SSD 14"  lte internet	440.20	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/318029598979?_skw=thinkpad&hash=item4a0c0a9103:g:6k4AAeSwfUJpvBcI	2026-03-20 02:40:56+11	2026-03-22 18:52:18.929846+11	2026-03-22 18:52:18.929849+11	\N	2026-03-22 18:52:18.92985+11	GB
21114	177	v1|157769539662|0	Lenovo ThinkPad X1 Yoga 4th Gen i5-8265U 8GB 256GB Win 11 14" Touch	145.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/157769539662?_skw=thinkpad&hash=item24bbcc204e:g:sTQAAeSwjyRpu~13	2026-03-20 02:40:47+11	2026-03-22 18:52:18.930649+11	2026-03-22 18:52:18.930652+11	\N	2026-03-22 18:52:18.930653+11	GB
21115	177	v1|358351014724|0	Lenovo ThinkPad X1 Carbon Gen 12 - Ultra 7 165U, 32GB RAM, 512GB SSD	924.69	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/358351014724?_skw=thinkpad&hash=item536f628b44:g:bdEAAeSwa~1pvBZQ	2026-03-20 02:29:58+11	2026-03-22 18:52:18.931478+11	2026-03-22 18:52:18.931481+11	\N	2026-03-22 18:52:18.931482+11	GB
21116	177	v1|127757514713|0	Lenovo Thinkpad E14 gen 1 Intel i7, 16GB RAM 480GB SSD, 2020, Win11 , RRP 1200	158.76	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/127757514713?_skw=thinkpad&hash=item1dbef0f7d9:g:ShAAAeSwMGhpvBMe	2026-03-20 02:19:21+11	2026-03-22 18:52:18.932292+11	2026-03-22 18:52:18.932295+11	\N	2026-03-22 18:52:18.932296+11	GB
21117	177	v1|377047313393|0	Lenovo ThinkPad E15 Laptop, i5 10210U, 8GB RAM, 256GB NVMe	180.00	GBP	Used	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/377047313393?_skw=thinkpad&hash=item57c9c56bf1:g:~mMAAeSwv6JpvBFM	2026-03-20 02:14:01+11	2026-03-22 18:52:18.93309+11	2026-03-22 18:52:18.933093+11	\N	2026-03-22 18:52:18.933094+11	GB
21118	177	v1|389770479162|0	Lenovo ThinkPad E15 Gen 2 Core i5 1135G7 16gb Memory 256gb SSD 15.6In FHD (7252)	275.00	GBP	Used	FIXED_PRICE,BEST_OFFER	EBAY_GB	https://www.ebay.co.uk/itm/389770479162?_skw=thinkpad&hash=item5ac021863a:g:5NMAAeSwH5FpfKtp	2026-03-20 02:06:59+11	2026-03-22 18:52:18.933893+11	2026-03-22 18:52:18.933895+11	\N	2026-03-22 18:52:18.933896+11	GB
21119	177	v1|406783306369|0	Lenovo Thinkpad L16 Gen 2 21SA001UUK 40.6 Cm 16" Notebook Wuxga Intel Core Ultra	1247.75	GBP	New	FIXED_PRICE	EBAY_GB	https://www.ebay.co.uk/itm/406783306369?_skw=thinkpad&hash=item5eb62caa81:g:a5kAAeSwyc1pvy~C	2026-03-20 01:53:36+11	2026-03-22 18:52:18.934703+11	2026-03-22 18:52:18.934706+11	\N	2026-03-22 18:52:18.934707+11	GB
21120	177	v1|188194036563|0	Lenovo ThinkPad L16 Gen 2 Ryzen 5 Pro 215 Radeon 740M 512GB 16GB 1920 x 1200	1518.91	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188194036563?_skw=thinkpad&hash=item2bd13d1b53:g:w3AAAeSw5OJpv5WZ	2026-03-22 18:07:09+11	2026-03-22 18:52:18.935504+11	2026-03-22 18:52:18.935507+11	\N	2026-03-22 18:52:18.935509+11	DE
21121	177	v1|127762890379|0	lenovo thinkpad E595 TOP Mit Windows 11pro  Installiert	150.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/127762890379?_skw=thinkpad&hash=item1dbf42fe8b:g:B~QAAeSwj0Rpv4zJ	2026-03-22 17:41:12+11	2026-03-22 18:52:18.936311+11	2026-03-22 18:52:18.936314+11	\N	2026-03-22 18:52:18.936315+11	DE
21122	177	v1|287223675010|0	Lenovo ThinkPad T490 - i7-8565U 16GB 512GB SSD WQHD - Nvidia MX250 DE Win11 Pro	349.99	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/287223675010?_skw=thinkpad&hash=item42dfdd7882:g:quMAAeSw9-9pv4cg	2026-03-22 17:11:27+11	2026-03-22 18:52:18.937114+11	2026-03-22 18:52:18.937117+11	\N	2026-03-22 18:52:18.937118+11	DE
21123	177	v1|318041484537|0	Lenovo ThinkPad X1 Carbon Gen 10 i5 8GB 256GB SSD 14" Laptop Gebraucht	504.99	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/318041484537?_skw=thinkpad&hash=item4a0cbfecf9:g:J3MAAeSw3mtpv3h4	2026-03-22 16:01:53+11	2026-03-22 18:52:18.937941+11	2026-03-22 18:52:18.937944+11	\N	2026-03-22 18:52:18.937945+11	JP
21124	177	v1|188193551864|0	Lenovo ThinkPad P14s Gen 5 Ryzen 7 Pro 8840HS Radeon 780M 1TB 32GB 1920 x 1200	2035.39	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188193551864?_skw=thinkpad&hash=item2bd135b5f8:g:ISgAAeSwWu5pv2ch	2026-03-22 14:47:51+11	2026-03-22 18:52:18.938746+11	2026-03-22 18:52:18.93875+11	\N	2026-03-22 18:52:18.938751+11	DE
21125	177	v1|358359762305|0	Lenovo V15 G2 IJL Laptop - Type82QY	199.99	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/358359762305?_skw=thinkpad&hash=item536fe80581:g:z8kAAeSwYqFpvzUb	2026-03-22 11:20:10+11	2026-03-22 18:52:18.939554+11	2026-03-22 18:52:18.939557+11	\N	2026-03-22 18:52:18.939558+11	DE
21126	177	v1|147216742325|0	Lenovo ThinkPad T460 i5-6300U 12GB 480GB Intel SSD DC S3510 Series Win 10 Pro	180.00	EUR	Gebraucht	FIXED_PRICE,AUCTION	EBAY_DE	https://www.ebay.de/itm/147216742325?_skw=thinkpad&hash=item2246cd37b5:g:vcwAAeSwD7RpvzSb	2026-03-22 11:17:37+11	2026-03-22 18:52:18.940357+11	2026-03-22 18:52:18.94036+11	\N	2026-03-22 18:52:18.940361+11	DE
21127	177	v1|236704486715|0	Lenovo ThinkPad E570 Laptop – Intel Core i5-7200U	120.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/236704486715?_skw=thinkpad&hash=item371cafd53b:g:M2wAAeSwoSJpvy14	2026-03-22 10:45:13+11	2026-03-22 18:52:18.941165+11	2026-03-22 18:52:18.941168+11	\N	2026-03-22 18:52:18.941169+11	DE
21128	177	v1|257418588476|0	Lenovo ThinkPad X390 – 13,3" (33,8 cm), 256 GB SSD, Intel Core i7 8. Gen, 16 RAM	250.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/257418588476?_skw=thinkpad&hash=item3bef57f13c:g:BWgAAeSwTgFpvyII	2026-03-22 10:01:11+11	2026-03-22 18:52:18.942522+11	2026-03-22 18:52:18.942527+11	\N	2026-03-22 18:52:18.942528+11	DE
21129	177	v1|287222809191|0	Lenovo ThinkPad E15 Gen 2 i5-1135G7 32GB RAM 250GB SSD Win 11 Pro	450.00	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/287222809191?_skw=thinkpad&hash=item42dfd04267:g:apkAAeSwdr5pvx56	2026-03-22 09:38:44+11	2026-03-22 18:52:18.94354+11	2026-03-22 18:52:18.943544+11	\N	2026-03-22 18:52:18.943545+11	DE
21130	177	v1|127762220284|0	Lenovo ThinkPad E14 G5 14“ Core i7-1335U 512 GB SSD 16 GB #Sehr gut QWERTZ Mwst.	599.00	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/127762220284?_skw=thinkpad&hash=item1dbf38c4fc:g:o9EAAeSwQytpvxIy	2026-03-22 08:52:40+11	2026-03-22 18:52:18.944392+11	2026-03-22 18:52:18.944395+11	\N	2026-03-22 18:52:18.944396+11	AT
21131	177	v1|188192578228|0	Lenovo ThinkPad L16 Gen 1 Ryzen 5 Pro 7535U Radeon 660M 512GB 16GB 1920 x 1200	1340.59	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192578228?_skw=thinkpad&hash=item2bd126dab4:g:zJgAAeSwgHhpvw8~	2026-03-22 08:31:58+11	2026-03-22 18:52:18.945466+11	2026-03-22 18:52:18.94547+11	\N	2026-03-22 18:52:18.945471+11	DE
21132	177	v1|188192578033|0	Lenovo ThinkPad L16 Gen 1 Ryzen 5 Pro 7535U AMD Radeon 660M 512GB 16GB	1340.59	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192578033?_skw=thinkpad&hash=item2bd126d9f1:g:aQ0AAeSw4R1pvw96	2026-03-22 08:31:53+11	2026-03-22 18:52:18.9463+11	2026-03-22 18:52:18.946303+11	\N	2026-03-22 18:52:18.946304+11	DE
21133	177	v1|188192577852|0	Lenovo ThinkPad T16 Gen 4 Core Ultra 5 225U 512GB 16GB 1920 x 1200 16.0" Zoll	1895.19	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192577852?_skw=thinkpad&hash=item2bd126d93c:g:1a4AAeSwmFBpvw9l	2026-03-22 08:31:47+11	2026-03-22 18:52:18.94711+11	2026-03-22 18:52:18.947113+11	\N	2026-03-22 18:52:18.947114+11	DE
21134	177	v1|188192577451|0	Lenovo ThinkPad L14 Gen 5 Core Ultra 5 125U 262GB 16GB 1920 x 1200 14.0" Zoll	1287.39	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192577451?_skw=thinkpad&hash=item2bd126d7ab:g:nukAAeSwXslpvw9o	2026-03-22 08:31:35+11	2026-03-22 18:52:18.947923+11	2026-03-22 18:52:18.947925+11	\N	2026-03-22 18:52:18.947926+11	DE
21135	177	v1|188192577151|0	Lenovo ThinkPad P14s Gen 5 Ryzen 7 Pro 8840HS Radeon 780M 1TB 32GB 1920 x 1200	1795.39	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192577151?_skw=thinkpad&hash=item2bd126d67f:g:EQsAAeSwwkppvw8k	2026-03-22 08:31:29+11	2026-03-22 18:52:18.948733+11	2026-03-22 18:52:18.948736+11	\N	2026-03-22 18:52:18.948737+11	DE
21136	177	v1|188192574393|0	Lenovo ThinkPad X1 Carbon G13 Core Ultra 7 268V 140V 2TB 32GB 2880 x 1800	2917.00	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192574393?_skw=thinkpad&hash=item2bd126cbb9:g:yLAAAeSwBf9pvw7A	2026-03-22 08:30:49+11	2026-03-22 18:52:18.949549+11	2026-03-22 18:52:18.949552+11	\N	2026-03-22 18:52:18.949553+11	DE
21137	177	v1|188192561490|0	Lenovo ThinkPad X9-14 G1 Core Ultra 5 Intel 226V 130V 512GB 16GB	1324.59	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192561490?_skw=thinkpad&hash=item2bd1269952:g:aDcAAeSwLqFpvw5G	2026-03-22 08:28:47+11	2026-03-22 18:52:18.950363+11	2026-03-22 18:52:18.950366+11	\N	2026-03-22 18:52:18.950367+11	DE
21138	177	v1|188192559016|0	Lenovo ThinkPad L13 Yoga Gen 2 Core i5 11th Gen 1135G7 262GB 8GB 1920 x 1080	743.89	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192559016?_skw=thinkpad&hash=item2bd1268fa8:g:2SoAAeSwEJppvw7Z	2026-03-22 08:28:27+11	2026-03-22 18:52:18.951193+11	2026-03-22 18:52:18.951196+11	\N	2026-03-22 18:52:18.951197+11	DE
21139	177	v1|327061273640|0	IBM ThinkPad T23 P3 833MHz 256MB 80GB DVD RS232 LPT 2xUSB S3 SuperSavage WinXP	169.99	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/327061273640?_skw=thinkpad&hash=item4c265efc28:g:q6AAAeSwLW1pvwh6	2026-03-22 08:10:26+11	2026-03-22 18:52:18.951992+11	2026-03-22 18:52:18.951994+11	\N	2026-03-22 18:52:18.951995+11	DE
21140	177	v1|137154770517|0	ThinkPad X12 Detachable Gen 1 Type 20UW I5-1140G7 16GB 512GB 12,3" Win 11 Pro DE	489.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/137154770517?_skw=thinkpad&hash=item1fef0fb655:g:LTUAAeSw8NdpvwTC	2026-03-22 07:54:40+11	2026-03-22 18:52:18.95279+11	2026-03-22 18:52:18.952793+11	\N	2026-03-22 18:52:18.952794+11	DE
21141	177	v1|188192436778|0	Lenovo ThinkPad X1 Carbon G13 Core Ultra 7 258V Arc 140V 32GB 1920 x 1200	2665.95	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192436778?_skw=thinkpad&hash=item2bd124b22a:g:fuIAAeSwmsVpvwNx	2026-03-22 07:41:31+11	2026-03-22 18:52:18.953598+11	2026-03-22 18:52:18.953601+11	\N	2026-03-22 18:52:18.953602+11	DE
21142	177	v1|188192434586|0	Lenovo ThinkPad L13 Yoga Gen 4 Ryzen 5 7530U 512GB 16GB 1920 x 1200 13.0" Zoll	1034.39	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192434586?_skw=thinkpad&hash=item2bd124a99a:g:Lq0AAeSwxnBpvwMN	2026-03-22 07:39:55+11	2026-03-22 18:52:18.954404+11	2026-03-22 18:52:18.954407+11	\N	2026-03-22 18:52:18.954408+11	DE
21143	177	v1|188192434454|0	Lenovo ThinkPad L13 Yoga Gen 4 Core i5 13th Gen 1335U 512GB 8GB 1920 x 1200	879.79	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192434454?_skw=thinkpad&hash=item2bd124a916:g:mFwAAeSwHnppvwNE	2026-03-22 07:39:50+11	2026-03-22 18:52:18.955232+11	2026-03-22 18:52:18.955235+11	\N	2026-03-22 18:52:18.955236+11	DE
21144	177	v1|188192434232|0	Lenovo ThinkPad P16 Gen 2 Core i7 13th Gen 13850HX RTX 3500 Ada 1TB 32GB	3431.39	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192434232?_skw=thinkpad&hash=item2bd124a838:g:lo8AAeSwZgVpvwM~	2026-03-22 07:39:45+11	2026-03-22 18:52:18.956042+11	2026-03-22 18:52:18.956045+11	\N	2026-03-22 18:52:18.956046+11	DE
21145	177	v1|188192433854|0	Lenovo ThinkPad X9-14 G1 Core Ultra 5 228V 130V 1TB 32GB 2880 x 1800 14.0" Zoll	1327.19	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192433854?_skw=thinkpad&hash=item2bd124a6be:g:jA4AAeSwXERpvwMt	2026-03-22 07:39:34+11	2026-03-22 18:52:18.956845+11	2026-03-22 18:52:18.956848+11	\N	2026-03-22 18:52:18.956849+11	DE
21146	177	v1|188192433239|0	Lenovo ThinkPad X13 G4 Core i5 13th Gen i5-1335U 512GB 16GB 1920 x 1200 WUXGA	1120.89	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192433239?_skw=thinkpad&hash=item2bd124a457:g:WKwAAeSwUrVpvwJr	2026-03-22 07:39:10+11	2026-03-22 18:52:18.957675+11	2026-03-22 18:52:18.957678+11	\N	2026-03-22 18:52:18.957679+11	DE
21147	177	v1|188192433151|0	Lenovo ThinkPad T14 G3 Core i5 12th Gen i5-1245U 262GB 16GB 1920 x 1200 WUXGA	1038.39	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192433151?_skw=thinkpad&hash=item2bd124a3ff:g:PiAAAeSw~QxpvwJj	2026-03-22 07:39:05+11	2026-03-22 18:52:18.958546+11	2026-03-22 18:52:18.95855+11	\N	2026-03-22 18:52:18.958552+11	DE
21148	177	v1|188192432897|0	Lenovo ThinkPad P16 G1 Core i9 12th Gen i9-12950HX 1TB 16GB 3840 x 2400 WQUXGA	1933.91	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192432897?_skw=thinkpad&hash=item2bd124a301:g:mPsAAeSwGkFpvwMM	2026-03-22 07:38:55+11	2026-03-22 18:52:18.959522+11	2026-03-22 18:52:18.959525+11	\N	2026-03-22 18:52:18.959527+11	DE
21149	177	v1|188192432498|0	Lenovo ThinkPad L13 G4 Ryzen 7 Pro 7730U 1TB 32GB 1920 x 1200 13.0" Zoll touch	1222.00	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192432498?_skw=thinkpad&hash=item2bd124a172:g:jrwAAeSw8otpvwL5	2026-03-22 07:38:38+11	2026-03-22 18:52:18.960342+11	2026-03-22 18:52:18.960345+11	\N	2026-03-22 18:52:18.960346+11	DE
21150	177	v1|147216409855|0	ThinkPad X12 Detachable Gen 1 Type 20UW I5-1140G7 16GB 512GB 12,3" Win 11 Pro DE	499.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/147216409855?_skw=thinkpad&hash=item2246c824ff:g:Co4AAeSw4GhpvvKy	2026-03-22 06:36:30+11	2026-03-22 18:52:18.961147+11	2026-03-22 18:52:18.96115+11	\N	2026-03-22 18:52:18.961151+11	DE
21151	177	v1|188192230989|0	Lenovo ThinkPad 14 Gen 7 Ryzen 5 7th Gen 7533HS 512GB 16GB 1920x1200 14.0" Zoll	895.79	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192230989?_skw=thinkpad&hash=item2bd1218e4d:g:BCEAAeSwgHhpvvEh	2026-03-22 06:24:26+11	2026-03-22 18:52:18.961956+11	2026-03-22 18:52:18.961959+11	\N	2026-03-22 18:52:18.96196+11	DE
21152	177	v1|188192230443|0	Lenovo ThinkPad X1 Yoga Gen 10 G10 Core Ultra 7 258V 1TB 32GB 2880x1800	1940.93	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188192230443?_skw=thinkpad&hash=item2bd1218c2b:g:5DIAAeSwEE5pvvF5	2026-03-22 06:24:04+11	2026-03-22 18:52:18.962774+11	2026-03-22 18:52:18.962777+11	\N	2026-03-22 18:52:18.962778+11	DE
21153	177	v1|257418183884|0	Lenovo ThinkPad X13 Laptop 13"  AMD  Gen 10 8GB RAM 256GB SSD Win11 B-Ware	189.00	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/257418183884?_skw=thinkpad&hash=item3bef51c4cc:g:e1kAAeSwz8lpvucF	2026-03-22 05:40:19+11	2026-03-22 18:52:18.963583+11	2026-03-22 18:52:18.963586+11	\N	2026-03-22 18:52:18.963587+11	NL
21154	177	v1|257418183889|0	Lenovo ThinkPad X13 Laptop 13"  AMD  Gen 10 8GB RAM 256GB SSD Win11 C-Ware	123.00	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/257418183889?_skw=thinkpad&hash=item3bef51c4d1:g:ceQAAeSwGn1pvuZU	2026-03-22 05:40:19+11	2026-03-22 18:52:18.964415+11	2026-03-22 18:52:18.964418+11	\N	2026-03-22 18:52:18.964419+11	NL
21155	177	v1|257418183877|0	Lenovo ThinkPad L13 Gen 2 Laptop 13"  Intel i5 16GB RAM 256GB SSD Win11 C-Ware	195.00	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/257418183877?_skw=thinkpad&hash=item3bef51c4c5:g:o9oAAeSwDLhpvucA	2026-03-22 05:40:18+11	2026-03-22 18:52:18.965379+11	2026-03-22 18:52:18.965383+11	\N	2026-03-22 18:52:18.965384+11	NL
21156	177	v1|257418183883|0	Lenovo ThinkPad X13 Laptop 13"  AMD  Gen 10 16GB RAM 256GB SSD Win11 A-Ware	279.00	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/257418183883?_skw=thinkpad&hash=item3bef51c4cb:g:r04AAeSwqJ9pvuZU	2026-03-22 05:40:18+11	2026-03-22 18:52:18.96621+11	2026-03-22 18:52:18.966213+11	\N	2026-03-22 18:52:18.966214+11	NL
21157	177	v1|397743839123|0	Lenovo ThinkPad E15 Gen2, Intel I7-1165G7, 16GB RAM, 256GB SSD, 15.6" Win11	310.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/397743839123?_skw=thinkpad&hash=item5c9b615793:g:wyoAAeSwZgVpvuSa	2026-03-22 05:37:12+11	2026-03-22 18:52:18.967023+11	2026-03-22 18:52:18.967026+11	\N	2026-03-22 18:52:18.967027+11	DE
21158	177	v1|406789214957|0	IBM Thinkpad R40 /2722 mit Windows XP / Pentium M 1,4Ghz / 120GB HDD / 512MB RAM	39.00	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/406789214957?_skw=thinkpad&hash=item5eb686d2ed:g:cx8AAeSwo3VpvtcG	2026-03-22 04:42:59+11	2026-03-22 18:52:18.967846+11	2026-03-22 18:52:18.967849+11	\N	2026-03-22 18:52:18.96785+11	DE
21159	177	v1|287222307277|0	Lenovo ThinkPad E14 Gen 6 - 35.6 cm (14") - Ryzen 5 7535HS - 16 GB RAM -  #EG544	1132.61	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287222307277?_skw=thinkpad&hash=item42dfc899cd:g:HSEAAeSwXslpvtXZ	2026-03-22 04:31:08+11	2026-03-22 18:52:18.968651+11	2026-03-22 18:52:18.968654+11	\N	2026-03-22 18:52:18.968655+11	DE
21160	177	v1|389779373984|0	Lenovo ThinkPad L16 G1 Intel Core Ultra 5 135U 16GB 512GB	599.99	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/389779373984?_skw=thinkpad&hash=item5ac0a93fa0:g:THIAAeSwUMZpvtAr	2026-03-22 04:28:08+11	2026-03-22 18:52:18.969887+11	2026-03-22 18:52:18.969891+11	\N	2026-03-22 18:52:18.969892+11	HR
21161	177	v1|117100212389|0	Laptop Lenovo thinkpad t570 i7  SSD 500 gb 16 gb RAM	199.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/117100212389?_skw=thinkpad&hash=item1b43b770a5:g:-TgAAeSwMoRpvs~h	2026-03-22 04:27:25+11	2026-03-22 18:52:18.970742+11	2026-03-22 18:52:18.970745+11	\N	2026-03-22 18:52:18.970746+11	DE
21162	177	v1|147216224178|0	Lenovo ThinkPad T580 i7 8th Gen	120.00	EUR	Gebraucht	FIXED_PRICE,AUCTION	EBAY_DE	https://www.ebay.de/itm/147216224178?_skw=thinkpad&hash=item2246c54fb2:g:TzgAAeSwYC5pvtFf	2026-03-22 04:13:54+11	2026-03-22 18:52:18.971548+11	2026-03-22 18:52:18.971551+11	\N	2026-03-22 18:52:18.971552+11	DE
21163	177	v1|227266895790|0	Lenovo ThinkPad T470p 14" Intel  i7-7700HQ 2,80GHz 256GB SSD 16GB RAM DE	219.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/227266895790?_skw=thinkpad&hash=item34ea299fae:g:rKMAAeSwERtpnYJA	2026-03-22 04:05:43+11	2026-03-22 18:52:18.97237+11	2026-03-22 18:52:18.972373+11	\N	2026-03-22 18:52:18.972374+11	DE
21164	177	v1|188191871905|0	lenovo thinkpad e 580 i7 8th gen	195.00	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188191871905?_skw=thinkpad&hash=item2bd11c13a1:g:QA8AAeSwUMZpvs3q	2026-03-22 04:01:56+11	2026-03-22 18:52:18.973173+11	2026-03-22 18:52:18.973176+11	\N	2026-03-22 18:52:18.973177+11	DE
21165	177	v1|358358712767|0	Lenovo ThinkPad E15 Intel I3 10110U	180.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/358358712767?_skw=thinkpad&hash=item536fd801bf:g:4k8AAeSwGa5pvsYO	2026-03-22 03:27:59+11	2026-03-22 18:52:18.973987+11	2026-03-22 18:52:18.973991+11	\N	2026-03-22 18:52:18.973994+11	DE
21166	177	v1|206156262241|0	Lenovo ThinkPad T480 – 14" FHD | i5-8350U | 08GB RAM | 256GB SSD | Windows 11Pro	179.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/206156262241?_skw=thinkpad&hash=item2fffdeeb61:g:-SwAAeSwsAJpvsRN	2026-03-22 03:22:46+11	2026-03-22 18:52:18.975511+11	2026-03-22 18:52:18.975516+11	\N	2026-03-22 18:52:18.975517+11	DE
21167	177	v1|318039081823|0	Lenovo Thinkpad W700ds Windows 10 8GB RAM 2x120GB Festplatte Laptop Getestet ✅	1499.99	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/318039081823?_skw=thinkpad&hash=item4a0c9b435f:g:i54AAeSwY0hpvrwy	2026-03-22 02:45:48+11	2026-03-22 18:52:18.97693+11	2026-03-22 18:52:18.976935+11	\N	2026-03-22 18:52:18.976937+11	DE
21168	177	v1|188191657970|0	Nr.2 Lenovo ThinkPad T420 mit Windows 10 ** Intel Core i5 * 256 GB SSD * 6GB Ram	60.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/188191657970?_skw=thinkpad&hash=item2bd118cff2:g:eDAAAeSwl2hpvrjd	2026-03-22 02:35:16+11	2026-03-22 18:52:18.97809+11	2026-03-22 18:52:18.978095+11	\N	2026-03-22 18:52:18.978096+11	DE
21169	177	v1|188191612826|0	Nr.1 Lenovo ThinkPad T420 mit Ubuntu (Linux) ** Intel Core i5 * 500 GB HDD * 4GB	55.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/188191612826?_skw=thinkpad&hash=item2bd1181f9a:g:fUwAAeSwiuFpvrRa	2026-03-22 02:24:02+11	2026-03-22 18:52:18.979368+11	2026-03-22 18:52:18.979371+11	\N	2026-03-22 18:52:18.979373+11	DE
21170	177	v1|397743271551|0	Lenovo ThinkPad T490s, I5-8365U	250.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/397743271551?_skw=thinkpad&hash=item5c9b58ae7f:g:gLUAAeSwpAtpvrNM	2026-03-22 02:04:43+11	2026-03-22 18:52:18.980308+11	2026-03-22 18:52:18.98031+11	\N	2026-03-22 18:52:18.980311+11	DE
21171	177	v1|389778901534|0	Lenovo ThinkPad 11th Gen  i5-1135G7 16GB 256GB Win11Pro/DE.	379.00	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/389778901534?_skw=thinkpad&hash=item5ac0a20a1e:g:6hUAAeSw95tpvp6p	2026-03-22 01:43:20+11	2026-03-22 18:52:18.981142+11	2026-03-22 18:52:18.981145+11	\N	2026-03-22 18:52:18.981147+11	DE
21172	177	v1|117100012230|0	Lenovo ThinkPad P52s Touch - i7-8550U 4x1,8GHz,16GB,512GB NVMe,P500,FHD,FPR,BL	589.00	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/117100012230?_skw=thinkpad&hash=item1b43b462c6:g:J1oAAeSw6V1pvqyK	2026-03-22 01:38:24+11	2026-03-22 18:52:18.981987+11	2026-03-22 18:52:18.981989+11	\N	2026-03-22 18:52:18.98199+11	DE
21173	177	v1|298147099601|0	E-INK Lenovo Thinkpad Plus G4 i7-1355U 16GB Ram 512GB SSD Laptop PC Paperlike	1490.00	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/298147099601?_skw=thinkpad&hash=item456af3b3d1:g:BQkAAeSwT3xpvqxy	2026-03-22 01:35:36+11	2026-03-22 18:52:18.982881+11	2026-03-22 18:52:18.982884+11	\N	2026-03-22 18:52:18.982886+11	DE
21174	177	v1|406788911872|0	Lenovo Thinkpad x280 i5-7200U / Windows 11 / 256GB HDD / 8GB RAM / sehr gepflegt	119.00	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/406788911872?_skw=thinkpad&hash=item5eb6823300:g:yq4AAeSwlf1pts8y	2026-03-22 01:32:53+11	2026-03-22 18:52:18.983702+11	2026-03-22 18:52:18.983705+11	\N	2026-03-22 18:52:18.983707+11	DE
21175	177	v1|298147081977|0	Lenovo ThinkPad T16g Gen 3 - Intel Ultra 7 - 16" - Ultra 7 - 1.000 GB #BY914	4502.07	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/298147081977?_skw=thinkpad&hash=item456af36ef9:g:FUsAAeSwSoJpvqtt	2026-03-22 01:30:10+11	2026-03-22 18:52:18.984514+11	2026-03-22 18:52:18.984517+11	\N	2026-03-22 18:52:18.984518+11	DE
21176	177	v1|188191408438|0	IBM ThinkPad X41, Intel Pentium M 1.50Ghz, 1.5GB RAM, 40GB HDD + Extras	250.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/188191408438?_skw=thinkpad&hash=item2bd1150136:g:-ZMAAeSwRqppvqAl	2026-03-22 00:59:09+11	2026-03-22 18:52:18.985325+11	2026-03-22 18:52:18.985328+11	\N	2026-03-22 18:52:18.985329+11	HR
21177	177	v1|227266711754|0	Lenovo ThinkPad T470s I7 8GB RAM 512GB SSD LTE 14" FHD	130.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/227266711754?_skw=thinkpad&hash=item34ea26d0ca:g:xcIAAeSw4JZpqWIZ	2026-03-22 00:56:06+11	2026-03-22 18:52:18.986138+11	2026-03-22 18:52:18.986141+11	\N	2026-03-22 18:52:18.986142+11	DE
21178	177	v1|397743071865|0	Lenovo ThinkPad X1 Carbon Gen 12 / Ultra 7 155U / 32 GB / 512 GB SSD / EN INT KB	1300.00	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/397743071865?_skw=thinkpad&hash=item5c9b55a279:g:CnUAAeSwGMhpvqEe	2026-03-22 00:51:26+11	2026-03-22 18:52:18.986956+11	2026-03-22 18:52:18.986959+11	\N	2026-03-22 18:52:18.98696+11	DE
21179	177	v1|298146981603|0	Lenovo ThinkPad L570 15,6 1TB SSD Intel i5-16GB Win 11 FullHD	249.00	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/298146981603?_skw=thinkpad&hash=item456af1e6e3:g:0wEAAeSw4phpvqCA	2026-03-22 00:45:28+11	2026-03-22 18:52:18.987762+11	2026-03-22 18:52:18.987765+11	\N	2026-03-22 18:52:18.987766+11	DE
21180	177	v1|188191377547|0	Lenovo ThinkPad X1 Yoga G5 | i5-10310U | 14"	310.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/188191377547?_skw=thinkpad&hash=item2bd114888b:g:yC4AAeSwhORpvp6o	2026-03-22 00:38:11+11	2026-03-22 18:52:18.988582+11	2026-03-22 18:52:18.988585+11	\N	2026-03-22 18:52:18.988586+11	DE
21181	177	v1|389778673132|0	Lenovo ThinkPad 11th Gen  i5-1135G7 8GB 256GB Win11Pro/DE.	359.00	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/389778673132?_skw=thinkpad&hash=item5ac09e8dec:g:6hUAAeSw95tpvp6p	2026-03-22 00:32:47+11	2026-03-22 18:52:18.989713+11	2026-03-22 18:52:18.989717+11	\N	2026-03-22 18:52:18.989719+11	DE
21182	177	v1|318038588436|0	Lenovo ThinkPad X200 Tablet – 4GB RAM – SSD – voll funktionsfähig	50.90	EUR	Gebraucht	FIXED_PRICE,AUCTION	EBAY_DE	https://www.ebay.de/itm/318038588436?_skw=thinkpad&hash=item4a0c93bc14:g:mZEAAeSw-QxpvpwF	2026-03-22 00:25:34+11	2026-03-22 18:52:18.990762+11	2026-03-22 18:52:18.990766+11	\N	2026-03-22 18:52:18.990767+11	DE
21183	177	v1|358358153565|0	Lenovo ThinkPad X13 Yoga Gen 2 i5-11th 16GB RAM 512GB SSD 13,3" FHD Touchscreen	423.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/358358153565?_skw=thinkpad&hash=item536fcf795d:g:UGQAAeSw6YtpvpaI	2026-03-22 00:05:06+11	2026-03-22 18:52:18.991603+11	2026-03-22 18:52:18.991605+11	\N	2026-03-22 18:52:18.991607+11	DE
21184	177	v1|227266626351|0	Lenovo ThinkPad T450 14 Zoll ( 256GB SSD , intel Core i5 5300U , 8GB RAM )...	150.00	EUR	Gebraucht	FIXED_PRICE,AUCTION	EBAY_DE	https://www.ebay.de/itm/227266626351?_skw=thinkpad&hash=item34ea25832f:g:3pEAAeSwzd1pvo~b	2026-03-21 23:48:07+11	2026-03-22 18:52:18.992436+11	2026-03-22 18:52:18.992439+11	\N	2026-03-22 18:52:18.99244+11	DE
21185	177	v1|147215943697|0	Lenovo ThinkPad E16 G3 16" WQXGA 120Hz Ultra 7 255H 32GB 1TB IR FPR ohne BS! NEU	1399.90	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/147215943697?_skw=thinkpad&hash=item2246c10811:g:BJ0AAeSwNctptD-V	2026-03-21 23:46:27+11	2026-03-22 18:52:18.993266+11	2026-03-22 18:52:18.993269+11	\N	2026-03-22 18:52:18.99327+11	DE
21186	177	v1|147215928153|0	Lenovo ThinkPad T14 Gen 1 14'' AMD Ryzen 5 PRO 4650U. 16GB	249.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/147215928153?_skw=thinkpad&hash=item2246c0cb59:g:TWgAAeSw8rRpvpCS	2026-03-21 23:35:38+11	2026-03-22 18:52:18.994754+11	2026-03-22 18:52:18.994759+11	\N	2026-03-22 18:52:18.994761+11	DE
21187	177	v1|227266609352|0	Lenovo ThinkPad T560 -Intel Core i7 - 16gb RAM - 500gb SSD - Notebook Win11	149.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/227266609352?_skw=thinkpad&hash=item34ea2540c8:g:PvkAAeSwU0Zpvo6G	2026-03-21 23:28:55+11	2026-03-22 18:52:18.996034+11	2026-03-22 18:52:18.996038+11	\N	2026-03-22 18:52:18.996039+11	DE
21188	177	v1|117099823896|0	Lenovo ThinkPad P52 – i7-8850H, 16GB RAM TOP ohne Windows laptop notebook	300.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/117099823896?_skw=thinkpad&hash=item1b43b18318:g:YVsAAeSwKeRpvpHi	2026-03-21 23:23:28+11	2026-03-22 18:52:18.996974+11	2026-03-22 18:52:18.996977+11	\N	2026-03-22 18:52:18.996978+11	DE
21189	177	v1|206155853587|0	Lenovo ThinkPad T480 – 14" FHD | i5-8350U | 08GB RAM | 256GB SSD | Windows 11Pro	179.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/206155853587?_skw=thinkpad&hash=item2fffd8af13:g:~sUAAeSwrDJpvotQ	2026-03-21 23:13:22+11	2026-03-22 18:52:18.997843+11	2026-03-22 18:52:18.997846+11	\N	2026-03-22 18:52:18.997847+11	DE
21190	177	v1|389778342212|0	Lenovo ThinkPad X1 Carbon Gen7 | i5-8365U | 16 / 512GB M.2 | Winds 11 | BIOS#35E	149.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/389778342212?_skw=thinkpad&hash=item5ac0998144:g:9eIAAeSw75ppvoa8	2026-03-21 22:54:59+11	2026-03-22 18:52:18.998673+11	2026-03-22 18:52:18.998676+11	\N	2026-03-22 18:52:18.998677+11	DE
21191	177	v1|397742576783|0	Lenovo L590 i 7 CPU ,16GB RAM,256 GB SSD,Win11 Pro Notebook inkl.Netzteil	280.00	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/397742576783?_skw=thinkpad&hash=item5c9b4e148f:g:dR4AAeSw6Ytpvnaw	2026-03-21 22:14:47+11	2026-03-22 18:52:18.999801+11	2026-03-22 18:52:18.999806+11	\N	2026-03-22 18:52:18.999807+11	DE
21192	177	v1|306834645950|0	Lenovo ThinkPad T14s G6 14" FHD+ Ultra 7 258V 32GB LPDDR5X-8533 256GB IR FPR NEU	1499.90	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/306834645950?_skw=thinkpad&hash=item4770c523be:g:JKUAAeSw92xpA2YZ	2026-03-21 22:13:16+11	2026-03-22 18:52:19.001099+11	2026-03-22 18:52:19.001104+11	\N	2026-03-22 18:52:19.001105+11	DE
21193	177	v1|157773710058|0	Lenovo ThinkPad X1 Titanium Touch i7-1160G7 11th 16GB 1TB NVMe Win11 "Yoga"	649.00	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/157773710058?_skw=thinkpad&hash=item24bc0bc2ea:g:Il8AAeSwryhpvm1N	2026-03-21 21:27:37+11	2026-03-22 18:52:19.002059+11	2026-03-22 18:52:19.002063+11	\N	2026-03-22 18:52:19.002065+11	NL
21194	177	v1|127761167786|0	Lenovo ThinkPad E15 Gen 2, i5, 256 GB SSD, 16 GB RAM	249.00	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/127761167786?_skw=thinkpad&hash=item1dbf28b5aa:g:6PUAAeSwM29pvmO0	2026-03-21 20:25:10+11	2026-03-22 18:52:19.003093+11	2026-03-22 18:52:19.003096+11	\N	2026-03-22 18:52:19.003097+11	DE
21195	177	v1|147215646415|0	Lenovo ThinkPad X1 Carbon 9. Gen 14" 32GB, 512GB i7 1185U, Display 3840x2400 En	599.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/147215646415?_skw=thinkpad&hash=item2246bc7ecf:g:Wa4AAeSw4whpvk4Z	2026-03-21 19:49:08+11	2026-03-22 18:52:19.003918+11	2026-03-22 18:52:19.003921+11	\N	2026-03-22 18:52:19.003922+11	DE
21196	177	v1|389777823033|0	Laptop ThinkPad Yoga 460 Touchscreen + Stift i7-6500U 8GB RAM #3	180.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/389777823033?_skw=thinkpad&hash=item5ac0919539:g:fXgAAeSwPKtpvld2	2026-03-21 19:46:14+11	2026-03-22 18:52:19.004733+11	2026-03-22 18:52:19.004735+11	\N	2026-03-22 18:52:19.004736+11	DE
21197	177	v1|198211231145|0	X1 Carbon 7th Gen - (Type 20QD, 20QE) Laptop (ThinkPad) - Type 20QE	159.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/198211231145?_skw=thinkpad&hash=item2e264f5da9:g:oEcAAeSwXhxoxpL0	2026-03-21 19:36:51+11	2026-03-22 18:52:19.005558+11	2026-03-22 18:52:19.005561+11	\N	2026-03-22 18:52:19.005562+11	DE
21198	177	v1|117099543574|0	Lenovo ThinkPad E14 Gen 2 14"(480 SSD, Intel Core i5-1135G7, 16GB,MX450)	240.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/117099543574?_skw=thinkpad&hash=item1b43ad3c16:g:bNwAAeSwVhJpvlXO	2026-03-21 19:36:41+11	2026-03-22 18:52:19.006399+11	2026-03-22 18:52:19.006402+11	\N	2026-03-22 18:52:19.006403+11	DE
21199	177	v1|188190496573|0	Lenovo ThinkPad T14 G5 Ryzen 7 Pro 8840U Radeon 780M 512GB 32GB 2880 x 1800	1449.69	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190496573?_skw=thinkpad&hash=item2bd107173d:g:ai8AAeSwK9RpvlAj	2026-03-21 18:59:31+11	2026-03-22 18:52:19.007213+11	2026-03-22 18:52:19.007216+11	\N	2026-03-22 18:52:19.007217+11	DE
21200	177	v1|188190492416|0	Lenovo ThinkPad T14 G5 Ryzen 7 Pro 8840U Radeon 780M 512GB 32GB 1920 x 1200	1449.69	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190492416?_skw=thinkpad&hash=item2bd1070700:g:f6QAAeSwymlpvlAC	2026-03-21 18:57:01+11	2026-03-22 18:52:19.008022+11	2026-03-22 18:52:19.008025+11	\N	2026-03-22 18:52:19.008026+11	DE
21201	177	v1|188190480107|0	Lenovo ThinkPad P16v G1 Ryzen 7 Pro 7840HS RTX A500 512GB 16GB 1920 x 1200 WUXGA	2071.09	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190480107?_skw=thinkpad&hash=item2bd106d6eb:g:ZvAAAeSwLoxpvk82	2026-03-21 18:54:34+11	2026-03-22 18:52:19.008826+11	2026-03-22 18:52:19.00883+11	\N	2026-03-22 18:52:19.008831+11	DE
21202	177	v1|188190456846|0	Lenovo ThinkPad X1 Carbon G13 Core Ultra 7 258V 140V 512GB 32GB 1920 x 1200	2491.00	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190456846?_skw=thinkpad&hash=item2bd1067c0e:g:P7IAAeSwrDJpvk4l	2026-03-21 18:48:00+11	2026-03-22 18:52:19.010621+11	2026-03-22 18:52:19.010627+11	\N	2026-03-22 18:52:19.010628+11	DE
21203	177	v1|188190451369|0	Lenovo ThinkPad P14s G5 Ryzen 7 Pro 8840HS Radeon 780M 512GB 32GB	1538.89	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190451369?_skw=thinkpad&hash=item2bd10666a9:g:Wm0AAeSwR0tpvk1L	2026-03-21 18:46:23+11	2026-03-22 18:52:19.01212+11	2026-03-22 18:52:19.012126+11	\N	2026-03-22 18:52:19.012128+11	DE
21204	177	v1|188190404423|0	Lenovo ThinkPad P16 Gen 2 Core i7 13th Gen 13850HX RTX 4000 Ada 1TB 64GB	4901.39	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190404423?_skw=thinkpad&hash=item2bd105af47:g:NXAAAeSw~Qxpvki2	2026-03-21 18:23:47+11	2026-03-22 18:52:19.013352+11	2026-03-22 18:52:19.013357+11	\N	2026-03-22 18:52:19.013359+11	DE
21205	177	v1|188190402181|0	Lenovo ThinkPad P16 Gen 2 Core i7 13th Gen 13850HX RTX 4000 Ada 1TB 64GB	4901.39	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190402181?_skw=thinkpad&hash=item2bd105a685:g:QHsAAeSwjaZpvkfj	2026-03-21 18:21:20+11	2026-03-22 18:52:19.014753+11	2026-03-22 18:52:19.014757+11	\N	2026-03-22 18:52:19.014758+11	DE
21206	177	v1|188190399807|0	Lenovo ThinkPad P16 Gen 2 Core i7 13th Gen 13850HX RTX 4000 Ada 1TB 64GB	4901.39	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190399807?_skw=thinkpad&hash=item2bd1059d3f:g:3U4AAeSwdLdpvkdb	2026-03-21 18:18:03+11	2026-03-22 18:52:19.015793+11	2026-03-22 18:52:19.015797+11	\N	2026-03-22 18:52:19.015798+11	DE
21207	177	v1|188190398581|0	Lenovo ThinkPad P16 Gen 2 Core i7 13th Gen 13850HX RTX 4000 Ada 1TB 64GB	4901.39	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190398581?_skw=thinkpad&hash=item2bd1059875:g:MiIAAeSwzT9pvka8	2026-03-21 18:16:24+11	2026-03-22 18:52:19.016643+11	2026-03-22 18:52:19.016646+11	\N	2026-03-22 18:52:19.016647+11	DE
21208	177	v1|188190367229|0	Lenovo Thinkpad L16 G2 Ryzen 5 Pro 215 512GB 16GB 1920x1200 16.0" Zoll Black	1518.91	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190367229?_skw=thinkpad&hash=item2bd1051dfd:g:A2cAAeSwjKxpvkQW	2026-03-21 18:07:04+11	2026-03-22 18:52:19.01747+11	2026-03-22 18:52:19.017473+11	\N	2026-03-22 18:52:19.017474+11	DE
21209	177	v1|188190361750|0	Lenovo ThinkPad T14s Gen 2 20WN Core i7 11th Gen 1165G7 512GB 8GB 1920 x 1080	1102.19	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190361750?_skw=thinkpad&hash=item2bd1050896:g:BYcAAeSwfcVpvkNk	2026-03-21 18:02:08+11	2026-03-22 18:52:19.018286+11	2026-03-22 18:52:19.018289+11	\N	2026-03-22 18:52:19.01829+11	DE
21210	177	v1|188190356719|0	Lenovo ThinkPad T14 Gen 5 Ryzen Pro 8th Gen 8540U Radeon 740M 512GB 16GB	1465.69	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190356719?_skw=thinkpad&hash=item2bd104f4ef:g:BEIAAeSwYhhpvkKe	2026-03-21 17:58:54+11	2026-03-22 18:52:19.019102+11	2026-03-22 18:52:19.019105+11	\N	2026-03-22 18:52:19.019106+11	DE
21211	177	v1|188190354160|0	Lenovo ThinkPad P16 Gen 2 Core i7 13th Gen 13850HX RTX 4000 Ada 1TB 64GB	4901.39	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190354160?_skw=thinkpad&hash=item2bd104eaf0:g:0nAAAeSwYqFpvkHO	2026-03-21 17:56:24+11	2026-03-22 18:52:19.019918+11	2026-03-22 18:52:19.019921+11	\N	2026-03-22 18:52:19.019922+11	DE
21212	177	v1|188190334169|0	Lenovo ThinkPad T14 Gen 5 Ryzen Pro 8th Gen 8540U Radeon 740M 512GB 16GB	1465.69	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190334169?_skw=thinkpad&hash=item2bd1049cd9:g:n3EAAeSw0fVpvj~I	2026-03-21 17:48:45+11	2026-03-22 18:52:19.020721+11	2026-03-22 18:52:19.020724+11	\N	2026-03-22 18:52:19.020725+11	DE
21213	177	v1|188190327497|0	Lenovo ThinkPad T14 Gen 5 Ryzen Pro 8th Gen 8540U Radeon 740M 512GB 16GB	1465.69	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190327497?_skw=thinkpad&hash=item2bd10482c9:g:yOEAAeSwzadpvkAO	2026-03-21 17:47:54+11	2026-03-22 18:52:19.021548+11	2026-03-22 18:52:19.021551+11	\N	2026-03-22 18:52:19.021552+11	DE
21214	177	v1|188190318695|0	Lenovo ThinkPad X9-14 G1 Core Ultra 5 228V 130V 512GB 32GB 1920 x 1200 WUXGA	1705.39	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190318695?_skw=thinkpad&hash=item2bd1046067:g:uFQAAeSwhORpvj43	2026-03-21 17:42:01+11	2026-03-22 18:52:19.022365+11	2026-03-22 18:52:19.022368+11	\N	2026-03-22 18:52:19.022369+11	DE
21215	177	v1|188190317752|0	Lenovo ThinkPad T14 Gen 5 Ryzen Pro 8th Gen 8540U Radeon 740M 512GB 16GB	1465.69	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190317752?_skw=thinkpad&hash=item2bd1045cb8:g:rJ4AAeSwif9pvj5I	2026-03-21 17:41:13+11	2026-03-22 18:52:19.02318+11	2026-03-22 18:52:19.023183+11	\N	2026-03-22 18:52:19.023184+11	DE
21216	177	v1|188190309264|0	Lenovo ThinkPad L13 G6 Core Ultra 7 Intel 255U 512GB 16GB 1920 x 1200 WUXGA	1251.39	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190309264?_skw=thinkpad&hash=item2bd1043b90:g:vLYAAeSwYQdpvjxU	2026-03-21 17:32:58+11	2026-03-22 18:52:19.024004+11	2026-03-22 18:52:19.024007+11	\N	2026-03-22 18:52:19.024008+11	DE
21217	177	v1|188190286170|0	Lenovo ThinkPad T14 Gen 5 Ryzen Pro 8th Gen 8540U Radeon 740M 512GB 16GB	1465.69	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190286170?_skw=thinkpad&hash=item2bd103e15a:g:xq4AAeSwcIRpvjt0	2026-03-21 17:28:07+11	2026-03-22 18:52:19.02481+11	2026-03-22 18:52:19.024813+11	\N	2026-03-22 18:52:19.024815+11	DE
21218	177	v1|188190278883|0	Lenovo ThinkPad T14 Gen 5 Ryzen Pro 8th Gen 8540U Radeon 740M 512GB 16GB	1465.69	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190278883?_skw=thinkpad&hash=item2bd103c4e3:g:kYEAAeSwZgVpvjqe	2026-03-21 17:25:38+11	2026-03-22 18:52:19.025843+11	2026-03-22 18:52:19.025847+11	\N	2026-03-22 18:52:19.025848+11	DE
21219	177	v1|188190277912|0	Lenovo ThinkPad T14 Gen 5 Ryzen Pro 8th Gen 8540U Radeon 740M 512GB 16GB	1465.69	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190277912?_skw=thinkpad&hash=item2bd103c118:g:kYsAAeSwY0hpvjom	2026-03-21 17:24:42+11	2026-03-22 18:52:19.027275+11	2026-03-22 18:52:19.02728+11	\N	2026-03-22 18:52:19.027282+11	DE
21220	177	v1|188190272390|0	Lenovo ThinkPad X12 Detachable Core i7 11th Gen 1160G7 262GB 16GB 1920 x 1280	1067.59	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190272390?_skw=thinkpad&hash=item2bd103ab86:g:iTUAAeSwbKlpvjkx	2026-03-21 17:19:37+11	2026-03-22 18:52:19.028428+11	2026-03-22 18:52:19.028432+11	\N	2026-03-22 18:52:19.028433+11	DE
21221	177	v1|188190271981|0	Lenovo ThinkPad X12 Detachable Core i5 11th Gen 1140G7 262GB 16GB 1920 x 1280	1042.39	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190271981?_skw=thinkpad&hash=item2bd103a9ed:g:lE0AAeSwOyxpvjmc	2026-03-21 17:19:18+11	2026-03-22 18:52:19.029961+11	2026-03-22 18:52:19.029965+11	\N	2026-03-22 18:52:19.029966+11	DE
21222	177	v1|188190269285|0	Lenovo ThinkPad X1 Carbon G13 Core Ultra 7 258V 140V 512GB 32GB 1920 x 1200	2479.00	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190269285?_skw=thinkpad&hash=item2bd1039f65:g:kwIAAeSwtgZpvjiV	2026-03-21 17:17:00+11	2026-03-22 18:52:19.030939+11	2026-03-22 18:52:19.030943+11	\N	2026-03-22 18:52:19.030944+11	DE
21223	177	v1|188190262917|0	Lenovo ThinkPad X1 Tablet G3 Core i7 8th Gen i7-8550U 512GB 16GB	855.00	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190262917?_skw=thinkpad&hash=item2bd1038685:g:FiEAAeSwzd1pvjfz	2026-03-21 17:12:18+11	2026-03-22 18:52:19.031798+11	2026-03-22 18:52:19.031801+11	\N	2026-03-22 18:52:19.031802+11	DE
21224	177	v1|188190259362|0	Lenovo ThinkPad T14s G4 Ryzen 5 Pro 7540U Radeon 740M 512GB 16GB	1042.39	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190259362?_skw=thinkpad&hash=item2bd10378a2:g:v6IAAeSwsgtpvjeh	2026-03-21 17:10:53+11	2026-03-22 18:52:19.032621+11	2026-03-22 18:52:19.032625+11	\N	2026-03-22 18:52:19.032626+11	DE
21225	177	v1|188190240430|0	Lenovo ThinkPad X12 Detachable Core i5 11th Gen 1140G7 262GB 16GB 1920 x 1280	893.09	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190240430?_skw=thinkpad&hash=item2bd1032eae:g:VmkAAeSw9-9pvjcq	2026-03-21 17:08:46+11	2026-03-22 18:52:19.03344+11	2026-03-22 18:52:19.033443+11	\N	2026-03-22 18:52:19.033445+11	DE
21226	177	v1|267615332066|0	Lenovo ThinkPad P16v G2 (21KX004XGE) 16" Full HD Notebook Intel Core Ultra 7	2503.07	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/267615332066?_skw=thinkpad&hash=item3e4f1de6e2:g:5A4AAeSwjKdpvdj2	2026-03-21 17:07:23+11	2026-03-22 18:52:19.034258+11	2026-03-22 18:52:19.034261+11	\N	2026-03-22 18:52:19.034262+11	DE
21227	177	v1|287221180674|0	Lenovo ThinkPad P16 G3 (21RQ003WGE) 16" Touch Notebook Intel Core Ultra 9 SSD	8624.42	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287221180674?_skw=thinkpad&hash=item42dfb76902:g:U-sAAeSw8otpvdj2	2026-03-21 17:07:23+11	2026-03-22 18:52:19.035079+11	2026-03-22 18:52:19.035082+11	\N	2026-03-22 18:52:19.035083+11	DE
21228	177	v1|267615332041|0	Lenovo ThinkPad P16 G3 (21RQ000MGE) 16" Full HD Notebook Intel Core Ultra 9 SSD	6615.86	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/267615332041?_skw=thinkpad&hash=item3e4f1de6c9:g:wJ8AAeSw2jNptzx9	2026-03-21 17:07:22+11	2026-03-22 18:52:19.035895+11	2026-03-22 18:52:19.035898+11	\N	2026-03-22 18:52:19.035899+11	DE
21229	177	v1|267615332044|0	Lenovo ThinkPad P16 G3 (21RQ003QGE) 16" Full HD Notebook Intel Core Ultra 9 SSD	5641.99	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/267615332044?_skw=thinkpad&hash=item3e4f1de6cc:g:418AAeSwSHlpueJj	2026-03-21 17:07:22+11	2026-03-22 18:52:19.036707+11	2026-03-22 18:52:19.03671+11	\N	2026-03-22 18:52:19.036711+11	DE
21230	177	v1|287221158534|0	Lenovo ThinkPad T16 Gen 4 - (16") - Ultra 5 225U - 16 GB RAM - 512 GB SSD #AL268	1625.93	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287221158534?_skw=thinkpad&hash=item42dfb71286:g:KDYAAeSw8kRpvjD1	2026-03-21 16:47:38+11	2026-03-22 18:52:19.037542+11	2026-03-22 18:52:19.037546+11	\N	2026-03-22 18:52:19.037547+11	DE
21231	177	v1|298145828113|0	Lenovo ThinkPad P1 Gen 8 #BY834	3628.74	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/298145828113?_skw=thinkpad&hash=item456ae04d11:g:mMcAAeSwrw5pvjCi	2026-03-21 16:46:16+11	2026-03-22 18:52:19.038501+11	2026-03-22 18:52:19.038504+11	\N	2026-03-22 18:52:19.038506+11	DE
21232	177	v1|358357024562|0	Lenovo ThinkPad P16s Gen 4 - AMD Ryzen AI 7 PRO 350 - AMD PRO - Win 11 Pr #BY825	2032.33	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/358357024562?_skw=thinkpad&hash=item536fbe3f32:g:WgQAAeSwnc1pvjCZ	2026-03-21 16:46:07+11	2026-03-22 18:52:19.039331+11	2026-03-22 18:52:19.039334+11	\N	2026-03-22 18:52:19.039335+11	DE
21233	177	v1|358357023738|0	Lenovo ThinkPad P14s Gen 5 #BY816	2063.75	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/358357023738?_skw=thinkpad&hash=item536fbe3bfa:g:VI0AAeSwhORpvjCE	2026-03-21 16:45:45+11	2026-03-22 18:52:19.040141+11	2026-03-22 18:52:19.040144+11	\N	2026-03-22 18:52:19.040145+11	DE
21234	177	v1|298145825755|0	Lenovo ThinkPad X1 Carbon Gen 13 - 14", Intel Core Ultra 7 258V, 32 GB RA #BY474	2578.01	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/298145825755?_skw=thinkpad&hash=item456ae043db:g:ohYAAeSwjaZpvjBo	2026-03-21 16:45:18+11	2026-03-22 18:52:19.040975+11	2026-03-22 18:52:19.040978+11	\N	2026-03-22 18:52:19.040979+11	DE
21235	177	v1|358357021902|0	Lenovo ThinkPad E16 Gen 3 - 16", AMD Ryzen 7 250, 16 GB RAM, 512 GB SSD,  #BY385	1060.34	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/358357021902?_skw=thinkpad&hash=item536fbe34ce:g:b6AAAeSwrIBpvjBg	2026-03-21 16:45:10+11	2026-03-22 18:52:19.041901+11	2026-03-22 18:52:19.041905+11	\N	2026-03-22 18:52:19.041907+11	DE
21236	177	v1|406787906626|0	Lenovo ThinkPad T14 Gen 3 AMD | Ryzen 5 PRO 6650U | 16GB  | 256GB NVMe | Win 11	479.00	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/406787906626?_skw=thinkpad&hash=item5eb672dc42:g:XTcAAeSwbq5pviv~	2026-03-21 16:31:25+11	2026-03-22 18:52:19.043208+11	2026-03-22 18:52:19.043212+11	\N	2026-03-22 18:52:19.043213+11	DE
21237	177	v1|188190151643|0	Lenovo ThinkPad X13 2-in-1 Gen 5 Core Ultra 13th Gen 135U 262GB 16GB 1920 x 1200	1226.00	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190151643?_skw=thinkpad&hash=item2bd101d3db:g:RX4AAeSwzadpvi2u	2026-03-21 16:30:22+11	2026-03-22 18:52:19.044571+11	2026-03-22 18:52:19.044576+11	\N	2026-03-22 18:52:19.044577+11	DE
21238	177	v1|198210916138|0	Lenovo ThinkPad X1 2-in-1 G10 21NU007MGE 14" WUXGA Core Ultra 7 258V 32GB/1TB...	2236.67	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/198210916138?_skw=thinkpad&hash=item2e264a8f2a:g:UvkAAeSwkGZpviym	2026-03-21 16:24:04+11	2026-03-22 18:52:19.045839+11	2026-03-22 18:52:19.045844+11	\N	2026-03-22 18:52:19.045845+11	DE
21239	177	v1|188190121909|0	Lenovo ThinkPad X1 Carbon G13 Core Ultra 7 255U 512GB 32GB 2880 x 1800	2461.69	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190121909?_skw=thinkpad&hash=item2bd1015fb5:g:bKgAAeSwY0ppvivg	2026-03-21 16:22:51+11	2026-03-22 18:52:19.046912+11	2026-03-22 18:52:19.046915+11	\N	2026-03-22 18:52:19.046916+11	DE
21240	177	v1|188190119064|0	Lenovo ThinkPad X12 Detachable Core i7 11th Gen 1160G7 262GB 16GB 1920 x 1280	1067.59	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190119064?_skw=thinkpad&hash=item2bd1015498:g:KFcAAeSwYB1pvisS	2026-03-21 16:20:20+11	2026-03-22 18:52:19.047766+11	2026-03-22 18:52:19.047769+11	\N	2026-03-22 18:52:19.04777+11	DE
21241	177	v1|188190111440|0	Lenovo ThinkPad X12 Detachable Core i5 11th Gen 1140G7 262GB 16GB 1920 x 1280	893.09	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190111440?_skw=thinkpad&hash=item2bd10136d0:g:cpwAAeSwrw5pvip6	2026-03-21 16:14:44+11	2026-03-22 18:52:19.048591+11	2026-03-22 18:52:19.048594+11	\N	2026-03-22 18:52:19.048596+11	DE
21242	177	v1|188190109446|0	Lenovo ThinkPad T14 G5 Ryzen 7 Pro 8840U Radeon 780M 512GB 16GB	1280.59	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190109446?_skw=thinkpad&hash=item2bd1012f06:g:BEYAAeSwTX5pvink	2026-03-21 16:13:22+11	2026-03-22 18:52:19.04941+11	2026-03-22 18:52:19.049414+11	\N	2026-03-22 18:52:19.049415+11	DE
21243	177	v1|188190092690|0	Lenovo ThinkPad T14s G4 Ryzen 5 Pro 7540U Radeon 740M 512GB 16GB	1190.09	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188190092690?_skw=thinkpad&hash=item2bd100ed92:g:McIAAeSwiYFpviiX	2026-03-21 16:08:44+11	2026-03-22 18:52:19.050225+11	2026-03-22 18:52:19.050229+11	\N	2026-03-22 18:52:19.05023+11	DE
21244	177	v1|277821459997|0	Lenovo Thinkpad E595 & Dockingstation (AMD Ryzen 5 3500; 16 GB RAM; 512 GB SSD)	325.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/277821459997?_skw=thinkpad&hash=item40af730e1d:g:IykAAeSwfK5pLEmS	2026-03-21 14:44:10+11	2026-03-22 18:52:19.05104+11	2026-03-22 18:52:19.051042+11	\N	2026-03-22 18:52:19.051043+11	DE
21245	177	v1|287221029434|0	Lenovo ThinkPad E16 Gen 3 (Intel) – 16", Intel Core Ultra 5 228V, 32 GB R #CYY97	1242.58	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287221029434?_skw=thinkpad&hash=item42dfb51a3a:g:0jEAAeSwkGZpvhOS	2026-03-21 14:42:17+11	2026-03-22 18:52:19.051847+11	2026-03-22 18:52:19.05185+11	\N	2026-03-22 18:52:19.051851+11	DE
21246	177	v1|358356707528|0	Lenovo ThinkPad T14 Gen 6 - Intel Core Ultra 5 225U - Win 11 Pro - Intel  #CY02Q	2028.13	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/358356707528?_skw=thinkpad&hash=item536fb968c8:g:83YAAeSweElpvhLB	2026-03-21 14:38:47+11	2026-03-22 18:52:19.052684+11	2026-03-22 18:52:19.052687+11	\N	2026-03-22 18:52:19.052688+11	DE
21247	177	v1|358356659056|0	Lenovo ThinkPad P14s Gen 6 -  Core Ultra 7 255H - Win 11 Pro - NVIDIA RTX #AP607	2508.86	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/358356659056?_skw=thinkpad&hash=item536fb8ab70:g:5goAAeSwoolpvg2K	2026-03-21 14:16:33+11	2026-03-22 18:52:19.05349+11	2026-03-22 18:52:19.053493+11	\N	2026-03-22 18:52:19.053494+11	DE
21248	177	v1|358356652803|0	Lenovo ThinkPad T14 Gen 6, 14'', Core Ultra 5 228V, 32GB RAM, 1TB SSD, Wi #AP594	1713.92	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/358356652803?_skw=thinkpad&hash=item536fb89303:g:3BcAAeSwyc1pvgzn	2026-03-21 14:13:49+11	2026-03-22 18:52:19.054305+11	2026-03-22 18:52:19.054308+11	\N	2026-03-22 18:52:19.054309+11	DE
21249	177	v1|298145591912|0	Lenovo ThinkPad E16 Gen 3, 16'', Black, Core Ultra 7 258V, 32GB RAM, 1TB  #AP350	1285.53	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/298145591912?_skw=thinkpad&hash=item456adcb268:g:mt4AAeSw95tpvgzf	2026-03-21 14:13:41+11	2026-03-22 18:52:19.055108+11	2026-03-22 18:52:19.055111+11	\N	2026-03-22 18:52:19.055112+11	DE
21250	177	v1|298145591530|0	Lenovo ThinkPad L14 Gen 6 (AMD), Ryzen 5 PRO 215, 32 GB RAM, 1 TB SSD, Ra #AP928	1404.93	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/298145591530?_skw=thinkpad&hash=item456adcb0ea:g:sdcAAeSwBfVpvgy2	2026-03-21 14:13:00+11	2026-03-22 18:52:19.055906+11	2026-03-22 18:52:19.055909+11	\N	2026-03-22 18:52:19.055911+11	DE
21251	177	v1|358356650332|0	Lenovo ThinkPad L16 Gen 2 #AP940	1397.60	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/358356650332?_skw=thinkpad&hash=item536fb8895c:g:kakAAeSw9RFpvgyU	2026-03-21 14:12:25+11	2026-03-22 18:52:19.056708+11	2026-03-22 18:52:19.056711+11	\N	2026-03-22 18:52:19.056712+11	DE
21252	177	v1|287220999330|0	Lenovo ThinkPad T14 Gen 6 #AP954	2501.55	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287220999330?_skw=thinkpad&hash=item42dfb4a4a2:g:phIAAeSw9H9pvgyL	2026-03-21 14:12:17+11	2026-03-22 18:52:19.057521+11	2026-03-22 18:52:19.057524+11	\N	2026-03-22 18:52:19.057525+11	DE
21253	177	v1|287220999055|0	Lenovo ThinkPad E14 Gen 7 – 14", Intel Core Ultra 7 258V, 32 GB RAM, 1 TB #AP993	1272.96	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287220999055?_skw=thinkpad&hash=item42dfb4a38f:g:6YsAAeSwHPBpvgx7	2026-03-21 14:12:01+11	2026-03-22 18:52:19.058394+11	2026-03-22 18:52:19.058398+11	\N	2026-03-22 18:52:19.058399+11	DE
21254	177	v1|298145590592|0	Lenovo ThinkPad L14 Gen 6 #AP980	1154.60	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/298145590592?_skw=thinkpad&hash=item456adcad40:g:pd8AAeSw17hpvgxh	2026-03-21 14:11:35+11	2026-03-22 18:52:19.059547+11	2026-03-22 18:52:19.059552+11	\N	2026-03-22 18:52:19.059553+11	DE
21255	177	v1|358356649633|0	Lenovo ThinkPad L16 Gen 2 (Intel) - 16", Intel Core Ultra 5 225U, 16 GB R #AP915	1225.83	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/358356649633?_skw=thinkpad&hash=item536fb886a1:g:C~wAAeSwGMhpvgxV	2026-03-21 14:11:26+11	2026-03-22 18:52:19.061001+11	2026-03-22 18:52:19.061006+11	\N	2026-03-22 18:52:19.061007+11	DE
21256	177	v1|287220998394|0	LENOVO ThinkPad L13 G6 33,78cm (13,3") Ultra 5 225U 16GB 512GB W11P #AP898	1201.74	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287220998394?_skw=thinkpad&hash=item42dfb4a0fa:g:e1MAAeSwbKlpvgxO	2026-03-21 14:11:14+11	2026-03-22 18:52:19.062369+11	2026-03-22 18:52:19.062374+11	\N	2026-03-22 18:52:19.062376+11	DE
21257	177	v1|298145590181|0	Lenovo ThinkPad T14 G6 (Intel), Black, Core Ultra 5 225U, 16GB RAM, 512GB #AP278	1500.24	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/298145590181?_skw=thinkpad&hash=item456adcaba5:g:hoUAAeSw4cZpvgw-	2026-03-21 14:10:58+11	2026-03-22 18:52:19.063653+11	2026-03-22 18:52:19.063657+11	\N	2026-03-22 18:52:19.063658+11	DE
21258	177	v1|298145590071|0	Lenovo ThinkPad X1 Carbon G13, Black, Core Ultra 7 258V, 32GB RAM, 1TB SS #AP121	2393.67	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/298145590071?_skw=thinkpad&hash=item456adcab37:g:4xEAAeSwSoJpvgw2	2026-03-21 14:10:50+11	2026-03-22 18:52:19.064521+11	2026-03-22 18:52:19.064524+11	\N	2026-03-22 18:52:19.064525+11	DE
21259	177	v1|298145589715|0	LENOVO ThinkPad X1 Carbon G13 - 14", Intel Core Ultra 5 225U, 16 GB RAM,  #AP677	2012.42	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/298145589715?_skw=thinkpad&hash=item456adca9d3:g:4mAAAeSwncRpvgwk	2026-03-21 14:10:35+11	2026-03-22 18:52:19.065334+11	2026-03-22 18:52:19.065337+11	\N	2026-03-22 18:52:19.065339+11	DE
21260	177	v1|298145588035|0	Lenovo ThinkPad T14s G6 (Intel), Black, Core Ultra 5 228V, 32GB RAM, 1TB  #AP530	1988.33	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/298145588035?_skw=thinkpad&hash=item456adca343:g:lx4AAeSwrIBpvgwN	2026-03-21 14:10:09+11	2026-03-22 18:52:19.066138+11	2026-03-22 18:52:19.066141+11	\N	2026-03-22 18:52:19.066142+11	DE
21261	177	v1|358356643137|0	Lenovo ThinkPad X9-15 Gen 1 - (15.3") - Ultra 7 258V - Evo - 32 GB RAM -  #AP245	1786.18	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/358356643137?_skw=thinkpad&hash=item536fb86d41:g:V0UAAeSwTX5pvgv7	2026-03-21 14:09:53+11	2026-03-22 18:52:19.066951+11	2026-03-22 18:52:19.066954+11	\N	2026-03-22 18:52:19.066955+11	DE
21262	177	v1|287220989509|0	Lenovo ThinkPad T14 Gen 6 -  Core Ultra 5 226V - Win 11 Pro - Arc Graphic #TE226	1459.40	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287220989509?_skw=thinkpad&hash=item42dfb47e45:g:kqwAAeSwPOhpvgth	2026-03-21 14:07:16+11	2026-03-22 18:52:19.067752+11	2026-03-22 18:52:19.067755+11	\N	2026-03-22 18:52:19.067756+11	DE
21263	177	v1|358356635519|0	Lenovo ThinkPad T14 Gen 6 -  Core Ultra 5 226V - Win 11 Pro - Arc Graphic #TE227	1521.20	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/358356635519?_skw=thinkpad&hash=item536fb84f7f:g:91IAAeSwXzBpvgtb	2026-03-21 14:07:10+11	2026-03-22 18:52:19.068581+11	2026-03-22 18:52:19.068584+11	\N	2026-03-22 18:52:19.068586+11	DE
21264	177	v1|298145571029|0	Lenovo ThinkPad E16 Gen 3 (Intel), 16", Intel Core Ultra 5 225U, 32 GB RA #TE401	1411.21	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/298145571029?_skw=thinkpad&hash=item456adc60d5:g:e6AAAeSwzONpvgrH	2026-03-21 14:04:45+11	2026-03-22 18:52:19.069388+11	2026-03-22 18:52:19.069391+11	\N	2026-03-22 18:52:19.069392+11	DE
21265	177	v1|287220985552|0	Lenovo ThinkPad T14 Gen 6 #TE541	2118.20	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287220985552?_skw=thinkpad&hash=item42dfb46ed0:g:mcAAAeSwV8xpvgq~	2026-03-21 14:04:37+11	2026-03-22 18:52:19.070194+11	2026-03-22 18:52:19.070197+11	\N	2026-03-22 18:52:19.070198+11	DE
21266	177	v1|298145566499|0	Lenovo ThinkPad P1 Gen 8 - Ultra 7 255H - Evo - Win 11 Pro - RTX PRO 2000 #IN168	4162.71	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/298145566499?_skw=thinkpad&hash=item456adc4f23:g:S-UAAeSw-Qxpvgo2	2026-03-21 14:02:20+11	2026-03-22 18:52:19.071012+11	2026-03-22 18:52:19.071015+11	\N	2026-03-22 18:52:19.071016+11	DE
21267	177	v1|287220978123|0	Lenovo ThinkPad E14 Gen 7 – 14" 2.8K, Intel Core Ultra 5 228V, 32 GB RAM, #IN443	1283.43	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287220978123?_skw=thinkpad&hash=item42dfb451cb:g:SHQAAeSwtnBpvgoj	2026-03-21 14:02:01+11	2026-03-22 18:52:19.071818+11	2026-03-22 18:52:19.071821+11	\N	2026-03-22 18:52:19.071822+11	DE
21268	177	v1|298145556499|0	Lenovo ThinkPad L14 G6 (Intel), Black, Core Ultra 5 225U, 16GB RAM, 512GB #AL230	1227.92	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/298145556499?_skw=thinkpad&hash=item456adc2813:g:hGQAAeSw5JppvghC	2026-03-21 13:53:58+11	2026-03-22 18:52:19.07263+11	2026-03-22 18:52:19.072632+11	\N	2026-03-22 18:52:19.072633+11	DE
21269	177	v1|287220970983|0	Lenovo ThinkPad X1 Carbon Gen 13 - (14") - Ultra 7 258V - Evo - 32 GB RAM #AL005	2434.52	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287220970983?_skw=thinkpad&hash=item42dfb435e7:g:bUIAAeSwhORpvggx	2026-03-21 13:53:41+11	2026-03-22 18:52:19.073426+11	2026-03-22 18:52:19.073429+11	\N	2026-03-22 18:52:19.073429+11	DE
21270	177	v1|358356612266|0	Lenovo ThinkPad T14s G6 (Intel), Black, Core Ultra 7 258V, 32GB RAM, 1TB  #AL582	2132.87	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/358356612266?_skw=thinkpad&hash=item536fb7f4aa:g:X5YAAeSw~U5pvgf1	2026-03-21 13:52:40+11	2026-03-22 18:52:19.074222+11	2026-03-22 18:52:19.074225+11	\N	2026-03-22 18:52:19.074226+11	DE
21271	177	v1|298145546942|0	Lenovo ThinkPad P16 Gen 3 - 16", Core Ultra 9 275HX, 96 GB RAM, 1 TB SSD, #EG343	6596.85	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/298145546942?_skw=thinkpad&hash=item456adc02be:g:jckAAeSw4xBpvgdN	2026-03-21 13:49:55+11	2026-03-22 18:52:19.075066+11	2026-03-22 18:52:19.075093+11	\N	2026-03-22 18:52:19.075095+11	DE
21272	177	v1|287220961643|0	Lenovo ThinkPad E14 Gen 5 - (14") - Ryzen 5 7530U - 16 GB RAM - 512 GB SS #EG693	907.42	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287220961643?_skw=thinkpad&hash=item42dfb4116b:g:76cAAeSwzntpvgYh	2026-03-21 13:44:54+11	2026-03-22 18:52:19.07633+11	2026-03-22 18:52:19.076335+11	\N	2026-03-22 18:52:19.076336+11	DE
21273	177	v1|358356300749|0	Lenovo ThinkPad T14s 2-in-1 Gen 1, 14", Intel Core Ultra 7 255U, 32 GB RA #BY987	2266.93	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/358356300749?_skw=thinkpad&hash=item536fb333cd:g:pEwAAeSw0fVpveqP	2026-03-21 11:47:16+11	2026-03-22 18:52:19.077743+11	2026-03-22 18:52:19.077748+11	\N	2026-03-22 18:52:19.077749+11	DE
21274	177	v1|358356300490|0	Lenovo ThinkPad T14s 2-in-1 Gen 1 – 14", Intel Core Ultra 7 255U, 32 GB R #BY986	2315.11	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/358356300490?_skw=thinkpad&hash=item536fb332ca:g:4qsAAeSwOp1pveqG	2026-03-21 11:47:09+11	2026-03-22 18:52:19.079114+11	2026-03-22 18:52:19.079119+11	\N	2026-03-22 18:52:19.079121+11	DE
21275	177	v1|298145302381|0	Lenovo ThinkPad P16 Gen 3 - 16", Intel Core Ultra 9 275HX, 96 GB RAM, 1 T #BY313	3706.79	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/298145302381?_skw=thinkpad&hash=item456ad8476d:g:mIwAAeSwsdppveof	2026-03-21 11:45:25+11	2026-03-22 18:52:19.080325+11	2026-03-22 18:52:19.080329+11	\N	2026-03-22 18:52:19.08033+11	DE
21276	177	v1|358356294592|0	Lenovo ThinkPad E14 Gen 7 - 14", Intel Core Ultra 5 226V, 32 GB RAM, 512  #BY874	1084.43	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/358356294592?_skw=thinkpad&hash=item536fb31bc0:g:46wAAeSw7-tpveoB	2026-03-21 11:44:55+11	2026-03-22 18:52:19.081202+11	2026-03-22 18:52:19.081205+11	\N	2026-03-22 18:52:19.081206+11	DE
21277	177	v1|298145299518|0	Lenovo ThinkPad T14 Gen 6 – 14", Intel Core Ultra 7 258V, 32 GB RAM, 1 TB #BY908	2111.92	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/298145299518?_skw=thinkpad&hash=item456ad83c3e:g:8hMAAeSwWpxpvenx	2026-03-21 11:44:39+11	2026-03-22 18:52:19.082019+11	2026-03-22 18:52:19.082021+11	\N	2026-03-22 18:52:19.082022+11	DE
21278	177	v1|287220808300|0	LENOVO ThinkPad L16 Gen 2 - 16", Intel Core Ultra 7 255U, 32 GB RAM, 1 TB #BY888	1694.01	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287220808300?_skw=thinkpad&hash=item42dfb1ba6c:g:oZsAAeSwzOtpvenH	2026-03-21 11:43:59+11	2026-03-22 18:52:19.082828+11	2026-03-22 18:52:19.082831+11	\N	2026-03-22 18:52:19.082832+11	DE
21279	177	v1|287220808135|0	Lenovo ThinkPad L16 Gen 2 - 16", Intel Core Ultra 7 255U, 32 GB RAM, 1 TB #BY887	1634.31	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287220808135?_skw=thinkpad&hash=item42dfb1b9c7:g:K2MAAeSw0x5pvem8	2026-03-21 11:43:49+11	2026-03-22 18:52:19.083637+11	2026-03-22 18:52:19.08364+11	\N	2026-03-22 18:52:19.083641+11	DE
21280	177	v1|287220807993|0	Lenovo ThinkPad P16s Gen 4 - (16") - Ryzen AI 7 PRO 350 - AMD PRO - 64 GB #BY534	2227.13	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287220807993?_skw=thinkpad&hash=item42dfb1b939:g:~oAAAeSwLqFpvem0	2026-03-21 11:43:36+11	2026-03-22 18:52:19.08447+11	2026-03-22 18:52:19.084473+11	\N	2026-03-22 18:52:19.084474+11	DE
21281	177	v1|287220807897|0	Lenovo ThinkPad T16 Gen 4 (AMD) Copilot+ - 16", AMD Ryzen AI 7 350, 32 GB #BY671	2159.05	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287220807897?_skw=thinkpad&hash=item42dfb1b8d9:g:~jAAAeSwuAxpvemr	2026-03-21 11:43:29+11	2026-03-22 18:52:19.085287+11	2026-03-22 18:52:19.08529+11	\N	2026-03-22 18:52:19.085291+11	DE
21282	177	v1|358356291471|0	Lenovo ThinkPad X1 Carbon Gen 13 - 14", Intel Core Ultra 7 255U, 32 GB RA #BY472	2733.02	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/358356291471?_skw=thinkpad&hash=item536fb30f8f:g:3QcAAeSwiihpvemf	2026-03-21 11:43:20+11	2026-03-22 18:52:19.086095+11	2026-03-22 18:52:19.086097+11	\N	2026-03-22 18:52:19.086098+11	DE
21283	177	v1|287220806449|0	Lenovo ThinkPad T14 G6 (Intel), Black, Core Ultra 7 255U, 32GB RAM, 1TB S #BY655	2315.11	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287220806449?_skw=thinkpad&hash=item42dfb1b331:g:0M0AAeSwHKtpvemP	2026-03-21 11:42:59+11	2026-03-22 18:52:19.087047+11	2026-03-22 18:52:19.087051+11	\N	2026-03-22 18:52:19.087052+11	DE
21284	177	v1|287220796547|0	Lenovo ThinkPad T14 Gen 6 -  14", Core Ultra 5 228V - Arc Graphics 130V - 3 #907	1801.89	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287220796547?_skw=thinkpad&hash=item42dfb18c83:g:FdcAAeSwLlxpvej9	2026-03-21 11:40:34+11	2026-03-22 18:52:19.08787+11	2026-03-22 18:52:19.087873+11	\N	2026-03-22 18:52:19.087874+11	DE
21285	177	v1|358356282361|0	Lenovo ThinkPad E16 Gen 3 - 16", Intel Core Ultra 7 255H, 32 GB RAM, 1 TB S #520	1330.55	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/358356282361?_skw=thinkpad&hash=item536fb2ebf9:g:VpcAAeSwUoFpvei5	2026-03-21 11:39:28+11	2026-03-22 18:52:19.088668+11	2026-03-22 18:52:19.088671+11	\N	2026-03-22 18:52:19.088672+11	DE
21286	177	v1|287220794811|0	Lenovo ThinkPad X9-14 Gen 1 - (14") - Core Ultra 7 258V - Evo - 32 GB RAM - #690	1758.95	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/287220794811?_skw=thinkpad&hash=item42dfb185bb:g:9koAAeSwrDJpveiO	2026-03-21 11:38:45+11	2026-03-22 18:52:19.089468+11	2026-03-22 18:52:19.089471+11	\N	2026-03-22 18:52:19.089472+11	DE
21287	177	v1|298145013972|0	Lenovo Thinkpad X380 Yoga	250.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/298145013972?_skw=thinkpad&hash=item456ad3e0d4:g:UXkAAeSwlJNpvcaU	2026-03-21 09:19:49+11	2026-03-22 18:52:19.090264+11	2026-03-22 18:52:19.090267+11	\N	2026-03-22 18:52:19.090268+11	DE
21288	177	v1|227265815210|0	ThinkPad E16 Gen 3	1556.00	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/227265815210?_skw=thinkpad&hash=item34ea1922aa:g:4wIAAeSwlQNpvcN3	2026-03-21 08:25:30+11	2026-03-22 18:52:19.091065+11	2026-03-22 18:52:19.091068+11	\N	2026-03-22 18:52:19.091069+11	DE
21289	177	v1|327059533051|0	TS / ThinkPad E / E16 AMD G3 / R5 220 / 32GB / 512GB SSD / 16.0" / WUXGA / Black	1317.00	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/327059533051?_skw=thinkpad&hash=item4c26446cfb:g:t3kAAeSwSZBpvcNu	2026-03-21 08:25:27+11	2026-03-22 18:52:19.091956+11	2026-03-22 18:52:19.091959+11	\N	2026-03-22 18:52:19.09196+11	DE
21290	177	v1|188188833096|0	Lenovo ThinkPad T14 G5 Core Ultra U5-135U 512GB 16GB 1920 x 1200 14.0" Zoll	1465.69	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188188833096?_skw=thinkpad&hash=item2bd0edb548:g:f0kAAeSw1yRpvbrG	2026-03-21 08:21:13+11	2026-03-22 18:52:19.093138+11	2026-03-22 18:52:19.093142+11	\N	2026-03-22 18:52:19.093143+11	DE
21291	177	v1|188188831455|0	Lenovo ThinkPad L16 Gen 2 Core Ultra 5 225U 512GB 16GB 1920 x 1200 16.0" Zoll	1518.91	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188188831455?_skw=thinkpad&hash=item2bd0edaedf:g:328AAeSwottpvbos	2026-03-21 08:19:33+11	2026-03-22 18:52:19.094591+11	2026-03-22 18:52:19.094597+11	\N	2026-03-22 18:52:19.094598+11	DE
21292	177	v1|188188830764|0	Lenovo ThinkPad P14s G6 Core Ultra 7 Intel 255H 2TB 32GB 1920 x 1200 WUXGA	2137.00	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188188830764?_skw=thinkpad&hash=item2bd0edac2c:g:DuIAAeSw3mtpvbqo	2026-03-21 08:18:44+11	2026-03-22 18:52:19.09595+11	2026-03-22 18:52:19.095955+11	\N	2026-03-22 18:52:19.095956+11	DE
21293	177	v1|188188818200|0	Lenovo ThinkPad P14s G6 Core Ultra 7 Intel 255H 140T 512GB 16GB 3072 x 1920 (3K)	1723.69	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188188818200?_skw=thinkpad&hash=item2bd0ed7b18:g:wD8AAeSwY0ppvblq	2026-03-21 08:15:25+11	2026-03-22 18:52:19.09703+11	2026-03-22 18:52:19.097033+11	\N	2026-03-22 18:52:19.097035+11	DE
21294	177	v1|188188815799|0	Lenovo ThinkPad P14s Gen 5 Ryzen 7 Pro 8840HS Radeon 780M 1TB 32GB 1920 x 1200	1795.39	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188188815799?_skw=thinkpad&hash=item2bd0ed71b7:g:gf0AAeSw65tpvbkE	2026-03-21 08:13:47+11	2026-03-22 18:52:19.098217+11	2026-03-22 18:52:19.098221+11	\N	2026-03-22 18:52:19.098222+11	DE
21295	177	v1|188188811266|0	Lenovo ThinkPad L13 G6 Ryzen 7 Pro 250 Radeon 780M 1TB 32GB 1920 x 1200 WUXGA	1689.39	EUR	Neu: Sonstige (siehe Artikelbeschreibung)	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188188811266?_skw=thinkpad&hash=item2bd0ed6002:g:32IAAeSw1iJpvbki	2026-03-21 08:11:19+11	2026-03-22 18:52:19.099071+11	2026-03-22 18:52:19.099074+11	\N	2026-03-22 18:52:19.099075+11	DE
21296	177	v1|188188806533|0	Lenovo ThinkPad L14 Gen 5 Core Ultra 12th Gen 125U 262GB 16GB 1920 x 1200	1287.39	EUR	Neu	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/188188806533?_skw=thinkpad&hash=item2bd0ed4d85:g:XbIAAeSw~Bdpvbg-	2026-03-21 08:10:28+11	2026-03-22 18:52:19.099879+11	2026-03-22 18:52:19.099882+11	\N	2026-03-22 18:52:19.099883+11	DE
21297	177	v1|267615065261|0	Lenovo X1 Carbon Gen 10 14 Zoll 1TB SSD Intel Core i7-1255U 16GB RAM	740.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/267615065261?_skw=thinkpad&hash=item3e4f19d4ad:g:p-oAAeSw4ExpvbLQ	2026-03-21 08:00:38+11	2026-03-22 18:52:19.100688+11	2026-03-22 18:52:19.100691+11	\N	2026-03-22 18:52:19.100692+11	DE
21298	177	v1|267615042090|0	Lenovo ThinkPad T14 Gen 4 Intel i5-1335U 16GB RAM 512GB SSD + 12M Garantie	760.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/267615042090?_skw=thinkpad&hash=item3e4f197a2a:g:EPMAAeSwZcNpvaix	2026-03-21 07:24:59+11	2026-03-22 18:52:19.101524+11	2026-03-22 18:52:19.101527+11	\N	2026-03-22 18:52:19.101528+11	DE
21299	177	v1|366291789910|0	Lenovo ThinkPad T560 - İ7 2,8ghz - 12GB Ram - 128GB SSD - 2xAkku	150.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/366291789910?_skw=thinkpad&hash=item5548b12856:g:dwAAAeSwz5xpvapm	2026-03-21 07:13:45+11	2026-03-22 18:52:19.102335+11	2026-03-22 18:52:19.102338+11	\N	2026-03-22 18:52:19.10234+11	DE
21300	177	v1|366291781199|0	Lenovo ThinkPad T560 - İ7 2,8ghz - 12GB Ram - 128GB SSD - 2xAkku	150.00	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/366291781199?_skw=thinkpad&hash=item5548b1064f:g:XIsAAeSwfcVpvakx	2026-03-21 07:08:41+11	2026-03-22 18:52:19.103146+11	2026-03-22 18:52:19.103149+11	\N	2026-03-22 18:52:19.10315+11	DE
21301	177	v1|318035435319|0	Laptop Lenovo ThinkPad X260 (Core i5 - 6300U CPU@2.40 Ghz x 2 8GB Ram) Notebook	100.00	EUR	Gebraucht	FIXED_PRICE,AUCTION	EBAY_DE	https://www.ebay.de/itm/318035435319?_skw=thinkpad&hash=item4a0c639f37:g:jzoAAeSwO4lpvaV0	2026-03-21 07:00:10+11	2026-03-22 18:52:19.103961+11	2026-03-22 18:52:19.103963+11	\N	2026-03-22 18:52:19.103964+11	DE
21302	177	v1|177977297612|0	Lenovo ThinkPad T14 G1 - Intel i7-10510U - 32 GB - 512 SSD - Akku 100%	349.90	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/177977297612?_skw=thinkpad&hash=item2970460acc:g:Ej8AAeSwmsVpvZXA	2026-03-21 06:36:31+11	2026-03-22 18:52:19.104768+11	2026-03-22 18:52:19.104771+11	\N	2026-03-22 18:52:19.104772+11	DE
21303	177	v1|147214688799|0	LENOVO Notebook Thinkpad T14 35,56cm (14") FHD, Ryzen 5, PRO 4560U, Win11Pro	434.51	EUR	Gebraucht	FIXED_PRICE	EBAY_DE	https://www.ebay.de/itm/147214688799?_skw=thinkpad&hash=item2246ade21f:g:ZQMAAeSwmWFpvpOH	2026-03-21 06:20:55+11	2026-03-22 18:52:19.10557+11	2026-03-22 18:52:19.105573+11	\N	2026-03-22 18:52:19.105574+11	DE
21304	177	v1|198209717842|0	Lenovo ThinkPad L480 14" FHD i5-8250U 8GB 240GB SSD Windows 11 Pro Gebraucht	180.50	EUR	Gebraucht	FIXED_PRICE,BEST_OFFER	EBAY_DE	https://www.ebay.de/itm/198209717842?_skw=thinkpad&hash=item2e26384652:g:e-AAAeSwOFhpvWXC	2026-03-21 06:11:53+11	2026-03-22 18:52:19.106378+11	2026-03-22 18:52:19.10638+11	\N	2026-03-22 18:52:19.106381+11	IT
21305	177	v1|277824378106|0	Lenovo ThinkPad E495 Ryzen 5 - 16 GB Ram - 512 GB SSD Windows 11	599.00	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/277824378106?_skw=thinkpad&hash=item40af9f94fa:g:lxgAAOSwaAdhff8I	2026-03-22 18:05:19+11	2026-03-22 18:52:19.10718+11	2026-03-22 18:52:19.107182+11	\N	2026-03-22 18:52:19.107183+11	AU
21306	177	v1|127762849490|0	Lenovo ThinkPad X250 12.5inch TOUCH  i5-5300U 16GB Memory 256GB SSD WINDOWS 11	269.00	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/127762849490?_skw=thinkpad&hash=item1dbf425ed2:g:lDMAAeSw-Qxpv4Kg	2026-03-22 16:54:16+11	2026-03-22 18:52:19.108009+11	2026-03-22 18:52:19.108012+11	\N	2026-03-22 18:52:19.108013+11	AU
21307	177	v1|117101022015|0	Lenovo ThinkPad X250 12.5inch TOUCH  i5-5300U 16GB Memory 256GB SSD WINDOWS 11 P	289.00	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/117101022015?_skw=thinkpad&hash=item1b43c3cb3f:g:lDMAAeSw-Qxpv4Kg	2026-03-22 16:53:46+11	2026-03-22 18:52:19.109078+11	2026-03-22 18:52:19.109083+11	\N	2026-03-22 18:52:19.109084+11	AU
21308	177	v1|117101013847|0	Lenovo ThinkPad X260 12.5inch FHD i7-6600U 16GB Memory 256GB SSD WINDOWS 11 P	359.00	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/117101013847?_skw=thinkpad&hash=item1b43c3ab57:g:lDMAAeSw-Qxpv4Kg	2026-03-22 16:50:10+11	2026-03-22 18:52:19.110536+11	2026-03-22 18:52:19.11054+11	\N	2026-03-22 18:52:19.110542+11	AU
21309	177	v1|117101011167|0	Lenovo ThinkPad X260 12.5inch FHD i7-6600U 16GB Memory 256GB SSD WINDOWS 11 PRO	369.00	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/117101011167?_skw=thinkpad&hash=item1b43c3a0df:g:lDMAAeSw-Qxpv4Kg	2026-03-22 16:49:25+11	2026-03-22 18:52:19.111829+11	2026-03-22 18:52:19.111834+11	\N	2026-03-22 18:52:19.111835+11	AU
21310	177	v1|127762833258|0	Lenovo X1 Carbon Gen3 (NP) 14" Laptop Intel i5-5300 8G 256G SSD WIFI Win11 Pro	220.00	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/127762833258?_skw=thinkpad&hash=item1dbf421f6a:g:pzkAAeSwABFoe0QY	2026-03-22 16:40:52+11	2026-03-22 18:52:19.113091+11	2026-03-22 18:52:19.113096+11	\N	2026-03-22 18:52:19.113097+11	AU
21311	177	v1|127762832266|0	Lenovo X1 Carbon Gen4 14" Laptop i5-6300u 8G Ram 256G SSD WIFI Win11 Pro	239.00	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/127762832266?_skw=thinkpad&hash=item1dbf421b8a:g:pzkAAeSwABFoe0QY	2026-03-22 16:39:46+11	2026-03-22 18:52:19.114022+11	2026-03-22 18:52:19.114025+11	\N	2026-03-22 18:52:19.114026+11	AU
21312	177	v1|127762830074|0	Lenovo X1 Carbon Gen4 14" Laptop Intel i5-6th 8G Ram 256G SSD WIFI Win11 Pro	239.00	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/127762830074?_skw=thinkpad&hash=item1dbf4212fa:g:pzkAAeSwABFoe0QY	2026-03-22 16:38:56+11	2026-03-22 18:52:19.114847+11	2026-03-22 18:52:19.11485+11	\N	2026-03-22 18:52:19.114851+11	AU
21313	177	v1|318041490172|0	Lenovo ThinkPad X1 Carbon Gen 10 i5 8GB 256GB SSD 14" Laptop Used	990.67	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/318041490172?_skw=thinkpad&hash=item4a0cc002fc:g:~5oAAeSwJetpv3jY	2026-03-22 16:04:17+11	2026-03-22 18:52:19.115659+11	2026-03-22 18:52:19.115662+11	\N	2026-03-22 18:52:19.115663+11	JP
21314	177	v1|177980422996|0	Lenovo ThinkPad P14S G5 U7-155H, 32GB, 1TB, 14.5" WUXGA, RTX 500 Ada 4GB, W11P	2899.99	AUD	Brand New	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/177980422996?_skw=thinkpad&hash=item297075bb54:g:ZogAAeSw5OJpvy9S	2026-03-22 10:54:04+11	2026-03-22 18:52:19.116496+11	2026-03-22 18:52:19.116498+11	\N	2026-03-22 18:52:19.1165+11	AU
21315	177	v1|277823171131|0	Lenovo ThinkPad T14 Gen 4 Ryzen 7 7840M 16GB DDR5 Radeon 780M 256GB NVMe TOUCH	854.88	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/277823171131?_skw=thinkpad&hash=item40af8d2a3b:g:qkAAAeSwfyxpvv5k	2026-03-22 07:19:02+11	2026-03-22 18:52:19.117315+11	2026-03-22 18:52:19.117318+11	\N	2026-03-22 18:52:19.117319+11	CA
21316	177	v1|397744094972|0	Lenovo ThinkPad L15 Laptop Core i5-10210U 8GB RAM 256GB SSD 15.6" Win 10 Japan	354.21	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/397744094972?_skw=thinkpad&hash=item5c9b653efc:g:RsEAAeSwQiVpvvqm	2026-03-22 07:05:39+11	2026-03-22 18:52:19.118121+11	2026-03-22 18:52:19.118124+11	\N	2026-03-22 18:52:19.118125+11	JP
21317	177	v1|267615826953|0	Lenovo ThinkPad E14 Gen 7 - 14" - Intel Core Ultra 7 - 255H - 16 GB (21SX0038US)	2919.65	AUD	New	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/267615826953?_skw=thinkpad&hash=item3e4f257409:g:5pQAAeSwQBFpv3Nh	2026-03-22 06:41:30+11	2026-03-22 18:52:19.118926+11	2026-03-22 18:52:19.118929+11	\N	2026-03-22 18:52:19.11893+11	US
21318	177	v1|206156571814|0	Lenovo ThinkPad X1 Extreme 2nd Gen | i7-9750H | 16GB RAM | 512GB SSD	407.23	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/206156571814?_skw=thinkpad&hash=item2fffe3a4a6:g:0IgAAeSw-Qxpvunk	2026-03-22 06:28:32+11	2026-03-22 18:52:19.119729+11	2026-03-22 18:52:19.119732+11	\N	2026-03-22 18:52:19.119733+11	US
21319	177	v1|137154556819|0	Lenovo ThinkPad E14 Gen 2 14.0" i7-1165G7@2.80GHz 32GB RAM 512GB SSD TOUCHSCREEN	407.23	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/137154556819?_skw=thinkpad&hash=item1fef0c7393:g:~~4AAeSwIIFpvudV	2026-03-22 05:47:43+11	2026-03-22 18:52:19.120531+11	2026-03-22 18:52:19.120534+11	\N	2026-03-22 18:52:19.120535+11	US
21320	177	v1|188192112977|0	Lenovo ThinkPad P1 Gen 6 21FW-SBAJ00 16" i7-13800H 64GB RAM 1TB SSD RTX 4080	2975.92	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/188192112977?_skw=thinkpad&hash=item2bd11fc151:g:xQEAAeSwmFBpvuXf	2026-03-22 05:39:34+11	2026-03-22 18:52:19.121336+11	2026-03-22 18:52:19.121338+11	\N	2026-03-22 18:52:19.121339+11	US
21321	177	v1|336493440356|0	Lenovo ThinkPad L14 Gen 4 i5-1345U 32GB RAM 256GB SSD Windows 11 Pro	812.90	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/336493440356?_skw=thinkpad&hash=item4e58926d64:g:APsAAeSwgR1ptgMf	2026-03-22 05:33:28+11	2026-03-22 18:52:19.122139+11	2026-03-22 18:52:19.122142+11	\N	2026-03-22 18:52:19.122143+11	US
21322	177	v1|298147617542|0	Lenovo ThinkPad P15v Gen 2i 15.6" i7-11850H 32GB 1TB SSD NVIDIA T1200 Win10 Pro	1065.01	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/298147617542?_skw=thinkpad&hash=item456afb9b06:g:dPgAAeSwt4JpvuRh	2026-03-22 05:28:31+11	2026-03-22 18:52:19.122945+11	2026-03-22 18:52:19.122947+11	\N	2026-03-22 18:52:19.122948+11	US
21323	177	v1|406789281658|0	LENOVO ThinkPad L390 Yoga 2-in-1 13 FHD Touch I5-8365U 512GB SSD 16GB W/Pen W11P	352.41	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/406789281658?_skw=thinkpad&hash=item5eb687d77a:g:eg0AAeSwvddpvuHj	2026-03-22 05:25:41+11	2026-03-22 18:52:19.123775+11	2026-03-22 18:52:19.123778+11	\N	2026-03-22 18:52:19.123779+11	US
21324	177	v1|389779535465|0	Lenovo ThinkPad X13 Gen 2i | i5-1135G7 16GB RAM 512GB NVMe SSD | FHD FPS Backlit	469.87	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/389779535465?_skw=thinkpad&hash=item5ac0abb669:g:QfgAAeSwLlxpvt1J	2026-03-22 05:20:35+11	2026-03-22 18:52:19.124581+11	2026-03-22 18:52:19.124584+11	\N	2026-03-22 18:52:19.124585+11	US
21325	177	v1|306835202185|0	Lenovo ThinkPad T460 14" FHD Laptop Intel Core i5, 12GB RAM, 128GB SSD, MX Linux	180.12	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/306835202185?_skw=thinkpad&hash=item4770cda089:g:bwYAAeSw0x5pvuAl	2026-03-22 05:17:29+11	2026-03-22 18:52:19.12577+11	2026-03-22 18:52:19.125776+11	\N	2026-03-22 18:52:19.125778+11	US
21326	177	v1|227266943970|0	Lenovo ThinkPad T570 TOUCH 15.6" Laptop i5-7300U 8GB 256GB NVMe SSD Win10P w/pwr	311.69	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/227266943970?_skw=thinkpad&hash=item34ea2a5be2:g:UtAAAeSwEJppvtiF	2026-03-22 05:01:16+11	2026-03-22 18:52:19.127118+11	2026-03-22 18:52:19.127123+11	\N	2026-03-22 18:52:19.127125+11	US
21327	177	v1|267615764690|0	Lenovo ThinkPad T16 Gen 2 Intel i5-1335U @1.6GHZ 16GB RAM 512GB SSD WIN 11 Pro	938.20	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/267615764690?_skw=thinkpad&hash=item3e4f2480d2:g:Oj8AAeSwUrVpvtmt	2026-03-22 04:50:21+11	2026-03-22 18:52:19.128292+11	2026-03-22 18:52:19.128296+11	\N	2026-03-22 18:52:19.128298+11	US
21328	177	v1|206156410151|0	Lenovo ThinkPad T14 Gen 1 14” FHD Intel Core i5-10310U  1.7GHz 8GB SSD 256GB	313.26	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/206156410151?_skw=thinkpad&hash=item2fffe12d27:g:FFcAAeSwpyZpvthN	2026-03-22 04:43:55+11	2026-03-22 18:52:19.129583+11	2026-03-22 18:52:19.129587+11	\N	2026-03-22 18:52:19.129588+11	US
21329	177	v1|188191937432|0	Lenovo IdeaPad Slim 5 16IRU9 2n1 16" Touch (1TB SSD Core 7 150u 16 gb Good	587.36	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/188191937432?_skw=thinkpad&hash=item2bd11d1398:g:XG8AAeSwiihpvtUC	2026-03-22 04:28:36+11	2026-03-22 18:52:19.130531+11	2026-03-22 18:52:19.130534+11	\N	2026-03-22 18:52:19.130536+11	US
21330	177	v1|157774363348|0	Lenovo ThinkPad E14 Gen4 256GB/16GB Ryzen 7 5825u backlit keyboard fingerprint	503.13	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/157774363348?_skw=thinkpad&hash=item24bc15bad4:g:WpgAAeSwRqppvtK9	2026-03-22 04:19:59+11	2026-03-22 18:52:19.131356+11	2026-03-22 18:52:19.131359+11	\N	2026-03-22 18:52:19.13136+11	US
21331	177	v1|127761898676|0	Lenovo ThinkPad P14s Gen 2 | i7-1185G7 | NVIDIA Quadro T500 | 48GB DDR4 | 1TB	781.57	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/127761898676?_skw=thinkpad&hash=item1dbf33dcb4:g:VIUAAeSw95tpvtLE	2026-03-22 04:18:24+11	2026-03-22 18:52:19.132192+11	2026-03-22 18:52:19.132195+11	\N	2026-03-22 18:52:19.132197+11	US
21332	177	v1|257418101344|0	Lenovo ThinkPad T14 Gen 6 21QDS3601Q Core Ultra 5 235U 2.0GHz 16GB RAM 256GB SSD	1096.38	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/257418101344?_skw=thinkpad&hash=item3bef508260:g:4dYAAeSwUrtpvtCF	2026-03-22 04:08:26+11	2026-03-22 18:52:19.133003+11	2026-03-22 18:52:19.133006+11	\N	2026-03-22 18:52:19.133007+11	US
21333	177	v1|397743513548|0	Lenovo ThinkPad T16 Gen 1 16" Laptop i5-1240p 16GB RAM 256GB NVMe	649.99	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/397743513548?_skw=thinkpad&hash=item5c9b5c5fcc:g:9m8AAeSwWrVpvWGO	2026-03-22 03:46:56+11	2026-03-22 18:52:19.133812+11	2026-03-22 18:52:19.133815+11	\N	2026-03-22 18:52:19.133816+11	US
21334	177	v1|206156289898|0	Lenovo ThinkPad T15 Gen 2i 15.6" Laptop i5-1135G7 8GB RAM 512GB NVMe	391.56	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/206156289898?_skw=thinkpad&hash=item2fffdf576a:g:FmwAAeSw6BppvYiQ	2026-03-22 03:40:42+11	2026-03-22 18:52:19.134771+11	2026-03-22 18:52:19.134775+11	\N	2026-03-22 18:52:19.134776+11	US
21335	177	v1|206156289391|0	Lenovo ThinkPad T15 Gen 2i 15.6" Laptop i5-1135G7 8GB RAM 512GB NVMe, As Is	375.89	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/206156289391?_skw=thinkpad&hash=item2fffdf556f:g:2uIAAeSwdLdpvXMV	2026-03-22 03:40:00+11	2026-03-22 18:52:19.135599+11	2026-03-22 18:52:19.135602+11	\N	2026-03-22 18:52:19.135603+11	US
21336	177	v1|206156288637|0	Lenovo ThinkPad T15 Gen 2i 15.6" Laptop i5-1135G7 8GB RAM 512GB NVMe, As Is	375.89	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/206156288637?_skw=thinkpad&hash=item2fffdf527d:g:~f4AAeSwe35pvVlz	2026-03-22 03:39:10+11	2026-03-22 18:52:19.136414+11	2026-03-22 18:52:19.136416+11	\N	2026-03-22 18:52:19.136417+11	US
21337	177	v1|227266871735|0	Lenovo ThinkPad X1 2-1 G10 14" WUXGA Touchscreen Laptop, Ultra 7-255U, 32GB...	4096.00	AUD	Brand New	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/227266871735?_skw=thinkpad&hash=item34ea2941b7:g:KiAAAeSwdr5pvsp-	2026-03-22 03:38:34+11	2026-03-22 18:52:19.137217+11	2026-03-22 18:52:19.13722+11	\N	2026-03-22 18:52:19.137221+11	AU
21338	177	v1|227266871663|0	Lenovo ThinkPad X1 CARBON G13 14" WUXGA Laptop, Ultra 5-225H, 32GB RAM, 512GB...	3254.00	AUD	Brand New	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/227266871663?_skw=thinkpad&hash=item34ea29416f:g:~4MAAeSwUCVpvsp8	2026-03-22 03:38:32+11	2026-03-22 18:52:19.138027+11	2026-03-22 18:52:19.13803+11	\N	2026-03-22 18:52:19.138031+11	AU
21339	177	v1|206156287991|0	Lenovo ThinkPad T15 Gen 2i 15.6" Laptop i5-1135G7 16GB RAM 512GB NVMe, As Is	383.72	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/206156287991?_skw=thinkpad&hash=item2fffdf4ff7:g:iaAAAeSwWB5pvYHK	2026-03-22 03:38:09+11	2026-03-22 18:52:19.138859+11	2026-03-22 18:52:19.138862+11	\N	2026-03-22 18:52:19.138863+11	US
21340	177	v1|397743497857|0	Lenovo ThinkPad T15 Gen 2i 15.6" Laptop i5-1145G7 16GB RAM 512GB NVMe - As Is	383.72	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397743497857?_skw=thinkpad&hash=item5c9b5c2281:g:M5gAAeSwWv5pvXg6	2026-03-22 03:37:22+11	2026-03-22 18:52:19.13967+11	2026-03-22 18:52:19.139673+11	\N	2026-03-22 18:52:19.139674+11	US
21341	177	v1|397743492006|0	Lenovo ThinkPad T15 Gen 2i 15.6" Laptop i5-1145G7 16GB RAM 512GB NVMe, As Is	391.56	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/397743492006?_skw=thinkpad&hash=item5c9b5c0ba6:g:et8AAeSwCUlpvWXS	2026-03-22 03:33:58+11	2026-03-22 18:52:19.140476+11	2026-03-22 18:52:19.140478+11	\N	2026-03-22 18:52:19.14048+11	US
21342	177	v1|206156283312|0	Lenovo ThinkPad T15 Gen 2i 15.6" Laptop i7-1165G7 16GB RAM 512GB NVMe, As Is	383.72	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/206156283312?_skw=thinkpad&hash=item2fffdf3db0:g:LHwAAeSwfKJpvV2u	2026-03-22 03:33:12+11	2026-03-22 18:52:19.141282+11	2026-03-22 18:52:19.141285+11	\N	2026-03-22 18:52:19.141286+11	US
21343	177	v1|397743487534|0	Lenovo ThinkPad T15 Gen 2i 15.6" Laptop i5-1135G7 16GB RAM 512GB NVMe, As Is	383.72	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397743487534?_skw=thinkpad&hash=item5c9b5bfa2e:g:YfwAAeSw3nppvU-c	2026-03-22 03:31:59+11	2026-03-22 18:52:19.142518+11	2026-03-22 18:52:19.142523+11	\N	2026-03-22 18:52:19.142525+11	US
21344	177	v1|397743485376|0	Lenovo ThinkPad T15 Gen 2i 15.6" Laptop i5-1135G7 16GB RAM 512GB NVMe	407.22	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/397743485376?_skw=thinkpad&hash=item5c9b5bf1c0:g:srQAAeSwWNVpvUxS	2026-03-22 03:30:53+11	2026-03-22 18:52:19.143893+11	2026-03-22 18:52:19.143898+11	\N	2026-03-22 18:52:19.1439+11	US
21345	177	v1|287222123929|0	Lenovo ThinkPad T14 14" Intel Core i7 4.7GHz 40GB 256GB SSD Win11 * READ**	467.54	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/287222123929?_skw=thinkpad&hash=item42dfc5cd99:g:IsMAAeSwfNxo7Uxn	2026-03-22 02:47:38+11	2026-03-22 18:52:19.145023+11	2026-03-22 18:52:19.145027+11	\N	2026-03-22 18:52:19.145029+11	US
21346	177	v1|168251689577|0	Lenovo ThinkPad T14s Gen 2 - Intel Core i7 11th Gen 16GB RAM 256GB SSD No OS	407.22	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/168251689577?_skw=thinkpad&hash=item272c950a69:g:~UwAAeSw24hpaQyY	2026-03-22 02:46:21+11	2026-03-22 18:52:19.146307+11	2026-03-22 18:52:19.146311+11	\N	2026-03-22 18:52:19.146312+11	US
21347	177	v1|287222108337|0	Lenovo ThinkPad T14 14" Intel Core i7 4.8GHz 32GB 256GB SSD Win11 Touch * READ**	468.32	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/287222108337?_skw=thinkpad&hash=item42dfc590b1:g:IsMAAeSwfNxo7Uxn	2026-03-22 02:40:38+11	2026-03-22 18:52:19.147241+11	2026-03-22 18:52:19.147243+11	\N	2026-03-22 18:52:19.147245+11	US
21348	177	v1|287222104464|0	Lenovo ThinkPad T14s 14" Intel i7 4.8GHz 32GB 256GB SSD Win11 * READ	453.44	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/287222104464?_skw=thinkpad&hash=item42dfc58190:g:tgEAAeSwGE5pMtlg	2026-03-22 02:38:00+11	2026-03-22 18:52:19.148094+11	2026-03-22 18:52:19.148097+11	\N	2026-03-22 18:52:19.148098+11	US
21349	177	v1|206156174902|0	Lenovo ThinkPad X220 i7-2640M 2.80GHz 8GB RAM 500GB HDD w/OFFICE 21 & 90WCharger	249.96	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/206156174902?_skw=thinkpad&hash=item2fffdd9636:g:dTcAAeSw8M1pvrgi	2026-03-22 02:30:09+11	2026-03-22 18:52:19.148911+11	2026-03-22 18:52:19.148914+11	\N	2026-03-22 18:52:19.148915+11	CA
21350	177	v1|206156171474|0	LENOVO THINKPAD T14s INTEL CORE i7 2.80GHz, 16 GB, 512GB 14" GEN 1 WIN 11 GEN 2	610.78	AUD	Open box	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/206156171474?_skw=thinkpad&hash=item2fffdd88d2:g:alYAAeSwXslpvrjv	2026-03-22 02:28:59+11	2026-03-22 18:52:19.149722+11	2026-03-22 18:52:19.149725+11	\N	2026-03-22 18:52:19.149726+11	US
21351	177	v1|287222079940|0	Lenovo ThinkPad X1 Carbon Gen 9 14 - Intel Core i7 32GB 256GB Win 11 * READ`	546.63	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/287222079940?_skw=thinkpad&hash=item42dfc521c4:g:d-kAAeSweqBo3Dea	2026-03-22 02:21:03+11	2026-03-22 18:52:19.150531+11	2026-03-22 18:52:19.150534+11	\N	2026-03-22 18:52:19.150535+11	US
21352	177	v1|157774163731|0	Lenovo ThinkPad T14s Gen 2 - 14" Intel Core i7-1185G7 16GB RAM 256GB SSD No OS	469.87	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/157774163731?_skw=thinkpad&hash=item24bc12af13:g:adsAAeSwGVBpvrX4	2026-03-22 02:16:02+11	2026-03-22 18:52:19.151334+11	2026-03-22 18:52:19.151336+11	\N	2026-03-22 18:52:19.151338+11	US
21353	177	v1|287222041075|0	Lenovo ThinkPad X1 Carbon Gen 9 14 - Intel Core i7 16GB 256GB Win 11  * READ	530.97	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/287222041075?_skw=thinkpad&hash=item42dfc489f3:g:d-kAAeSweqBo3Dea	2026-03-22 02:01:00+11	2026-03-22 18:52:19.152141+11	2026-03-22 18:52:19.152144+11	\N	2026-03-22 18:52:19.152145+11	US
21354	177	v1|287222032857|0	Lenovo ThinkPad T14 Gen 3 14" Intel Core i7 4.8GHz 32GB 256GB SSD Win11 * READ	562.30	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/287222032857?_skw=thinkpad&hash=item42dfc469d9:g:kLQAAeSwGE5pOd3R	2026-03-22 01:55:00+11	2026-03-22 18:52:19.152949+11	2026-03-22 18:52:19.152952+11	\N	2026-03-22 18:52:19.152953+11	US
21355	177	v1|206156116798|0	Lenovo ThinkPad P1 Gen 4 i9-11950H RTX 3080 16GB 4K 64GB Mem 2TB SSD Win11Pro	2349.42	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/206156116798?_skw=thinkpad&hash=item2fffdcb33e:g:msgAAeSwgWRpZtWq	2026-03-22 01:52:09+11	2026-03-22 18:52:19.153761+11	2026-03-22 18:52:19.153764+11	\N	2026-03-22 18:52:19.153765+11	US
21356	177	v1|177979377616|0	Lenovo ThinkPad T410 - i5 M520 2.4GHz - 6GB RAM - 240 GB SSD  - Linux Mint 22.3	155.06	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/177979377616?_skw=thinkpad&hash=item297065c7d0:g:G2oAAeSwon5pvqy1	2026-03-22 01:42:31+11	2026-03-22 18:52:19.154588+11	2026-03-22 18:52:19.15459+11	\N	2026-03-22 18:52:19.154591+11	US
21357	177	v1|206156082478|0	LENOVO THINKPAD T14s INTEL CORE i7 2.80GHz, 16 GB, 512GB 14" GEN 1 WIN 11 GEN 2	610.78	AUD	Open box	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/206156082478?_skw=thinkpad&hash=item2fffdc2d2e:g:GXwAAeSwoA1pvqXY	2026-03-22 01:32:57+11	2026-03-22 18:52:19.155395+11	2026-03-22 18:52:19.155398+11	\N	2026-03-22 18:52:19.155399+11	US
21358	177	v1|358358370741|0	Lenovo ThinkPad X390 13.3" FHD Touch i7-8665U 1.9GHz 16GB 1TB SSD	266.27	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/358358370741?_skw=thinkpad&hash=item536fd2c9b5:g:C-gAAeSwCnlpvqkK	2026-03-22 01:20:39+11	2026-03-22 18:52:19.156205+11	2026-03-22 18:52:19.156208+11	\N	2026-03-22 18:52:19.156209+11	US
21359	177	v1|198211902707|0	Lenovo ThinkPad X1 Extreme 15.6" i7-8750H 16GB 512GB SSD GTX 1050 Ti FREE SHIP	610.69	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/198211902707?_skw=thinkpad&hash=item2e26599cf3:g:A6oAAeSwP4ZpvqdU	2026-03-22 01:15:11+11	2026-03-22 18:52:19.157164+11	2026-03-22 18:52:19.157166+11	\N	2026-03-22 18:52:19.157168+11	US
21360	177	v1|267615639283|0	Lenovo ThinkPad P73 i7-9750H@2.60GHz QUADRO P620 4GB GPU 16GB RAM 512GB SSD  Lap	523.88	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/267615639283?_skw=thinkpad&hash=item3e4f2296f3:g:IqQAAeSwrIBpvqbc	2026-03-22 01:08:31+11	2026-03-22 18:52:19.157989+11	2026-03-22 18:52:19.157992+11	\N	2026-03-22 18:52:19.157993+11	CA
21361	177	v1|267615637836|0	Lenovo ThinkPad T14 Gen 1 Intel Core i5-10210U 1.60GHz 16GB RAM 256 GB NVME  Lap	386.92	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/267615637836?_skw=thinkpad&hash=item3e4f22914c:g:Hp0AAeSwgI9pvqZ4	2026-03-22 01:05:52+11	2026-03-22 18:52:19.158947+11	2026-03-22 18:52:19.158952+11	\N	2026-03-22 18:52:19.158953+11	CA
21362	177	v1|287221729614|0	Lenovo ThinkPad L15 Laptop Core i5-10210U 8GB RAM 256GB SSD 15.6" Win 10 Japan	367.08	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/287221729614?_skw=thinkpad&hash=item42dfbfc94e:g:NCEAAeSwbq5pvPTj	2026-03-22 01:05:00+11	2026-03-22 18:52:19.160148+11	2026-03-22 18:52:19.160153+11	\N	2026-03-22 18:52:19.160155+11	JP
21363	177	v1|287221914206|0	LENOVO ThinkPad T570 15.6" Core i5-7300U @ 2.60GHz 256GB SSD 16GB RAM	227.11	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/287221914206?_skw=thinkpad&hash=item42dfc29a5e:g:yqcAAeSwd9RpvKOL	2026-03-22 00:52:36+11	2026-03-22 18:52:19.161659+11	2026-03-22 18:52:19.161663+11	\N	2026-03-22 18:52:19.161665+11	US
21364	177	v1|236703574782|0	Reconditioned Lenovo T430 14" i5 2.50 GHz 4GB 120GB Windows 7 Pro USB 3.0	203.60	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/236703574782?_skw=thinkpad&hash=item371ca1eafe:g:k50AAeSw~U5pvpnN	2026-03-22 00:17:36+11	2026-03-22 18:52:19.16353+11	2026-03-22 18:52:19.163536+11	\N	2026-03-22 18:52:19.163538+11	US
21365	177	v1|389778637303|0	thinkpad t14 gen 1	719.05	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/389778637303?_skw=thinkpad&hash=item5ac09e01f7:g:rc4AAeSwfKJpvpmt	2026-03-22 00:15:51+11	2026-03-22 18:52:19.164887+11	2026-03-22 18:52:19.164891+11	\N	2026-03-22 18:52:19.164893+11	CA
21366	177	v1|227266622660|0	Lenovo ThinkPad P1 Gen 4 i7-11850H 16" 4K HDR 2TB 32GB NVIDIA RTX A4000 - READ	900.00	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/227266622660?_skw=thinkpad&hash=item34ea2574c4:g:yygAAeSwT3xpvn~L	2026-03-21 23:43:43+11	2026-03-22 18:52:19.166133+11	2026-03-22 18:52:19.166138+11	\N	2026-03-22 18:52:19.166139+11	AU
21367	177	v1|277822159521|0	Lenovo ThinkPad L13 Yoga i5-10210U | 256GB SSD | 8GB RAM | Win 11 Pro C264	140.95	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/277822159521?_skw=thinkpad&hash=item40af7dbaa1:g:j64AAeSwV8xpvnwI	2026-03-21 22:08:10+11	2026-03-22 18:52:19.167305+11	2026-03-22 18:52:19.167309+11	\N	2026-03-22 18:52:19.16731+11	US
21368	177	v1|287221604734|0	Lenovo ThinkPad L13 Yoga i5-10210U | 256GB SSD | 8GB RAM | Win 11 Pro C263	172.28	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/287221604734?_skw=thinkpad&hash=item42dfbde17e:g:l2sAAeSwyXJpvnjv	2026-03-21 21:55:09+11	2026-03-22 18:52:19.168463+11	2026-03-22 18:52:19.168467+11	\N	2026-03-22 18:52:19.168469+11	US
21369	177	v1|287221593760|0	Lenovo ThinkPad L13 Yoga i5-10210U | 256GB SSD | 8GB RAM | Win 11 Pro C262	187.94	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/287221593760?_skw=thinkpad&hash=item42dfbdb6a0:g:p9MAAeSwrIBpvndA	2026-03-21 21:47:53+11	2026-03-22 18:52:19.169617+11	2026-03-22 18:52:19.169621+11	\N	2026-03-22 18:52:19.169622+11	US
21370	177	v1|188190836100|0	Lenovo ThinkPad X1 Yoga 4th Gen – i5-8365U | 8GB RAM | 256GB SSD | Touchscreen	300.00	AUD	Used	FIXED_PRICE,AUCTION	EBAY_AU	https://www.ebay.com.au/itm/188190836100?_skw=thinkpad&hash=item2bd10c4584:g:q3gAAeSwBblpvnA~	2026-03-21 21:19:19+11	2026-03-22 18:52:19.170778+11	2026-03-22 18:52:19.170781+11	\N	2026-03-22 18:52:19.170782+11	AU
21371	177	v1|406788301266|0	Lenovo ThinkPad T460 20FN002SUS - NO BOOT DRIVE/RAM, Intel i5-6200u	85.60	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/406788301266?_skw=thinkpad&hash=item5eb678e1d2:g:OlUAAeSweLNpvm0k	2026-03-21 21:07:47+11	2026-03-22 18:52:19.171942+11	2026-03-22 18:52:19.171945+11	\N	2026-03-22 18:52:19.171947+11	CA
21372	177	v1|318037494358|0	Lenovo ThinkPad X390 13.3"  I5-8365U 1.6GHz, 8GB RAM, 256GB NVMe SSD Win11Pro	264.70	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/318037494358?_skw=thinkpad&hash=item4a0c830a56:g:bMAAAeSwuHBpvlEX	2026-03-21 19:08:23+11	2026-03-22 18:52:19.17311+11	2026-03-22 18:52:19.173114+11	\N	2026-03-22 18:52:19.173115+11	US
21373	177	v1|318037465746|0	Lenovo ThinkPad T560 Laptop 15.6” I5-6200U 2.30 GHz,12GB RAM, 256GB SSD Win10Pro	233.38	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/318037465746?_skw=thinkpad&hash=item4a0c829a92:g:by8AAeSwlJNpvk9l	2026-03-21 18:57:59+11	2026-03-22 18:52:19.174283+11	2026-03-22 18:52:19.174287+11	\N	2026-03-22 18:52:19.174288+11	US
21374	177	v1|318037407176|0	Lenovo ThinkPad T490 I5-8265U 1.6GHz, 16GB RAM, 14-inch 256GB SSD, Win 11Pro	311.69	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/318037407176?_skw=thinkpad&hash=item4a0c81b5c8:g:AJoAAeSwif9pvkkT	2026-03-21 18:33:51+11	2026-03-22 18:52:19.175528+11	2026-03-22 18:52:19.175533+11	\N	2026-03-22 18:52:19.175534+11	US
21375	177	v1|257417562364|0	Lenovo ThinkPad P14S Gen 2 Intel i7-1185G7 16GB RAM 256GB SSD NVIDIA T500 Touch	501.20	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/257417562364?_skw=thinkpad&hash=item3bef4848fc:g:b44AAeSwjKdpvkf0	2026-03-21 18:27:29+11	2026-03-22 18:52:19.177176+11	2026-03-22 18:52:19.177181+11	\N	2026-03-22 18:52:19.177183+11	US
21376	177	v1|188190110490|0	Lenovo ThinkPad T580 15.6" FHD i7 8TH Gen laptop 16GB DDR4 1TB  SSD win 11 pro	501.21	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/188190110490?_skw=thinkpad&hash=item2bd101331a:g:-QwAAeSwRLlpvhow	2026-03-21 16:13:57+11	2026-03-22 18:52:19.178662+11	2026-03-22 18:52:19.178667+11	\N	2026-03-22 18:52:19.178669+11	US
21377	177	v1|358356929500|0	Linux + Libreboot Thinkpad T480s | 16GB | 256GB | i5-8650U | Wifi 6 MonMode+	500.00	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/358356929500?_skw=thinkpad&hash=item536fbccbdc:g:VgQAAeSwzstpviMv	2026-03-21 16:03:23+11	2026-03-22 18:52:19.180062+11	2026-03-22 18:52:19.180067+11	\N	2026-03-22 18:52:19.180068+11	AU
21378	177	v1|206155108228|0	Lenovo ThinkPad T14s Gen 1 16GB 256GB SSD Core i5-10310U Win 10 Pro	344.58	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/206155108228?_skw=thinkpad&hash=item2fffcd4f84:g:O2AAAeSwBfhpviHv	2026-03-21 15:50:52+11	2026-03-22 18:52:19.181225+11	2026-03-22 18:52:19.181229+11	\N	2026-03-22 18:52:19.18123+11	US
21379	177	v1|318036763076|0	Lenovo ThinkPad L15 Gen 2a AMD Ryzen Pro 5650U, 16GB RAM, 256 GB NVMe SSD Win11P	468.32	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/318036763076?_skw=thinkpad&hash=item4a0c77e1c4:g:xuoAAeSwz8lpvhDg	2026-03-21 14:35:42+11	2026-03-22 18:52:19.182351+11	2026-03-22 18:52:19.182355+11	\N	2026-03-22 18:52:19.182356+11	US
21380	177	v1|389777048063|0	Lenovo ThinkPad Extreme Gen3 Laptop Excellent Condition	1929.67	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/389777048063?_skw=thinkpad&hash=item5ac085c1ff:g:tz0AAeSwQdppvhGm	2026-03-21 14:28:52+11	2026-03-22 18:52:19.183509+11	2026-03-22 18:52:19.183513+11	\N	2026-03-22 18:52:19.183514+11	KR
21381	177	v1|318036715350|0	Lenovo ThinkPad L15 Gen 1 Laptop 15.6" AMD Ryzen 5 4650U, 16GB RAM, 256GB NVMe	343.02	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/318036715350?_skw=thinkpad&hash=item4a0c772756:g:oUcAAeSwulNpvg2~	2026-03-21 14:20:47+11	2026-03-22 18:52:19.184692+11	2026-03-22 18:52:19.184696+11	\N	2026-03-22 18:52:19.184697+11	US
21382	177	v1|318036650827|0	Lenovo ThinkPad X1 Carbon Gen 8 14” I5-10310U, 16GB RAM, 256GB NVMe SSD Win11Pro	468.32	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/318036650827?_skw=thinkpad&hash=item4a0c762b4b:g:lAAAAeSwkGZpvgik	2026-03-21 14:00:28+11	2026-03-22 18:52:19.185849+11	2026-03-22 18:52:19.185853+11	\N	2026-03-22 18:52:19.185854+11	US
21383	177	v1|277821392011|0	Hackintosh - macOS Sequoia & Windows 11 - Intel Core i5-10210U 16GB DDr4 1TB SSD	438.56	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/277821392011?_skw=thinkpad&hash=item40af72048b:g:sxkAAeSwDXtpvgk3	2026-03-21 13:58:14+11	2026-03-22 18:52:19.187024+11	2026-03-22 18:52:19.187027+11	\N	2026-03-22 18:52:19.187029+11	US
21384	177	v1|198212954302|0	Lenovo ThinkPad T14 Gen 4 i5-1335u 16GB DDR5 512GB RAM Win 11 Pro ACTIVE SUPPORT	916.28	AUD	New	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/198212954302?_skw=thinkpad&hash=item2e2669a8be:g:x~4AAeSwdLdpvfBe	2026-03-22 10:24:40+11	2026-03-22 18:52:19.188298+11	2026-03-22 18:52:19.188302+11	\N	2026-03-22 18:52:19.188304+11	US
21385	177	v1|257417343284|0	Lenovo ThinkPad T430 i5-3320M @2.6GHz 8 GB RAM 14" 460GB HDD Windows 10 Pro	212.97	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/257417343284?_skw=thinkpad&hash=item3bef44f134:g:iwwAAeSwz8lpvgSL	2026-03-21 13:44:44+11	2026-03-22 18:52:19.189531+11	2026-03-22 18:52:19.189535+11	\N	2026-03-22 18:52:19.189536+11	US
21386	177	v1|227266091215|0	Lenovo ThinkPad L16 Gen 2 16" NB Intel Ultra 5 8GB RAM 512GB SSD - Touchscreen	1080.71	AUD	Open box	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/227266091215?_skw=thinkpad&hash=item34ea1d58cf:g:2UwAAeSw2FppvgER	2026-03-21 13:25:08+11	2026-03-22 18:52:19.190718+11	2026-03-22 18:52:19.190722+11	\N	2026-03-22 18:52:19.190724+11	US
21387	177	v1|318036470332|0	Lenovo ThinkPad X1 Carbon 6th Gen 14" FHD  i5-8350U 16GB RAM 256GB SSD Win 11	352.41	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/318036470332?_skw=thinkpad&hash=item4a0c736a3c:g:TNwAAeSwWD5pvfnU	2026-03-21 12:55:10+11	2026-03-22 18:52:19.191914+11	2026-03-22 18:52:19.191919+11	\N	2026-03-22 18:52:19.19192+11	US
21388	177	v1|236702623432|0	Lenovo ThinkPad E14 Gen 5, i7 13th gen 16gb Ram, 512gb NVMe, Touchscreen, Win11P	551.32	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/236702623432?_skw=thinkpad&hash=item371c9366c8:g:r-kAAeSw3mtpvfn4	2026-03-21 12:54:35+11	2026-03-22 18:52:19.193439+11	2026-03-22 18:52:19.193444+11	\N	2026-03-22 18:52:19.193446+11	US
21389	177	v1|206154830237|0	Lenovo P71 ThinkPad Intel i7-7700HQ Quadro GPU FHD NVMe SSD NICE! But Needs BATT	274.41	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/206154830237?_skw=thinkpad&hash=item2fffc9119d:g:iYMAAeSw7GJpvfGa	2026-03-21 12:43:14+11	2026-03-22 18:52:19.194903+11	2026-03-22 18:52:19.194909+11	\N	2026-03-22 18:52:19.194912+11	US
21390	177	v1|318036409694|0	Lenovo ThinkPad T490 14” I7-10510U 1.80GHz, 16GB RAM, 256GB NVMe SSD Win11Pro	390.00	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/318036409694?_skw=thinkpad&hash=item4a0c727d5e:g:c9YAAeSws~JpvfTD	2026-03-21 12:34:53+11	2026-03-22 18:52:19.196319+11	2026-03-22 18:52:19.196323+11	\N	2026-03-22 18:52:19.196325+11	US
21391	177	v1|366292279230|0	Lenovo ThinkPad P15 Gen 1 i7-10750H 32GB RAM 512GB SSD 4GB NVIDIA T2000 Win 11	797.81	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/366292279230?_skw=thinkpad&hash=item5548b89fbe:g:BKcAAeSwnc1pvfKy	2026-03-21 12:23:56+11	2026-03-22 18:52:19.197487+11	2026-03-22 18:52:19.197492+11	\N	2026-03-22 18:52:19.197493+11	CA
21392	177	v1|198210349824|0	Lenovo ThinkPad T480S i7-8650U  16GB Ram 512 GB SSD Win 11 Pro	482.06	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/198210349824?_skw=thinkpad&hash=item2e2641eb00:g:7i8AAeSwQ6lpvewb	2026-03-21 11:55:11+11	2026-03-22 18:52:19.198618+11	2026-03-22 18:52:19.198622+11	\N	2026-03-22 18:52:19.198623+11	US
21393	177	v1|236702532575|0	Lenovo Slim 7 Pro X Ryzen 9 6900HS, GeForce RTX 3050 4GB GDDR6, 32GB Win 11 Pro	1076.04	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/236702532575?_skw=thinkpad&hash=item371c9203df:g:kJcAAeSwgHhpveb4	2026-03-21 11:54:05+11	2026-03-22 18:52:19.19973+11	2026-03-22 18:52:19.199735+11	\N	2026-03-22 18:52:19.199736+11	US
21394	177	v1|277821182343|0	LENOVO THINKPAD P1 GEN5 LAPTOP, 64GB RAM, 1T M.2, i9	2175.57	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/277821182343?_skw=thinkpad&hash=item40af6ed187:g:60EAAeSwYC5pvemd	2026-03-21 11:43:17+11	2026-03-22 18:52:19.200885+11	2026-03-22 18:52:19.200889+11	\N	2026-03-22 18:52:19.20089+11	US
21395	177	v1|177977853729|0	IBM ThinkPad T42 Laptop 14" Intel Pentium M, Vintage, 100gb Hdd Cd/dvd	148.80	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/177977853729?_skw=thinkpad&hash=item29704e8721:g:zU0AAeSwV8xpveLE	2026-03-21 11:33:13+11	2026-03-22 18:52:19.202019+11	2026-03-22 18:52:19.202023+11	\N	2026-03-22 18:52:19.202024+11	US
21396	177	v1|177977844915|0	Lenovo ThinkPad 13 Chromebook Parts Repair Keyboard Issue Works AS IS	101.79	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/177977844915?_skw=thinkpad&hash=item29704e64b3:g:pZMAAeSw4oFpvdvp	2026-03-21 11:30:29+11	2026-03-22 18:52:19.203207+11	2026-03-22 18:52:19.203211+11	\N	2026-03-22 18:52:19.203213+11	US
21397	177	v1|267615205503|0	Lenovo ThinkPad X1 Carbon Gen 7 14"  i5-8365U 8GB Ram 256GB SSD Win11	300.00	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/267615205503?_skw=thinkpad&hash=item3e4f1bf87f:g:nSUAAeSwSIxpveT6	2026-03-21 11:29:21+11	2026-03-22 18:52:19.20436+11	2026-03-22 18:52:19.204365+11	\N	2026-03-22 18:52:19.204366+11	AU
21398	177	v1|306834100035|0	Lenovo ThinkPad T460S 14'' (128gb SSD Intel Core i5-6300U 2.4GHz 8GB RAM) Laptop	234.93	AUD	Used	FIXED_PRICE,AUCTION	EBAY_AU	https://www.ebay.com.au/itm/306834100035?_skw=thinkpad&hash=item4770bccf43:g:EOcAAeSwaFdpveXE	2026-03-21 11:27:17+11	2026-03-22 18:52:19.205473+11	2026-03-22 18:52:19.205477+11	\N	2026-03-22 18:52:19.205478+11	US
21399	177	v1|358356254498|0	(LOT of 2) Lenovo ThinkPad 14" E14 G2 i5-1135G7 16GB 256GB NVMe Windows 11 Pro	593.62	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/358356254498?_skw=thinkpad&hash=item536fb27f22:g:l5YAAeSwIKBpveSd	2026-03-21 11:26:44+11	2026-03-22 18:52:19.206592+11	2026-03-22 18:52:19.206597+11	\N	2026-03-22 18:52:19.206598+11	US
21400	177	v1|397741005836|0	Lenovo ThinkPad E14 Gen 5 Laptop	1065.06	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/397741005836?_skw=thinkpad&hash=item5c9b361c0c:g:lCgAAeSwbKlpveKX	2026-03-21 11:19:26+11	2026-03-22 18:52:19.207715+11	2026-03-22 18:52:19.207719+11	\N	2026-03-22 18:52:19.20772+11	US
21401	177	v1|358356151709|0	(LOT of 2) Lenovo ThinkPad 14" E14 G4 i5-1235U 16GB 512GB NVMe Windows 11 Pro	953.87	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/358356151709?_skw=thinkpad&hash=item536fb0ed9d:g:rNoAAeSw6Ytpvdzf	2026-03-21 10:51:44+11	2026-03-22 18:52:19.208908+11	2026-03-22 18:52:19.208913+11	\N	2026-03-22 18:52:19.208914+11	US
21402	177	v1|306834033689|0	Lenovo ThinkPad T14s Gen 6 14" WUXGA Snapdragon X Elite 32GB 1TB SSD	1251.46	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/306834033689?_skw=thinkpad&hash=item4770bbcc19:g:dnEAAeSwOvZpvdsu	2026-03-21 10:44:11+11	2026-03-22 18:52:19.210578+11	2026-03-22 18:52:19.210586+11	\N	2026-03-22 18:52:19.210589+11	US
21403	177	v1|188189238690|0	Lenovo ThinkPad P53 15.6" i7-9850H 2.6GHz Quadro T2000 8GB RAM 512GB SSD	501.21	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/188189238690?_skw=thinkpad&hash=item2bd0f3e5a2:g:K5kAAeSwASBpvdnG	2026-03-21 10:36:11+11	2026-03-22 18:52:19.211887+11	2026-03-22 18:52:19.211891+11	\N	2026-03-22 18:52:19.211892+11	US
21404	177	v1|257417149899|0	Lenovo ThinkPad P50 XEON E3-1505M v5 @ 2.9GHz | 32GB RAM, NO SSD | #P235	313.19	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/257417149899?_skw=thinkpad&hash=item3bef41fdcb:g:W2AAAeSwUMZpvdRy	2026-03-21 10:24:39+11	2026-03-22 18:52:19.213371+11	2026-03-22 18:52:19.213375+11	\N	2026-03-22 18:52:19.213376+11	US
21405	177	v1|127760404449|0	Lenovo ThinkPad X1 Tablet Gen 3 i7-8650U 1.9GHz CPU 8GB RAM 250GB SSD Win 11 Pro	352.34	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/127760404449?_skw=thinkpad&hash=item1dbf1d0fe1:g:vvsAAeSwBblpvdGd	2026-03-21 10:01:14+11	2026-03-22 18:52:19.214744+11	2026-03-22 18:52:19.21475+11	\N	2026-03-22 18:52:19.214751+11	US
21406	177	v1|147214919012|0	Lenovo ThinkPad X1 Nano Gen 1 i7-1180G7 16GB RAM 512GB SSD 13" 2k  Touch	853.62	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/147214919012?_skw=thinkpad&hash=item2246b16564:g:nacAAeSwGMhpvcyB	2026-03-21 09:41:58+11	2026-03-22 18:52:19.215941+11	2026-03-22 18:52:19.215945+11	\N	2026-03-22 18:52:19.215946+11	US
21407	177	v1|188189060679|0	Lenovo ThinkPad E14 Gen 2-i5-1135G7@2.4GHz 16GB DDR4 Ram 256GB NVME SSD W11P	266.27	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/188189060679?_skw=thinkpad&hash=item2bd0f12e47:g:TusAAeSwOp1pvZdN	2026-03-21 09:39:26+11	2026-03-22 18:52:19.217026+11	2026-03-22 18:52:19.21703+11	\N	2026-03-22 18:52:19.217031+11	US
21408	177	v1|336492313497|0	Lenovo Thinkpad T430s 14" Core i5-3320 2.6GHz 8GB RAM 320GB HDD W/MS Office 2016	258.44	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/336492313497?_skw=thinkpad&hash=item4e58813b99:g:XJsAAeSwQBFpvcjI	2026-03-21 09:24:48+11	2026-03-22 18:52:19.217947+11	2026-03-22 18:52:19.217951+11	\N	2026-03-22 18:52:19.217953+11	US
21409	177	v1|198210037480|0	Lenovo ThinkPad P17 Gen 1 (i9-10885H 2.40GHz 16GB 512GB NVMe Quadro T2000) No AC	1065.07	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/198210037480?_skw=thinkpad&hash=item2e263d26e8:g:EzkAAeSwsV9pp2e7	2026-03-21 09:18:12+11	2026-03-22 18:52:19.21949+11	2026-03-22 18:52:19.219495+11	\N	2026-03-22 18:52:19.219496+11	US
21410	177	v1|177977583846|0	Lenovo ThinkPad L16 G2 16" Touchscreen AMD Ryzen 7 PRO 250 16GB RAM, 512GB SSD	2526.88	AUD	New	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/177977583846?_skw=thinkpad&hash=item29704a68e6:g:5oEAAeSwmWFpvcdL	2026-03-21 09:16:49+11	2026-03-22 18:52:19.220745+11	2026-03-22 18:52:19.220749+11	\N	2026-03-22 18:52:19.220751+11	US
21411	177	v1|127760331127|0	Lenovo ThinkPad T16 Gen 1 - 16" Intel Core i7-1260P 8GB RAM NO SSD/NO OS	577.96	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/127760331127?_skw=thinkpad&hash=item1dbf1bf177:g:wjoAAeSwH8RpvcQ3	2026-03-21 09:04:13+11	2026-03-22 18:52:19.22192+11	2026-03-22 18:52:19.221925+11	\N	2026-03-22 18:52:19.221926+11	US
21412	177	v1|306833869153|0	Lenovo ThinkPad T15 Gen 1 4K UHD i5-10310U 16GB RAM 256GB SSD Win 11P - READ	344.57	AUD	Used	FIXED_PRICE	EBAY_AU	https://www.ebay.com.au/itm/306833869153?_skw=thinkpad&hash=item4770b94961:g:B0wAAeSwHPBpvb-3	2026-03-21 08:54:14+11	2026-03-22 18:52:19.223073+11	2026-03-22 18:52:19.223077+11	\N	2026-03-22 18:52:19.223078+11	US
21413	177	v1|137152039502|0	ThinkPad T14 Gen 4 14-inch i7-1365U 16Gb RAM 512Gb NVME Win 11 Pro Warranty	906.88	AUD	Used	FIXED_PRICE,BEST_OFFER	EBAY_AU	https://www.ebay.com.au/itm/137152039502?_skw=thinkpad&hash=item1feee60a4e:g:kTYAAeSw9RFpvb5Q	2026-03-21 08:51:02+11	2026-03-22 18:52:19.224183+11	2026-03-22 18:52:19.224187+11	\N	2026-03-22 18:52:19.224188+11	US
\.


--
-- Name: cpu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: thinkpaduser
--

SELECT pg_catalog.setval('public.cpu_id_seq', 47, true);


--
-- Name: listings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: thinkpaduser
--

SELECT pg_catalog.setval('public.listings_id_seq', 35860, true);


--
-- Name: marketplaces_id_seq; Type: SEQUENCE SET; Schema: public; Owner: thinkpaduser
--

SELECT pg_catalog.setval('public.marketplaces_id_seq', 4, true);


--
-- Name: model_list_id_seq; Type: SEQUENCE SET; Schema: public; Owner: thinkpaduser
--

SELECT pg_catalog.setval('public.model_list_id_seq', 556, true);


--
-- Name: model_price_stats_id_seq; Type: SEQUENCE SET; Schema: public; Owner: thinkpaduser
--

SELECT pg_catalog.setval('public.model_price_stats_id_seq', 15577, true);


--
-- Name: models_id_seq; Type: SEQUENCE SET; Schema: public; Owner: thinkpaduser
--

SELECT pg_catalog.setval('public.models_id_seq', 12024, true);


--
-- Name: price_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: thinkpaduser
--

SELECT pg_catalog.setval('public.price_history_id_seq', 21288, true);


--
-- Name: ram_id_seq; Type: SEQUENCE SET; Schema: public; Owner: thinkpaduser
--

SELECT pg_catalog.setval('public.ram_id_seq', 20, true);


--
-- Name: specs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: thinkpaduser
--

SELECT pg_catalog.setval('public.specs_id_seq', 23456, true);


--
-- Name: storage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: thinkpaduser
--

SELECT pg_catalog.setval('public.storage_id_seq', 19, true);


--
-- Name: temp_details_id_seq; Type: SEQUENCE SET; Schema: public; Owner: thinkpaduser
--

SELECT pg_catalog.setval('public.temp_details_id_seq', 18811, true);


--
-- Name: temp_summaries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: thinkpaduser
--

SELECT pg_catalog.setval('public.temp_summaries_id_seq', 21413, true);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: cpu cpu_name_key; Type: CONSTRAINT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.cpu
    ADD CONSTRAINT cpu_name_key UNIQUE (name);


--
-- Name: cpu cpu_pkey; Type: CONSTRAINT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.cpu
    ADD CONSTRAINT cpu_pkey PRIMARY KEY (id);


--
-- Name: model_price_stats ix_model_price_stats_model_market; Type: CONSTRAINT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.model_price_stats
    ADD CONSTRAINT ix_model_price_stats_model_market UNIQUE (model_id, marketplace);


--
-- Name: listings listings_pkey; Type: CONSTRAINT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.listings
    ADD CONSTRAINT listings_pkey PRIMARY KEY (id);


--
-- Name: marketplaces marketplaces_marketplace_id_key; Type: CONSTRAINT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.marketplaces
    ADD CONSTRAINT marketplaces_marketplace_id_key UNIQUE (marketplace_id);


--
-- Name: marketplaces marketplaces_pkey; Type: CONSTRAINT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.marketplaces
    ADD CONSTRAINT marketplaces_pkey PRIMARY KEY (id);


--
-- Name: model_list model_list_name_key; Type: CONSTRAINT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.model_list
    ADD CONSTRAINT model_list_name_key UNIQUE (name);


--
-- Name: model_list model_list_pkey; Type: CONSTRAINT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.model_list
    ADD CONSTRAINT model_list_pkey PRIMARY KEY (id);


--
-- Name: model_list model_list_slug_key; Type: CONSTRAINT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.model_list
    ADD CONSTRAINT model_list_slug_key UNIQUE (slug);


--
-- Name: model_price_stats model_price_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.model_price_stats
    ADD CONSTRAINT model_price_stats_pkey PRIMARY KEY (id);


--
-- Name: models models_pkey; Type: CONSTRAINT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.models
    ADD CONSTRAINT models_pkey PRIMARY KEY (id);


--
-- Name: price_history price_history_pkey; Type: CONSTRAINT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.price_history
    ADD CONSTRAINT price_history_pkey PRIMARY KEY (id);


--
-- Name: ram ram_pkey; Type: CONSTRAINT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.ram
    ADD CONSTRAINT ram_pkey PRIMARY KEY (id);


--
-- Name: ram ram_size_key; Type: CONSTRAINT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.ram
    ADD CONSTRAINT ram_size_key UNIQUE (size);


--
-- Name: specs specs_pkey; Type: CONSTRAINT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.specs
    ADD CONSTRAINT specs_pkey PRIMARY KEY (id);


--
-- Name: storage storage_pkey; Type: CONSTRAINT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.storage
    ADD CONSTRAINT storage_pkey PRIMARY KEY (id);


--
-- Name: storage storage_size_key; Type: CONSTRAINT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.storage
    ADD CONSTRAINT storage_size_key UNIQUE (size);


--
-- Name: temp_details temp_details_ebay_item_id_key; Type: CONSTRAINT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.temp_details
    ADD CONSTRAINT temp_details_ebay_item_id_key UNIQUE (ebay_item_id);


--
-- Name: temp_details temp_details_pkey; Type: CONSTRAINT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.temp_details
    ADD CONSTRAINT temp_details_pkey PRIMARY KEY (id);


--
-- Name: temp_summaries temp_summaries_ebay_item_id_key; Type: CONSTRAINT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.temp_summaries
    ADD CONSTRAINT temp_summaries_ebay_item_id_key UNIQUE (ebay_item_id);


--
-- Name: temp_summaries temp_summaries_pkey; Type: CONSTRAINT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.temp_summaries
    ADD CONSTRAINT temp_summaries_pkey PRIMARY KEY (id);


--
-- Name: idx_listings_marketplace_status_price; Type: INDEX; Schema: public; Owner: thinkpaduser
--

CREATE INDEX idx_listings_marketplace_status_price ON public.listings USING btree (marketplace, status, price);


--
-- Name: idx_specs_search; Type: INDEX; Schema: public; Owner: thinkpaduser
--

CREATE INDEX idx_specs_search ON public.specs USING btree (cpu, ram, storage);


--
-- Name: ix_listings_ebay_item_id; Type: INDEX; Schema: public; Owner: thinkpaduser
--

CREATE UNIQUE INDEX ix_listings_ebay_item_id ON public.listings USING btree (ebay_item_id);


--
-- Name: ix_listings_status; Type: INDEX; Schema: public; Owner: thinkpaduser
--

CREATE INDEX ix_listings_status ON public.listings USING btree (status);


--
-- Name: ix_model_price_stats_model_id; Type: INDEX; Schema: public; Owner: thinkpaduser
--

CREATE INDEX ix_model_price_stats_model_id ON public.model_price_stats USING btree (model_id);


--
-- Name: ix_models_listing_id; Type: INDEX; Schema: public; Owner: thinkpaduser
--

CREATE UNIQUE INDEX ix_models_listing_id ON public.models USING btree (listing_id);


--
-- Name: ix_models_name; Type: INDEX; Schema: public; Owner: thinkpaduser
--

CREATE INDEX ix_models_name ON public.models USING btree (name);


--
-- Name: ix_price_history_recorded_at; Type: INDEX; Schema: public; Owner: thinkpaduser
--

CREATE INDEX ix_price_history_recorded_at ON public.price_history USING btree (recorded_at);


--
-- Name: ix_specs_listing_id; Type: INDEX; Schema: public; Owner: thinkpaduser
--

CREATE UNIQUE INDEX ix_specs_listing_id ON public.specs USING btree (listing_id);


--
-- Name: model_price_stats model_price_stats_model_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.model_price_stats
    ADD CONSTRAINT model_price_stats_model_id_fkey FOREIGN KEY (model_id) REFERENCES public.models(id);


--
-- Name: models models_canon_model_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.models
    ADD CONSTRAINT models_canon_model_id_fkey FOREIGN KEY (canon_model_id) REFERENCES public.model_list(id) ON DELETE SET NULL;


--
-- Name: models models_listing_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.models
    ADD CONSTRAINT models_listing_id_fkey FOREIGN KEY (listing_id) REFERENCES public.listings(id) ON DELETE CASCADE;


--
-- Name: price_history price_history_listing_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.price_history
    ADD CONSTRAINT price_history_listing_id_fkey FOREIGN KEY (listing_id) REFERENCES public.listings(id) ON DELETE CASCADE;


--
-- Name: specs specs_listing_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thinkpaduser
--

ALTER TABLE ONLY public.specs
    ADD CONSTRAINT specs_listing_id_fkey FOREIGN KEY (listing_id) REFERENCES public.listings(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict GJQUjOuPLO201eHWLJZU7pWoFKm1kPYaQuTebpb1dkej0E3lbPjL32vQkGf8TY3

