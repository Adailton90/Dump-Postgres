--
-- PostgreSQL database dump
--

-- Dumped from database version 11.2 (Debian 11.2-1.pgdg90+1)
-- Dumped by pg_dump version 11.2 (Debian 11.2-1.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;


--
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


SET default_with_oids = false;

--
-- Name: tb_versao_corte; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tb_versao_corte (
    id_versao_corte integer NOT NULL,
    plataforma character varying(30) NOT NULL,
    numero_versao bigint NOT NULL,
    nome_versao character varying(30)
);


--
-- Name: tb_versao_corte_id_versao_corte_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tb_versao_corte_id_versao_corte_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tb_versao_corte_id_versao_corte_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tb_versao_corte_id_versao_corte_seq OWNED BY public.tb_versao_corte.id_versao_corte;


--
-- Name: tb_versao_corte id_versao_corte; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_versao_corte ALTER COLUMN id_versao_corte SET DEFAULT nextval('public.tb_versao_corte_id_versao_corte_seq'::regclass);


--
-- Data for Name: tb_versao_corte; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.tb_versao_corte VALUES (1, 'Android', 29, '2.0.0');
INSERT INTO public.tb_versao_corte VALUES (2, 'IOS', 1, '1.0.0');


--
-- Name: tb_versao_corte_id_versao_corte_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tb_versao_corte_id_versao_corte_seq', 2, true);


--
-- Name: tb_versao_corte pk_tb_versao_corte; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_versao_corte
    ADD CONSTRAINT pk_tb_versao_corte PRIMARY KEY (id_versao_corte);


--
-- PostgreSQL database dump complete
--

