#!/bin/bash

API_URL="http://localhost:8000/api/v1"

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo "Testing FastAPI Book Management API"
echo "=================================="

# Test health check
echo -n "Testing health check... "
health_response=$(curl -s "${API_URL}/healthcheck")
if [[ $health_response == *"active"* ]]; then
    echo -e "${GREEN}OK${NC}"
else
    echo -e "${RED}FAILED${NC}"
fi

# Test get all books
echo -n "Testing get all books... "
books_response=$(curl -s "${API_URL}/books/")
if [[ $books_response == *"The Hobbit"* ]]; then
    echo -e "${GREEN}OK${NC}"
else
    echo -e "${RED}FAILED${NC}"
fi

# Test get single book
echo -n "Testing get single book... "
book_response=$(curl -s "${API_URL}/books/1")
if [[ $book_response == *"The Hobbit"* ]]; then
    echo -e "${GREEN}OK${NC}"
else
    echo -e "${RED}FAILED${NC}"
fi

# Test create book
echo -n "Testing create book... "
create_response=$(curl -s -X POST "${API_URL}/books/" \
    -H "Content-Type: application/json" \
    -d '{"id": 4, "title": "New Book", "author": "Test Author", "publication_year": 2024, "genre": "Fantasy"}')
if [[ $create_response == *"New Book"* ]]; then
    echo -e "${GREEN}OK${NC}"
else
    echo -e "${RED}FAILED${NC}"
fi

echo "Tests completed!"
