```bash
$ sudo docker pull syui/docker-arch
$ sudo docker run -it syui/docker-arch /bin/bash
```

## Step 1

```bash
$ systemctl start docker
$ pacman -Sy expect arch-install-scripts --noconfirm
$ curl -sLO https://raw.githubusercontent.com/docker/docker/master/contrib/mkimage-arch-pacman.conf -O https://raw.githubusercontent.com/docker/docker/master/contrib/mkimage-arch.sh -O https://github.com/docker/docker/blob/master/contrib/mkimage-archarm-pacman.conf 
$ chmod +x mkimage-arch.sh
$ vim mkimage-arch.sh
DOCKER_IMAGE_NAME=$USER/$REPO

$ ./mkimage-arch.sh

$ docker run -it $USER/$REPO /bin/bash
# :
# pacman -Sy archlinux-keyring --noconfirm
# pacman-key --refresh-keys
# pacman -Sy --noconfirm
# pacman-db-upgrade
# trust extract-compat
# exit

$ docker push $USER/$REPO
```

## Step 2

update : travis-ci($USER/$REPO) -> cron jobs -> d1

> .travis.yml

```bash
language: $LANG
sudo: required
services:
  - docker

env:
  - TARGET_CONTAINER_ID=container-$REPO


script:
  - docker build -t $USER/$REPO .

after_success:
  - if [ "$TRAVIS_BRANCH" == "master" ]; then
        docker login -e="$DOCKER_EMAIL" -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD";
        docker push $USER/$REPO;
    fi
```

## Other

```bash
$ ./mkimage-arch.sh
```

```bash
$ docker save $USER/$REPO > archlinux.tar.gz
$ tar -c . | docker import - $USER/$REPO
$ docker run -it $USER/$REPO /bin/bash
# :
# pacman -Sy archlinux-keyring --noconfirm
# pacman-key --refresh-keys
# pacman -Sy --noconfirm
# pacman-db-upgrade
# trust extract-compat
# exit

$ docker push $USER/$REPO
```

or 

> Dockerfile

```base
FROM scratch
ADD archlinux.tar.gz /
```

```bash
$ docker build -t $USER/$REPO .
$ docker run -it $USER/$REPO /bin/bash
# :
# pacman -Sy archlinux-keyring --noconfirm
# pacman-key --refresh-keys
# pacman -Sy --noconfirm
# pacman-db-upgrade
# trust extract-compat
# exit

$ docker psuh $USER/$REPO
```
