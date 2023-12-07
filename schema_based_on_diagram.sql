-- schemas
CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    date_of_birth DATE
);

CREATE TABLE medical_histories (
    id SERIAL PRIMARY KEY,
    admitted_at TIMESTAMP,
    patient_id INT REFERENCES patients(id),
    status VARCHAR(500)
);

CREATE TABLE invoices (
    id SERIAL PRIMARY KEY,
    total_amount DECIMAL(10, 2),
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_id INT REFERENCES medical_histories(id)
);

CREATE TABLE treatments (
    id SERIAL PRIMARY KEY,
    type VARCHAR(50),
    name VARCHAR(100)
);

CREATE TABLE invoice_items (
    id SERIAL PRIMARY KEY,
    unit_price DECIMAL(10, 2),
    quantity INT,
    total_price DECIMAL(10, 2),
    invoice_id INT REFERENCES invoices(id),
    treatment_id INT REFERENCES treatments(id)
);

CREATE TABLE treatment_histories (
    medical_id INT REFERENCES medical_histories(id),
    treatment_id INT REFERENCES treatments(id),
    PRIMARY KEY(medical_id, treatment_id)
);

-- INDEXES

CREATE INDEX patient_id_idx ON medical_histories(patient_id);
CREATE INDEX medical_histories_id_idx ON invoices(medical_history_id);
CREATE INDEX invoice_id_idx ON invoice_items(invoice_id);
CREATE INDEX treatment_id_idx ON invoice_items(treatment_id);
CREATE INDEX treatment_historeis_medical_id_idx ON treatment_histories(medical_id);
CREATE INDEX treatment_historeis_treatment_id_idx ON treatment_histories(treatment_id);


