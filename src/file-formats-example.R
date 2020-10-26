library("arrow")

df = read_feather("src/abc.arrow")
plot(df[c("alpha", "bravo")])

# write out -----------------------------------------------------------------
# serialized
f = file("src/abc-from-r.srlz", open = "wb")  # create binary file
serialize(df, connection = f)

# recover?
df_from = unserialize(file("src/abc-from-r.srlz", open = "rb"))
