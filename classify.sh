#!/bin/bash

# This AWK script loads threatlist.txt into a map,
# then scans firewall.log and prints classification results.

awk '
    # First file (threatlist.txt): build map[IP] = THREAT
    NR==FNR {
        map[$1] = $2
        next
    }

    # For second file (firewall.log): print header once
    FNR==1 {
        print "LINE ACTION TIME SRC-IP DEST-IP THREAT"
    }

    {
        # Lookup threat for source IP ($3)
        t = map[$3]

        # Default to UNKNOWN if not found
        if (t == "")
            t = "UNKNOWN"

        # Print: line#, action, time, src, dest, threat
        print FNR, $1, $2, $3, $4, t
    }
' "$1" "$2"
