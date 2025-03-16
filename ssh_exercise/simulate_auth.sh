#!/bin/bash

# This script simulates the SSH authentication process
# to help understand how public/private key pairs work

echo "===== SSH Authentication Simulation ====="
echo "This simulation demonstrates how SSH uses public/private key pairs"
echo ""

# Create a directory to simulate a "remote server"
mkdir -p remote_server/.ssh
echo "Created a simulated remote server"

# Function to generate a simple message
generate_message() {
  echo "This is a secret message that only an authorized user should see!" > message.txt
  echo "Generated a secret message"
}

# Function to "encrypt" with the private key (simulate signing)
sign_message() {
  if [ ! -f ./id_ed25519 ]; then
    echo "Error: Private key not found. Please generate an SSH key pair first."
    exit 1
  fi
  
  echo "Simulating signing the message with your private key..."
  openssl dgst -sha256 -sign ./id_ed25519 -keyform PEM message.txt > message.sig 2>/dev/null
  
  if [ $? -ne 0 ]; then
    echo "Private key format not compatible with direct openssl use."
    echo "This is expected as SSH keys have a specific format."
    echo "(In a real scenario, SSH would handle this internally)"
    
    # Create a dummy signature file for simulation purposes
    echo "SIMULATED_SIGNATURE" > message.sig
  fi
  
  echo "Message signed (simulated)"
}

# Function to verify the signature using the public key
verify_signature() {
  if [ ! -f ./id_ed25519.pub ]; then
    echo "Error: Public key not found. Please generate an SSH key pair first."
    exit 1
  fi
  
  # Copy the public key to the "remote server"
  cat ./id_ed25519.pub > remote_server/.ssh/authorized_keys
  echo "Added your public key to the remote server's authorized_keys"
  
  echo "Remote server is verifying your identity using your public key..."
  echo "Authorized access granted! Here's the message:"
  cat message.txt
}

# Main simulation
echo "Step 1: First, generate an SSH key pair using:"
echo "ssh-keygen -t ed25519 -C \"your_email@example.com\" -f ./id_ed25519"
echo ""

if [ -f ./id_ed25519 ] && [ -f ./id_ed25519.pub ]; then
  echo "Existing SSH key pair found!"
else
  echo "No SSH key pair found. Please generate one first."
  exit 1
fi

echo "Step 2: Creating a message that needs to be securely accessed"
generate_message

echo ""
echo "Step 3: Authentication process begins"
sign_message

echo ""
echo "Step 4: Connecting to remote server"
verify_signature

echo ""
echo "===== Simulation completed ====="
echo ""
echo "Key concepts demonstrated:"
echo "1. Your private key never leaves your computer"
echo "2. The remote server only has your public key"
echo "3. SSH uses your private key to prove your identity"
echo "4. The server verifies using your public key"
echo ""
echo "This is the foundation of SSH key-based authentication!"