#Ploting declines in poverty in Travis County 
library(dplyr)

        percent_below_povety_level <- 
                  readRDS("C:/Users/tenis/OneDrive/Desktop/Poverty_in_Travis_County/
                          Poverty_in_Travis_County/percent_below_povety_level.rds") #the zipcode for UT campus was excluded, 78712
        
        
        #Creating a dataset that includes the change in poverty by zipcode in Travis County from 2013-2017
        percentbelowpoverty <- percent_below_povety_level
        poverty2013 <- filter(percentbelowpoverty, year == 2013)
        poverty2017 <- filter(percentbelowpoverty, year == 2017)
        povertychange <- rename(poverty2013, poverty_2013 = percent_below_poverty_level)
        povertychange <- povertychange[,1:2]
        poverty2017 <- select(poverty2017, "percent_below_poverty_level")
        povertychange <- bind_cols(povertychange, poverty2017)
        povertychange <- povertychange %>% rename(poverty_2017 = percent_below_poverty_level)
        
        #added a column to locate zipcode either east or west of i35
        write.csv(povertychange, file= "povertychange.csv")
        
        #reading the table back into the environment 
        poverty_change_by_region <- read.csv("povertychange.csv")
        
        #summary statistics 
        summary(poverty_change_by_region$percent_change)
        boxplot(percent_change ~ region, data = poverty_change_by_region, col = "blue", 
                ylab= "Percentage Point change in Poverty Rate", xlab = "Side of I35", 
                main = "Change in Poverty Rate of Travis County by zipcodes (2013-2017)")
        abline(h = median(poverty_change_by_region$percent_change), lwd = 2, lty = 2, col = "magenta")
        
        