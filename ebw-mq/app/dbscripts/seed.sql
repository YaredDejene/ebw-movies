
CREATE SCHEMA logging;

CREATE TABLE logging.logs
(
    id bigserial PRIMARY KEY,
    log_timestamp timestamp NOT NULL,
    level  VARCHAR (50)  NOT NULL,
    machine  VARCHAR (100)  NULL,
    step  VARCHAR (100)  NULL,
    file_processed VARCHAR(200) NULL, 
    source VARCHAR(200) NULL, 
    line_number int NULL, 
    message text NOT NULL, 
    data jsonb NULL
);