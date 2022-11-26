# dbt-streamlit-demo
The dbt project uses two free snowflake marketplace datasets to generate san_francisco_census. This view provides zipcode-level census data for San Francisco for 2019 and 2020 (only partial data from one census table, but more could be incorportated).

The streamlit app visualizes san_francisco_census data with a basic chart of total population over the two years.

### Snowflake Pre-Reqs
1. Create dbt user, analytics database, transformer role, and transform warehouse
1. Get these two free datasets on the marketplace:
* SafeGraph: US Open Census Data & Neighborhood Insights - Free Dataset
* Precisely: ZIP Plus 4s – San Francisco, CA Area (EVALUATION)
1. Grant dbt user "imported privileges" on shared databases
1. Grant dbt user dbt-required privileges
