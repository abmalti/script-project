/*
 *  SCHEMA: reference
 *  ENGINE: postgresql
 */
CREATE SCHEMA IF NOT EXISTS reference;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA reference TO peak;

CREATE TABLE reference.address
(
    address_id      SERIAL,
    address_line_1  VARCHAR(40),
    address_line_2  VARCHAR(40),
    address_line_3  VARCHAR(40),
    city            VARCHAR(40),
    province_code   VARCHAR(2),
    country         VARCHAR(40),
    postal_code     VARCHAR(6),
    primary_phone   VARCHAR(10),
    secondary_phone VARCHAR(10),
    other_phone     VARCHAR(10),
    fax             VARCHAR(10),
    PRIMARY KEY (address_id)
);

-- ISO 639-1
CREATE TABLE reference.language
(
    language_code VARCHAR(2),
    english_name  VARCHAR(50),
    native_name   VARCHAR(50),
    PRIMARY KEY (language_code)
);

-- TODO move country_of_birth and citezenship to relationships
CREATE TABLE reference.individual
(
    individual_id                           SERIAL,
    first_name                              VARCHAR(35) NOT NULL,
    middle_name                             VARCHAR(35) NOT NULL,
    last_name                               VARCHAR(35) NOT NULL,
    salutation                              VARCHAR(50) NOT NULL CHECK (salutation IN ('Corp','Dr','Miss','Mr','Mrs','Ms','Prof')),
    gender                                  VARCHAR(1)  NOT NULL CHECK (gender IN ('M', 'F')),
    civil_status                            VARCHAR(25) NOT NULL CHECK (civil_status IN ('Married', 'Common law', 'Divorced', 'Single', 'Separated', 'Widowed')),
    social_insurance_number                 VARCHAR(9),
    date_of_birth                           DATE NOT NULL,
    country_of_birth                        VARCHAR(50),
    citizenship                             VARCHAR(50) NOT NULL,
    personal_address_id                     BIGINT NOT NULL,
    primary_personal_email_address          VARCHAR(255),
    secondary_personal_email_address        VARCHAR(255),
    PRIMARY KEY (individual_id ),
    FOREIGN KEY(personal_address_id) REFERENCES  reference.address (address_id)
);

CREATE TABLE reference.role
(
    role_id         SERIAL,
    name            VARCHAR(35),
    description     VARCHAR(35),
    PRIMARY KEY (role_id )
);

CREATE TABLE reference.individual_role
(
    individual_id   INTEGER REFERENCES reference.individual (individual_id),
    role_id         INTEGER REFERENCES reference.role (role_id),
    start_date      DATE,
    end_date        DATE,
    PRIMARY KEY (individual_id, role_id )
);

CREATE TABLE reference.financial_institution
(
    financial_institution_id   INTEGER,
    financial_name             VARCHAR(50),
    PRIMARY KEY (financial_institution_id)
);

CREATE TABLE reference.province
(
    province_code              VARCHAR(2),
    name                       VARCHAR(50),
    PRIMARY KEY (province_code)
);


CREATE TABLE reference.currency
(
    currency_id           VARCHAR(3),
    currency_numeric_code INTEGER,
    currency_minor_unit   INTEGER,
    currency_name         VARCHAR(255),
    load_date             DATE,
    created_at            TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at            TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (currency_id)
);

CREATE TABLE reference.country
(
    country_id  SERIAL,
    name        VARCHAR(255),
    alpha2      VARCHAR(2),
    alpha3      VARCHAR(3),
    currency_id VARCHAR(3),
    load_date   DATE,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (country_id),
    FOREIGN KEY (currency_id) REFERENCES reference.currency (currency_id) ON UPDATE NO ACTION
);