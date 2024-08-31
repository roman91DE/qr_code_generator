#!/bin/bash

# Check if Homebrew is installed
if ! command -v brew &> /dev/null
then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed. Updating..."
    brew update
fi

# Install Node.js
# Check if Node.js is installed
if ! command -v node &> /dev/null
then
    echo "Installing Node.js..."
    brew install node
else
    echo "Node.js is already installed."
fi

# Check if TypeScript is installed
if ! command -v tsc &> /dev/null
then
    echo "Installing TypeScript..."
    npm install -g typescript
else
    echo "TypeScript is already installed."
fi


# Initialize npm project
npm init -y

# Install development dependencies
npm install --save-dev typescript ts-loader webpack webpack-cli webpack-dev-server

# Create TypeScript configuration file
echo '{
  "compilerOptions": {
    "outDir": "./dist/",
    "sourceMap": true,
    "noImplicitAny": true,
    "module": "es6",
    "target": "es5",
    "jsx": "react",
    "allowJs": true,
    "moduleResolution": "node"
  }
}' > tsconfig.json

# Create Webpack configuration file
echo 'const path = require("path");

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
};' > webpack.config.js

# Create source files
echo '<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QR Code Generator</title>
    <script src="https://cdn.jsdelivr.net/npm/qrcode-generator@1.4.4/qrcode.min.js"></script>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <h1>QR Code Generator</h1>
        <input type="text" id="text-input" placeholder="Enter text or URL">
        <button id="generate-button">Generate QR Code</button>
        <div id="qr-code"></div>
    </div>
    <script src="dist/script.js"></script>
</body>
</html>' > index.html

echo 'body {
    font-family: Arial, sans-serif;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
    background-color: #f0f0f0;
}

.container {
    text-align: center;
    background-color: white;
    padding: 2rem;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

input, button {
    margin: 10px 0;
    padding: 10px;
    font-size: 16px;
}

button {
    background-color: #4CAF50;
    color: white;
    border: none;
    cursor: pointer;
}

button:hover {
    background-color: #45a049;
}

#qr-code {
    margin-top: 20px;
}' > styles.css

echo 'function generateQR(): void {
    const textInput = document.getElementById("text-input") as HTMLInputElement;
    const text = textInput.value;
    if (text) {
        const qr = qrcode(0, "M");
        qr.addData(text);
        qr.make();
        const qrCodeDiv = document.getElementById("qr-code");
        if (qrCodeDiv) {
            qrCodeDiv.innerHTML = qr.createImgTag(5);
        }
    } else {
        alert("Please enter some text or URL");
    }
}

document.addEventListener("DOMContentLoaded", () => {
    const generateButton = document.getElementById("generate-button");
    if (generateButton) {
        generateButton.addEventListener("click", generateQR);
    }
});' > script.ts

# Add scripts to package.json
npm pkg set scripts.build="webpack"
npm pkg set scripts.start="webpack serve --open"

echo "Setup complete! To start the development server, run:"
echo "cd qr-code-generator"
echo "npm start"

echo "Project setup completed. You can now run 'npm start' to start the development server."