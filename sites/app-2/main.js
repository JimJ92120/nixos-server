const express = require("express");

const PORT = 3000;
const HOST = "0.0.0.0";

const App = express();

App.get("/", (request, response) => {
  response.send("Hello World App");
});

App.get("/hell-world", (request, response) => {
  response.send({
    message: "Hello World App",
  });
});

async function main() {
  App.listen(PORT, HOST, () => {
    console.log(`Listening to http://${HOST}:${PORT}`);
  });
}

main();
