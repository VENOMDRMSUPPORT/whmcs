#!/bin/bash
# Login/Reset Final Audit — Automated Test Script
# Run from project root: bash docs/scripts/login-reset-audit-test.sh
# Base URL: change if different (http vs https, domain)
BASE_URL="${VENOM_AUDIT_URL:-https://venom-drm.test}"
COOKIES="/tmp/venom_audit_cookies_$$.txt"
PASS=0
FAIL=0

run_test() {
  local name="$1"
  local cmd="$2"
  local expect="$3"
  echo -n "  $name ... "
  result=$(eval "$cmd" 2>/dev/null)
  if echo "$result" | grep -qi "$expect"; then
    echo "PASS"
    ((PASS++))
    return 0
  else
    echo "FAIL (expected: $expect)"
    ((FAIL++))
    return 1
  fi
}

echo "=== Login/Reset Final Audit — Automated Checks ==="
echo "Base URL: $BASE_URL"
echo ""

# 4) CSRF — missing token must be rejected
echo "[4] CSRF — POST without token must be rejected"
run_test "CSRF reject" \
  "curl -sk -X POST \"$BASE_URL/index.php?rp=/login\" -d 'username=test@test.com&password=test' -o /tmp/csrf_out.html -w '%{http_code}' && grep -o 'Invalid CSRF Protection Token' /tmp/csrf_out.html" \
  "Invalid CSRF Protection Token"
echo ""

# 5) Failed login — standard error, no crash
echo "[5] Failed login — wrong credentials, no crash"
run_test "Failed login 200" \
  "curl -sk -c $COOKIES -b $COOKIES -X POST \"$BASE_URL/index.php?rp=/login\" -d 'username=invalid@x.com&password=wrong' -o /tmp/fail_login.html -w '%{http_code}'" \
  "200"
run_test "Login page still shown" \
  "grep -o 'venom-login-page\|Login - VENOM' /tmp/fail_login.html | head -1" \
  "venom-login-page\|Login"
echo ""

# 8) Routes work
echo "[8] Routes — login and reset pages load"
run_test "Login page loads" \
  "curl -sk -o /dev/null -w '%{http_code}' \"$BASE_URL/index.php?rp=/login\"" \
  "200"
run_test "Reset page loads" \
  "curl -sk -o /dev/null -w '%{http_code}' \"$BASE_URL/index.php?rp=/password/reset\"" \
  "200"
echo ""

# Form invariants in rendered HTML
echo "[Invariants] Form fields present in rendered HTML"
run_test "Login: username field" \
  "curl -sk \"$BASE_URL/index.php?rp=/login\" | grep -o 'name=\"username\"'" \
  "name=\"username\""
run_test "Login: password field" \
  "curl -sk \"$BASE_URL/index.php?rp=/login\" | grep -o 'name=\"password\"'" \
  "name=\"password\""
run_test "Login: rememberme field" \
  "curl -sk \"$BASE_URL/index.php?rp=/login\" | grep -o 'name=\"rememberme\"'" \
  "name=\"rememberme\""
run_test "Reset: email field" \
  "curl -sk \"$BASE_URL/index.php?rp=/password/reset\" | grep -o 'name=\"email\"'" \
  "name=\"email\""
run_test "Token in form" \
  "curl -sk \"$BASE_URL/index.php?rp=/login\" | grep -o 'name=\"token\"'" \
  "name=\"token\""
echo ""

# Cleanup
rm -f "$COOKIES"

echo "=== Summary ==="
echo "PASS: $PASS | FAIL: $FAIL"
if [ "$FAIL" -eq 0 ]; then
  echo "All automated checks PASS."
  exit 0
else
  echo "Some checks FAILED. Review output above."
  exit 1
fi
