SHELL 		:= 	/bin/bash
CANDIDATES	:=	$(sort $(dir $(wildcard */)))
EXCLUSIONS	:=	.git .gitignore .travis.yml .gitmodules .stow-global-ignore setup/ 
DOTFILES	:=	$(filter-out $(EXCLUSIONS), $(CANDIDATES))

.DEFAULT_GOAL := help

all:

list: ## Show dotfiles available for installation
	@$(foreach val, $(DOTFILES), /bin/ls -d $(val);)

status:
	. ./setup/config.sh && . ./setup/status.sh; get_dotfile_setup_status

dependencies:
	./setup/dependencies.sh

submodules:
	git submodule update --init

vim-plugins:
	vim +PlugInstall

stow:

install: dependencies submodules stow vim-plugins link-bin mac

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
	