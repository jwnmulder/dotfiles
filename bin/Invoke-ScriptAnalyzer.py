#!/usr/bin/env python3

import os
import subprocess
import sys

script_dir = os.path.dirname(__file__)

if os.name == "nt":
    res = subprocess.run(["powershell", f"{script_dir}/Invoke-ScriptAnalyzer.ps1"] + sys.argv[1:])
    sys.exit(res.returncode)
else:
    print("Skipping PSScriptAnalyzer on non Windows environments")
