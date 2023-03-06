#!/usr/bin/env zsh
#
# setopt.zsh
#
# Copyright (C) 2023 conor-sometimes <conor dot d dot mcshane at gmail dot com>
#
# Distributed under terms of the GPLv3 license.

setopt AUTO_CD              # type in directory name, it cds to it
setopt AUTO_REMOVE_SLASH    # removes / at the end of paths
setopt EXTENDED_GLOB        # more powerful globbing
setopt PROMPT_SUBST         # parameter expansion, command substitution and arithmetic expansion are performed in prompts
setopt ALWAYS_TO_END        # full completions move cursor to the end
setopt COMPLETE_IN_WORD     # complete from the cursor rather than from the end of the word
unsetopt CORRECT_ALL        # Try to correct the spelling of all arguments in a line.
setopt NOCLOBBER            # stops me accidentally overwriting existing files
setopt CORRECT              # enables spelling correction (sl -> ls)
setopt GLOBDOTS             # lets files beginning with a dot to be matched with wildcards without specifying the dot
setopt COMPLETE_ALIASES     # autocompletion of command line switches for aliases
setopt INTERACTIVECOMMENTS  # allows me to comment in the typical bash way (pound sign then text)

# setopt MENU_COMPLETE
