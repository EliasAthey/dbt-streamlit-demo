import numpy as np
import streamlit as st
from snowflake.snowpark.session import Session
from snowflake.snowpark.functions import avg, sum, col,lit
from dotenv import load_dotenv
from os import getenv

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
wh = sesh.get_current_warehouse()
acc = sesh.get_current_account()
print(wh)
print(acc)

st.write('# Hello! Welcome to my app')
st.write(f'Im using the {wh} warehouse in the {acc} snowflake account')
pc = st.text_input(f'Please enter a postal code: ')

addr = sesh.table('stg_address')
us_addr = addr.filter(col('country') == 'us' & col('postalcode') == pc).to_pandas()

st.table(us_addr)
st.map(us_addr)

# # input
# usr_val = st.slider('Slide Me!',1,10)

# # data
# data = np.random.random([usr_val, 10])

# # viz
# st.write(f'## Your Value: {usr_val}')
# st.bar_chart(data)