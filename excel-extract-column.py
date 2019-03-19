#!/usr/bin/python

import sys
from openpyxl import load_workbook

wb = load_workbook(filename = '/root/Documents/RVTools/chivcenter_vmlist_2018_12_04 (1).xlsx')
sheet_ranges = wb['vInfo']
print(sheet_ranges['A3'].value)


