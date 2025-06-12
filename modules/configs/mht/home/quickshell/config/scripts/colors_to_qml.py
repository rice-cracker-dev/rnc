from json import load
from sys import argv
from os.path import dirname, realpath

filepath = f"{dirname(realpath(argv[0]))}/colors.json"
mode = argv[1] if len(argv) > 1 else "dark"

output = """
pragma Singleton
import Quickshell
import QtQuick

Singleton {{
{0}
}}
"""
builder = ""

with open(filepath) as fcolor:
    data = load(fcolor)
    colors: dict[str, str] = data["colors"][mode]

    for name, color in colors.items():
        builder += f'  readonly property color {name}: "{color}"\n'

print(str.format(output, builder))
