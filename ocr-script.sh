#!/bin/bash
# ocr-script.sh
# 
# Usage:
#  Set this file as the post-processing script in the simple-scan preferences. No extra arguments needed.
#  Any postprocessing script arguments entered in the preferences will be passed along to ocrmypdf, for
#  example, add -l=eng+spa to recognize English and Spanish text.
# 
# Requirements:
# - simple-scan
# - ocrmypdf
# - tesseract, tesseract-eng
# 
# For reference, at the time of writing the arguments from simple-scan are:
# $1    - the mime type, eg application/pdf
# $2    - whether or not to keep a copy of the original file
# $3    - the filename
# $4..N - postprocessing script arguments entered in preferences

filename=$3
keep_original=$2
ocr_filename="${filename%\.*}.ocr.${filename##*\.}"

mv "$filename" "$ocr_filename"

#/usr/bin/ocrmypdf --deskew --clean --force-ocr -l eng "${@:4}" "$filename" "${ocr_filename}" &>> /tmp/ocr.log
/usr/bin/ocrmypdf -l eng "${ocr_filename}" "$filename" &>> /tmp/ocr.log

rm -f "$ocr_filename"

#if [ $? -ne 0 ]; then
#  notify-send -i scanner "OCR Failed" "See /tmp/ocr.log"
#  exit 1
#fi

#notify-send -i scanner "OCR Complete" "$extra_msg_details"
