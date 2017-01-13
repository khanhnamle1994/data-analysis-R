library(ggplot2)
data(diamonds)
head(diamonds)
summary(diamonds)

# Price Histograms with Facet and Color
ggplot(aes(x = log(price)), data = diamonds) +
  geom_histogram(aes(fill = cut)) +
  facet_wrap(~color) +
  scale_fill_brewer(type = 'qual')

# Price vs Table Colored by Cut
ggplot(aes(x = table, y = price), data = diamonds) +
  geom_point(aes(color = cut)) +
  scale_color_brewer(type = 'qual')

# Price vs Volume and Diamond Clarity
diamonds$volume = diamonds$x * diamonds$y * diamonds$z
ggplot(aes(x = volume, y = price), data = diamonds) +
  geom_point(aes(color = clarity)) +
  ylim(0, quantile(diamonds$volume, 0.99)) +
  scale_y_log10() +
  coord_cartesian(xlim = c(0,350))

# Proportions of Friendships Initiated
pf <- read.csv('pseudo_facebook.tsv')
pf$prop_initiated <- pf$friendships_initiated/pf$friend_count

# prop_initiated vs tenure
ggplot(aes(x = tenure, y = prop_initiated),
       data = subset(pf, !is.na(prop_initiated) & !is.na(year_joined.bucket))) +
  geom_line(aes(color = year_joined.bucket), fun.y = 'median', stat = 'summary') +
  scale_color_brewer(type = 'div')

# Smoothing prop_initiated vs tenure
ggplot(aes(x = tenure, y = prop_initiated), data = pf) +
  geom_line(aes(color = year_joined.bucket), stat = 'summary', fun.y = 'median') +
  geom_smooth(aes(color = year_joined.bucket))

summary(subset(pf, year_joined.bucket =='(2012,2014]')$prop_initiated)

# Price/Carat Binned, Faceted, Colored
ggplot(aes(x = cut, y = price/carat), data = subset(diamonds, fill = color)) +
  facet_wrap(~clarity) +
  geom_point(aes(color = color), pch = 5, position = "jitter") +
  scale_color_brewer(type = 'div')