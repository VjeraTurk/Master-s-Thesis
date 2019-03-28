install.packages("nlme")
install.packages("mgcv")
library(ggplot2)## Grammar of graphics
library(reshape2)## Reshaping data frames
library(lattice) ##More graphics
library(gridExtra) ## ... and more graphics
library(xtable) ## LaTeX formatting of tables
library(splines) ## Splines -- surprise :-)
library(hexbin) ## and more graphics 

vegetables <- read.table(
  "http://www.math.ku.dk/~richard/regression/data/vegetablesSale.txt",
  header = TRUE,
  colClasses = c("numeric", "numeric", "factor", "factor",
                 "numeric", "numeric", "numeric")
)
summary(vegetables)
vegetables <- subset(vegetables, week != 2)
naid <- is.na(vegetables$discount)
impute <- with(subset(vegetables, !is.na(discount) & week == 4),
               c(1, median(discount), median(discountSEK))
)
vegetables[naid, c("ad", "discount", "discountSEK")] <- impute
vegetables <- within(vegetables, {
  meanNormSale <- sort(tapply(normalSale, store, mean))
  store <- factor(store, levels = names(meanNormSale))
  meanNormSale <- meanNormSale[store]
}
)

mVegetables <- melt(vegetables[, c("sale", "normalSale")])

qplot(value, data = mVegetables, geom = "density",
      fill = I(gray(0.5)), xlab = "", ylab = "") +
  scale_x_log10() + facet_wrap(~ variable, ncol = 1)

mVegetables <- melt(vegetables[, c("discount", "discountSEK")])
qplot(value, data = mVegetables, geom = "bar",
      fill = I(gray(0.5)), xlab = "", ylab = "") +
  facet_wrap(~ variable, scales = "free", ncol = 1)

contVar <- c("sale", "normalSale", "discount", "discountSEK")
vegLog <- vegetables[, contVar]
vegLog <- transform(vegLog,
                    sale = log10(sale),
                    normalSale = log10(normalSale))

ggplot(vegetables, aes(x = store, ymin = week - 0.5,
                       ymax = week + 0.5,
                       group = store, color = meanNormSale)) + geom_linerange() +
  coord_flip() + scale_x_discrete(breaks = c()) +
  theme(legend.position = "top") +
  scale_color_continuous("Mean normal sale",
                         guide = guide_colorbar(title.position = "top"))

qplot(discount, store, data = vegetables, geom = "point",
      group = store, color = meanNormSale) +
  scale_y_discrete(breaks = c()) + theme(legend.position = "top") +
  scale_color_continuous(guide = "none")

form <- sale ~ ad + discount + discountSEK + store
nulModel <- glm(sale ~ offset(log(normalSale)),
                family = poisson,
                data = vegetables)
oneTermModels <- add1(nulModel, form, test = "LRT")

form <- sale ~ offset(log(normalSale)) + store + ad +
  discount + discountSEK - 1
vegetablesGlm <- glm(form,
                     family = poisson,
                     data = vegetables)


binScale <- scale_fill_continuous(breaks = c(1, 10, 100,1000),low = "gray80", high = "black", trans = "log", guide ="none")


vegetablesDiag <- transform(vegetables,
                            .fitted = predict(vegetablesGlm),
                            .deviance = residuals(vegetablesGlm),
                            .pearson = residuals(vegetablesGlm,
                                                 type = "pearson")
)
p1 <- qplot(.fitted, .deviance, data = vegetablesDiag,
            geom = "hex") + binScale + geom_smooth(size = 1) +
  xlab("fitted values") + ylab("deviance residuals")
p2 <- qplot(.fitted, .pearson, data = vegetablesDiag,
            geom = "hex") + binScale + geom_smooth(size = 1) +
  xlab("fitted values") + ylab("Pearson residuals")
p3 <- qplot(.fitted, sqrt(abs(.pearson)), data = vegetablesDiag,
            geom = "hex") + binScale + geom_smooth(size = 1) +
  xlab("fitted values") +
  ylab("$\\sqrt{|\\text{Pearson residuals}|}$")

grid.arrange(p1, p2, p3, ncol = 3)

vegetablesGlm2 <- glm(form,
                      family = quasipoisson,
                      data = vegetables)
library(splines)
form <- sale ~ offset(log(normalSale)) + store + ad +
  ns(discount, knots = c(20, 30, 40), Boundary.knots = c(0, 50)) - 1
vegetablesGlm3 <- glm(form,
                      family = Gamma("log"),
                      data = vegetables)

form <- sale ~ offset(log(normalSale)) + store + ad +
  discount - 1
vegetablesGlm4 <- glm(form,
                      family = Gamma("log"),
                      data = vegetables)
anova(vegetablesGlm4, vegetablesGlm3, test = "LRT")

predFrame <- expand.grid(
  normalSale = 1,
  store = factor(c(91, 84, 66, 206, 342, 256, 357)),
  ad = factor(c(0, 1)),
  discount = seq(10, 50, 1)
)
predSale <- predict(vegetablesGlm3,
                    newdata = predFrame,
                    se.fit = TRUE)
predFrame <- cbind(predFrame, as.data.frame(predSale))
p1 <- qplot(discount, exp(fit),
            data = subset(predFrame, store == 206), geom = "line") +
  ylab("sale") +
  geom_ribbon(aes(ymin = exp(fit - 2 * se.fit),
                  ymax = exp(fit + 2 * se.fit)),
              alpha = 0.3) + facet_grid(. ~ ad, label = label_both) +
  coord_cartesian(ylim = c(0, 10)) +
  scale_y_continuous(breaks = c(1, 3, 5, 7, 9))
p2 <- qplot(discount, fit, data = predFrame,
            geom = "line", color = store) + ylab("sale") +
  facet_grid(. ~ ad, label = label_both) +
  scale_y_continuous("log-sale")
grid.arrange(p1, p2, ncol = 2)

vegetablesGlm2 <- glm(form,
                      family = quasipoisson,
                      data = vegetables)

form <- sale ~ offset(log(normalSale)) + store + ad +
  ns(discount, knots = c(20, 30, 40), Boundary.knots = c(0, 50)) - 1
vegetablesGlm3 <- glm(form,
                      family = Gamma("log"),
                      data = vegetables)

form <- sale ~ offset(log(normalSale)) + store + ad +
  discount - 1
vegetablesGlm4 <- glm(form,
                      family = Gamma("log"),
                      data = vegetables)
anova(vegetablesGlm4, vegetablesGlm3, test = "LRT")

#Typical store
predFrame <- expand.grid(
  normalSale = 1,
  store = factor(c(91, 84, 66, 206, 342, 256, 357)),
  ad = factor(c(0, 1)),
  discount = seq(10, 50, 1)
)
predSale <- predict(vegetablesGlm3,
                    newdata = predFrame,
                    se.fit = TRUE)
predFrame <- cbind(predFrame, as.data.frame(predSale))
p1 <- qplot(discount, exp(fit),
            data = subset(predFrame, store == 206), geom = "line") +
  ylab("sale") +
  geom_ribbon(aes(ymin = exp(fit - 2 * se.fit),
                  ymax = exp(fit + 2 * se.fit)),
              alpha = 0.3) + facet_grid(. ~ ad, label = label_both) +
  coord_cartesian(ylim = c(0, 10)) +
  scale_y_continuous(breaks = c(1, 3, 5, 7, 9))
p2 <- qplot(discount, fit, data = predFrame,
            geom = "line", color = store) + ylab("sale") +
  facet_grid(. ~ ad, label = label_both) +
  scale_y_continuous("log-sale")
grid.arrange(p1, p2, ncol = 2)

