--liquibase formatted sql

--changeset workshop:001
CREATE TABLE demo_counts (
    table_name VARCHAR(50) PRIMARY KEY,
    source_rows INTEGER NOT NULL,
    target_rows INTEGER NOT NULL
);
--rollback DROP TABLE demo_counts;

--changeset workshop:002
CREATE VIEW demo_count_differences AS
SELECT
    table_name,
    source_rows - target_rows AS missing_rows
FROM demo_counts;
--rollback DROP VIEW demo_count_differences;
