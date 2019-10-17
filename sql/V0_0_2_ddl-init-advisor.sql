CREATE SCHEMA IF NOT EXISTS advisor;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA advisor TO peak;

CREATE TABLE advisor.advisor_code
(
    advisor_code           INTEGER,
    advisor_code_status    VARCHAR(25) CHECK (advisor_code_status IN ('ACTIVE', 'PENDING', 'INACTIVE')),
    advisor_code_team_name VARCHAR(255),
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (advisor_code)
);

CREATE TABLE advisor.branch
(
    branch_id       SERIAL,
    name            VARCHAR(255),
    manager         INTEGER REFERENCES reference.individual (individual_id),
    address_id      INTEGER REFERENCES reference.address (address_id),
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (branch_id)
);

CREATE TABLE advisor.business_region
(
    business_region_id      SERIAL,
    region_name             VARCHAR(255),
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (business_region_id)
);

CREATE TABLE advisor.company
(
    company_id                  SERIAL,
    company_name                VARCHAR(255),
    company_logo                BYTEA,
    company_web_site_address    VARCHAR(255),
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (company_id)
);

CREATE TABLE advisor.dealer_code
(
    dealer_code         INTEGER,
    regulatory_body     VARCHAR(10) CHECK (regulatory_body IN ('IIROC', 'MFDA')),
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (dealer_code)
);

CREATE TABLE advisor.advisor
(
    advisor_id                       SERIAL,
    individual_id                    INTEGER REFERENCES reference.individual (individual_id),
    photo                            BYTEA,
    communication_language           VARCHAR(2) CHECK (communication_language IN ('en', 'fr')),
    title_pro_designation            VARCHAR(255),
    transactional                    BOOLEAN,
    interest_areas                   VARCHAR(70),
    excellence_club                  BOOLEAN,
    nrd_number                       VARCHAR(25),
    supervision_tier                 VARCHAR(6) CHECK (supervision_tier IN ('TIER-1', 'TIER-2')),
    compliance_supervisor            VARCHAR(70),
    company_id                       INTEGER REFERENCES advisor.company (company_id),
    business_region_id               INTEGER REFERENCES advisor.business_region (business_region_id),
    business_address_id              INTEGER REFERENCES reference.address (address_id),
    primary_business_email_address   VARCHAR(255),
    secondary_business_email_address VARCHAR(255),
    communication_email_address      VARCHAR(255),
    assistant_id                     INTEGER REFERENCES reference.individual (individual_id),
    enrollment_date_investment       DATE,
    departure_date_investment        DATE,
    enrollment_date_insurance        DATE,
    departure_date_insurance         DATE,
    mailing_method                   VARCHAR(25) NOT NULL CHECK (mailing_method IN ('ICS', 'CANADA POST')),
    mga	                             VARCHAR(255),
    peak_private_wealth	             BOOLEAN,
    primary_mailing_address          VARCHAR(25) NOT NULL CHECK (primary_mailing_address IN ('BRANCH', 'PERSONAL', 'BUSINESS')) DEFAULT 'BUSINESS ',
    status                           VARCHAR(30) NOT NULL CHECK (status IN ('Active', 'Inactive')),
    comment                          VARCHAR(255),
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (advisor_id)
);

CREATE UNIQUE INDEX advisor_nrd_number ON advisor.advisor(nrd_number);

CREATE TABLE advisor.external_investment_account
(
    external_investment_accounts_id SERIAL,
    advisor_id                      INTEGER REFERENCES advisor.advisor (advisor_id),
    description                     VARCHAR(70),
    account_number                  VARCHAR(15),
    opening_date                    DATE,
    closing_date                    DATE,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (external_investment_accounts_id)
);

CREATE TABLE advisor.advisor_language
(
    advisor_id      INTEGER REFERENCES advisor.advisor (advisor_id),
    language_code   VARCHAR(2) REFERENCES reference.language(language_code),
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (language_code)
);

CREATE TABLE advisor.outside_business_activity
(
    outside_business_activities_id SERIAL,
    advisor_id                     INTEGER REFERENCES advisor.advisor (advisor_id),
    description                    VARCHAR(70),
    start_date                     DATE,
    end_date                       DATE,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (outside_business_activities_id)
);

CREATE TABLE advisor.advisor_advisor_code
(
    advisor_id      INTEGER REFERENCES advisor.advisor (advisor_id),
    advisor_code    INTEGER REFERENCES advisor.advisor_code (advisor_code),
    branch_code     INTEGER REFERENCES advisor.branch (branch_id),
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (advisor_id, advisor_code)
);

CREATE TABLE advisor.advisor_code_dealer_code
(
    advisor_code    INTEGER REFERENCES advisor.advisor_code (advisor_code),
    dealer_code     INTEGER REFERENCES advisor.dealer_code (dealer_code),
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (advisor_code, dealer_code)
);

CREATE TABLE advisor.license
(
    license_number              VARCHAR(30),
    nrd_number                  VARCHAR(25) REFERENCES advisor.advisor (nrd_number),
    license_status              VARCHAR(30) NOT NULL CHECK (license_status IN ('Active', 'Inactive', 'Pending')),
    registration_type           VARCHAR(30),
    license_inscription_date    DATE,
    license_expiry_date         DATE,
    registration_province_code  VARCHAR(2) REFERENCES reference.province(province_code),
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (license_number)
);

CREATE TABLE advisor.advisor_advisor_code_assistant
(
    advisor_id                  INTEGER REFERENCES advisor.advisor (advisor_id),
    advisor_code                INTEGER REFERENCES advisor.advisor_code (advisor_code),
    assistant_individual_id     INTEGER REFERENCES reference.individual (individual_id),
    PRIMARY KEY (advisor_id, advisor_code, assistant_individual_id)
);

CREATE INDEX aaca_advisor_code ON advisor.advisor_advisor_code_assistant (advisor_code);
CREATE INDEX aaca_assistant_individual_id ON advisor.advisor_advisor_code_assistant (assistant_individual_id);





