#! /bin/sh

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Initialize our own variables:
output_file=""
force=0
extensions=0

while getopts ":" opt; do
    case "$opt" in
    f) force=1
        ;;
    e) extensions=1
        ;;
    esac
done

shift $((OPTIND-1))

[ "${1:-}" = "--" ] && shift


if [ force = 1 ]; then
  sudo ansible-galaxy install -r ./requirements.yml --force
else
  sudo ansible-galaxy install -r ./requirements.yml
fi

sudo ansible-playbook playbook.yml --connection=local

if [ extensions = 1 ]; then
  echo "Cloning VsCode Extensions"
  git clone https://github.com/esdc-devx/vscode

  echo "Backing up existing extensions"
  code --list-extensions | sort -o vscode.bak.ext

  echo "Installing extensions"
  ./vscode/install.sh  ./vscode/vscode.ext
fi