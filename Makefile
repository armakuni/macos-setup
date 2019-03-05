.DEFAULT_GOAL := show-help
ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
.PHONY: show-help
# See <https://gist.github.com/klmr/575726c7e05d8780505a> for explanation.
## This help screen
show-help:
	@echo "$$(tput bold)Available rules:$$(tput sgr0)";echo;sed -ne"/^## /{h;s/.*//;:d" -e"H;n;s/^## //;td" -e"s/:.*//;G;s/\\n## /---/;s/\\n/ /g;p;}" ${MAKEFILE_LIST}|LC_ALL='C' sort -f|awk -F --- -v n=$$(tput cols) -v i=19 -v a="$$(tput setaf 6)" -v z="$$(tput sgr0)" '{printf"%s%*s%s ",a,-i,$$1,z;m=split($$2,w," ");l=n-i;for(j=1;j<=m;j++){l-=length(w[j])+1;if(l<= 0){l=n-i-length(w[j])-1;printf"\n%*s ",-i," ";}printf"%s ",w[j];}printf"\n";}'

.PHONY: install-packages
## Install or update all the packages in the brewfile
install-packages:
	"$(ROOT_DIR)/brew/bin/install"
	"$(ROOT_DIR)/brew/bin/bundle-install"

.PHONY: configure-git
## Copy git config
configure-git: install-packages
	"$(ROOT_DIR)/git/bin/copy"
	"$(ROOT_DIR)/git/bin/install-hook"

.PHONY: reinitialize-git-repositories
## Configure all existing git repositories with hooks from templates
reinitialize-git-repositories: install-packages configure-git configure-git-duet
	"$(ROOT_DIR)/git/bin/reinitialize-git-repositories"

.PHONY: configure-git-duet
## Link git-duet config and install git hooks
configure-git-duet: install-packages configure-git
	"$(ROOT_DIR)/git-duet/bin/link"
	"$(ROOT_DIR)/git-duet/bin/install-hooks"

.PHONY: configure-vim
## Link vim config
configure-vim: install-packages
	"$(ROOT_DIR)/vim/bin/link"

.PHONY: configure-gnupg
## Link gnupg config
configure-gnupg: install-packages
	"$(ROOT_DIR)/gnupg/bin/link"

.PHONY: setup
## Install and setup all a workstation
setup: install-packages configure-vim configure-gnupg configure-git configure-git-duet

.PHONY: lint
## Lint everything
lint: lint-shell

.PHONY: lint-shell
## Lint shell scripts
lint-shell: install-packages
	shfmt -f "$(ROOT_DIR)" | xargs shellcheck
	shfmt -d "$(ROOT_DIR)"

.PHONY: format-shell
## Format shell scripts
format-shell: install-packages
	shfmt -w -s "$(ROOT_DIR)"
