#!/usr/bin/env python3

import re

# Dictionary to hold user → count mapping
counts = {}

# Read the auth.log file line-by-line
with open("auth.log", "r") as f:
    for line in f:
        # Skip system-generated entries
        if "SYSTEM" in line:
            continue

        # Extract username using regex (letters, digits, underscore)
        m = re.search(r"user=([A-Za-z0-9_]+)", line)
        if m:
            u = m.group(1)
            # Increase count per user
            counts[u] = counts.get(u, 0) + 1

# Write results into CSV file
with open("user_stats.csv", "w") as out:
    for u, c in counts.items():
        out.write(f"{u},{c}\n")
