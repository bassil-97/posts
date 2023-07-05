-- CREATE TABLE post (
--   id SERIAL PRIMARY KEY,
--   user_id INT,
--   title VARCHAR(255),
--   description TEXT,
--   likes INT,
--   timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
-- );


-- Table: public.post

-- DROP TABLE IF EXISTS public.post;

CREATE TABLE IF NOT EXISTS public.post
(
    id integer NOT NULL DEFAULT nextval('post_id_seq'::regclass),
    user_id integer,
    title character varying(255) COLLATE pg_catalog."default",
    description text COLLATE pg_catalog."default",
    likes integer,
    "timestamp" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    status text COLLATE pg_catalog."default" NOT NULL DEFAULT 'pending'::text,
    CONSTRAINT post_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.post
    OWNER to postgres;

CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  post_id INT,
  user_id INT,
  comment TEXT,
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (post_id) REFERENCES post (post_id)
);


CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE TABLE users (
  user_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_name VARCHAR(255) NOT NULL, 
  user_email VARCHAR(255) NOT NULL,
  user_password VARCHAR(255) NOT NULL,
  deleted BOOLEAN DEFAULT false
);

-- Admin table


CREATE TABLE IF NOT EXISTS public.admin
(
    admin_id uuid NOT NULL DEFAULT uuid_generate_v4(),
    admin_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    admin_email character varying(255) COLLATE pg_catalog."default" NOT NULL,
    admin_password character varying(255) COLLATE pg_catalog."default" NOT NULL,
    deleted boolean DEFAULT false,
    role text COLLATE pg_catalog."default" NOT NULL DEFAULT 'admin'::text,
    CONSTRAINT users_pkey PRIMARY KEY (admin_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.admin
    OWNER to postgres;