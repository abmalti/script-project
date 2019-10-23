/*
 *  SCHEMA: reference
 *  ENGINE: postgresql
 */
CREATE SCHEMA IF NOT EXISTS reference;

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA reference TO peak;

CREATE TABLE reference.province
(
    province_code              VARCHAR(2),
    name_fr                       VARCHAR(50),
	name_en                       VARCHAR(50),
	load_date     DATE,
    PRIMARY KEY (province_code)
);


CREATE TABLE reference.currency
(
    currency_code           VARCHAR(3),
    currency_numeric_code INTEGER,
    currency_minor_unit   INTEGER,
    currency_name_fr         VARCHAR(255),
	currency_name_en         VARCHAR(255),
	load_date     DATE,
    PRIMARY KEY (currency_code)
);

CREATE TABLE reference.country
(
    country_code  SERIAL,
    name_fr        VARCHAR(255),
	name_en        VARCHAR(255),
    alpha2      VARCHAR(2),
    alpha3      VARCHAR(3),
    currency_code VARCHAR(3),
    load_date     DATE,
    PRIMARY KEY (country_code),
    FOREIGN KEY (currency_code) REFERENCES reference.currency (currency_code) ON UPDATE NO ACTION
);

CREATE TABLE reference.address
(
    address_id      SERIAL,
    address_line_1  VARCHAR(40),
    address_line_2  VARCHAR(40),
    address_line_3  VARCHAR(40),
    city            VARCHAR(40),
    province_code   VARCHAR(2) REFERENCES reference.province (province_code),
    postal_code     VARCHAR(10),
    land_phone   VARCHAR(10),
    cell_phone VARCHAR(10),
    other_phone     VARCHAR(10),
    fax             VARCHAR(10),
	country_code      INTEGER REFERENCES reference.country (country_code),
    created_at            TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at            TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (address_id)
);

-- ISO 639-1
CREATE TABLE reference.language
(
    language_code VARCHAR(2),
    english_name  VARCHAR(50),
    native_name   VARCHAR(50),
    load_date     DATE,
    PRIMARY KEY (language_code)
);

CREATE TABLE reference.individual
(
    individual_id                           SERIAL,
    first_name                              VARCHAR(35) NOT NULL,
    middle_name                             VARCHAR(35) NOT NULL,
    last_name                               VARCHAR(35) NOT NULL,
    salutation                              VARCHAR(50) CHECK (salutation IN ('CORP','DR','MISS','MR','MRS','MS','PROF')),
    gender                                  VARCHAR(1) CHECK (gender IN ('M', 'F')),
    civil_status                            VARCHAR(25) CHECK (civil_status IN ('MARRIED', 'COMMON LAW', 'DIVORCED', 'SINGLE', 'SEPARATED', 'WIDOWED')),
    social_insurance_number                 VARCHAR(9),
    date_of_birth                           DATE,
    date_of_decease                         DATE,
    country_of_birth_id                     INTEGER REFERENCES reference.country (country_code),
    citizenship                             VARCHAR(50),
    personal_address_id                     BIGINT NOT NULL,
    primary_personal_email_address          VARCHAR(255),
    secondary_personal_email_address        VARCHAR(255),
    created_at            TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at            TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (individual_id ),
    FOREIGN KEY(personal_address_id) REFERENCES  reference.address (address_id)
);

CREATE TABLE reference.role
(
    role_id         SERIAL,
    name_fr            VARCHAR(50),
	name_en            VARCHAR(50),
    description_fr     VARCHAR(255),
	description_en     VARCHAR(255),
	load_date     DATE,
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
    financial_name_fr             VARCHAR(50),
	financial_name_en             VARCHAR(50),
	load_date     DATE,
    PRIMARY KEY (financial_institution_id)
);

CREATE TABLE reference.fx_rate
(
    id            SERIAL,
    date          INTEGER NOT NULL,
    currency_from VARCHAR(255) NOT NULL,
    currency_to   VARCHAR(255) NOT NULL,
    rate          DECIMAL(5, 4) NOT NULL,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE (date, currency_from, currency_to)
);


CREATE TABLE reference.platform
(
    platform_id              INTEGER,
    platform_name            VARCHAR(30),
	load_date     DATE,
    PRIMARY KEY (platform_id)
);

CREATE TABLE reference.status
(
    status_id              INTEGER,
    status_name_fr            VARCHAR(50),
    status_name_en            VARCHAR(50),
	load_date     DATE,
    PRIMARY KEY (status_id)
);