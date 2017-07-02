from sklearn.linear_model import LinearRegression
import pandas
import coremltools

# Read the .csv file
data = pandas.read_csv("cars.csv")
print data

# Generate Scikit trained machine leaning model
model = LinearRegression()
model.fit(data[["model", "premium", "mileage", "condition"]], data["price"])

#  Convert Scikit-learn model to Core ML model
coreml_model = coremltools.converters.sklearn.convert(model, ["model", "premium", "mileage", "condition"], "price")
coreml_model.author = "Hacking with Swift"
coreml_model.liscense = "CC0"
coreml_model.short_description = "Predicts the trade-in price of a Tesla car."
coreml_model.save("Cars.mlmodel")
