from snowflake.snowpark.session import Session
from snowflake.snowpark.functions import col, lit
from dotenv import load_dotenv
from os import getenv

load_dotenv()

# connect to snowpark API
connection = {
        'user': getenv('SNOWFLAKE_ADMIN_USER')
      , 'password': getenv('SNOWFLAKE_ADMIN_PASSWORD')
      , 'account': getenv('SNOWFLAKE_ADMIN_ACCOUNT')
      , 'role': getenv('SNOWFLAKE_ADMIN_ROLE')
      , 'warehouse': getenv('SNOWFLAKE_ADMIN_WAREHOUSE')
  }
sesh = Session.builder.configs(connection).create()

# get a relation (table/view/result) from snowflake
tweets = sesh.table('s3_tweets.public.tweets')

# filter the relation
# use col() to reference columns by name
f = tweets.filter((col('KEYWORDS') == 'ai') & (col('KEYWORDS') == 'ml'))

# columns to select
# use lit() to set literal columns
s = f.select('text', 'createddate', lit('literal_column'))

print('done')