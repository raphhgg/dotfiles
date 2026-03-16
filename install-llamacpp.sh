#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# --- Configuration ---
WORKSPACE_DIR="$HOME/llm-workspace"
CUDA_ARCH="86" # 86 is for RTX 3000 series (Ampere)

# --- Colors for output ---
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Starting llama.cpp installation and environment setup...${NC}\n"

# Step 1: Update system and install dependencies
echo -e "${BLUE}[1/5] Updating system and installing dependencies...${NC}"
sudo apt update
sudo apt upgrade -y
sudo apt install -y build-essential cmake git wget curl pipx nvidia-cuda-toolkit

# Step 2: Create workspace
echo -e "\n${BLUE}[2/5] Setting up workspace at ${WORKSPACE_DIR}...${NC}"
mkdir -p "$WORKSPACE_DIR"
cd "$WORKSPACE_DIR"

# Step 3: Clone and build llama.cpp
echo -e "\n${BLUE}[3/5] Downloading and compiling llama.cpp for RTX 3090...${NC}"
if [ ! -d "llama.cpp" ]; then
  git clone https://github.com/ggerganov/llama.cpp
else
  echo "llama.cpp repository already exists. Pulling latest changes..."
  cd llama.cpp
  git pull
  cd ..
fi

cd llama.cpp
rm -rf build
mkdir build
cd build

# Configure for CUDA and specific GPU architecture
cmake .. -DGGML_CUDA=ON -DCMAKE_CUDA_ARCHITECTURES=${CUDA_ARCH}

# Compile using all available CPU cores
cmake --build . --config Release -j$(nproc)

# Install huggingface-cli
pipx install huggingface_hub

# Create models and benchmarks directories
mkdir -p "$WORKSPACE_DIR/models"
mkdir -p "$WORKSPACE_DIR/benchmarks"

# Step 5: Finish
echo -e "\n${GREEN}[5/5] Installation Complete!${NC}"
