SpellingVars <- data.frame(Headword= c('Knight','Knight','Knight','Sword','Sword')
                          ,Variant= c('Kniht', 'Knyhht', 'Knyt', 'Sword', 'Swerd')
                          ,Freq1 = c(17,28,6,7,14)
                          ,Freq2 = c(22,12,7,8,44))


sp <- split(PhoneData, PhoneData$ID, drop = TRUE)

lapply(sp, function(x){chisq.test(x$Freq1, x$Freq2)})

library(zoo)

roll <- function(x) if (length(x) >= 4) rollsumr(x, 4, fill = NA) else NA
transform(example_data, four_quarters = ave(data_value, id_1, id_2, FUN = roll))
