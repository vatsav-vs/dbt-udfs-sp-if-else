{%macro tbl_func()%}
{%set sql%}
    CREATE OR REPLACE FUNCTION TOP_ORDER_DTLS_FUNC (ODATE DATE, AMT FLOAT)
    RETURNS TABLE (ORDER_NUM INT,
              CUST_ID INT,
              SA_ID INT,
              REV_AMT FLOAT)
    AS
    $$
    SELECT
    ORDER_NUM,
    CUSTOMER_ID AS CUST_ID,
    SALES_AGENT_ID AS SA_ID,
    PURCHASE_AMT AS REV_AMT
    FROM
    {{ source('sales', 'ORDERS') }}
    WHERE ORDER_DATE = ODATE
    AND PURCHASE_AMT >AMT
    $$
{%endset%}
{% do run_query(sql) %}
{% do log("UDF created", info=True) %}
{% endmacro %}
