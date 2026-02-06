#!/bin/bash

SERVICE="${1:?Usage: $0 <service-name>}"

echo "État: $(systemctl is-active "$SERVICE")"
echo "PID: $(systemctl show "$SERVICE" -p MainPID --value)"
echo "Uptime: $(systemctl show "$SERVICE" -p ActiveEnterTimestamp --value)"
echo "Mémoire: $(systemctl show "$SERVICE" -p MemoryCurrent --value)"

echo ""
echo "=== 10 derniers logs ==="
journalctl -u "$SERVICE" -n 10 --no-pager
