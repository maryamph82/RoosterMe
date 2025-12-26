const express = require("express");
const cors = require("cors");

const app = express();
app.use(cors());

app.get("/alarms", (req, res) => {
  res.json([
    { id: 1, time: "07:00", enabled: true },
    { id: 2, time: "08:30", enabled: false },
  ]);
});

app.get("/", (req, res) => {
  res.send("RoosterMe API is running 🚀");
});


app.listen(8081, () => {
  console.log("API running on http://localhost:8081");
});
