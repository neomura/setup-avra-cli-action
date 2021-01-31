set -e

# Unfortunately, the GitHub Actions Marketplace strips out all Git details
# (including submodules) on publish, so we have to re-clone our own repository
# to get the AVRA submodule we plan to build.

mkdir clone
cd clone

git init
git remote add origin https://github.com/$NEOMURA_SETUP_AVRA_CLI_ACTION_REPOSITORY
git fetch origin $NEOMURA_SETUP_AVRA_CLI_ACTION_REF:temp
git checkout temp

git submodule update --init --recursive --depth 1 submodules/Ro5bert/avra

cd submodules
cd Ro5bert
cd avra

if [ "$(uname)" == "Darwin" ]; then
  make install OS=osx
  make check OS=osx
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  sudo make install
  make check
else
  rm -rf c:/neomura-setup-avra-cli-action
  mkdir -p c:/neomura-setup-avra-cli-action

  cp -r ./includes c:/neomura-setup-avra-cli-action

  make OS=mingw32 CC=x86_64-w64-mingw32-gcc.exe TARGET_INCLUDE_PATH=c:/neomura-setup-avra-cli-action/includes
  cp ./src/avra.exe c:/neomura-setup-avra-cli-action/avra.exe
  echo "c:/neomura-setup-avra-cli-action" >> $GITHUB_PATH

  make check OS=mingw32 CC=x86_64-w64-mingw32-gcc.exe TARGET_INCLUDE_PATH=c:/neomura-setup-avra-cli-action/includes
fi
