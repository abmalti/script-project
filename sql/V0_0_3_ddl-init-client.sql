CREATE SCHEMA IF NOT EXISTS client;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA client TO peak;

CREATE TABLE client.client
(
    client_id                                               SERIAL,
    individual_id                                           INTEGER  REFERENCES reference.individual (individual_id),
    other_name                                              VARCHAR(255),
    communication_language                                  VARCHAR(2) CHECK (communication_language IN ('en', 'fr')),
    document_delivery_method                                VARCHAR(2) CHECK (document_delivery_method IN ('PAPER', 'ELECTRONIC')),
    us_social_security_number                               VARCHAR(9),
    residency_for_tax_purposes                              VARCHAR(50),
    neq                                                     VARCHAR(25),
    cra_business_number                                     VARCHAR(25),
    number_of_dependant                                     SMALLINT NOT NULL,
    financial_institution                                   INTEGER NOT NULL  REFERENCES reference.financial_institution (financial_institution_id),
    bank_transit_number                                     INTEGER NOT NULL,
    bank_account_number                                     VARCHAR(30) NOT NULL,
    personal_net_worth_liquid_assets                        DECIMAL(15, 2) NOT NULL,
    personal_net_worth_fixed_assets                         DECIMAL(15, 2) NOT NULL,
    personal_net_worth_liabilities                          DECIMAL(15, 2) NOT NULL,
    personal_net_worth_total                                DECIMAL(15, 2) NOT NULL,
    estimated_annual_income                                 DECIMAL(15, 2) NOT NULL,
    occupation_type                                         VARCHAR(25) NOT NULL CHECK (occupation_type IN ('Employed', 'Self-employed', 'Retired', 'Unemployed')),
    occupation_position                                     VARCHAR(35),
    type_of_business                                        VARCHAR(35),
    employer_name                                           VARCHAR(70),
    employer_address                                        VARCHAR(255),
    telephone_work                                          VARCHAR(10),
    number_of_years_with_current_employer                   INTEGER,
    investment_knowledge                                    VARCHAR(25) NOT NULL CHECK (investment_knowledge IN ('Poor', 'Fair', 'Good', 'Sophisticated')),
    control_10_percent_of_a_public_company                  BOOLEAN NOT NULL,
    control_10_percent_public_company_list                  TEXT,
    control_20_percent_of_a_public_company                  BOOLEAN NOT NULL,
    control_20_percent_public_company_list                  TEXT,
    investment_accounts_outside_peak                        BOOLEAN NOT NULL,
    investment_accounts_outside_peak_list                   TEXT,
    control_other_investment_account                        BOOLEAN,
    control_other_investment_account_qty                    INTEGER,
    foreign_pep                                             VARCHAR(50) CHECK (foreign_pep IN ('Head of state / government', 'Deputy minister (or equivalent)', 'Military general (or equivalent)', 'Judge', 'Member of the executive council of government or member of legislature', 'Ambassador or ambassador''s attaché or counsellor', 'Head of a government agency', 'Leader or president of a political party in a legislature')),
    domestic_pep                                            VARCHAR(50) CHECK (domestic_pep IN ('Governor general, lieutenant governor or head of government', 'Member of the senate or House of commons or member of a legislature', 'Deputy minister or equivalent rank', 'Ambassador, attaché or counsellor of an ambassador', 'Military officer with a rank of general or above', 'President of a corporation that is wholly owned directly by Her Majesty of Canada or a province', 'Head of a government agency', 'Judge of an appellate court in a province, the Federal Court of Appeal or the Supreme Court of Canada', 'Leader or president of a political party represented in a legislature', 'Mayor')),
    head_of_international_organization                      VARCHAR(50) CHECK (head_of_international_organization IN ('Head of an international organization established by the governments of states', 'Head of an institution established by an international organization')),
    pep_or_hio_family_member                                BOOLEAN NOT NULL,
    pep_or_hio_family_member_organization_and_position      TEXT,
    disclosure_of_beneficial_ownership_information          BOOLEAN NOT NULL,
    receive_security_holder_material                        VARCHAR(50) NOT NULL CHECK (receive_security_holder_material IN ('ALL', 'NONE', 'PROXY')),
    temporary_mailing_address                               INTEGER  REFERENCES reference.address (address_id),
    consolidated_objectives_and_risk                        BOOLEAN NOT NULL,
    investment_objectives_income_iiroc                      INTEGER,
    investment_objectives_medium_term_growth_iiroc          INTEGER,
    investment_objectives_long_term_growth_iiroc            INTEGER,
    investment_objectives_speculation_iiroc                 INTEGER,
    investment_objectives_liquidity_mfda                    INTEGER,
    investment_objectives_income_mfda                       INTEGER,
    investment_objectives_growth_mfda                       INTEGER,
    investment_objectives_maximum_growth_mfda               INTEGER,
    risk_tolerance_low_iiroc                                INTEGER,
    risk_tolerance_medium_iiroc                             INTEGER,
    risk_tolerance_high_iiroc                               INTEGER,
    risk_tolerance_low_mfda                                 INTEGER,
    risk_tolerance_low_to_medium_mfda                       INTEGER,
    risk_tolerance_medium_mfda                              INTEGER,
    risk_tolerance_medium_to_high_mfda                      INTEGER,
    risk_tolerance_high_mfda                                INTEGER,
    time_horizon_iiroc                                      VARCHAR(20) NOT NULL CHECK (time_horizon_iiroc IN ('1 to 2 years', '3 to 5 years', '6 to 9 years', '10 years and more')),
    time_horizon_mfda                                       VARCHAR(20) NOT NULL CHECK (time_horizon_mfda IN ('Less than 1 year', 'Between 1 to 3 years', 'Between 4 to 5 years', 'Between 6 to 9 years', 'More than 10 years')),
    kyc_date                                                DATE,
    kyc_reviewed_date                                       DATE,
    comment                                                 VARCHAR(255),
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (client_id)
);

CREATE TABLE client.client_language
(
    client_id       INTEGER REFERENCES client.client (client_id),
    language_code   VARCHAR(2)  REFERENCES reference.language(language_code),
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (client_id, language_code)

);

CREATE TABLE client.client_number
(
    client_number                                           VARCHAR(10) NOT NULL ,
    client_id                                               INTEGER REFERENCES client.client(client_id),
    compound_return_1_year                                  DECIMAL(6, 2),
    compound_return_3_year                                  DECIMAL(6, 2),
    compound_return_5_year                                  DECIMAL(6, 2),
    compound_return_10_year                                 DECIMAL(6, 2),
    compound_return_inception                               DECIMAL(6, 2),
    return_ytd                                              DECIMAL(6, 2),
    return_this_year_minus_1                                DECIMAL(6, 2),
    return_this_year_minus_2                                DECIMAL(6, 2),
    return_this_year_minus_3                                DECIMAL(6, 2),
    return_this_year_minus_4                                DECIMAL(6, 2),
    return_this_quarter                                     DECIMAL(6, 2),
    return_this_quarter_minus_1                             DECIMAL(6, 2),
    return_this_quarter_minus_2                             DECIMAL(6, 2),
    return_this_quarter_minus_3                             DECIMAL(6, 2),
    return_this_quarter_percent                             DECIMAL(6, 2),
    return_this_quarter_percent_minus_1                     DECIMAL(6, 2),
    return_this_quarter_percent_minus_2                     DECIMAL(6, 2),
    return_this_quarter_percent_minus_3                     DECIMAL(6, 2),
    PRIMARY KEY (client_number)
);



CREATE TABLE client.account
(
    account_number                                      VARCHAR(25) NOT NULL,
    client_number                                       VARCHAR(10) NOT NULL ,
    advisor_code                                        INTEGER  REFERENCES advisor.advisor_code (advisor_code),
    account_ownership                                   VARCHAR(30) NOT NULL  CHECK (account_ownership IN ('Corporate account', 'Individual account', 'Individual trust account', 'Joint account', 'Joint trust account', 'Joint trust account with rights of survivorship', 'Managed account', 'Tenants in common')),
    account_type                                        VARCHAR(30) NOT NULL  CHECK (account_ownership IN ('Cash (CAD / USD)', 'Delivery against payment (DAP) (CAD / USD)', 'Leverage loan (CAD only)', 'Leverage loan (CAD / USD)', 'Margin (CAD / USD)', 'RESP', 'RESP (CAD only)', 'RRIF / LIF', 'RRIF / LIF (CAD only)', 'RRSP / LIRA', 'RRSP/LIRA (CAD only)', 'Spousal RRSP', 'Spousal RRSP (CAD only)', 'TFSA', 'TFSA (CAD only)')),
    client_name_account                                 BOOLEAN,
    nominee_account                                     BOOLEAN,
    internal_account_number                             VARCHAR(15),
    external_account_number                             VARCHAR(15),
    delivery_institution_name                           VARCHAR(255),
    delivery_institution_address_id                     INTEGER  REFERENCES reference.address(address_id),
    delivery_institution_client_account_number          VARCHAR(15),
    delivery_institution_fins_number                    VARCHAR(15),
    delivery_institution_cuid                           VARCHAR(4),
    account_performance_money_weighted                             DECIMAL(6, 2),
    account_performance_time_weighted                              DECIMAL(6, 2),
    consolidated_objectives_and_risk                    BOOLEAN NOT NULL,
    investment_objectives_income_iiroc                  INTEGER,
    investment_objectives_medium_term_growth_iiroc      INTEGER,
    investment_objectives_long_term_growth_iiroc        INTEGER,
    investment_objectives_speculation_iiroc             INTEGER,
    investment_objectives_liquidity_mfda                INTEGER,
    investment_objectives_income_mfda                   INTEGER,
    investment_objectives_growth_mfda                   INTEGER,
    investment_objectives_maximum_growth_mfda           INTEGER,
    risk_tolerance_low_iiroc                            INTEGER,
    risk_tolerance_medium_iiroc                         INTEGER,
    risk_tolerance_high_iiroc                           INTEGER,
    risk_tolerance_low_mfda                             INTEGER,
    risk_tolerance_low_to_medium_mfda                   INTEGER,
    risk_tolerance_medium_mfda                          INTEGER,
    risk_tolerance_medium_to_high_mfda                  INTEGER,
    risk_tolerance_high_mfda                            INTEGER,
    time_horizon_iiroc                                  VARCHAR(20) NOT NULL CHECK (time_horizon_iiroc IN ('1 to 2 years', '3 to 5 years', '6 to 9 years', '10 years and more')),
    time_horizon_mfda                                   VARCHAR(20) NOT NULL CHECK (time_horizon_mfda IN ('Less than 1 year', 'Between 1 to 3 years', 'Between 4 to 5 years', 'Between 6 to 9 years', 'More than 10 years')),
    intended_use_of_the_account                         VARCHAR(20) CHECK (intended_use_of_the_account IN ('Income generation', 'Long-term investment', 'Retirement savings', 'Savings', 'Short-term investment')),
    third_party_financial_benefits                      BOOLEAN NOT NULL,
    third_party_on_the_account                          BOOLEAN NOT NULL,
    power_of_attorney_on_the_account                    BOOLEAN NOT NULL,
    kyc_date                                            DATE,
    kyc_reviewed_date                                   DATE,
    compound_return_1_year                              DECIMAL(6, 2),
    compound_return_3_year                              DECIMAL(6, 2),
    compound_return_5_year                              DECIMAL(6, 2),
    compound_return_10_year                             DECIMAL(6, 2),
    compound_return_inception                           DECIMAL(6, 2),
    return_ytd                                          DECIMAL(6, 2),
    return_this_year_minus_1                            DECIMAL(6, 2),
    return_this_year_minus_2                            DECIMAL(6, 2),
    return_this_year_minus_3                            DECIMAL(6, 2),
    return_this_year_minus_4                            DECIMAL(6, 2),
    return_this_quarter                                 DECIMAL(6, 2),
    return_this_quarter_minus_1                         DECIMAL(6, 2),
    return_this_quarter_minus_2                         DECIMAL(6, 2),
    return_this_quarter_minus_3                         DECIMAL(6, 2),
    return_this_quarter_percent                         DECIMAL(6, 2),
    return_this_quarter_percent_minus_1                 DECIMAL(6, 2),
    return_this_quarter_percent_minus_2                 DECIMAL(6, 2),
    return_this_quarter_percent_minus_3                 DECIMAL(6, 2),
    load_date       DATE,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (account_number)
);

CREATE TABLE client.client_account
(
    client_id       INTEGER REFERENCES client.client (client_id),
    account_number  VARCHAR(25) REFERENCES client.account (account_number),
    load_date       DATE,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (client_id, account_number)
);
