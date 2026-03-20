# ansible-create-laptop

Automated macOS laptop setup using Ansible. Install development tools, applications, and configure my Mac environment in one command.

## Overview

This project uses Ansible to automate the installation of essential development tools, CLIs, and GUI applications on macOS. It ensures my laptop setup is reproducible, version-controlled, and easy to maintain.

**What gets installed:**
- **Homebrew** package manager and CLI tools (git, awscli, tfenv, kubectl, helm, docker, and more)
- **GUI applications** (Visual Studio Code, iTerm2, Firefox, Lens)
- **macOS App Store apps** (Amphetamine, and more)
- Sets computer name to `midas-macbook`

## Prerequisites

- macOS (Apple Silicon or Intel)
- Ansible installed: `brew install ansible` or `pip install ansible`
- Sudo access (required for some installation tasks)

## Quick Start

### 1. Clone the repository
```bash
git clone https://github.com/midasf/ansible-create-laptop.git
cd ansible-create-laptop
```

### 2. Run the playbook
```bash
ansible-playbook mac-setup.yml --ask-become-pass
```

The `--ask-become-pass` flag prompts for your sudo password, which is needed for some installation tasks.

## Customization

### Add/Remove Homebrew CLI packages
Edit `mac-setup.yml` and modify the `homebrew_packages` list:
```yaml
homebrew_packages:
  - git
  - awscli
  - your-new-package
```

### Add/Remove Homebrew Cask (GUI) apps
Edit the `homebrew_cask_packages` list:
```yaml
homebrew_cask_packages:
  - visual-studio-code
  - your-new-app
```

### Add/Remove App Store apps
Edit the `mas_apps` list with app ID and name:
```yaml
mas_apps:
  - { id: 937984704, name: "Amphetamine" }
  - { id: 123456789, name: "Your App" }
```

### Change computer name
Update the `computer_name` variable to customize your Mac's hostname.

## Scripts

### check-drift.sh
Detects drift between installed packages and your Ansible configuration.

```bash
./scripts/check-drift.sh
```

This script compares:
- Installed Homebrew formulas vs configured packages
- Installed Homebrew Casks vs configured apps
- Installed VSCode extensions vs configured extensions

Useful for identifying manual installations that aren't tracked in the playbook.

## Troubleshooting

**Homebrew not found:** Ensure Homebrew is installed or the playbook will install it automatically on first run.

**Permission denied:** Make sure to use `--ask-become-pass` flag when running the playbook.

**macOS App Store apps fail:** You may need to sign into the App Store first before running the playbook.
