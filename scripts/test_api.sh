#!/bin/bash

# Configuration
BASE_URL="http://143.198.65.97"
API_PREFIX="/api/v1" # Matches core/config.py API_PREFIX
API_URL="${BASE_URL}${API_PREFIX}"

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo "Testing FastAPI Book Management API"
echo "=================================="

# Test health check
echo "Testing health check..."
health_response=$(curl -s "${API_URL}/healthcheck")
echo "Response: $health_response"
if [[ $health_response == *"active"* ]]; then
  echo -e "${GREEN}OK${NC}"
else
  echo -e "${RED}FAILED${NC}"
fi
echo "----------------------------------------"

# Test get all books
echo "Testing get all books..."
books_response=$(curl -s "${API_URL}/books/")
echo "Response: $books_response"
if [[ $books_response == *"The Hobbit"* ]]; then
  echo -e "${GREEN}OK${NC}"
else
  echo -e "${RED}FAILED${NC}"
fi
echo "----------------------------------------"

# Test get single book
echo "Testing get single book (ID: 1)..."
book_response=$(curl -s "${API_URL}/books/1")
echo "Response: $book_response"
if [[ $book_response == *"The Hobbit"* ]]; then
  echo -e "${GREEN}OK${NC}"
else
  echo -e "${RED}FAILED${NC}"
fi
echo "----------------------------------------"

# Test get non-existent book
echo "Testing get non-existent book (ID: 999)..."
nonexistent_response=$(curl -s "${API_URL}/books/999")
echo "Response: $nonexistent_response"
if [[ $nonexistent_response == *"not found"* ]]; then
  echo -e "${GREEN}OK${NC}"
else
  echo -e "${RED}FAILED${NC}"
fi
echo "----------------------------------------"

# Test create book
echo "Testing create book..."
create_response=$(curl -s -X POST "${API_URL}/books/" \
  -H "Content-Type: application/json" \
  -d '{"id": 4, "title": "New Book", "author": "Test Author", "publication_year": 2024, "genre": "Fantasy"}')
echo "Response: $create_response"
if [[ $create_response == *"New Book"* ]]; then
  echo -e "${GREEN}OK${NC}"
else
  echo -e "${RED}FAILED${NC}"
fi

echo "Tests completed!"
