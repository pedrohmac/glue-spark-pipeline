CREATE SCHEMA IF NOT EXISTS support_data;

CREATE TABLE support_data.tickets (
    ticket_id INT PRIMARY KEY,
    customer_name VARCHAR(255),
    customer_email VARCHAR(255),
    customer_age INT,
    customer_gender VARCHAR(50),
    product_purchased VARCHAR(255),
    ticket_type VARCHAR(255),
    ticket_priority VARCHAR(50),
    ticket_channel VARCHAR(50),
    ticket_status VARCHAR(50),
    resolution VARCHAR(255),
    user_feedback VARCHAR(50),
    purchase_date DATE,
    ticket_subject VARCHAR(255),
    sentiment VARCHAR(50),
    tags VARCHAR(50),
    auto_qa_results VARCHAR(50),
    integration_type_used VARCHAR(50),
    action_taken VARCHAR(255),
    action_result VARCHAR(50),
    knowledge_source VARCHAR(255),
    response_types VARCHAR(50),
    first_response_time TIMESTAMP, 
    time_to_resolution TIMESTAMP, 
    customer_satisfaction_rating DECIMAL,
    conversation_experience_score SMALLINT,
    tokens_used DECIMAL
);
