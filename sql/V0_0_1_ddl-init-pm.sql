/*
 *  SCHEMA: pm
 *  ENGINE: postgresql
 */
CREATE SCHEMA IF NOT EXISTS pm;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA pm TO peak;

CREATE TABLE pm.allocation
(
    allocation_id   SERIAL,
    allocation_type VARCHAR(25),
    description     VARCHAR(50),
    load_date       DATE,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (allocation_id)
);

CREATE TABLE pm.cifsc_type
(
    cifsc_type_id          SERIAL,
    cifsc_type_key         INTEGER NOT NULL,
    cifsc_category_name    VARCHAR(50),
    liquidity_percent      DECIMAL(5, 2),
    income_percent         DECIMAL(5, 2),
    growth_percent         DECIMAL(5, 2),
    maximum_growth_percent DECIMAL(5, 2),
    esg_asset_class        INTEGER,
    univeris_asset_class   VARCHAR(2),
    load_date              DATE,
    created_at             TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at             TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (cifsc_type_id)
);

CREATE TABLE pm.cusip_to_process
(
    id                             SERIAL,
    client_id                      VARCHAR(255) NOT NULL UNIQUE,
    bond_issue_type_with_two_zeros VARCHAR(5)   NOT NULL,
    cusip_number                   VARCHAR(255),
    first_appearance_date          DATE,
    issue_name                     VARCHAR(255),
    load_date                      DATE,
    created_at                     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);

CREATE TABLE pm.product_risk_rating
(
    product_risk_rating_id SERIAL,
    rating_code            VARCHAR(25) NOT NULL UNIQUE,
    english_description    VARCHAR(50),
    french_description     VARCHAR(50),
    load_date       DATE,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (product_risk_rating_id)
);

CREATE TABLE pm.product_class_category
(
    product_class_category_id SERIAL,
    name                      VARCHAR(255) NOT NULL UNIQUE,
    load_date       DATE,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (product_class_category_id)
);

CREATE TABLE pm.product_class
(
    product_class_id          SERIAL,
    name                      VARCHAR(255) NULL UNIQUE,
    product_class_category_id INTEGER      NOT NULL REFERENCES pm.product_class_category(product_class_category_id),
    load_date       DATE,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (product_class_id)
);

CREATE TABLE pm.product
(
    product_id                 SERIAL,
    product_class_category     VARCHAR(25), -- REFERENCES pm.product_class_category(product_class_category_id),
    fundata_key                INTEGER,
    alternate_market_code      VARCHAR(255),
    ask_price                  DECIMAL(20, 8),
    bid_price                  DECIMAL(20, 8),
    currency_code              VARCHAR(3),
    cusip_number               VARCHAR(255) UNIQUE,
    dataphile_customer_code    VARCHAR(255),
    expiry_date                DATE,
    interest_rate              DECIMAL(20, 8),
    last_trade_price           DECIMAL(20, 8),
    price_date                 DATE,
    security_description       VARCHAR(255),
    security_name              VARCHAR(255),
    symbol                     VARCHAR(255) UNIQUE,
    product_class_english_name VARCHAR(255),
    load_date                  DATE,
	security_type              VARCHAR(255) NOT NULL,
    load_date       DATE,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (product_id),
    FOREIGN KEY (currency_code) REFERENCES reference.currency (currency_code),
    CHECK (product_class_category IN ('EQUITY', 'OPTION', 'FUND', 'BOND'))
);

CREATE TABLE pm.fund
(
    fund_id                         SERIAL,
    product_id                      INTEGER        NOT NULL REFERENCES pm.product(product_id),
    fundata_key                     INT            NOT NULL,
    cifsc_type_id                   INTEGER        NULL REFERENCES pm.cifsc_type(cifsc_type_id),
    associated_benchmark_id         INTEGER        NULL,
    available_in_province           VARCHAR(50)    NULL,
    currency_code                   VARCHAR(3)     NULL,
    distribution_frequency          VARCHAR(25)    NULL,
    english_classification          VARCHAR(255)   NULL,
    english_concise_fund_objective  VARCHAR(255)   NULL,
    english_detailed_classification VARCHAR(255)   NULL,
    english_fund_name25             VARCHAR(25)    NULL,
    english_fund_name50             VARCHAR(50)    NULL,
    english_fund_type_name          VARCHAR(255)   NULL,
    english_group_name              VARCHAR(255)   NULL,
    english_how_sold                VARCHAR(255)   NULL,
    english_investment_objective    TEXT           NULL,
    english_investment_strategy     TEXT           NULL,
    english_legal_name              VARCHAR(255)   NULL,
    english_legal_status            VARCHAR(255)   NULL,
    english_mgmt_fee_paid_by        VARCHAR(255)   NULL,
    english_prospectus_risk         TEXT           NULL,
    english_prospectus_risk_rating  VARCHAR(255)   NULL,
    english_trust_type              VARCHAR(255)   NULL,
    french_classification           VARCHAR(255)   NULL,
    french_concise_fund_objective   VARCHAR(255)   NULL,
    french_detailed_classification  VARCHAR(255)   NULL,
    french_fund_name25              VARCHAR(25)    NULL,
    french_fund_name50              VARCHAR(50)    NULL,
    french_fund_type_name           VARCHAR(255)   NULL,
    french_group_name               VARCHAR(255)   NULL,
    french_how_sold                 VARCHAR(255)   NULL,
    french_investment_objective     TEXT           NULL,
    french_investment_strategy      TEXT           NULL,
    french_legal_name               VARCHAR(255)   NULL,
    french_legal_status             VARCHAR(255)   NULL,
    french_mgmt_fee_paid_by         VARCHAR(255)   NULL,
    french_prospectus_risk          TEXT           NULL,
    french_prospectus_risk_rating   VARCHAR(255)   NULL,
    french_trust_type               VARCHAR(255)   NULL,
    fund_grade                      VARCHAR(2)     NULL,
    mer                             DECIMAL(20, 8) NULL,
    mgmt_fee_percent                DECIMAL(11, 8) NULL,
    money_fund                      BOOLEAN        NULL,
    non_rrsp_min_invest             INT            NULL,
    resp_eligible                   BOOLEAN        NULL,
    rrsp_eligible                   BOOLEAN        NULL,
    rrsp_min_invest                 INT            NULL,
    start_date                      DATE           NULL,
    time_horizon                    VARCHAR(50)    NULL,
    total_assets                    DECIMAL(20, 8) NULL,
    valuation_frequency             VARCHAR(50)    NULL,
    product_risk_rating_id          BIGINT         NULL,
    dist_review_date                DATE           NULL,
    dist_cap_gains_12mth            DECIMAL(20, 8) NULL,
    dist_cap_gains_curr_mth         DECIMAL(20, 8) NULL,
    dist_cap_gains_ytd              DECIMAL(20, 8) NULL,
    dist_frequency                  VARCHAR(25)    NULL,
    dist_yield                      DECIMAL(20, 8) NULL,
    dist_div_12mth                  DECIMAL(20, 8) NULL,
    dist_div_curr_mth               DECIMAL(20, 8) NULL,
    dist_div_ytd                    DECIMAL(20, 8) NULL,
    dist_fgn_div_12mth              DECIMAL(20, 8) NULL,
    dist_fgn_div_curr_mth           DECIMAL(20, 8) NULL,
    dist_fgn_div_ytd                DECIMAL(20, 8) NULL,
    dist_int_inc_12mth              DECIMAL(20, 8) NULL,
    dist_int_inc_curr_mth           DECIMAL(20, 8) NULL,
    dist_int_inc_ytd                DECIMAL(20, 8) NULL,
    dist_rtn_principle_12mth        DECIMAL(20, 8) NULL,
    dist_rtn_principle_curr_mth     DECIMAL(20, 8) NULL,
    dist_rtn_principle_ytd          DECIMAL(20, 8) NULL,
    dist_total_12mth                DECIMAL(20, 8) NULL,
    dist_total_curr_mth             DECIMAL(20, 8) NULL,
    dist_total_ytd                  DECIMAL(20, 8) NULL,
    mpr_capital_gains               DECIMAL(11, 8) NULL,
    mpr_distribution_total          DECIMAL(11, 8) NULL,
    mpr_dividend_income             DECIMAL(11, 8) NULL,
    mpr_navps                       DECIMAL(14, 8) NULL,
    mpr_return_of_capital           DECIMAL(11, 8) NULL,
    mpr_split_factor                INT            NULL,
    perf_10yr_compound_return       DECIMAL(6, 3)  NULL,
    perf_10yr_simple_return         DECIMAL(6, 3)  NULL,
    perf_1mth_return                DECIMAL(6, 3)  NULL,
    perf_1yr_compound_return        DECIMAL(6, 3)  NULL,
    perf_1yr_simple_return          DECIMAL(6, 3)  NULL,
    perf_3mth_return                DECIMAL(6, 3)  NULL,
    perf_3yr_compound_return        DECIMAL(6, 3)  NULL,
    perf_3yr_simple_return          DECIMAL(6, 3)  NULL,
    perf_5yr_compound_return        DECIMAL(6, 3)  NULL,
    perf_5yr_simple_return          DECIMAL(6, 3)  NULL,
    perf_6mth_return                DECIMAL(6, 3)  NULL,
    perf_inception_return           DECIMAL(6, 3)  NULL,
    perf_total_dist                 DECIMAL(11, 8) NULL,
    perf_ytd_return                 DECIMAL(6, 3)  NULL,
    portfolio_avg_maturity          DECIMAL(6, 3)  NULL,
    portfolio_credit_rating         INT            NULL,
    portfolio_long_term_bond        DECIMAL(6, 3)  NULL,
    portfolio_mid_term_bond         DECIMAL(6, 3)  NULL,
    portfolio_short_term_bond       DECIMAL(6, 3)  NULL,
    portfolio_mkt_cap_bias          VARCHAR(5)     NULL,
    portfolio_mod_duration          DECIMAL(11, 8) NULL,
    portfolio_mod_duration_date     DATE           NULL,
    portfolio_style_bias            VARCHAR(6)     NULL,
    load_date                       DATE           NULL,
    created_at                      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fund_id
        UNIQUE (fund_id),
    CONSTRAINT product_risk_rating_fk
        FOREIGN KEY (product_risk_rating_id) REFERENCES pm.product_risk_rating (product_risk_rating_id),
    FOREIGN KEY (currency_code) REFERENCES reference.currency (currency_code)
);

CREATE INDEX fund_fundata_key
    ON pm.fund (fundata_key);

CREATE INDEX fund_load_date
    ON pm.fund (load_date);

CREATE INDEX fund_product_id
    ON pm.fund (product_id);

ALTER TABLE pm.fund
    ADD PRIMARY KEY (fund_id);

CREATE TABLE pm.fund_allocation
(
    fund_id            INTEGER NOT NULL REFERENCES pm.fund(fund_id),
    allocation_id      INTEGER NOT NULL REFERENCES pm.allocation(allocation_id),
    reviewed_date      DATE,
    allocation_percent DECIMAL(5, 2),
    load_date          DATE,
    created_at         TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at         TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (fund_id, allocation_id, reviewed_date)
);

CREATE TABLE pm.fund_load_type
(
    fund_load_type_id SERIAL,
    name              VARCHAR(40) NOT NULL,
    load_date       DATE,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (fund_load_type_id)
);

CREATE TABLE pm.fundserv_code_fund
(
    fundserv_code_fund_id SERIAL,
    fundserv_code         VARCHAR(20) NOT NULL UNIQUE,
    fund_id               INTEGER     NOT NULL,
    fund_load_type_id     INTEGER,
    load_date             DATE,
    created_at            TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at            TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (fundserv_code_fund_id),
    FOREIGN KEY (fund_id) REFERENCES pm.fund (fund_id) ON UPDATE NO ACTION,
    FOREIGN KEY (fund_load_type_id) REFERENCES pm.fund_load_type(fund_load_type_id) ON UPDATE NO ACTION
);

CREATE TABLE pm.fund_pricing_fee
(
    fund_pricing_fee_id   SERIAL,
    fundserv_code_fund_id INTEGER        NOT NULL,
    currency_code           VARCHAR(3)     NOT NULL,
    price                 DECIMAL(20, 8) NOT NULL,
    price_date            INTEGER,
    load_date             DATE,
    created_at            TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at            TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (fund_pricing_fee_id),
    FOREIGN KEY (currency_code) REFERENCES reference.currency (currency_code) ON UPDATE NO ACTION,
    FOREIGN KEY (fundserv_code_fund_id) REFERENCES pm.fundserv_code_fund (fundserv_code_fund_id) ON UPDATE NO ACTION
);

CREATE INDEX product_ldfk ON pm.product (load_date, fundata_key);

CREATE TABLE pm.risk_return
(
    risk_return_id        SERIAL,
    fund_id               BIGINT NOT NULL,
    reviewed_date         DATE,
    beta                  DECIMAL(12, 8),
    alpha                 DECIMAL(12, 8),
    benchmark_correlation DECIMAL(8, 6),
    rsquared              DECIMAL(12, 8),
    sharpe                DECIMAL(12, 8),
    sortino               DECIMAL(12, 8),
    std_dev               DECIMAL(12, 8),
    treynor               DECIMAL(12, 8),
    volatility            INTEGER,
    year                  INTEGER,
    load_date             DATE,
    created_at            TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at            TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (risk_return_id, fund_id, year),
    FOREIGN KEY (fund_id) REFERENCES pm.fund (fund_id) ON UPDATE NO ACTION
);

CREATE TABLE pm.system_date
(
    system_date DATE
);

CREATE TABLE pm.top_holdings
(
    top_holdings_id      SERIAL,
    fund_id              BIGINT NOT NULL,
    rank_order           INTEGER,
    reviewed_date        DATE,
    market_percent       DECIMAL(6, 3),
    security_id          BIGINT,
    security_name        VARCHAR(80),
    security_name_french VARCHAR(80),
    load_date            DATE,
    created_at           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (top_holdings_id, fund_id, rank_order),
    FOREIGN KEY (fund_id) REFERENCES pm.fund (fund_id) ON UPDATE NO ACTION
);


CREATE TABLE pm.year_performance
(
    year_performance_id          SERIAL,
    fund_id                      BIGINT NOT NULL,
    reviewed_date                DATE,
    calendar_compound_quartile   INTEGER,
    calendar_compound_rank       INTEGER,
    calendar_compound_rank_count INTEGER,
    calendar_compound_rtn        DECIMAL(6, 3),
    calendar_simple_quartile     INTEGER,
    calendar_simple_rank         INTEGER,
    calendar_simple_rank_count   INTEGER,
    calendar_simple_rtn          DECIMAL(6, 3),
    compound_quartile            INTEGER,
    compound_rank                INTEGER,
    compound_rank_count          INTEGER,
    compound_return              DECIMAL(6, 3),
    simple_quartile              INTEGER,
    simple_rank                  INTEGER,
    simple_rank_count            INTEGER,
    simple_return                DECIMAL(6, 3),
    year                         INTEGER,
    load_date                    DATE,
    created_at                   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (year_performance_id, fund_id, year),
    FOREIGN KEY (fund_id) REFERENCES pm.fund (fund_id) ON UPDATE NO ACTION
);
