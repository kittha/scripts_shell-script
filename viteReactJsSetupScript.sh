# first: chmod u+x createViteReactJsScript.sh (set only once)

# second: copy script to destination then run-script

# third ./viteReactJsSetupScript.sh
# input project name
# and this script will create vite react app template for you

echo 'Enter your project name' && read projectname && npm create vite@latest ${projectname} -- --template react &&
cd ${projectname} &&
npm install &&
npm run dev
