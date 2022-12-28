select
    CENSUS_BLOCK_GROUP as id,
    sex_by_age__est__sex_by_age__ttl_pop__ttl as label_total_pop,
    ZIP_CODE as feature_zip,
    YEAR as feature_year,
    sex_by_age__est__sex_by_age__ttl_pop__ttl__male as feature_male_pop,
    sex_by_age__est__sex_by_age__ttl_pop__ttl__female as feature_female_pop
