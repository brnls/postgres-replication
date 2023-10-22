CREATE EXTENSION IF NOT EXISTS pgcrypto;
create table opps(
    id int primary key generated always as identity,
    data text not null
)

INSERT INTO opps (data)
VALUES (encode(digest(random()::text, 'sha256'), 'hex'));

# Publisher
CREATE PUBLICATION alltables FOR ALL TABLES;

# Subscriber
CREATE SUBSCRIPTION sub1
CONNECTION 'host=db-11 dbname=postgres application_name=sub1 user=postgres password=postgres'
PUBLICATION alltables;

# Get last value of sequences on Publisher
select sequencename, last_value from pg_sequences;

# Set last value of sequence on Subscriber
select setval('opps_id_seq', 13);