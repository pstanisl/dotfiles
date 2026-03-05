# Python 3.14 from Homebrew
export PATH="/opt/homebrew/opt/python@3.14/bin:$PATH"

# Note: No aliases defined - this allows virtual environments to override
# When outside a venv: python resolves to Homebrew's python3.14
# When inside a venv: python resolves to the venv's python
