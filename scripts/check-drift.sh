#!/bin/bash
set -e

echo "=== Checking Homebrew packages drift ==="
installed_brew=$(brew list --formula | sort)
configured_brew=$(grep -A 30 'homebrew_packages:' mac-setup.yml | grep '^\s*-' | sed 's/.*- //' | sort)
echo "Missing from config:"
comm -23 <(echo "$installed_brew") <(echo "$configured_brew") | grep -v '^$' || echo "None"

echo -e "\n=== Checking Homebrew casks drift ==="
installed_cask=$(brew list --cask | sort)
configured_cask=$(grep -A 10 'homebrew_cask_packages:' mac-setup.yml | grep '^\s*-' | sed 's/.*- //' | sort)
echo "Missing from config:"
comm -23 <(echo "$installed_cask") <(echo "$configured_cask") | grep -v '^$' || echo "None"

echo -e "\n=== Checking VSCode extensions drift ==="
installed_ext=$(code --list-extensions | sort)
configured_ext=$(grep -A 20 'vscode_extensions:' mac-setup.yml | grep '^\s*-' | sed 's/.*- //' | sort)
echo "Missing from config:"
comm -23 <(echo "$installed_ext") <(echo "$configured_ext") | grep -v '^$' || echo "None"
