const path = require("path");

module.exports = {
  entry: "./script.ts",
  module: {
    rules: [
      {
        test: /\.tsx?$/,
        use: "ts-loader",
        exclude: /node_modules/,
      },
    ],
  },
  resolve: {
    extensions: [".tsx", ".ts", ".js"],
  },
  output: {
    filename: "script.js",
    path: path.resolve(__dirname, "dist"),
  },
  mode: "development",
  devServer: {
    static: {
      directory: path.join(__dirname, "./"),
    },
    compress: true,
    port: 9000,
  },
};