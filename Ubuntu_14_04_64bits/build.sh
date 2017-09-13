count_x_files()
{
    COUNT=$(git status --porcelain | grep -v "/patch/" | grep $1 | wc -l)
    echo $COUNT # return $COUNT
}

IMAGE="eurecom-s3/avatar-14"

docker build -t $IMAGE . || (echo "[!] ERROR: docker build. exit" ; exit)
echo "[*] DONE: docker build"

if [ $(count_x_files "MM") -ne "0" ]; then
    echo "[!] There's not staged changes. git add it now"; exit
fi
if [ $(count_x_files "??") -ne "0" ]; then
    echo "[!] There's untracked patch files. git add it now"; exit
fi
docker tag $IMAGE $IMAGE:$(git rev-parse --short HEAD)
echo "[*] DONE: docker tag"
