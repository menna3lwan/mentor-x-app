#!/bin/bash

BASE_URL="http://98.94.45.209:8081"
TOKEN="eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiU1RVREVOVCIsInBob25lIjoiMDEyMDEyNTA3MDYiLCJzZXNzaW9uSWQiOiI4NjE1MTQ2MS0wNGFjLTQ1MTktOGI2ZC01YmIyMzFkNWI0YjQiLCJ0b2tlblR5cGUiOiJBQ0NFU1MiLCJ1c2VySWQiOjMyLCJkZXZpY2VJZCI6ImJjYWMyODM4ZmYzM2E1YmZhZTA2ZTZiYTM3YTA3MmU4MGVmYzgxOWFkOWM1MGZlNDkwYmU2MzgwNzdlOGZhNGYiLCJzdWIiOiIwMTIwMTI1MDcwNiIsImlhdCI6MTc3ODQzMDQxOCwiZXhwIjoxNzc4NDMyMjE4fQ.2oSlJBAOugKsGUBgjRflONZAwcmT2qF45h1VpqltovE"
DEVICE_ID="bcac2838ff33a5bfae06e6ba37a072e80efc819ad9c50fe490be638077e8fa4f"
OUTPUT_FILE="api_responses_audit.json"

echo "{" > $OUTPUT_FILE

endpoints=(
    "/api/student/profile"
    "/api/banners/active"
    "/api/announcements"
    "/api/courses"
    "/api/grades/my"
    "/api/attendance/my"
    "/api/assignments/my"
    "/api/quizzes"
    "/api/notifications/my"
    "/api/payment/wallet/balance"
    "/api/wallet/my/transactions"
    "/api/enrollments/my-enrollments"
    "/api/leaderboard/global"
    "/api/auth/session-status"
)

for i in "${!endpoints[@]}"; do
    endpoint="${endpoints[$i]}"
    echo "Testing $endpoint..."
    
    response=$(curl -s -X GET "$BASE_URL$endpoint" \
         -H "Authorization: Bearer $TOKEN" \
         -H "X-Device-Id: $DEVICE_ID")
    
    echo "  \"$endpoint\": $response" >> $OUTPUT_FILE
    
    if [ $i -lt $((${#endpoints[@]} - 1)) ]; then
        echo "," >> $OUTPUT_FILE
    fi
done

echo "}" >> $OUTPUT_FILE

echo "Audit complete. Results saved to $OUTPUT_FILE"
