CREATE TABLE employees (
    first_name character varying(100),
    last_name character varying(100),
    department character varying(100),
    vacation_remaining integer
);

INSERT INTO employees VALUES ('Leonardo', 'Ferreira', 'finance', 14);
INSERT INTO employees VALUES ('Sara', 'Mikaelsen', 'operations', 14);
INSERT INTO employees VALUES ('Lian', 'Ma', 'marketing', 13);

INSERT INTO employees (first_name, last_name)
     VALUES ('Haiden', 'Smith');

SELECT * FROM employees ORDER BY vacation_remaining DESC;

SELECT *, vacation_remaining * 15.50 * 8 AS amount
  FROM employees
  ORDER BY vacation_remaining DESC;

ALTER TABLE employees ALTER COLUMN vacation_remaining SET NOT NULL;

DELETE FROM employees WHERE vacation_remaining IS NULL;

ALTER TABLE employees ALTER COLUMN vacation_remaining SET NOT NULL;

-- INSERT INTO employees (first_name, last_name, vacation_remaining)
--     VALUES ('Haiden', 'Smith', 0);

ALTER TABLE employees ALTER COLUMN vacation_remaining
SET DEFAULT 0;

INSERT INTO employees (first_name, last_name) VALUES ('Haiden', 'Smith');

-- practice problems
ALTER TABLE employees ALTER COLUMN department SET DEFAULT 'unassigned';
UPDATE employees SET department = 'unassigned' WHERE department IS NULL;
ALTER TABLE employees ALTER COLUMN department SET NOT NULL;

CREATE TABLE temperatures (
    date date NOT NULL,
    low integer NOT NULL,
    high integer NOT NULL
);

INSERT INTO temperatures VALUES ('2016-03-01', 34, 43);
INSERT INTO temperatures VALUES ('2016-03-02', 32, 44);
INSERT INTO temperatures VALUES ('2016-03-03', 31, 47);
INSERT INTO temperatures VALUES ('2016-03-04', 33, 42);
INSERT INTO temperatures VALUES ('2016-03-05', 39, 46);
INSERT INTO temperatures VALUES ('2016-03-06', 32, 43);
INSERT INTO temperatures VALUES ('2016-03-07', 29, 32);
INSERT INTO temperatures VALUES ('2016-03-08', 23, 31);
INSERT INTO temperatures VALUES ('2016-03-09', 17, 28);

