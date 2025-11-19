"""
Input Fortran file is always rewritten, even if there is nothing to modify!
"""
from argparse import ArgumentParser

parser = ArgumentParser()
parser.add_argument("INPUT", type=str, help="Path to the input file")
args = parser.parse_args()

with open(args.INPUT, "r") as f:
    content = f.read()

# Convert printed "HELLO WORLD" messages to lower-case
content = content.replace('"HELLO WORLD"', '"hello world"')

with open(args.INPUT, "w") as f:
    f.write(content)
