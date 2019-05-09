--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--

DROP DATABASE "maquinaTest";




--
-- Drop roles
--

DROP ROLE postgres;


--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'md524bb002702969490e41e26e1a454036c';






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

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- Name: template1; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE template1 OWNER TO postgres;

\connect template1

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
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: postgres
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\connect template1

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
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: postgres
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


--
-- PostgreSQL database dump complete
--

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
-- Name: maquinaTest; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "maquinaTest" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE "maquinaTest" OWNER TO postgres;

\connect "maquinaTest"

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
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;


--
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: tb_acao_usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_acao_usuario (
    id_acao integer NOT NULL,
    data_acao timestamp without time zone NOT NULL,
    id_tipo integer NOT NULL,
    id_usuario integer NOT NULL
);


ALTER TABLE public.tb_acao_usuario OWNER TO postgres;

--
-- Name: historico_acessos; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.historico_acessos AS
 SELECT date_part('month'::text, tb_acao_usuario.data_acao) AS mes,
    count(tb_acao_usuario.id_usuario) AS qtd_usuario
   FROM public.tb_acao_usuario
  WHERE ((tb_acao_usuario.id_tipo = 1) AND (date_part('year'::text, tb_acao_usuario.data_acao) = date_part('year'::text, CURRENT_DATE)))
  GROUP BY (date_part('month'::text, tb_acao_usuario.data_acao))
  ORDER BY (date_part('month'::text, tb_acao_usuario.data_acao));


ALTER TABLE public.historico_acessos OWNER TO postgres;

--
-- Name: historico_cadastros; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.historico_cadastros AS
 SELECT date_part('month'::text, tb_acao_usuario.data_acao) AS mes,
    count(tb_acao_usuario.id_usuario) AS qtd_usuario
   FROM public.tb_acao_usuario
  WHERE ((tb_acao_usuario.id_tipo = 2) AND (date_part('year'::text, tb_acao_usuario.data_acao) = date_part('year'::text, CURRENT_DATE)))
  GROUP BY (date_part('month'::text, tb_acao_usuario.data_acao))
  ORDER BY (date_part('month'::text, tb_acao_usuario.data_acao));


ALTER TABLE public.historico_cadastros OWNER TO postgres;

--
-- Name: jeferson; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jeferson (
    teste_coluna "char"
);


ALTER TABLE public.jeferson OWNER TO postgres;

--
-- Name: relatorio_acessos_cadastros; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.relatorio_acessos_cadastros AS
 SELECT ( SELECT count(*) AS count
           FROM public.tb_acao_usuario
          WHERE (tb_acao_usuario.id_tipo = 2)) AS quantidade_total_cadastros,
    ( SELECT count(*) AS count
           FROM public.tb_acao_usuario
          WHERE ((tb_acao_usuario.id_tipo = 2) AND (date_part('month'::text, tb_acao_usuario.data_acao) = date_part('month'::text, CURRENT_DATE)))) AS quantidade_cadastro_mes_atual,
    ( SELECT count(*) AS count
           FROM public.tb_acao_usuario
          WHERE (tb_acao_usuario.id_tipo = 1)) AS quantidade_total_acessos,
    ( SELECT count(*) AS count
           FROM public.tb_acao_usuario
          WHERE ((tb_acao_usuario.id_tipo = 1) AND (date_part('month'::text, tb_acao_usuario.data_acao) = date_part('month'::text, CURRENT_DATE)))) AS quantidade_acessos_mes_atual;


ALTER TABLE public.relatorio_acessos_cadastros OWNER TO postgres;

--
-- Name: tb_acao_usuario_id_acao_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_acao_usuario_id_acao_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tb_acao_usuario_id_acao_seq OWNER TO postgres;

--
-- Name: tb_acao_usuario_id_acao_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_acao_usuario_id_acao_seq OWNED BY public.tb_acao_usuario.id_acao;


--
-- Name: tb_avaliacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_avaliacao (
    id_avaliacao integer NOT NULL,
    id_preco integer NOT NULL,
    data_avaliacao date NOT NULL,
    nota integer NOT NULL,
    CONSTRAINT chk_nota CHECK (((nota <= 5) AND (nota >= 0)))
);


ALTER TABLE public.tb_avaliacao OWNER TO postgres;

--
-- Name: tb_avaliacao_id_avaliacao_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_avaliacao_id_avaliacao_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tb_avaliacao_id_avaliacao_seq OWNER TO postgres;

--
-- Name: tb_avaliacao_id_avaliacao_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_avaliacao_id_avaliacao_seq OWNED BY public.tb_avaliacao.id_avaliacao;


--
-- Name: tb_categoria_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_categoria_produto (
    id_categoria integer NOT NULL,
    descricao character varying(50) NOT NULL
);


ALTER TABLE public.tb_categoria_produto OWNER TO postgres;

--
-- Name: tb_categoria_produto_id_categoria_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_categoria_produto_id_categoria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tb_categoria_produto_id_categoria_seq OWNER TO postgres;

--
-- Name: tb_categoria_produto_id_categoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_categoria_produto_id_categoria_seq OWNED BY public.tb_categoria_produto.id_categoria;


--
-- Name: tb_cidade; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_cidade (
    id_cidade integer NOT NULL,
    id_estado integer NOT NULL,
    nome character varying(255) NOT NULL
);


ALTER TABLE public.tb_cidade OWNER TO postgres;

--
-- Name: tb_cidade_id_cidade_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_cidade_id_cidade_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tb_cidade_id_cidade_seq OWNER TO postgres;

--
-- Name: tb_cidade_id_cidade_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_cidade_id_cidade_seq OWNED BY public.tb_cidade.id_cidade;


--
-- Name: tb_endereco; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_endereco (
    id_endereco integer NOT NULL,
    bairro character varying(255) NOT NULL,
    id_cidade integer NOT NULL,
    id_localizacao integer
);


ALTER TABLE public.tb_endereco OWNER TO postgres;

--
-- Name: tb_endereco_id_endereco_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_endereco_id_endereco_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tb_endereco_id_endereco_seq OWNER TO postgres;

--
-- Name: tb_endereco_id_endereco_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_endereco_id_endereco_seq OWNED BY public.tb_endereco.id_endereco;


--
-- Name: tb_estado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_estado (
    id_estado integer NOT NULL,
    id_pais integer NOT NULL,
    uf character varying(50) NOT NULL,
    nome character varying(50) NOT NULL
);


ALTER TABLE public.tb_estado OWNER TO postgres;

--
-- Name: tb_estado_id_estado_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_estado_id_estado_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tb_estado_id_estado_seq OWNER TO postgres;

--
-- Name: tb_estado_id_estado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_estado_id_estado_seq OWNED BY public.tb_estado.id_estado;


--
-- Name: tb_filial; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_filial (
    id_filial integer NOT NULL,
    id_supermercado integer NOT NULL,
    id_endereco integer NOT NULL
);


ALTER TABLE public.tb_filial OWNER TO postgres;

--
-- Name: tb_filial_id_filial_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_filial_id_filial_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tb_filial_id_filial_seq OWNER TO postgres;

--
-- Name: tb_filial_id_filial_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_filial_id_filial_seq OWNED BY public.tb_filial.id_filial;


--
-- Name: tb_localizacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_localizacao (
    id_localizacao integer NOT NULL,
    latitude numeric(9,6) NOT NULL,
    longitude numeric(9,6) NOT NULL
);


ALTER TABLE public.tb_localizacao OWNER TO postgres;

--
-- Name: tb_localizacao_id_localizacao_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_localizacao_id_localizacao_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tb_localizacao_id_localizacao_seq OWNER TO postgres;

--
-- Name: tb_localizacao_id_localizacao_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_localizacao_id_localizacao_seq OWNED BY public.tb_localizacao.id_localizacao;


--
-- Name: tb_pais; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_pais (
    id_pais integer NOT NULL,
    nome character varying(50) NOT NULL,
    sigla character varying(50) NOT NULL
);


ALTER TABLE public.tb_pais OWNER TO postgres;

--
-- Name: tb_pais_id_pais_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_pais_id_pais_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tb_pais_id_pais_seq OWNER TO postgres;

--
-- Name: tb_pais_id_pais_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_pais_id_pais_seq OWNED BY public.tb_pais.id_pais;


--
-- Name: tb_perfil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_perfil (
    id_perfil integer NOT NULL,
    descricao character varying(255) NOT NULL
);


ALTER TABLE public.tb_perfil OWNER TO postgres;

--
-- Name: tb_perfil_id_perfil_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_perfil_id_perfil_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tb_perfil_id_perfil_seq OWNER TO postgres;

--
-- Name: tb_perfil_id_perfil_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_perfil_id_perfil_seq OWNED BY public.tb_perfil.id_perfil;


--
-- Name: tb_preco; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_preco (
    id_preco integer NOT NULL,
    id_filial integer NOT NULL,
    id_produto integer NOT NULL,
    preco numeric(6,2) NOT NULL,
    data_inclusao date NOT NULL,
    data_validade date NOT NULL
);


ALTER TABLE public.tb_preco OWNER TO postgres;

--
-- Name: tb_preco_id_preco_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_preco_id_preco_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tb_preco_id_preco_seq OWNER TO postgres;

--
-- Name: tb_preco_id_preco_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_preco_id_preco_seq OWNED BY public.tb_preco.id_preco;


--
-- Name: tb_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_produto (
    id_produto integer NOT NULL,
    id_categoria integer NOT NULL,
    nome character varying(50) NOT NULL,
    descricao character varying(255),
    foto character varying(255),
    marca character varying(50)
);


ALTER TABLE public.tb_produto OWNER TO postgres;

--
-- Name: tb_produto_id_produto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_produto_id_produto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tb_produto_id_produto_seq OWNER TO postgres;

--
-- Name: tb_produto_id_produto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_produto_id_produto_seq OWNED BY public.tb_produto.id_produto;


--
-- Name: tb_supermercado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_supermercado (
    id_supermercado integer NOT NULL,
    nome character varying(255) NOT NULL,
    foto character varying(255)
);


ALTER TABLE public.tb_supermercado OWNER TO postgres;

--
-- Name: tb_supermercado_id_supermercado_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_supermercado_id_supermercado_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tb_supermercado_id_supermercado_seq OWNER TO postgres;

--
-- Name: tb_supermercado_id_supermercado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_supermercado_id_supermercado_seq OWNED BY public.tb_supermercado.id_supermercado;


--
-- Name: tb_tipo_acao_usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_tipo_acao_usuario (
    id_tipo integer NOT NULL,
    descricao character varying(50) NOT NULL
);


ALTER TABLE public.tb_tipo_acao_usuario OWNER TO postgres;

--
-- Name: tb_tipo_acao_usuario_id_tipo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_tipo_acao_usuario_id_tipo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tb_tipo_acao_usuario_id_tipo_seq OWNER TO postgres;

--
-- Name: tb_tipo_acao_usuario_id_tipo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_tipo_acao_usuario_id_tipo_seq OWNED BY public.tb_tipo_acao_usuario.id_tipo;


--
-- Name: tb_usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_usuario (
    id_usuario integer NOT NULL,
    id_perfil integer NOT NULL,
    nome character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    senha character varying(255) NOT NULL
);


ALTER TABLE public.tb_usuario OWNER TO postgres;

--
-- Name: tb_usuario_firebase_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_usuario_firebase_token (
    id_usuario_firebase_token integer NOT NULL,
    id_usuario integer NOT NULL,
    token character varying(255) NOT NULL
);


ALTER TABLE public.tb_usuario_firebase_token OWNER TO postgres;

--
-- Name: tb_usuario_firebase_token_id_usuario_firebase_token_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_usuario_firebase_token_id_usuario_firebase_token_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tb_usuario_firebase_token_id_usuario_firebase_token_seq OWNER TO postgres;

--
-- Name: tb_usuario_firebase_token_id_usuario_firebase_token_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_usuario_firebase_token_id_usuario_firebase_token_seq OWNED BY public.tb_usuario_firebase_token.id_usuario_firebase_token;


--
-- Name: tb_usuario_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_usuario_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tb_usuario_id_usuario_seq OWNER TO postgres;

--
-- Name: tb_usuario_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_usuario_id_usuario_seq OWNED BY public.tb_usuario.id_usuario;


--
-- Name: tb_usuario_reset_password_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_usuario_reset_password_token (
    id_usuario_reset_password_token integer NOT NULL,
    id_usuario integer NOT NULL,
    token character varying(255) NOT NULL,
    data_expiracao timestamp without time zone NOT NULL
);


ALTER TABLE public.tb_usuario_reset_password_token OWNER TO postgres;

--
-- Name: tb_usuario_reset_password_tok_id_usuario_reset_password_tok_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_usuario_reset_password_tok_id_usuario_reset_password_tok_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tb_usuario_reset_password_tok_id_usuario_reset_password_tok_seq OWNER TO postgres;

--
-- Name: tb_usuario_reset_password_tok_id_usuario_reset_password_tok_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_usuario_reset_password_tok_id_usuario_reset_password_tok_seq OWNED BY public.tb_usuario_reset_password_token.id_usuario_reset_password_token;


--
-- Name: tb_versao_corte; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_versao_corte (
    id_versao_corte integer NOT NULL,
    plataforma character varying(30) NOT NULL,
    numero_versao bigint NOT NULL,
    nome_versao character varying(30)
);


ALTER TABLE public.tb_versao_corte OWNER TO postgres;

--
-- Name: tb_versao_corte_id_versao_corte_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_versao_corte_id_versao_corte_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tb_versao_corte_id_versao_corte_seq OWNER TO postgres;

--
-- Name: tb_versao_corte_id_versao_corte_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_versao_corte_id_versao_corte_seq OWNED BY public.tb_versao_corte.id_versao_corte;


--
-- Name: tb_acao_usuario id_acao; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_acao_usuario ALTER COLUMN id_acao SET DEFAULT nextval('public.tb_acao_usuario_id_acao_seq'::regclass);


--
-- Name: tb_avaliacao id_avaliacao; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_avaliacao ALTER COLUMN id_avaliacao SET DEFAULT nextval('public.tb_avaliacao_id_avaliacao_seq'::regclass);


--
-- Name: tb_categoria_produto id_categoria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_categoria_produto ALTER COLUMN id_categoria SET DEFAULT nextval('public.tb_categoria_produto_id_categoria_seq'::regclass);


--
-- Name: tb_cidade id_cidade; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_cidade ALTER COLUMN id_cidade SET DEFAULT nextval('public.tb_cidade_id_cidade_seq'::regclass);


--
-- Name: tb_endereco id_endereco; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_endereco ALTER COLUMN id_endereco SET DEFAULT nextval('public.tb_endereco_id_endereco_seq'::regclass);


--
-- Name: tb_estado id_estado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_estado ALTER COLUMN id_estado SET DEFAULT nextval('public.tb_estado_id_estado_seq'::regclass);


--
-- Name: tb_filial id_filial; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_filial ALTER COLUMN id_filial SET DEFAULT nextval('public.tb_filial_id_filial_seq'::regclass);


--
-- Name: tb_localizacao id_localizacao; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_localizacao ALTER COLUMN id_localizacao SET DEFAULT nextval('public.tb_localizacao_id_localizacao_seq'::regclass);


--
-- Name: tb_pais id_pais; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_pais ALTER COLUMN id_pais SET DEFAULT nextval('public.tb_pais_id_pais_seq'::regclass);


--
-- Name: tb_perfil id_perfil; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_perfil ALTER COLUMN id_perfil SET DEFAULT nextval('public.tb_perfil_id_perfil_seq'::regclass);


--
-- Name: tb_preco id_preco; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_preco ALTER COLUMN id_preco SET DEFAULT nextval('public.tb_preco_id_preco_seq'::regclass);


--
-- Name: tb_produto id_produto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_produto ALTER COLUMN id_produto SET DEFAULT nextval('public.tb_produto_id_produto_seq'::regclass);


--
-- Name: tb_supermercado id_supermercado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_supermercado ALTER COLUMN id_supermercado SET DEFAULT nextval('public.tb_supermercado_id_supermercado_seq'::regclass);


--
-- Name: tb_tipo_acao_usuario id_tipo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_tipo_acao_usuario ALTER COLUMN id_tipo SET DEFAULT nextval('public.tb_tipo_acao_usuario_id_tipo_seq'::regclass);


--
-- Name: tb_usuario id_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_usuario ALTER COLUMN id_usuario SET DEFAULT nextval('public.tb_usuario_id_usuario_seq'::regclass);


--
-- Name: tb_usuario_firebase_token id_usuario_firebase_token; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_usuario_firebase_token ALTER COLUMN id_usuario_firebase_token SET DEFAULT nextval('public.tb_usuario_firebase_token_id_usuario_firebase_token_seq'::regclass);


--
-- Name: tb_usuario_reset_password_token id_usuario_reset_password_token; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_usuario_reset_password_token ALTER COLUMN id_usuario_reset_password_token SET DEFAULT nextval('public.tb_usuario_reset_password_tok_id_usuario_reset_password_tok_seq'::regclass);


--
-- Name: tb_versao_corte id_versao_corte; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_versao_corte ALTER COLUMN id_versao_corte SET DEFAULT nextval('public.tb_versao_corte_id_versao_corte_seq'::regclass);


--
-- Data for Name: jeferson; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jeferson (teste_coluna) FROM stdin;
\.


--
-- Data for Name: tb_acao_usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_acao_usuario (id_acao, data_acao, id_tipo, id_usuario) FROM stdin;
\.


--
-- Data for Name: tb_avaliacao; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_avaliacao (id_avaliacao, id_preco, data_avaliacao, nota) FROM stdin;
\.


--
-- Data for Name: tb_categoria_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_categoria_produto (id_categoria, descricao) FROM stdin;
1	Limpeza
2	Frios
3	Frutas
4	Eletrodoméstico
5	Outros
\.


--
-- Data for Name: tb_cidade; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_cidade (id_cidade, id_estado, nome) FROM stdin;
1	1	Salvador
\.


--
-- Data for Name: tb_endereco; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_endereco (id_endereco, bairro, id_cidade, id_localizacao) FROM stdin;
\.


--
-- Data for Name: tb_estado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_estado (id_estado, id_pais, uf, nome) FROM stdin;
1	1	BA	Bahia
\.


--
-- Data for Name: tb_filial; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_filial (id_filial, id_supermercado, id_endereco) FROM stdin;
\.


--
-- Data for Name: tb_localizacao; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_localizacao (id_localizacao, latitude, longitude) FROM stdin;
\.


--
-- Data for Name: tb_pais; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_pais (id_pais, nome, sigla) FROM stdin;
1	Brasil	BR
\.


--
-- Data for Name: tb_perfil; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_perfil (id_perfil, descricao) FROM stdin;
1	Administrador
2	Operador
\.


--
-- Data for Name: tb_preco; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_preco (id_preco, id_filial, id_produto, preco, data_inclusao, data_validade) FROM stdin;
\.


--
-- Data for Name: tb_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_produto (id_produto, id_categoria, nome, descricao, foto, marca) FROM stdin;
\.


--
-- Data for Name: tb_supermercado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_supermercado (id_supermercado, nome, foto) FROM stdin;
\.


--
-- Data for Name: tb_tipo_acao_usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_tipo_acao_usuario (id_tipo, descricao) FROM stdin;
1	LOGIN
2	CADASTRO
\.


--
-- Data for Name: tb_usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_usuario (id_usuario, id_perfil, nome, email, senha) FROM stdin;
1	1	Administrador	admin@keropreco.com	472A7542DE1C93DDB9E40A5352841A32B85F1297ABDAE96EB209A085466F4DE4
2	2	Operador	operador@keropreco.com	operador2018
\.


--
-- Data for Name: tb_usuario_firebase_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_usuario_firebase_token (id_usuario_firebase_token, id_usuario, token) FROM stdin;
\.


--
-- Data for Name: tb_usuario_reset_password_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_usuario_reset_password_token (id_usuario_reset_password_token, id_usuario, token, data_expiracao) FROM stdin;
\.


--
-- Data for Name: tb_versao_corte; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_versao_corte (id_versao_corte, plataforma, numero_versao, nome_versao) FROM stdin;
1	Android	29	2.0.0
2	IOS	1	1.0.0
\.


--
-- Name: tb_acao_usuario_id_acao_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_acao_usuario_id_acao_seq', 1, false);


--
-- Name: tb_avaliacao_id_avaliacao_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_avaliacao_id_avaliacao_seq', 1, false);


--
-- Name: tb_categoria_produto_id_categoria_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_categoria_produto_id_categoria_seq', 5, true);


--
-- Name: tb_cidade_id_cidade_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_cidade_id_cidade_seq', 1, true);


--
-- Name: tb_endereco_id_endereco_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_endereco_id_endereco_seq', 1, false);


--
-- Name: tb_estado_id_estado_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_estado_id_estado_seq', 1, true);


--
-- Name: tb_filial_id_filial_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_filial_id_filial_seq', 1, false);


--
-- Name: tb_localizacao_id_localizacao_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_localizacao_id_localizacao_seq', 1, false);


--
-- Name: tb_pais_id_pais_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_pais_id_pais_seq', 1, true);


--
-- Name: tb_perfil_id_perfil_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_perfil_id_perfil_seq', 2, true);


--
-- Name: tb_preco_id_preco_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_preco_id_preco_seq', 1, false);


--
-- Name: tb_produto_id_produto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_produto_id_produto_seq', 1, false);


--
-- Name: tb_supermercado_id_supermercado_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_supermercado_id_supermercado_seq', 1, false);


--
-- Name: tb_tipo_acao_usuario_id_tipo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_tipo_acao_usuario_id_tipo_seq', 2, true);


--
-- Name: tb_usuario_firebase_token_id_usuario_firebase_token_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_usuario_firebase_token_id_usuario_firebase_token_seq', 1, false);


--
-- Name: tb_usuario_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_usuario_id_usuario_seq', 2, true);


--
-- Name: tb_usuario_reset_password_tok_id_usuario_reset_password_tok_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_usuario_reset_password_tok_id_usuario_reset_password_tok_seq', 1, false);


--
-- Name: tb_versao_corte_id_versao_corte_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_versao_corte_id_versao_corte_seq', 2, true);


--
-- Name: tb_acao_usuario pk_acao_usuario; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_acao_usuario
    ADD CONSTRAINT pk_acao_usuario PRIMARY KEY (id_acao);


--
-- Name: tb_avaliacao pk_avaliacao; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_avaliacao
    ADD CONSTRAINT pk_avaliacao PRIMARY KEY (id_avaliacao);


--
-- Name: tb_categoria_produto pk_categoria_produto; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_categoria_produto
    ADD CONSTRAINT pk_categoria_produto PRIMARY KEY (id_categoria);


--
-- Name: tb_cidade pk_cidade; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_cidade
    ADD CONSTRAINT pk_cidade PRIMARY KEY (id_cidade);


--
-- Name: tb_endereco pk_endereco; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_endereco
    ADD CONSTRAINT pk_endereco PRIMARY KEY (id_endereco);


--
-- Name: tb_estado pk_estado; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_estado
    ADD CONSTRAINT pk_estado PRIMARY KEY (id_estado);


--
-- Name: tb_filial pk_filial; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_filial
    ADD CONSTRAINT pk_filial PRIMARY KEY (id_filial);


--
-- Name: tb_localizacao pk_localizacao; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_localizacao
    ADD CONSTRAINT pk_localizacao PRIMARY KEY (id_localizacao);


--
-- Name: tb_pais pk_pais; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_pais
    ADD CONSTRAINT pk_pais PRIMARY KEY (id_pais);


--
-- Name: tb_perfil pk_perfil; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_perfil
    ADD CONSTRAINT pk_perfil PRIMARY KEY (id_perfil);


--
-- Name: tb_preco pk_preco; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_preco
    ADD CONSTRAINT pk_preco PRIMARY KEY (id_preco);


--
-- Name: tb_produto pk_produto; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_produto
    ADD CONSTRAINT pk_produto PRIMARY KEY (id_produto);


--
-- Name: tb_supermercado pk_supermercado; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_supermercado
    ADD CONSTRAINT pk_supermercado PRIMARY KEY (id_supermercado);


--
-- Name: tb_usuario_reset_password_token pk_tb_usuario_reset_password_token; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_usuario_reset_password_token
    ADD CONSTRAINT pk_tb_usuario_reset_password_token PRIMARY KEY (id_usuario_reset_password_token);


--
-- Name: tb_versao_corte pk_tb_versao_corte; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_versao_corte
    ADD CONSTRAINT pk_tb_versao_corte PRIMARY KEY (id_versao_corte);


--
-- Name: tb_tipo_acao_usuario pk_tipo_acao; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_tipo_acao_usuario
    ADD CONSTRAINT pk_tipo_acao PRIMARY KEY (id_tipo);


--
-- Name: tb_usuario pk_usuario; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_usuario
    ADD CONSTRAINT pk_usuario PRIMARY KEY (id_usuario);


--
-- Name: tb_usuario_firebase_token pk_usuario_token; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_usuario_firebase_token
    ADD CONSTRAINT pk_usuario_token PRIMARY KEY (id_usuario_firebase_token);


--
-- Name: tb_usuario unk_usuario_email; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_usuario
    ADD CONSTRAINT unk_usuario_email UNIQUE (email);


--
-- Name: tb_acao_usuario fk_acao_usuario_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_acao_usuario
    ADD CONSTRAINT fk_acao_usuario_usuario FOREIGN KEY (id_usuario) REFERENCES public.tb_usuario(id_usuario);


--
-- Name: tb_avaliacao fk_avaliacao_preco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_avaliacao
    ADD CONSTRAINT fk_avaliacao_preco FOREIGN KEY (id_preco) REFERENCES public.tb_preco(id_preco);


--
-- Name: tb_cidade fk_cidade_estado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_cidade
    ADD CONSTRAINT fk_cidade_estado FOREIGN KEY (id_estado) REFERENCES public.tb_estado(id_estado);


--
-- Name: tb_endereco fk_endereco_cidade; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_endereco
    ADD CONSTRAINT fk_endereco_cidade FOREIGN KEY (id_cidade) REFERENCES public.tb_cidade(id_cidade);


--
-- Name: tb_endereco fk_endereco_localizacao; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_endereco
    ADD CONSTRAINT fk_endereco_localizacao FOREIGN KEY (id_localizacao) REFERENCES public.tb_localizacao(id_localizacao);


--
-- Name: tb_estado fk_estado_pais; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_estado
    ADD CONSTRAINT fk_estado_pais FOREIGN KEY (id_pais) REFERENCES public.tb_pais(id_pais);


--
-- Name: tb_filial fk_filial_endereco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_filial
    ADD CONSTRAINT fk_filial_endereco FOREIGN KEY (id_endereco) REFERENCES public.tb_endereco(id_endereco);


--
-- Name: tb_filial fk_filial_supermercado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_filial
    ADD CONSTRAINT fk_filial_supermercado FOREIGN KEY (id_supermercado) REFERENCES public.tb_supermercado(id_supermercado);


--
-- Name: tb_preco fk_preco_filial; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_preco
    ADD CONSTRAINT fk_preco_filial FOREIGN KEY (id_filial) REFERENCES public.tb_filial(id_filial);


--
-- Name: tb_preco fk_preco_produto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_preco
    ADD CONSTRAINT fk_preco_produto FOREIGN KEY (id_produto) REFERENCES public.tb_produto(id_produto);


--
-- Name: tb_produto fk_produto_categoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_produto
    ADD CONSTRAINT fk_produto_categoria FOREIGN KEY (id_categoria) REFERENCES public.tb_categoria_produto(id_categoria);


--
-- Name: tb_usuario_reset_password_token fk_tb_usuario_reset_password_token_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_usuario_reset_password_token
    ADD CONSTRAINT fk_tb_usuario_reset_password_token_usuario FOREIGN KEY (id_usuario) REFERENCES public.tb_usuario(id_usuario);


--
-- Name: tb_acao_usuario fk_tipo_acao; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_acao_usuario
    ADD CONSTRAINT fk_tipo_acao FOREIGN KEY (id_tipo) REFERENCES public.tb_tipo_acao_usuario(id_tipo);


--
-- Name: tb_usuario_firebase_token fk_token_firebase_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_usuario_firebase_token
    ADD CONSTRAINT fk_token_firebase_usuario FOREIGN KEY (id_usuario) REFERENCES public.tb_usuario(id_usuario);


--
-- Name: tb_usuario fk_usuario_perfil; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_usuario
    ADD CONSTRAINT fk_usuario_perfil FOREIGN KEY (id_perfil) REFERENCES public.tb_perfil(id_perfil);


--
-- PostgreSQL database dump complete
--

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

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO postgres;

\connect postgres

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
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

