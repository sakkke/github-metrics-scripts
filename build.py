#!/usr/bin/env python

import glob
import os
import pandas as pd
from pathlib import Path

output_file = 'metrics.xlsx'

if os.path.exists(output_file):
    os.remove(output_file)

csv_files = glob.glob('*.csv')

with pd.ExcelWriter(output_file) as writer:
    for file in csv_files:
        sheet = pd.read_csv(file)
        stem = Path(file).stem
        tokens = stem.split('-')
        sheet_name = '-'.join(map(lambda token: token[:3], tokens))
        sheet.to_excel(writer, sheet_name=sheet_name, index=False)
