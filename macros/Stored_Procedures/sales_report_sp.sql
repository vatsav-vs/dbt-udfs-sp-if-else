{%macro sales_report()%}
{%set sql%}
    create or replace procedure sales_report()
    returns string
    language sql
    as
    $$
    declare
        tab_a RESULTSET;
        tab_b RESULTSET;
        cnt_a integer;
        cnt_b integer;
        cnt_c integer;
    begin
        tab_a := (CREATE OR REPLACE TEMPORARY TABLE TAB_A AS (SELECT SA.SALES_AGENT_ID, SA.NAME AS AGENT_NAME,SA.SALEC_COMMISION_PCT FROM SALES_AGENT AS SA));
        tab_b := (CREATE OR REPLACE TEMPORARY TABLE TAB_B AS (SELECT ORD.PURCHASE_AMT,ORD.SALES_AGENT_ID,CUST.CUSTOMER_ID,CUST.CUST_NAME FROM ORDERS ORD INNER JOIN CUSTOMER CUST ON CUST.CUSTOMER_ID=ORD.CUSTOMER_ID));
        cnt_a := (select count(*) from TAB_A);
        cnt_b := (SELECT COUNT(*) FROM TAB_B);
        cnt_c := (select count(*) from TAB_C);
            if (cnt_c =0) then
            /*logic to insert data into a new table tab_c from tab_a and tab_b created above*/
            INSERT INTO VATSAV_DB.SALES_SCHEMA.TAB_C SELECT A.SALES_AGENT_ID,B.CUSTOMER_ID,A.AGENT_NAME,B.CUST_NAME,SUM((A.SALEC_COMMISION_PCT*B.PURCHASE_AMT)::number(32,2))COMMISION_EARNED FROM TAB_A AS A INNER JOIN TAB_B AS B ON A.SALES_AGENT_ID=B.SALES_AGENT_ID  GROUP BY 1,2,3,4;
            return 'ONLY INSERT';
        else
        /*logic to delete data into a new table tab_c*/
        DELETE FROM VATSAV_DB.SALES_SCHEMA.TAB_C;
        return 'DELETE';
    end if;
    end;
    $$;
{%endset%}
{% do run_query(sql) %}
{% do log("UDF created", info=True) %}
{% endmacro %}