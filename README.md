# shell script
---

## "cleaning-remote-repo-script.sh"
- Clean GitHub Remote repo (dangerous script).
### How to use (in Bash or POSIX Compliant Shells)
- copy GitHub remote repo link which you want to clear everything (also delete every git commit).
- open script and set 2 variables
  - target_link
  - target_dir_name
- in bash terminal type command `chmod u+x cleaning-remote-repo-script.sh`
- right click file then click "Run as a program"
- program will clean everything in that remote repo.
---

## "createViteReactJsScript.sh"
- set project-name and run. This script will create Vite React JS app for you.
### How to use (in Bash or POSIX Compliant Shells)
- in bash terminal type command `chmod u+x createViteReactJsScript.sh`
- right click file then click "Run as a program"
- program will create vite react js app project for you.
---
## "gh-clone-prod-to-sandbox-env-script.sh"
- Clone FROM: GitHub Remote repo TO: Sandbox env script
### How to use (in Bash or POSIX Compliant Shells)
- copy GitHub remote repo (prod) link
- copy GitHub remote repo (sandbox) link; if don't have, then create new one.
- open script and set 4 variables
  - template_link
  - sandbox_link
  - template_dir_name
  - sandbox_dir_name
- in bash terminal type command `chmod u+x clone-gh-prod-to-sandbox-env-script.sh`
- right click file then click "Run as a program"
- program will set new remote origin of sandbox repo & clone sandbox remote repo to local repo.
---
