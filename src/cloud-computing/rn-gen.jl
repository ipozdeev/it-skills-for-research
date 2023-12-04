using Statistics
using CSV
using DataFrames

# Read in the data from 'data.csv' as DataFrame called `data`
data = CSV.read("data.csv", DataFrame)

# Calculate the column means and standard deviations
means = mean.(eachcol(data))
std_devs = std.(eachcol(data))

# Create a new DataFrame for storing stats
stats = DataFrame([means std_devs]', :auto)

# Write the stats DataFrame to 'stats.csv'
CSV.write("stats.csv", stats)
