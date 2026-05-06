#!/bin/bash

TOKEN="eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiU1RVREVOVCIsInBob25lIjoiMDExOTI3ODk4OTAiLCJzZXNzaW9uSWQiOiI2Njg2ZjY3Ni01MjY3LTQzNTEtYTgwYy0wYWMzNzIxZjQwZjgiLCJ0b2tlblR5cGUiOiJBQ0NFU1MiLCJ1c2VySWQiOjQsImRldmljZUlkIjoiMDRiYzFlMjkzOTU0NzM2ZDc4NTgxZWRkMWRmZGI1YmRkZjQ3ZTI0MmFkZDYxYzVjNWJjZmYwNDYyYjU4M2UyYiIsInN1YiI6IjAxMTkyNzg5ODkwIiwiaWF0IjoxNzc4MDExNjk3LCJleHAiOjE3NzgwMTM0OTd9.WXQTeLWaGq_EQwWwfNWTWZrv--RijlUGNvr-3SZNezk"
BASE_URL="http://98.94.45.209:8081"
DEVICE_ID="04bc1e293954736d78581edd1dfdb5bddf47e242add61c5c5bcff0462b583e2b"

echo "=== Testing Announcements (Base) ==="
curl -s -X GET "$BASE_URL/api/announcements" \
     -H "Authorization: Bearer $TOKEN" \
     -H "X-Device-Id: $DEVICE_ID" \
     -H "Content-Type: application/json" | jq .
