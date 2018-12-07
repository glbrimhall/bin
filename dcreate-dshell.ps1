#!powershell.exe -File c:\\Users\\gbrimhall\\bin\\dubuntu.ps1

docker run -d --user root -it --entrypoint /bin/bash --restart=always --name dshell -v c:/:/win -w=/root glbrimhall/debslim:editors-stretch 

#       -w=//root \
