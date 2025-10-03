import express from "express";
import swaggerUi from "swagger-ui-express";
import fs from "fs";
import YAML from "yaml";

const app = express();
const port = 3000;

// YAML を読み込み
const file = fs.readFileSync("./tsp-output/schema/openapi.yaml", "utf8");
const swaggerDocument = YAML.parse(file);

// Swagger UI を /api-docs で公開
app.use("/", swaggerUi.serve, swaggerUi.setup(swaggerDocument));

app.listen(port, () => {
  console.log(`http://localhost:${port}/ で OpenAPI を確認できます`);
});
