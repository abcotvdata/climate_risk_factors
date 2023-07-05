library(tidyverse)

# Total properties nationwide for SEVERE risk
prettyNum(sum(fire_state_chart$number_severe), big.mark = ",") # 4,215,554
prettyNum(sum(wind_state_chart$number_severe), big.mark = ",") # 22,395,818
prettyNum(sum(heat_state_chart$number_severe), big.mark = ",") # 43,253,854
prettyNum(sum(flood_state_chart$number_severe), big.mark = ",") # 11,994,390

# Total properties nationwide for major risk
prettyNum(sum(fire_state_chart$number_major), big.mark = ",") # 10,195,827
prettyNum(sum(wind_state_chart$number_major), big.mark = ",") # 42,474,809
prettyNum(sum(heat_state_chart$number_major), big.mark = ",") # 79,671,061
prettyNum(sum(flood_state_chart$number_major), big.mark = ",") # 19,361,827

# Total properties nationwide
props_fire <- prettyNum(sum(fire_state_chart$count_property)) # 141,749,040
props_wind <- prettyNum(sum(wind_state_chart$count_property)) # 141,707,110
props_heat <- prettyNum(sum(heat_state_chart$count_property)) # 141,672,776
props_flood <- prettyNum(sum(flood_state_chart$count_property)) # 143,653,175

# Share of total properties nationwide for SEVERE risk
sum(fire_state_chart$number_severe)/as.numeric(props_fire) # 3%
sum(wind_state_chart$number_severe)/as.numeric(props_wind) # 15.8%
sum(heat_state_chart$number_severe)/as.numeric(props_heat) # 30.5%
sum(flood_state_chart$number_severe)/as.numeric(props_flood) # 8.3%

# Share of total properties nationwide for major risk
sum(fire_state_chart$number_major)/as.numeric(props_fire) # 7.2%
sum(wind_state_chart$number_major)/as.numeric(props_wind) # 30%
sum(heat_state_chart$number_major)/as.numeric(props_heat) # 56.2%
sum(flood_state_chart$number_major)/as.numeric(props_flood) # 13.5%

# Counties with at least 50% properties at SEVERE risk
fire_county_chart %>% filter(pct_severe>50) %>% nrow() # 81 or nearly 3%
wind_county_chart %>% filter(pct_severe>50) %>% nrow() # 371 or 12%
heat_county_chart %>% filter(pct_severe>50) %>% nrow() # 658 or 21%
flood_county_chart %>% filter(pct_severe>50) %>% nrow() # 29 or 1% percent

# Counties with at least 50% properties at major risk
fire_county_chart %>% filter(pct_major>50) %>% nrow() # 212 or 7%
wind_county_chart %>% filter(pct_major>50) %>% nrow() # 706 or 22%
heat_county_chart %>% filter(pct_major>50) %>% nrow() # 1,455 or 46%
flood_county_chart %>% filter(pct_major>50) %>% nrow() # 53 or nearly 2%

# Zip codes with at least 50% properties at SEVERE risk
fire_zip_chart %>% filter(pct_severe>50) %>% nrow() # 872 or nearly 3%
wind_zip_chart %>% filter(pct_severe>50) %>% nrow() # 3,473 or 11%
heat_zip_chart %>% filter(pct_severe>50) %>% nrow() # 6,538 or 20%
flood_zip_chart %>% filter(pct_severe>50) %>% nrow() # 918 or nearly 3%

# Zip codes with at least 50% properties at major risk
fire_zip_chart %>% filter(pct_major>50) %>% nrow() # 2,083 or 6%
wind_zip_chart %>% filter(pct_major>50) %>% nrow() # 7,235 or 22%
heat_zip_chart %>% filter(pct_major>50) %>% nrow() # 14,084 or 44%
flood_zip_chart %>% filter(pct_major>50) %>% nrow() # 1,407 or 4%

# TRACTS with at least 50% properties at SEVERE risk
fire_tract_chart %>% filter(pct_severe>50) %>% nrow() # 1,667 or 2%
wind_tract_chart %>% filter(pct_severe>50) %>% nrow() # 12,324 or 15%
heat_tract_chart %>% filter(pct_severe>50) %>% nrow() # 26,387 or 32%
flood_tract_chart %>% filter(pct_severe>50) %>% nrow() # 2,190 or nearly 3%

# TRACTS with at least 50% properties at major risk
fire_tract_chart %>% filter(pct_major>50) %>% nrow() # 4,441 or 5%
wind_tract_chart %>% filter(pct_major>50) %>% nrow() # 26,188 or 31%
heat_tract_chart %>% filter(pct_major>50) %>% nrow() # 49,768 or 44%
flood_tract_chart %>% filter(pct_major>50) %>% nrow() # 4,359 or 4%

# Our states
# California: flood 15% major, fire 23% major, heat 69% major, wind 0% major
# Texas: flood 12% major, fire 14% major, heat 99% major, wind 70% major
# North Carolina: flood 12% major, fire 2% major, heat 87% major, wind 55% major
# Pennsylvania: flood 12% major, fire 0% major, heat 42% major, wind 22% major
# Illinois: flood 11% major, fire 0% major, heat 10% major, wind 0% major
# New York: flood 12% major, fire 0% major, heat 38% major, wind 35% major
# New Jersey: flood 14% major, fire 5% major, heat 95% major, wind 83% major

# Our core counties
# California-Los Angeles: flood 16% (332,000 properties), fire 11% (238K prop), heat 84%, wind 0%
# California-Orange: flood 13% (86,000 properties), fire 5%, heat 81%, wind 0%
# California-Riverside: flood 13% (118,000 properties), fire 67% (592K prop), heat 99%, wind 0%
# California-San Bernardino: flood 11% (87,000 properties), fire 45% (369K prop), heat 91%, wind 0%
# California-Ventura: flood 16% (40,000 properties), fire 18% (46K prop), heat 48%, wind 0%

# California-Fresno: flood 16% (49,000 properties), fire 29% (89K prop), heat 98%, wind 0%

# California-San Francisco: flood 7% (10,000 properties), fire 0%, heat 0%, wind 0%
# California-Alameda: flood 14% (58,000 properties), fire 5%, heat 9%, wind 0%
# California-Santa Clara: flood 23% (107,000 properties), fire 0%, heat 44%, wind 0%

# California-Contra Costa: flood 23% (107,000 properties), fire 0%, heat 44%, wind 0%
# California-Marin: flood 23% (107,000 properties), fire 0%, heat 44%, wind 0%
# California-Napa: flood 23% (107,000 properties), fire 0%, heat 44%, wind 0%
# California-San Mateo: flood 23% (107,000 properties), fire 0%, heat 44%, wind 0%
# California-Solano: flood 23% (107,000 properties), fire 0%, heat 44%, wind 0%
# California-Sonoma: flood 23% (107,000 properties), fire 0%, heat 44%, wind 0%

# Texas-Harris: flood 15% (198K), fire 0%, heat 100%, wind 100%
# Texas-Galveston: flood 75% (125K), fire 6%, heat 100%, wind 100%

# North Carolina-Wake: flood 6%, fire 0%, heat 100%, wind 100%
# North Carolina-Durham: flood 7%, fire 0%, heat 100%, wind 98%

# Pennsylvania-Philadelphia: flood 10% (54K), fire 0%, heat 100%, wind 100%

# Illinois-Cook: flood 15% (209K properties), fire 0%, heat 0%, wind 0%

# New York-Queens: flood 14% (44K), fire 0%, heat 100%, wind 100%
# New York-Richmond: flood 12% (14K), fire 1%, heat 100%, wind 100%
# New York-Kings: flood 12% (32K), fire 0%, heat 100%, wind 100%
# New York-New York (Manhattan): flood 6% (2,600), fire 0%, heat 100%, wind 20%
# New York-Bronx: flood 11% (9,600), fire 0%, heat 100%, wind 57%

# New Jersey: flood 14%, fire 5%, heat 95%, wind 83%


