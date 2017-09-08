{ writeText, zsh-prezto, neovim, less }:

let
  self = writeText "zsh-config"
    ''
      #
      # Sets Prezto options.
      #
      # Authors:
      #   Sorin Ionescu <sorin.ionescu@gmail.com>
      #

      #
      # General
      #

      # Color output (auto set to 'no' on dumb terminals).
      zstyle ':prezto:*:*' color 'yes'

      # Set the Zsh modules to load (man zshmodules).
      # zstyle ':prezto:load' zmodule 'attr' 'stat'

      # Set the Zsh functions to load (man zshcontrib).
      # zstyle ':prezto:load' zfunction 'zargs' 'zmv'

      # Set the Prezto modules to load (browse modules).
      # The order matters.
      zstyle ':prezto:load' pmodule \
        'environment' \
        'editor' \
        'history' \
        'spectrum' \
        'utility' \
        'completion' \
        'git' \
        'syntax-highlighting' \
        'history-substring-search' \
        'ssh' \
        'prompt' \
        'tmux' \
        'ruby' \
        'rsync' \
        'node' \
        'fasd' \
        'pacman' \
        'rsync'

      #
      # Editor
      #

      # Set the key mapping style to 'emacs' or 'vi'.
      # zstyle ':prezto:module:editor' key-bindings 'emacs'

      # Auto convert .... to ../..
      zstyle ':prezto:module:editor' dot-expansion 'yes'

      #
      # Git
      #

      # Ignore submodules when they are 'dirty', 'untracked', 'all', or 'none'.
      # zstyle ':prezto:module:git:status:ignore' submodules 'all'

      #
      # GNU Utility
      #

      # Set the command prefix on non-GNU systems.
      # zstyle ':prezto:module:gnu-utility' prefix 'g'

      #
      # History Substring Search
      #

      # Set the prompt theme to load.
      # Setting it to 'random' loads a random theme.
      # Auto set to 'off' on dumb terminals.
      zstyle ':prezto:module:prompt' theme 'sorin'

      #
      # Screen
      #

      # Auto start a session when Zsh is launched in a local terminal.
      # zstyle ':prezto:module:screen:auto-start' local 'yes'

      # Auto start a session when Zsh is launched in a SSH connection.
      # zstyle ':prezto:module:screen:auto-start' remote 'yes'

      #
      # SSH
      #

      # Set the SSH identities to load into the agent.
      zstyle ':prezto:module:ssh:load' identities 'id_rsa' 'id_ed25519'

      #
      # Syntax Highlighting
      #

      # Set syntax highlighters.
      # By default, only the main highlighter is enabled.
      zstyle ':prezto:module:syntax-highlighting' highlighters \
        'main' \
        'brackets' \
        'pattern' \
        'root'
      #
      # Set syntax highlighting styles.
      # zstyle ':prezto:module:syntax-highlighting' styles \
      #   'builtin' 'bg=blue' \
      #   'command' 'bg=blue' \
      #   'function' 'bg=blue'

      #
      # Terminal
      #

      # Auto set the tab and window titles.
      # zstyle ':prezto:module:terminal' auto-title 'yes'

      # Set the window title format.
      # zstyle ':prezto:module:terminal:window-title' format '%n@%m: %s'

      # Set the tab title format.
      # zstyle ':prezto:module:terminal:tab-title' format '%m: %s'

      #
      # Tmux
      #

      # Auto start a session when Zsh is launched in a local terminal.
      # zstyle ':prezto:module:tmux:auto-start' local 'yes'

      # Auto start a session when Zsh is launched in a SSH connection.
      zstyle ':prezto:module:tmux:auto-start' remote 'no'

      # Integrate with iTerm2.
      # zstyle ':prezto:module:tmux:iterm' integrate 'yes'

      # Pacman
      zstyle ':prezto:module:pacman' frontend 'yaourt'
      # -------------------------------------------------

      export EDITOR='${neovim}/bin/nvim'
      export VISUAL='${neovim}/bin/nvim'
      export PAGER='${less}/bin/less -R'
      export KEYTIMEOUT=1
    '';
in {
  environmentConfig =
    [ { source = "${zsh-prezto}/runcoms/zlogin";
        target = "zlogin";
      }
      { source = "${zsh-prezto}/runcoms/zlogout";
        target = "zlogout";
      }
      { source = self;
        target = "zpreztorc";
      }
      { source = "${zsh-prezto}/runcoms/zprofile";
        target = "zprofile.local";
      }
      { source = "${zsh-prezto}/runcoms/zshenv";
        target = "zshenv.local";
      }
      { source = "${zsh-prezto}/runcoms/zshrc";
        target = "zshrc.local";
      }
    ];
}
