library(tidyverse)

# Total properties nationwide for SEVERE risk
prettyNum(sum(fire_state_chart$number_severe), big.mark = ",") # 8,792,392 not 4,215,554
prettyNum(sum(wind_state_chart$number_severe), big.mark = ",") # 22,395,818
prettyNum(sum(heat_state_chart$number_severe), big.mark = ",") # 43,253,854
prettyNum(sum(flood_state_chart$number_severe), big.mark = ",") # 12,007,842 not 11,994,390

# Total properties nationwide for major risk
prettyNum(sum(fire_state_chart$number_major), big.mark = ",") # 21,489,704 not 10,195,827
prettyNum(sum(wind_state_chart$number_major), big.mark = ",") # 42,474,809
prettyNum(sum(heat_state_chart$number_major), big.mark = ",") # 79,671,061
prettyNum(sum(flood_state_chart$number_major), big.mark = ",") # 21,005,912 not 19,361,827

# Total properties nationwide
props_fire <- prettyNum(sum(fire_state_chart$count_property)) # 143,479,339 not 141,749,040
props_wind <- prettyNum(sum(wind_state_chart$count_property)) # 141,707,110
props_heat <- prettyNum(sum(heat_state_chart$count_property)) # 141,672,776
props_flood <- prettyNum(sum(flood_state_chart$count_property)) # 145,485,001 not 143,653,175

# Share of total properties nationwide for SEVERE risk
sum(fire_state_chart$number_severe)/as.numeric(props_fire) # 6% not 3%
sum(wind_state_chart$number_severe)/as.numeric(props_wind) # 15.8%
sum(heat_state_chart$number_severe)/as.numeric(props_heat) # 30.5%
sum(flood_state_chart$number_severe)/as.numeric(props_flood) # 8.3% still stays same

# Share of total properties nationwide for major risk
sum(fire_state_chart$number_major)/as.numeric(props_fire) # 15% not 7.2%
sum(wind_state_chart$number_major)/as.numeric(props_wind) # 30%
sum(heat_state_chart$number_major)/as.numeric(props_heat) # 56.2%
sum(flood_state_chart$number_major)/as.numeric(props_flood) # 14.4%

# Counties with at least 50% properties at SEVERE risk
fire_county_chart %>% filter(pct_severe>50) %>% nrow() # 136 NOT (81 or nearly 3%)
wind_county_chart %>% filter(pct_severe>50) %>% nrow() # 371 or 12%
heat_county_chart %>% filter(pct_severe>50) %>% nrow() # 658 or 21%
flood_county_chart %>% filter(pct_severe>50) %>% nrow() # 28 NOT (29 or 1% percent)

# Counties with at least 50% properties at major risk
fire_county_chart %>% filter(pct_major>50) %>% nrow() # 469 NOT (212 or 7%)
wind_county_chart %>% filter(pct_major>50) %>% nrow() # 706 or 22%
heat_county_chart %>% filter(pct_major>50) %>% nrow() # 1,455 or 46%
flood_county_chart %>% filter(pct_major>50) %>% nrow() # 62 NOT (53 or nearly 2%)

# Zip codes with at least 50% properties at SEVERE risk
fire_zip_chart %>% filter(pct_severe>50) %>% nrow() # 1,520 NOT (872 or nearly 3%)
wind_zip_chart %>% filter(pct_severe>50) %>% nrow() # 3,473 or 11%
heat_zip_chart %>% filter(pct_severe>50) %>% nrow() # 6,538 or 20%
flood_zip_chart %>% filter(pct_severe>50) %>% nrow() # 976 NOT (918 or nearly 3%)

# Zip codes with at least 50% properties at major risk
fire_zip_chart %>% filter(pct_major>50) %>% nrow() # 4,402 NOT (2,083 or 6%)
wind_zip_chart %>% filter(pct_major>50) %>% nrow() # 7,235 or 22%
heat_zip_chart %>% filter(pct_major>50) %>% nrow() # 14,084 or 44%
flood_zip_chart %>% filter(pct_major>50) %>% nrow() # 1,683 NOT (1,407 or 4%)

# TRACTS with at least 50% properties at SEVERE risk
fire_tract_chart %>% filter(pct_severe>50) %>% nrow() # 4,006 NOT (1,667 or 2%)
wind_tract_chart %>% filter(pct_severe>50) %>% nrow() # 12,324 or 15%
heat_tract_chart %>% filter(pct_severe>50) %>% nrow() # 26,387 or 32%
flood_tract_chart %>% filter(pct_severe>50) %>% nrow() # 2,092 NOT (2,190 or nearly 3%)

# TRACTS with at least 50% properties at major risk
fire_tract_chart %>% filter(pct_major>50) %>% nrow() # 9,403 NOT (4,441 or 5%)
wind_tract_chart %>% filter(pct_major>50) %>% nrow() # 26,188 or 31%
heat_tract_chart %>% filter(pct_major>50) %>% nrow() # 49,768 or 44%
flood_tract_chart %>% filter(pct_major>50) %>% nrow() # 4,848 NOT (4,359 or 4%)

# Our states
# California: XXX flood 14% major, XXX fire 40% major, heat 69% major, wind 0% major
# Texas: flood XXX 17% major, XXX fire 30% major, heat 99% major, wind 70% major
# North Carolina: XXX flood 13% major, XXX fire 13% major, heat 87% major, wind 55% major
# Pennsylvania: XXX flood 17% major, fire 0% major, heat 42% major, wind 22% major
# Illinois: XXX flood 12% major, fire 0% major, heat 10% major, wind 0% major
# New York: XXX flood 17% major, XXX fire 2.5% major, heat 38% major, wind 35% major
# New Jersey: XXX flood 21% major, XXX fire 6% major, heat 95% major, wind 83% major

# Our core counties
# California-Los Angeles: XXX flood 9.2% (193,000 properties), XXX fire 29% (599K prop), heat 84%, wind 0%
# California-Orange: XXX flood 7% (46,000 properties), XXX fire 14%, heat 81%, wind 0%
# California-Riverside: XXX flood 9.4% (82,000 properties), XXX fire 78% (685K prop), heat 99%, wind 0%
# California-San Bernardino: flood 9% (74,000 properties), XXX fire 51% (417K prop), heat 91%, wind 0%
# California-Ventura: flood 13% (33,000 properties), fire 69% (177K prop), heat 48%, wind 0%

# California-Fresno: XXX flood 19% (57,000 properties), fire 32% (100K prop), heat 98%, wind 0%

# California-San Francisco: XX flood 5% (7,800 properties), fire 1%, heat 0%, wind 0%
# California-Alameda: XXflood 8% (32,000 properties), fire 23%, heat 9%, wind 0%
# California-Santa Clara: flood 18% (87,000 properties), fire 26%, heat 44%, wind 0%

# California-Contra Costa: flood 14% (53,000 properties), fire 48%, heat 44%, wind 0%
# California-Marin: flood 35% (34,000 properties), fire 21%, heat 44%, wind 0%
# California-Napa: flood 21% (10,000 properties), fire 71%, heat 44%, wind 0%
# California-San Mateo: flood 20% (43,000 properties), fire 11%, heat 44%, wind 0%
# California-Solano: flood 14% (20,000 properties), fire 66%, heat 44%, wind 0%
# California-Sonoma: flood 25% (46,000 properties), fire 57%, heat 44%, wind 0%

# Texas-Harris: flood 32% (438K), fire 1%, heat 100%, wind 100%
# Texas-Galveston: flood 76% (129K), fire 1%, heat 100%, wind 100%

# North Carolina-Wake: flood 9%, fire 0%, heat 100%, wind 100%
# North Carolina-Durham: flood 8%, fire 1%, heat 100%, wind 98%

# Pennsylvania-Philadelphia: flood 22% (121K), fire 0%, heat 100%, wind 100%

# Illinois-Cook: flood 14% (201K properties), fire 0%, heat 0%, wind 0%

# New York-Queens: flood 22% (72K), fire 1%, heat 100%, wind 100%
# New York-Richmond: flood 19% (24K), fire 40%, heat 100%, wind 100%
# New York-Kings: flood 24% (66K), fire 2%, heat 100%, wind 100%
# New York-New York (Manhattan): flood 13% (5,500), fire 0%, heat 100%, wind 20%
# New York-Bronx: flood 20% (18,000), fire 0%, heat 100%, wind 57%

# New Jersey: XXX flood 21% major, XXX fire 6% major, heat 95% major, wind 83% major


