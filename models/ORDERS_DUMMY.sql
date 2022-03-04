{{
  config(
    materialized='table'
  )
}}


SELECT * FROM TABLE(VATSAV_DB.DBT_TRIALS.TEST_TBL_FUNC1('2012-10-10'::date,100::float))