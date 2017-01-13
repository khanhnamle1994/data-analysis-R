library(ggplot2)
data(diamonds)
head(diamonds)
summary(diamonds)

ggplot(aes(x = price, y = x), data = diamonds) + geom_line()

cor.test(diamonds$price, diamonds$x, method = 'pearson')
cor.test(diamonds$price, diamonds$y, method = 'pearson')
cor.test(diamonds$price, diamonds$z, method = 'pearson')

ggplot(data = diamonds, aes(x = depth, y = price)) + geom_line()

ggplot(data = diamonds, aes(x = depth, y = price)) + 
  geom_point(alpha=1/100) +
  scale_x_continuous(breaks = 2)

cor.test(diamonds$depth, diamonds$price)

ggplot(aes(x = price, y = carat), data = diamonds) + geom_point() +
  xlim(0, quantile(diamonds$price, 0.9)) +
  ylim(0, quantile(diamonds$carat, 0.9)) +
  geom_smooth(method = 'lm', color = 'red')