-- AUTO-GENERATED BY schema-ddl DO NOT EDIT
-- Generator: schema-ddl 0.2.0
-- Generated: 2015-12-11 15:55

CREATE SCHEMA IF NOT EXISTS atomic;

CREATE TABLE IF NOT EXISTS atomic.com_urbanairship_connect_location_1 (
    "schema_vendor"          VARCHAR(128)  ENCODE RUNLENGTH NOT NULL,
    "schema_name"            VARCHAR(128)  ENCODE RUNLENGTH NOT NULL,
    "schema_format"          VARCHAR(128)  ENCODE RUNLENGTH NOT NULL,
    "schema_version"         VARCHAR(128)  ENCODE RUNLENGTH NOT NULL,
    "root_id"                CHAR(36)      ENCODE RAW       NOT NULL,
    "root_tstamp"            TIMESTAMP     ENCODE LZO       NOT NULL,
    "ref_root"               VARCHAR(255)  ENCODE RUNLENGTH NOT NULL,
    "ref_tree"               VARCHAR(1500) ENCODE RUNLENGTH NOT NULL,
    "ref_parent"             VARCHAR(255)  ENCODE RUNLENGTH NOT NULL,
    "body.foreground"        BOOLEAN       ENCODE RAW,
    "body.latitude"          VARCHAR(4096) ENCODE LZO,
    "body.longitude"         VARCHAR(4096) ENCODE LZO,
    "body.session_id"        CHAR(36)      ENCODE LZO,
    "device.amazon_channel"  CHAR(36)      ENCODE LZO,
    "device.android_channel" CHAR(36)      ENCODE LZO,
    "device.ios_channel"     CHAR(36)      ENCODE LZO,
    "device.named_user_id"   CHAR(36)      ENCODE LZO,
    "id"                     CHAR(36)      ENCODE LZO,
    "occurred"               TIMESTAMP     ENCODE LZO,
    "offset"                 VARCHAR(4096) ENCODE LZO,
    "processed"              TIMESTAMP     ENCODE LZO,
    "type"                   VARCHAR(4096) ENCODE LZO,
    FOREIGN KEY (root_id) REFERENCES atomic.events(event_id)
)
DISTSTYLE KEY
DISTKEY (root_id)
SORTKEY (root_tstamp);

COMMENT ON TABLE atomic.com_urbanairship_connect_location_1 IS 'iglu:com.urbanairship.connect/LOCATION/jsonschema/1-0-0';
