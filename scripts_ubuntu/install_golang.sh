sudo apt install ubuntu-make
umake go
echo "Now remember to set your enviroments"
echo "
export GOROOT=/home/cassiobotaro/.local/share/umake/go/go-lang
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
"
