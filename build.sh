set -e

# Unfortunately, the GitHub Actions Marketplace strips out all Git details
# (including submodules) on publish, so we have to re-clone our own repository
# to get the avra submodule we plan to build.

NEOMURA_SETUP_AVRA_CLI_ACTION_BRANCH=${NEOMURA_SETUP_AVRA_CLI_ACTION_REF#refs/heads/}
NEOMURA_SETUP_AVRA_CLI_ACTION_BRANCH=${NEOMURA_SETUP_AVRA_CLI_ACTION_BRANCH#refs/tags/}

git clone https://github.com/$NEOMURA_SETUP_AVRA_CLI_ACTION_REPOSITORY --branch $NEOMURA_SETUP_AVRA_CLI_ACTION_BRANCH --depth 1 clone

cd clone
git submodule update --init --recursive submodules/Ro5bert/avra

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
  make OS=mingw32 CC=x86_64-w64-mingw32-gcc.exe
  rm -rf ./bin
  mkdir -p ./bin
  cp ./src/avra.exe ./bin/avra.exe
  echo "$PWD/bin" >> $GITHUB_PATH

  #make check OS=mingw32
fi
