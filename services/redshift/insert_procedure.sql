CREATE OR REPLACE PROCEDURE support_data.insert_fact_support_ticket(
    IN v_ticket_id SMALLINT,
    IN v_customer_name VARCHAR, 
    IN v_customer_email VARCHAR,
    IN v_customer_age SMALLINT,
    IN v_customer_gender VARCHAR,
    IN v_product_purchased VARCHAR, 
    IN v_ticket_detail VARCHAR, 
    IN v_purchase_date DATE, 
    IN v_ticket_subject VARCHAR,
    IN v_FirstResponseTime VARCHAR, 
    IN v_TimeToResolution VARCHAR, 
    IN v_CustomerSatisfactionRating DECIMAL,
    IN v_ConversationExperienceScore SMALLINT,
    IN v_tokens_used DECIMAL
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_customer_id INT;
    v_product_id INT;
    v_ticket_type_id INT;
    v_ticket_detail_id INT;
BEGIN
    -- Fetch customer_id
    SELECT customer_id INTO v_customer_id FROM support_data.dim_customer WHERE customer_email = v_customer_email LIMIT 1;
    IF NOT FOUND THEN
        INSERT INTO support_data.dim_customer(customer_name, customer_email, customer_age, customer_gender)
        VALUES(v_customer_name, v_customer_email, v_customer_age, v_customer_gender)
        RETURNING customer_id INTO customer_id;
    END IF;

    -- Fetch product_id
    SELECT product_id INTO v_product_id FROM support_data.dim_product WHERE product_purchased = v_product_purchased LIMIT 1;
    IF NOT FOUND THEN
        INSERT INTO support_data.dim_customer(product_id)
        VALUES(v_product_id)
        RETURNING product_id INTO product_id;
    END IF;

    -- Fetch ticket_type_id
    SELECT ticket_detail_id INTO v_ticket_type_id FROM support_data.dim_ticket_type WHERE ticket_type = v_ticket_type LIMIT 1;
    IF NOT FOUND THEN
        INSERT INTO support_data.dim_customer(product_id)
        VALUES(v_product_id)
        RETURNING product_id INTO product_id;
    END IF;
    
    -- Insert into fact_support_tickets
    INSERT INTO support_data.fact_support_tickets (
        ticket_id
        customer_id, 
        product_id, 
        ticket_type_id, 
        date_id, 
        ticket_detail_id, 
        FirstResponseTime, 
        TimeToResolution, 
        CustomerSatisfactionRating, 
        ConversationExperienceScore, 
        tokens_used
    ) VALUES (
        v_ticket_id
        v_customer_id, 
        v_product_id, 
        v_ticket_type_id, 
        v_date_id, 
        v_ticket_detail_id, 
        v_FirstResponseTime, 
        v_TimeToResolution, 
        v_CustomerSatisfactionRating, 
        v_ConversationExperienceScore, 
        v_tokens_used
    );
    
    COMMIT;
END;
$$;
