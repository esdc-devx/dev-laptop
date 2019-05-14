#!/bin/sh
echo "entering"
# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Initialize our own variables:
force=0
extensions=0
skipansible=0
echo "getopts"
while getopts "fes" opt; do
    case "$opt" in
    f) force=1
        ;;
    e) extensions=1
        ;;
    s) skipansible=1
        ;;
    **) ;;
    esac
done

shift $((OPTIND-1))

[ "${1:-}" = "--" ] && shift
echo "skipansible ${skipansible}"
if [ $skipansible = 0 ]; then
  echo "running ansible"
  if [ $force = 1 ]; then
    echo "forcing requirements"
    sudo ansible-galaxy install -r ./requirements.yml --force
  else
    echo "installing requirements"
    sudo ansible-galaxy install -r ./requirements.yml
  fi

  sudo ansible-playbook playbook.yml --connection=local

fi

echo "extensions flag: ${extensions}"
if [ $extensions = 1 ]; then
  echo "Cloning VsCode Extensions"
  git clone https://github.com/esdc-devx/vscode

  echo "Backing up existing extensions"
  code --list-extensions | sort -o vscode.bak.ext

  echo "Installing extensions"
  ./vscode/install.sh  ./vscode/vscode.ext
fi