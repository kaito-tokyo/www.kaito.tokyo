import express from "express";

import { handleOptimizeImage } from "./handlers/optimize-image.js";
import { handleUploadObjectToCdn } from "./handlers/upload-object-to-cdn.js";

const app = express();

app.get("/newt-storage-optimize-image", handleOptimizeImage);
app.get("/newt-storage-upload-object-to-cdn", handleUploadObjectToCdn);

const port = parseInt(process.env["PORT"] ?? "8080", 10);
app.listen(port, () => {
  console.log(`Listening on port ${port}`);
});
