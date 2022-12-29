from snowflake.snowpark.session import Session
from dotenv import load_dotenv
from os import getenv

def main():
  """
  Sends sql commands to snowflake which configure the snowpipe for tweets
  """

  load_dotenv()

  connection = {
        'user': getenv('SNOWFLAKE_ADMIN_USER')
      , 'password': getenv('SNOWFLAKE_ADMIN_PASSWORD')
      , 'account': getenv('SNOWFLAKE_ADMIN_ACCOUNT')
      , 'role': getenv('SNOWFLAKE_ADMIN_ROLE')
      , 'warehouse': getenv('SNOWFLAKE_ADMIN_WAREHOUSE')
  }

  sesh = Session.builder.configs(connection).create()

  responses = []

  # create database for raw tweets
  sql_db = "create or replace database s3_tweets"
  responses.append(sesh.sql(f'{sql_db}').collect())

  # create warehouse for loading raw tweets
  sql_wh = """
  create or replace warehouse s3_twitter_load
    with warehouse_size = 'x-small'
    auto_suspend = 60
    auto_resume = true
    initially_suspended = true
  """
  responses.append(sesh.sql(f'{sql_wh}').collect())

  # create stage for s3 bucket with tweets
  sql_stg = f"""
  create or replace stage s3_tweets.public.tweets
    URL = 's3://twitter-stream'
    CREDENTIALS = (AWS_KEY_ID = '{getenv('AWS_ACCESS_KEY_ID')}'
      AWS_SECRET_KEY = '{getenv('AWS_SECRET_ACCESS_KEY')}')
    file_format = (type='JSON')
    COMMENT = 'Tweets in S3'
  """
  responses.append(sesh.sql(f'{sql_stg}').collect())

  # create table for raw tweets
  sql_tbl = "create or replace table s3_tweets.public.json_tweets (data variant)"
  responses.append(sesh.sql(f'{sql_tbl}').collect())

  # create pipe to ingest s3 tweets
  sql_pipe = """
  create or replace pipe s3_tweets.public.s3_tweets_pipe auto_ingest = true as
    copy into s3_tweets.public.json_tweets
    from @s3_tweets.public.tweets
    file_format = (type='JSON')
  """
  responses.append(sesh.sql(f'{sql_pipe}').collect())

  # create view to format into raw source
  sql_view = """
  create or replace view s3_tweets.public.tweets as
    select
      data:data:id::string as id,
      data:data:text::string as text,
      data:keywords::string as keywords,
      data:data:created_at::datetime as createddate,
      data
    from json_tweets
  """
  responses.append(sesh.sql(f'{sql_view}').collect())

  if len(responses) > 0:
    print(f'Responses:\n{responses}')


if __name__ == "__main__":
    main()
