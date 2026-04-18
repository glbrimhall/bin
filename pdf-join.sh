#!/bin/sh
IN1_PDF="$1"
IN2_PDF="$2"
OUT_PDF="$3"

qpdf --empty \
  --pages \
  "$IN1_PDF" \
  "$IN2_PDF" \
  -- "$OUT_PDF"

