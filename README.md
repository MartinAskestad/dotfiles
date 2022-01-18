# dot-files

## Clone repo to new machine

- Add the following to your powershell-profile
  ```powershell
  Function Get-GitDotfiles {
  & git --git-dir=$HOME\.dotfiles --work-tree=$HOME $args
  }
  New-Alias -Name dot -Value Get-GitDotfiles -Force -Option AllScope
  ```
  Or this to your `.bashrc`
  ```bash
  alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
  ```
- Clone repo into a [bare](http://www.saintsjd.com/2011/01/what-is-a-bare-git-repository/) repository.
  ```powershell
  git clone https://github.com/MartinAskestad/dotfiles.git --bare $HOME\.dotfiles --recurse-submodules
  ```
- Set the flag `showUntrackedFiles` to no on this specific repo

```powershell
dot config --local status.showUntrackedFiles no
dot checkout
dot submodule init
dot submodule update
```

To use the new repo,

```powershell
dot status
dot add vimfiles\vimrc
dot commit -m "Update vimrc'
dot push
```

## Add git submodules for vim-plugins

To add a submodule

```powershell
dot submodule add --depth 1 <remote_url> <destination_folder>
dot commit -m "Added submodule to project"
dot push
```

## Update all submodules

```powershell
dot submodule update --init --recursive
```

## Remove submodule

```powershell
dot submodule deinit <submodule>
dot rm <submodule>
```
