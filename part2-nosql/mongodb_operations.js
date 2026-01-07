const fleximartDB = db.getSiblingDB("fleximart");

fleximartDB.products.drop();

const products = require("./products_catalog.json");

fleximartDB.products.insertMany(products);

print("Products catalog loaded successfully");

fleximartDB.products.createIndex({ category: 1 });
fleximartDB.products.createIndex({ price: 1 });

print("Indexes created");

const electronicsUnder50k = fleximartDB.products.find(
  { category: "Electronics", price: { $lt: 50000 } },
  { name: 1, price: 1, stock: 1, _id: 0 }
).toArray();

print("Electronics under 50000:");
printjson(electronicsUnder50k);

const avgRatingProducts = fleximartDB.products.aggregate([
  { $unwind: "$reviews" },
  {
    $group: {
      _id: "$product_id",
      name: { $first: "$name" },
      avg_rating: { $avg: "$reviews.rating" }
    }
  },
  { $match: { avg_rating: { $gte: 4 } } }
]).toArray();

print("Products with average rating >= 4:");
printjson(avgRatingProducts);

fleximartDB.products.updateOne(
  { product_id: "ELEC001" },
  {
    $push: {
      reviews: {
        user_id: "U999",
        username: "ValueBuyer",
        rating: 4,
        comment: "Good value for the price",
        date: new Date()
      }
    }
  }
);

print("Review added to ELEC001");

const avgPriceByCategory = fleximartDB.products.aggregate([
  {
    $group: {
      _id: "$category",
      avg_price: { $avg: "$price" },
      product_count: { $sum: 1 }
    }
  },
  { $sort: { avg_price: -1 } }
]).toArray();

print("Average price by category:");
printjson(avgPriceByCategory);