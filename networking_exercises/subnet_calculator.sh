#!/bin/bash

# Subnet Calculator Script
# This script helps with common IP subnetting calculations

# Text formatting
BOLD=$(tput bold)
NORMAL=$(tput sgr0)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)

# Show help
show_help() {
  echo "${BOLD}IP Subnet Calculator${NORMAL}"
  echo "A tool for AWS cloud engineers to perform subnet calculations"
  echo
  echo "Usage:"
  echo "  $0 [options]"
  echo
  echo "Options:"
  echo "  -c, --cidr CIDR      Calculate subnet information for CIDR (e.g., 192.168.1.0/24)"
  echo "  -s, --split CIDR N   Split CIDR into N equal subnets"
  echo "  -v, --vlsm CIDR      Perform VLSM subnetting (requires sizes)"
  echo "  -i, --in-range IP CIDR  Check if IP is within CIDR range"
  echo "  -h, --help           Show this help message"
  echo
  echo "Examples:"
  echo "  $0 --cidr 10.0.0.0/16"
  echo "  $0 --split 10.0.0.0/16 4"
  echo "  $0 --in-range 192.168.1.25 192.168.1.0/24"
  echo
}

# Convert IP to decimal
ip_to_decimal() {
  local ip=$1
  IFS='.' read -r i1 i2 i3 i4 <<< "$ip"
  echo $(( (i1 << 24) + (i2 << 16) + (i3 << 8) + i4 ))
}

# Convert decimal to IP
decimal_to_ip() {
  local decimal=$1
  local ip1=$(( (decimal >> 24) & 255 ))
  local ip2=$(( (decimal >> 16) & 255 ))
  local ip3=$(( (decimal >> 8) & 255 ))
  local ip4=$(( decimal & 255 ))
  echo "$ip1.$ip2.$ip3.$ip4"
}

# Calculate subnet information
calculate_subnet_info() {
  local cidr=$1
  
  # Extract IP and prefix
  local ip=${cidr%/*}
  local prefix=${cidr#*/}
  
  # Calculate subnet mask
  local mask_decimal=$(( 0xffffffff ^ ((1 << (32 - prefix)) - 1) ))
  local subnet_mask=$(decimal_to_ip $mask_decimal)
  
  # Calculate network address
  local ip_decimal=$(ip_to_decimal $ip)
  local network_decimal=$(( ip_decimal & mask_decimal ))
  local network_address=$(decimal_to_ip $network_decimal)
  
  # Calculate broadcast address
  local broadcast_decimal=$(( network_decimal | (0xffffffff ^ mask_decimal) ))
  local broadcast_address=$(decimal_to_ip $broadcast_decimal)
  
  # Calculate first and last usable IP
  local first_usable_decimal=$(( network_decimal + 1 ))
  local last_usable_decimal=$(( broadcast_decimal - 1 ))
  local first_usable=$(decimal_to_ip $first_usable_decimal)
  local last_usable=$(decimal_to_ip $last_usable_decimal)
  
  # Calculate number of hosts
  local hosts=$(( (1 << (32 - prefix)) - 2 ))
  if [[ $hosts -lt 0 ]]; then
    hosts=0
  fi
  
  # Display results
  echo "${BOLD}${GREEN}Subnet Information for $cidr${NORMAL}"
  echo "${BOLD}Network Address:${NORMAL}    $network_address"
  echo "${BOLD}Subnet Mask:${NORMAL}        $subnet_mask"
  echo "${BOLD}CIDR Notation:${NORMAL}      $network_address/$prefix"
  echo "${BOLD}Broadcast Address:${NORMAL}  $broadcast_address"
  echo "${BOLD}First Usable IP:${NORMAL}    $first_usable"
  echo "${BOLD}Last Usable IP:${NORMAL}     $last_usable"
  echo "${BOLD}Total Hosts:${NORMAL}        $hosts"
  
  # AWS specific information
  if [[ $prefix -ge 16 && $prefix -le 28 ]]; then
    echo
    echo "${BOLD}${BLUE}AWS VPC Information:${NORMAL}"
    
    # Determine if suitable for VPC
    if [[ $prefix -le 16 ]]; then
      echo "${BOLD}VPC Suitability:${NORMAL}    Ideal for VPC (/16 to /28 recommended in AWS)"
    elif [[ $prefix -le 23 ]]; then
      echo "${BOLD}VPC Suitability:${NORMAL}    Good for medium-sized subnet"
    elif [[ $prefix -le 27 ]]; then
      echo "${BOLD}VPC Suitability:${NORMAL}    Good for small subnet"
    else
      echo "${BOLD}VPC Suitability:${NORMAL}    Minimum size for AWS subnet (/28)"
    fi
    
    # Reserved IPs in AWS
    echo "${BOLD}AWS Reserved IPs:${NORMAL}   5 IPs (first 4 and last 1)"
    echo "${BOLD}Available Hosts:${NORMAL}    $((hosts - 5)) (AWS reserves 5 IPs per subnet)"
    echo "${YELLOW}Note: AWS reserves the first 4 IPs and the last IP of each subnet${NORMAL}"
  fi
}

# Split subnet into equal parts
split_subnet() {
  local cidr=$1
  local parts=$2
  
  # Extract IP and prefix
  local ip=${cidr%/*}
  local prefix=${cidr#*/}
  
  # Calculate how many bits we need
  local bits_needed=0
  local max_subnets=1
  
  while [[ $max_subnets -lt $parts ]]; do
    bits_needed=$((bits_needed + 1))
    max_subnets=$((max_subnets * 2))
  done
  
  local new_prefix=$((prefix + bits_needed))
  
  if [[ $new_prefix -gt 32 ]]; then
    echo "Error: Cannot split into $parts subnets (would exceed /32)"
    return 1
  fi
  
  echo "${BOLD}${GREEN}Splitting $cidr into $parts equal subnets${NORMAL}"
  echo "${BOLD}New prefix length:${NORMAL} /$new_prefix"
  echo
  
  # Calculate the decimal network address
  local ip_decimal=$(ip_to_decimal $ip)
  local mask_decimal=$(( 0xffffffff ^ ((1 << (32 - prefix)) - 1) ))
  local network_decimal=$(( ip_decimal & mask_decimal ))
  
  # Calculate subnet size
  local subnet_size=$((1 << (32 - new_prefix)))
  
  # Display each subnet
  echo "${BOLD}Subnet List:${NORMAL}"
  echo "----------------"
  
  for ((i=0; i<parts; i++)); do
    local subnet_network=$((network_decimal + (i * subnet_size)))
    local subnet_broadcast=$((subnet_network + subnet_size - 1))
    local subnet_ip=$(decimal_to_ip $subnet_network)
    local subnet_first=$(decimal_to_ip $((subnet_network + 1)))
    local subnet_last=$(decimal_to_ip $((subnet_broadcast - 1)))
    
    echo "${BOLD}Subnet $((i+1)):${NORMAL}"
    echo "  CIDR:            $subnet_ip/$new_prefix"
    echo "  First Usable IP: $subnet_first"
    echo "  Last Usable IP:  $subnet_last"
    echo "  Usable IPs:      $(( (1 << (32 - new_prefix)) - 2 ))"
    echo
  done
  
  echo "${YELLOW}AWS Note: Remember that AWS reserves the first 4 IPs and the last IP of each subnet${NORMAL}"
}

# Check if IP is in CIDR range
check_ip_in_range() {
  local ip=$1
  local cidr=$2
  
  # Extract network part and prefix from CIDR
  local network_ip=${cidr%/*}
  local prefix=${cidr#*/}
  
  # Convert IP addresses to decimal
  local ip_decimal=$(ip_to_decimal $ip)
  local network_decimal=$(ip_to_decimal $network_ip)
  
  # Calculate subnet mask
  local mask_decimal=$(( 0xffffffff ^ ((1 << (32 - prefix)) - 1) ))
  
  # Calculate network address of the CIDR block
  local cidr_network_decimal=$(( network_decimal & mask_decimal ))
  
  # Calculate network address of the IP using the same mask
  local ip_network_decimal=$(( ip_decimal & mask_decimal ))
  
  # Compare network addresses
  if [[ $cidr_network_decimal -eq $ip_network_decimal ]]; then
    echo "${GREEN}${BOLD}YES:${NORMAL} $ip is within the range of $cidr"
    return 0
  else
    echo "${YELLOW}${BOLD}NO:${NORMAL} $ip is NOT within the range of $cidr"
    return 1
  fi
}

# Check arguments
if [[ $# -eq 0 ]]; then
  show_help
  exit 0
fi

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    -c|--cidr)
      if [[ -z "$2" ]]; then
        echo "Error: CIDR value required"
        exit 1
      fi
      calculate_subnet_info "$2"
      shift 2
      ;;
    -s|--split)
      if [[ -z "$2" || -z "$3" ]]; then
        echo "Error: CIDR and number of parts required"
        exit 1
      fi
      split_subnet "$2" "$3"
      shift 3
      ;;
    -i|--in-range)
      if [[ -z "$2" || -z "$3" ]]; then
        echo "Error: IP and CIDR required"
        exit 1
      fi
      check_ip_in_range "$2" "$3"
      shift 3
      ;;
    -h|--help)
      show_help
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      show_help
      exit 1
      ;;
  esac
done