library(ggplot2)
library(cowplot)

#source: https://stackoverflow.com/questions/18509723/display-two-parallel-axes-on-a-ggplot-r

set.seed(123)
x1 <- rnorm(100000, log(2), 1)
x2 <- rnorm(100000, -log(2), 1)
x <- c(x1, x2)
group <- c(rep("treat1", length(x1)), 
           rep("treat2", length(x2)))

plot <- ggplot(data.frame(x, group), aes(x = x, colour = group)) +
  geom_density(bw = 0.2, linewidth = 1.2) +
  scale_color_manual(values = c("treat1" = "green4", "treat2" = "red")) +
  scale_x_continuous(breaks = c(-2.5, -log(2), 0, log(2), 2.5), 
                     label = round(exp(c(-2.5, -log(2), 0, log(2), 2.5)), 1)) + 
  labs(x = "Informative missingness odds ratio (IMOR)", y = "Density") + 
  guides(colour = "none") +
  theme_classic() +
  theme(axis.text = element_text(size = 14),
        axis.title = element_text(size = 14, face = "bold"))

x2plot <- ggplot(data.frame(x, group), aes(x = x, colour = group)) +
  geom_density(bw = 0.2, linewidth = 1.2) +
  scale_color_manual(values = c("treat1" = "green4", "treat2" = "red")) +
  scale_x_continuous(breaks = c(-2.5, -log(2), 0, log(2), 2.5), 
                     label = c(-2.5, round(-log(2), 1), 0, round(-log(2), 1), 2.5)) + 
  labs(x = "IMOR in logarithmic scale", y = "Density") + 
  guides(colour = "none") +
  theme_classic() +
  theme(axis.text = element_text(size = 14),
        axis.title = element_text(size = 14, face = "bold"))

x <- get_x_axis(x2plot)
xl <- get_plot_component(x2plot, "xlab-b")

plot_grid(plot, ggdraw(x), ggdraw(xl), align = 'v', axis = 'rl', ncol = 1, 
          rel_heights = c(0.8, 0.05, 0.05))

