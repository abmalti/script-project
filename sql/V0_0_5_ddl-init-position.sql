CREATE SCHEMA IF NOT EXISTS position;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA position TO peak;

CREATE TABLE position.position
(
	position_id                                                    SERIAL,
    account_id                                                     INTEGER  REFERENCES client.account(account_id),
    cusip                                                          VARCHAR(10),
	symbol                                                          VARCHAR(10),
    last_purchase_date                                             DATE,
    quantity                                                       DECIMAL(14, 4),
    book_value                                                     DECIMAL(21, 6),
    end_of_month_value                                             DECIMAL(21, 6),
    load_date       DATE,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (position_id),
    UNIQUE (account_id,cusip),
    UNIQUE (account_id,cusip),
	FOREIGN KEY (cusip) REFERENCES pm.product(cusip),
	FOREIGN KEY (symbol) REFERENCES pm.product(symbol)
);