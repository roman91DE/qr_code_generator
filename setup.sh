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

# Install project dependencies
echo "Installing project dependencies..."
npm install

echo "Setup complete! To start the development server, run:"
echo "npm start"