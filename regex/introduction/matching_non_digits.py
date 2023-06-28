"""
You have a test string S. Your task is to match the pattern xxXxxXxxxxX
Here x denotes a digit character, and X denotes a non-digit character.
"""

Regex_Pattern = r"\d{2}\D\d{2}\D\d{4}"	# Do not delete 'r'.

import re

print(str(bool(re.search(Regex_Pattern, input()))).lower())