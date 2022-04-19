{% var(max_ord_dt)%}
    {%- call statement('my_statement', fetch_result=True) -%}
      select max(reported_dt) from vatsav_db.sales_schema.order_dates_used
{%- endcall -%}

{%- set var1 = load_result('my_statement')['data'][0][0] -%}
{{ return(var1) }}
{% endmacro %}