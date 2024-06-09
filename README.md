# shell script
---

## "gh_cleaning-remote-repo-script.sh"
- Clean GitHub Remote repo (dangerous script).
### How to use (in Bash or POSIX Compliant Shells)
- copy GitHub remote repo link which you want to clear everything (also delete every git commit).
- open script and set 2 variables
  - target_link
  - target_dir_name
- in bash terminal type command `chmod u+x gh_cleaning-remote-repo-script.sh`
- right click file then click "Run as a program"
- program will clean everything in that remote repo.
---

## "gh_clone-gh-prod-to-sandbox-env-script.sh"
- Clone FROM: GitHub Remote repo TO: Sandbox env script
### How to use (in Bash or POSIX Compliant Shells)
- copy GitHub remote repo (prod) link
- copy GitHub remote repo (sandbox) link; if don't have, then create new one.
- open script and set 4 variables
  - template_link
  - sandbox_link
  - template_dir_name
  - sandbox_dir_name
- in bash terminal type command `chmod u+x gh_clone-gh-prod-to-sandbox-env-script.sh`
- right click file then click "Run as a program"
- program will set new remote origin of sandbox repo & clone sandbox remote repo to local repo.
---

## "react_vite-react-js-setup-script.sh"
- set project-name and run. This script will create Vite React JS app for you.
### How to use (in Bash or POSIX Compliant Shells)
- in bash terminal type command `chmod u+x react_vite-react-js-setup-script.sh`
- right click file then click "Run as a program"
- program will open terminal -> ask for project name (use only lower-case char or kebab case name) -> then script will setup automatically.
---

## "vim_plugin-vim-thai-keys-installer.sh"
- this is just an installer of [Chakrit Wichian](https://github.com/chakrit/vim-thai-keys/tree/master) code
- ### How to use (in Bash or POSIX Compliant Shells)
- in bash terminal type command `vim_plugin-vim-thai-keys-installer.sh`
- right click file then click "Run as a program"
- script will create dir at "~/.vim/plugin/" then create file "vim_plugin-vim-thai-keys-installer.sh" with Chakrit's code.
- done.
---

## "vim_ubuntu-remap-capslock-to-ctrl.sh"
- remap "capslock to ctrl", "capslock to capslock"
- ### How to use (in Bash or POSIX Compliant Shells)
- in bash terminal type command `chmod u+x vim_ubuntu-remap-capslock-to-ctrl.sh`
- right click file then click "Run as a program"
- choose option 1-3
- done
---
