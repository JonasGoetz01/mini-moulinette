source "$(dirname "${BASH_SOURCE[0]}")"/mini-moul/config.sh

run_norminette()
{
    if command -v norminette &> /dev/null; then
        norminette `pwd`
    else
        echo "norminette not found, skipping norminette checks"
    fi
}

function handle_sigint {
  echo "${RED}Script aborted by user. Cleaning up..."
  rm -R ../mini-moul
  echo ""
  echo "${GREEN}Cleaning process done.${DEFAULT}"
  exit 1
}

if [[ "$#" -eq 1 ]]; then
  run_norminette
	cp -R "$(dirname "${BASH_SOURCE[0]}")"/mini-moul mini-moul
  trap handle_sigint SIGINT
	cd mini-moul
  ./test.sh "$1"
  rm -R ../mini-moul
else
  printf "${RED}You need to choose an assignment. e.g: mini C02\n${DEFAULT}"
fi

exit 1