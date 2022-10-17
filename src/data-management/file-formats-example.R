library("arrow")

df = read_feather("temp/abc.arrow")
plot(df[c("alpha", "bravo")])

# write out -----------------------------------------------------------------
# serialized
f = file("temp/abc-from-r.srlz", open = "wb")  # create binary file
serialize(df, connection = f)

# recover?
df_from = unserialize(file("temp/abc-from-r.srlz", open = "rb"))
