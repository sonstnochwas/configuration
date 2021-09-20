# fedora powerline configuration ([here](https://fedoramagazine.org/add-power-terminal-powerline/))

## packages

```bash
sudo dnf install \
  powerline \
  powerline-fonts \
  tmux \
  tmux-powerline \
  vim \
  vim-powerline
```

## configure bash

**Enable powerline** (add to `~/.bashrc`):
```bash
if [ -f `which powerline-daemon` ]; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  . /usr/share/powerline/bash/powerline.sh
fi
```

## configure tmux

**Enable powerline** (add to `~/.tmux.conf`):

```bash
source "/usr/share/tmux/powerline.conf"
```

**Start tmux with shell** (add to `~/.bashrc`):

```bash
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi
```

## configure vim

**Enable powerlin** (add to `~/.vimrc`):

```bash
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always  display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set t_Co=256
```
