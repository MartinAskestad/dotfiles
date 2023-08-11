@ECHO OFF

DOSKEY ls=dir /B $*
DOSKEY type=bat $*
DOSKEY dot=git --git-dir=%userprofile%\.dotfiles --work-tree=%userprofile% $*
