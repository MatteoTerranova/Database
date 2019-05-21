-- Database Craetion
CREATE DATABASE ennedue OWNER POSTREG ENCODING = 'UTF8';

-- Connect to examode db to create data for its 'public' schema
\c ennedue

-- Install the extention for the uuid: uuid-ossp.
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create new domains
CREATE DOMAIN pwd AS character varying(254)
	CONSTRAINT properpassword CHECK (((VALUE)::text ~* '[A-Za-z0-9._%-]{5,}'::text));
	
-- Table Creation

-- Document
CREATE TABLE Project(
	ProjectID UUID,
	Title VARCHAR NOT NULL,
	StartDate DATE NOT NULL,
	EndDate DATE,
	Location VARCHAR NOT NULL,
	Quote ???????????????????????????????????????,
	Deadline DATE NOT NULL,
	EstimatedHours FLOAT(2) NOT NULL,
	PRIMARY KEY (ProjectID)
	?????????????????????????????????
);
	