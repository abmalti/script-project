CREATE SCHEMA IF NOT EXISTS trade;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA trade TO peak;

CREATE TABLE trade.system_date
(
    system_date DATE
);

CREATE TABLE trade.trade_type
(
    trade_type_id SERIAL,
	label_fr         VARCHAR(18)    NOT NULL,
	label_en         VARCHAR(18)    NOT NULL,
	PRIMARY KEY (trade_type_id)
);

CREATE TABLE trade.trade
(
    order_unique_id         VARCHAR(18)    NOT NULL, -- Order unique ID
    trade_type_id			INTEGER        NOT NULL REFERENCES trade.trade_type (trade_type_id),
    account_number          VARCHAR(25)    NOT NULL REFERENCES client.account (account_number),
    product_type            VARCHAR(12)    NOT NULL, -- Trade category
    dealer_code             VARCHAR(4)     NOT NULL, -- Dealer code
    advisor_code            VARCHAR(5)     NOT NULL, -- Advisor code
    transaction_type        VARCHAR(2)     NOT NULL, -- Transaction type
    symbol                  VARCHAR(7),              -- Symbol
    cusip                   VARCHAR(10) NOT NULL,             -- CUSIP
    currency_code             VARCHAR(3),              -- Currency
    gross_amount            DECIMAL(21, 2) NOT NULL, -- Gross Amount
    commission              DECIMAL(21, 2),          -- Commission
    net_amount              DECIMAL(21, 2) NOT NULL, -- Net Amount
    exchange_rate           DECIMAL(19, 4),          -- Exchange rate
    transaction_quantity    DECIMAL(14, 4),          -- Transaction quantity
    client_price_per_unit   DECIMAL(21, 6),          -- Client price per unit
    entry_date              DATE           NOT NULL, -- Entry Date
    effective_date          DATE           NOT NULL, -- Effective date
    trade_date              DATE           NULL,     -- Trade date
    settlement_date         DATE           NULL,     -- Settlement date
    load_date               DATE,
    created_at              TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at              TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (order_unique_id),
    FOREIGN KEY (currency_code) REFERENCES reference.currency (currency_code)
);

CREATE INDEX idx_trade_trade_date ON trade.trade (trade_date);

CREATE TABLE trade.trade_bond
(
    order_unique_id                     VARCHAR(18) NOT NULL,
    issuer_account_number               VARCHAR(15),
    intermediary_code                   VARCHAR(4),
    intermediary_account_identifier     VARCHAR(15),
    transaction_status                  INTEGER,
    transaction_type_detail             VARCHAR(2),
    general_ledger_date                 DATE,
    trade_surcharge                     DECIMAL(21, 2),
    sec_fee                             DECIMAL(21, 2),
    foreign_tax                         DECIMAL(21, 2),
    non_resident_withholding_tax_amount DECIMAL(21, 2),
    client_settle_amount                DECIMAL(21, 2),
    client_settle_currency_code         VARCHAR(3),
    wire_order_number                   VARCHAR(20),
    trade_basis                         INTEGER,
    other_plan_account_number           VARCHAR(15),
    other_issuer_account_identifier     VARCHAR(15),
    other_dealer_code                   VARCHAR(4),
    transfer_company_code               VARCHAR(4),
    other_transfer_company              VARCHAR(40),
    gross_transaction_amount_cad        DECIMAL(21, 2),
    net_transaction_amount_cad          DECIMAL(21, 2),
    transfer_category                   VARCHAR(1),
    transfer_company                    VARCHAR(50),
    related_transaction_number          BIGINT,
    alternate_transaction_type_code     INTEGER,
    contribution_type                   INTEGER,
    transaction_reason_code             VARCHAR(8),
    alternate_transaction_status        INTEGER,
    transfer_form_code                  VARCHAR(8),
    originating_operator                VARCHAR(20),
    certificate_number                  VARCHAR(20),
    registration_type                   INTEGER,
    registration_name                   VARCHAR(40),
    registration_address_line_1         VARCHAR(40),
    registration_address_line_2         VARCHAR(40),
    registration_address_line_3         VARCHAR(40),
    registration_city                   VARCHAR(30),
    registration_province               VARCHAR(2),
    registration_country                VARCHAR(8),
    registration_postal_code            VARCHAR(10),
    total_quantity                      DECIMAL(9, 4),
    transfer_advisor                    INTEGER,
    company_code                        VARCHAR(4),
    company_description                 VARCHAR(255),
    other                               VARCHAR(40),
    trading_advisor_code                VARCHAR(5),
    trading_advisor_first_name          VARCHAR(20),
    trading_advisor_last_name           VARCHAR(20),
    transaction_number                  VARCHAR(8),
    comment                             VARCHAR(255),
    load_date                           DATE,
    created_at                          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (order_unique_id),
    FOREIGN KEY (order_unique_id) REFERENCES trade.trade (order_unique_id),
    FOREIGN KEY (client_settle_currency_code) REFERENCES reference.currency (currency_code)
);

CREATE TABLE trade.trade_demand
(
    order_unique_id                           VARCHAR(18) NOT NULL,
    intermediary_code                         VARCHAR(4),
    intermediary_account_identifier           VARCHAR(15),
    transaction_status                        INTEGER,
    transaction_type_detail                   VARCHAR(2),
    general_ledger_date                       DATE,
    federal_withholding_tax_amount            DECIMAL(21, 2),
    federal_withholding_tax_rate              DECIMAL(21, 2),
    regional_withholding_tax_amount           DECIMAL(21, 2),
    regional_withholding_tax_rate             DECIMAL(21, 2),
    non_resident_withholding_tax_amount       DECIMAL(21, 2),
    non_resident_withholding_tax_rate         DECIMAL(21, 2),
    related_investment_code                   VARCHAR(9),
    related_investment_type                   VARCHAR(1),
    related_term_investment_cerificate_number VARCHAR(20),
    other_plan_account_number                 VARCHAR(15),
    gross_transaction_amount_cad              DECIMAL(21, 2),
    net_transaction_amount_cad                DECIMAL(21, 2),
    transfer_category                         VARCHAR(1),
    transfer_company                          VARCHAR(50),
    related_transaction_number                BIGINT,
    contribution_type                         INTEGER,
    withdrawal_reason                         INTEGER,
    transaction_reason_code                   VARCHAR(8),
    alternate_transaction_status              INTEGER,
    transfer_form_code                        VARCHAR(8),
    originating_operator                      VARCHAR(20),
    trading_advisor_code                      VARCHAR(5),
    trading_advisor_first_name                VARCHAR(20),
    trading_advisor_last_name                 VARCHAR(20),
    transaction_number                        VARCHAR(8),
    comment                                   VARCHAR(255),
    settlement_method                         VARCHAR(255),
    eft_bank_account_institution_number       VARCHAR(3),
    eft_bank_account_transit                  VARCHAR(5),
    eft_bank_account_number                   VARCHAR(12),
    cheque_payee_name                         VARCHAR(40),
    cheque_payee_address_line_1               VARCHAR(40),
    cheque_payee_address_line_2               VARCHAR(40),
    cheque_payee_address_line_3               VARCHAR(40),
    transfer_company_code                     VARCHAR(4),
    other_transfer_company                    VARCHAR(40),
    deposit_source                            INTEGER,
    clearing_transaction_type                 INTEGER,
    clearing_account                          VARCHAR(255),
    clearing_transaction_number               VARCHAR(8),
    deposit_location                          INTEGER,
    cheque_amount                             DECIMAL(21, 2),
    magnetic_ink_character_recognition_number VARCHAR(10),
    cheque_extract_date                       DATE,
    print_location                            INTEGER,
    eft_amount                                DECIMAL(21, 2),
    account_name                              VARCHAR(40),
    description                               VARCHAR(40),
    eft_file_creation_date                    DATE,
    eft_type                                  INTEGER,
    systematic_instruction_type               INTEGER,
    from_dealer_code                          VARCHAR(4),
    from_account_number                       VARCHAR(15),
    to_dealer_code                            VARCHAR(4),
    to_account_number                         VARCHAR(15),
    new_amount                                DECIMAL(21, 2),
    new_percentage                            DECIMAL(6, 2),
    gifter                                    VARCHAR(1),
    load_date                                 DATE,
    created_at                                TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                                TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (order_unique_id),
    FOREIGN KEY (order_unique_id) REFERENCES trade.trade (order_unique_id)
);

CREATE TABLE trade.trade_equity
(
    order_unique_id                     VARCHAR(18) NOT NULL,
    issuer_account_number               VARCHAR(15),
    intermediary_code                   VARCHAR(4),
    intermediary_account_identifier     VARCHAR(15),
    transaction_status                  INTEGER,
    transaction_type_detail             VARCHAR(2),
    general_ledger_date                 DATE,
    trade_surcharge                     DECIMAL(21, 2),
    sec_fee                             DECIMAL(21, 2),
    foreign_tax                         DECIMAL(21, 2),
    non_resident_withholding_tax_amount DECIMAL(21, 2),
    client_settle_amount                DECIMAL(21, 2),
    client_settle_currency_code         VARCHAR(3),
    exchange_code                       VARCHAR(8),
    exchange_currency_code              VARCHAR(3),
    wire_order_number                   VARCHAR(20),
    trade_basis                         INTEGER,
    other_plan_account_number           VARCHAR(15),
    other_issuer_account_identifier     VARCHAR(15),
    other_dealer_code                   VARCHAR(4),
    transfer_company_code               VARCHAR(4),
    other_transfer_company              VARCHAR(40),
    gross_transaction_amount_cad        DECIMAL(21, 2),
    net_transaction_amount_cad          DECIMAL(21, 2),
    transfer_category                   VARCHAR(1),
    transfer_company                    VARCHAR(50),
    related_transaction_number          BIGINT,
    alternate_transaction_type_code     INTEGER,
    contribution_type                   INTEGER,
    transaction_reason_code             VARCHAR(8),
    alternate_transaction_status        INTEGER,
    transfer_form_code                  VARCHAR(8),
    originating_operator                VARCHAR(20),
    certificate_number                  VARCHAR(20),
    registration_type                   INTEGER,
    registration_name                   VARCHAR(40),
    registration_address_line_1         VARCHAR(40),
    registration_address_line_2         VARCHAR(40),
    registration_address_line_3         VARCHAR(40),
    registration_city                   VARCHAR(30),
    registration_province               VARCHAR(3),
    registration_country                VARCHAR(8),
    registration_postal_code            VARCHAR(10),
    total_quantity                      DECIMAL(9, 4),
    transfer_advisor                    INTEGER,
    company_code                        VARCHAR(4),
    company_description                 VARCHAR(255),
    other                               VARCHAR(40),
    trading_advisor_code                VARCHAR(5),
    trading_advisor_first_name          VARCHAR(20),
    trading_advisor_last_name           VARCHAR(20),
    transaction_number                  VARCHAR(8),
    comment                             VARCHAR(255),
    load_date                           DATE,
    created_at                          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (order_unique_id),
    FOREIGN KEY (order_unique_id) REFERENCES trade.trade (order_unique_id),
    FOREIGN KEY (client_settle_currency_code) REFERENCES reference.currency (currency_code),
    FOREIGN KEY (exchange_currency_code) REFERENCES reference.currency (currency_code)
);


CREATE TABLE trade.trade_fund
(
    order_unique_id                     VARCHAR(18) NOT NULL,
    transaction_type_detail             VARCHAR(2),
    dividend_option                     VARCHAR(255),
    average_cost_per_unit               DECIMAL(21, 6),
    federal_withholding_tax_amount      DECIMAL(21, 2),
    regional_withholding_tax_amount     DECIMAL(21, 2),
    total_deductions                    DECIMAL(21, 2),
    client_settle_amount                DECIMAL(21, 2),
    eft_bank_account_institution_number VARCHAR(3),
    eft_bank_account_transit            VARCHAR(5),
    eft_bank_account_number             VARCHAR(12),
    eft_bank_account_currency_code           VARCHAR(3),
    eft_bank_account_holder_name        VARCHAR(40),
    assigned_quantity                   DECIMAL(14, 4),
    unassigned_quantity                 DECIMAL(14, 4),
    load_date                           DATE,
    created_at                          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (order_unique_id),
    FOREIGN KEY (order_unique_id) REFERENCES trade.trade (order_unique_id),
    FOREIGN KEY (eft_bank_account_currency_code) REFERENCES reference.currency (currency_code)
);


CREATE TABLE trade.trade_term
(
    order_unique_id                 VARCHAR(18) NOT NULL,
    issuer_account_number           VARCHAR(15),
    intermediary_code               VARCHAR(4),
    intermediary_account_identifier VARCHAR(15),
    certificate_number              VARCHAR(20),
    transaction_status              INTEGER,
    transaction_type_detail         VARCHAR(2),
    general_ledger_date             DATE,
    fees_mva_er                     DECIMAL(21, 2),
    interest_amount                 DECIMAL(21, 2),
    other_plan_account_number       VARCHAR(15),
    other_issuer_account_identifier VARCHAR(15),
    other_dealer_code               VARCHAR(4),
    transfer_company_code           VARCHAR(4),
    other_transfer_company          VARCHAR(40),
    gross_transaction_amount_cad    DECIMAL(21, 2),
    fees_mva_er_cad                 DECIMAL(21, 2),
    interest_amount_cad             DECIMAL(21, 2),
    net_transaction_amount_cad      DECIMAL(21, 2),
    transfer_category               VARCHAR(1),
    transfer_company                VARCHAR(50),
    related_transaction_number      BIGINT,
    contribution_type               INTEGER,
    withdrawal_reason               INTEGER,
    transaction_reason_code         VARCHAR(8),
    transfer_form_code              VARCHAR(8),
    originating_operator            VARCHAR(20),
    trading_advisor_code            VARCHAR(5),
    trading_advisor_first_name      VARCHAR(20),
    trading_advisor_last_name       VARCHAR(20),
    transaction_number              VARCHAR(8),
    comment                         VARCHAR(255),
    load_date                       DATE,
    created_at                      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (order_unique_id),
    FOREIGN KEY (order_unique_id) REFERENCES trade.trade (order_unique_id)
);
