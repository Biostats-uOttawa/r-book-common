library(tidyverse)

d <- function(u1, u2, sd1, sd2) {
  abs(u1 - u2) / sqrt((sd1^2 + sd2^2) / 2)
}

plot_pwr <- function(
    n, d, sig_level, type
    ) {
  typ_num <- ifelse(type == "two.sample", 2, 1)
  qc <- qt(1 - sig_level / typ_num, (n - 1) * 2)
  if (typ_num == 2) {
    qcl <- c(-qc, qc)
  } else {
    qcl <- qc
  } 
  ncp <- d * sqrt(n*2) / 2
  dat <- data.frame(
    x = seq(-4, 4, length = 200),
    y0 = dt(x, (n - 1) * 2),
    y1 = dt(x, (n - 1) * 2, ncp = ncp)
  ) %>%
    mutate(
      beta = ifelse(x <= qc, y1, 0),
      pow = ifelse(x > qc, y1, 0)
    )

  ggplot(dat, aes(x = x)) +
    geom_line(aes(y = y0), color = "red") +
    geom_line(aes(y = y1), color = "blue") +
    geom_vline(xintercept = qcl, color = "green") +
    geom_area(
      aes(x = x, y = beta),
      fill = rgb(red = 0, green = 0.2, blue = 1, alpha = 0.5)
    ) +
    geom_area(
      aes(x = x, y = pow),
      fill = rgb(red = 1, green = 0, blue = 0.2, alpha = 0.5)
    ) +
    theme_classic() +
    ylab("dt(x)")
}
