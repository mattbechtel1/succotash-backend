SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: crop_category; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.crop_category AS ENUM (
    'vegetable',
    'fruit',
    'legume',
    'grain',
    'flower',
    'herb',
    'grass',
    'other'
);


--
-- Name: cycle_stage; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.cycle_stage AS ENUM (
    'unused',
    'tilled',
    'planted',
    'growing',
    'harvest',
    'barren'
);


--
-- Name: unit; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.unit AS ENUM (
    'bushel',
    'count',
    'bunch',
    'peck',
    'pounds',
    'crate',
    'dry quart'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: beds; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.beds (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying,
    field_id uuid NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: crops; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.crops (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying,
    pic_url character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    category public.crop_category,
    default_measure public.unit
);


--
-- Name: favorites; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.favorites (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    crop_id uuid NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: fields; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fields (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    x_axis_count integer,
    y_axis_count integer,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    slug character varying,
    user_id uuid NOT NULL,
    pic_opt character varying
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: stages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stages (
    id bigint NOT NULL,
    start_date date,
    due_date date,
    bed_id uuid NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    status public.cycle_stage,
    crop_id uuid
);


--
-- Name: stages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.stages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.stages_id_seq OWNED BY public.stages.id;


--
-- Name: todos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.todos (
    id bigint NOT NULL,
    note character varying,
    due_date timestamp without time zone,
    complete boolean,
    user_id uuid NOT NULL,
    field_id uuid,
    bed_id uuid,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: todos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.todos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: todos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.todos_id_seq OWNED BY public.todos.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    username character varying,
    password_digest character varying,
    pic character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    email character varying
);


--
-- Name: stages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stages ALTER COLUMN id SET DEFAULT nextval('public.stages_id_seq'::regclass);


--
-- Name: todos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.todos ALTER COLUMN id SET DEFAULT nextval('public.todos_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: beds beds_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.beds
    ADD CONSTRAINT beds_pkey PRIMARY KEY (id);


--
-- Name: crops crops_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.crops
    ADD CONSTRAINT crops_pkey PRIMARY KEY (id);


--
-- Name: favorites favorites_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_pkey PRIMARY KEY (id);


--
-- Name: fields fields_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fields
    ADD CONSTRAINT fields_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: stages stages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stages
    ADD CONSTRAINT stages_pkey PRIMARY KEY (id);


--
-- Name: todos todos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.todos
    ADD CONSTRAINT todos_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_beds_on_field_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_beds_on_field_id ON public.beds USING btree (field_id);


--
-- Name: index_favorites_on_crop_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_favorites_on_crop_id ON public.favorites USING btree (crop_id);


--
-- Name: index_favorites_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_favorites_on_user_id ON public.favorites USING btree (user_id);


--
-- Name: index_fields_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_fields_on_user_id ON public.fields USING btree (user_id);


--
-- Name: index_stages_on_bed_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stages_on_bed_id ON public.stages USING btree (bed_id);


--
-- Name: index_stages_on_crop_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stages_on_crop_id ON public.stages USING btree (crop_id);


--
-- Name: index_todos_on_bed_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_todos_on_bed_id ON public.todos USING btree (bed_id);


--
-- Name: index_todos_on_field_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_todos_on_field_id ON public.todos USING btree (field_id);


--
-- Name: index_todos_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_todos_on_user_id ON public.todos USING btree (user_id);


--
-- Name: stages fk_rails_23f5c65236; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stages
    ADD CONSTRAINT fk_rails_23f5c65236 FOREIGN KEY (crop_id) REFERENCES public.crops(id);


--
-- Name: stages fk_rails_3fadf8c609; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stages
    ADD CONSTRAINT fk_rails_3fadf8c609 FOREIGN KEY (bed_id) REFERENCES public.beds(id) ON DELETE CASCADE;


--
-- Name: beds fk_rails_5b7351ec6e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.beds
    ADD CONSTRAINT fk_rails_5b7351ec6e FOREIGN KEY (field_id) REFERENCES public.fields(id) ON DELETE CASCADE;


--
-- Name: favorites fk_rails_8ff4177e6a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT fk_rails_8ff4177e6a FOREIGN KEY (crop_id) REFERENCES public.crops(id);


--
-- Name: todos fk_rails_9c64952b54; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.todos
    ADD CONSTRAINT fk_rails_9c64952b54 FOREIGN KEY (field_id) REFERENCES public.fields(id) ON DELETE CASCADE;


--
-- Name: todos fk_rails_a8ff7c7e34; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.todos
    ADD CONSTRAINT fk_rails_a8ff7c7e34 FOREIGN KEY (bed_id) REFERENCES public.beds(id) ON DELETE CASCADE;


--
-- Name: fields fk_rails_b061b4e224; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fields
    ADD CONSTRAINT fk_rails_b061b4e224 FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: favorites fk_rails_d15744e438; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT fk_rails_d15744e438 FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: todos fk_rails_d94154aa95; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.todos
    ADD CONSTRAINT fk_rails_d94154aa95 FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20200128191814'),
('20200128192126'),
('20200128192945'),
('20200128193626'),
('20200129190806'),
('20200130155308'),
('20200131163147'),
('20200206152019'),
('20200206164225'),
('20200208191118'),
('20200209204050'),
('20200209204152'),
('20200209205526'),
('20200209205916'),
('20200209211646'),
('20200210034405'),
('20200211023947'),
('20200212153914'),
('20201115191946'),
('20201115192823');


