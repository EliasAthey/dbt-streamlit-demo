import numpy as np
import streamlit as st
from snowflake.snowpark.session import Session
from snowflake.snowpark.functions import avg, sum, col,lit
from dotenv import load_dotenv
from os import getenv
import altair as alt

load_dotenv()

connection = {
      'user': getenv('SNOWFLAKE_USER')
    , 'password': getenv('SNOWFLAKE_PASSWORD')
    , 'account': getenv('SNOWFLAKE_ACCOUNT')
    , 'role': getenv('SNOWFLAKE_ROLE')
    , 'warehouse': getenv('SNOWFLAKE_WAREHOUSE')
    , 'database': getenv('SNOWFLAKE_DATABASE')
    , 'schema': getenv('SNOWFLAKE_SCHEMA')
}

sesh = Session.builder.configs(connection).create()
acc = sesh.get_current_account()
wh = sesh.get_current_warehouse()
db = sesh.get_current_database()
schema = sesh.get_current_schema()
role = sesh.get_current_role()

st.write('# Hello! Welcome to my app')
st.write(f'I\'m connected to the {acc} snowflake account.')
st.write(f'By default, I\'m using the {wh} warehouse, the {role} role,\
  and the {db}.{schema} schema.')

# get data
data = sesh.table('san_francisco_census')

# spinners are great for long operations
with st.spinner(f'Getting raw data...'):
  st.dataframe(data.collect())

with st.spinner(f'Getting stats...'):
  df = data.to_pandas()
  total_pop = df[['ZIP_CODE',
    'YEAR',
    'estimate__total_population__total_population__total']]
    # 'total_population__marginoferror__total_population__total_population__total']]
  # st.bar_chart(total_pop, 'ZIP_CODE', ['YEAR', 'total_population__estimate__total_population__total_population__total'])
  chart = alt.Chart(total_pop).mark_bar().encode(
    x='YEAR',
    y=alt.Y('sum(estimate__total_population__total_population__total)', title='Total Population'),
    color='YEAR',
    column='ZIP_CODE'
  )

  st.altair_chart(chart, use_container_width=False)





######## This creates a SQL portal - veyr insecure (allows any SQL commands) ############################
#########################################################################################################
# tables = sesh.sql(f'select TABLE_NAME from {db}.information_schema.views where TABLE_SCHEMA = \'DBT\'')
# st.write(f'Here are some tables to use: {tables.collect()[0]}')

# insecure_sql = st.text_area(f'Please enter some SQL: ')
# print(insecure_sql)
# if len(insecure_sql) > 0:
#   print(insecure_sql)
#   with st.spinner(f'Running sql...'):
#     res = sesh.sql(f'{insecure_sql}').collect()
#     st.dataframe(res)
#########################################################################################################





######## This creates a random data chart from slider input ############################
########################################################################################
# st.map(us_addr)
# # input
# usr_val = st.slider('Slide Me!',1,10)
# # data
# data = np.random.random([usr_val, 10])
# # viz
# st.write(f'## Your Value: {usr_val}')
# st.bar_chart(data)
########################################################################################



print('done')