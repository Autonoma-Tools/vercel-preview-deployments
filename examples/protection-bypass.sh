#!/usr/bin/env bash
#
# Verifies Vercel Deployment Protection bypass is wired up correctly.
#
# Usage:
#   PREVIEW_URL=https://your-preview.vercel.app \
#   VERCEL_BYPASS_SECRET=xxx \
#   ./examples/protection-bypass.sh
#
set -euo pipefail

if [[ -z "${PREVIEW_URL:-}" ]]; then
  echo "error: PREVIEW_URL is not set" >&2
  echo "hint:  export PREVIEW_URL=https://your-preview-deployment.vercel.app" >&2
  exit 1
fi

if [[ -z "${VERCEL_BYPASS_SECRET:-}" ]]; then
  echo "error: VERCEL_BYPASS_SECRET is not set" >&2
  echo "hint:  export VERCEL_BYPASS_SECRET=your-vercel-bypass-secret" >&2
  exit 1
fi

status_code=$(curl -sS -o /dev/null -w '%{http_code}\n' \
  -H "x-vercel-protection-bypass: ${VERCEL_BYPASS_SECRET}" \
  "${PREVIEW_URL}")

echo "HTTP ${status_code}  ${PREVIEW_URL}"

case "${status_code}" in
  200|301|302|304)
    echo "OK: bypass header accepted — Playwright/CI will reach the preview."
    ;;
  401|403)
    echo "FAIL: the bypass secret is wrong or Deployment Protection is not configured to accept it."
    echo "      Check Vercel Project Settings -> Deployment Protection -> Protection Bypass for Automation."
    exit 2
    ;;
  404)
    echo "FAIL: the preview deployment has been torn down (or the URL is wrong)."
    exit 3
    ;;
  *)
    echo "WARN: unexpected status — verify the preview is healthy and the URL is correct."
    exit 4
    ;;
esac
