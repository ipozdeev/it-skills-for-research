
# Load necessary libraries
library(ggplot2)
library(wesanderson)

# Set seed for reproducibility
set.seed(123)

# Generate two random walk processes
rw1 <- cumsum(rnorm(10))
rw2 <- cumsum(rnorm(10))

# Create a data frame for plotting
df <- data.frame(
  Step = 1:10,
  Process1 = rw1,
  Process2 = rw2
)

# Melt data for ggplot
library(reshape2)
df_melted <- melt(df, id.vars = 'Step')

png("random_walk_plot.png", width = 800, height = 600)

# Plot the random walks using a Wes Anderson palette
ggplot(df_melted, aes(x = Step, y = value, color = variable)) +
  geom_line(linewidth = 1.2) +
  scale_color_manual(values = wes_palette("Zissou1", 2, type = "continuous")) +
  labs(title = 'Random Walk Processes', x = 'Step', y = 'Value') +
  theme_minimal()

# Display the plot
dev.off()
