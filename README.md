# sorbet-linux-aarch64-binaries
A docker container for compiling sorbet for use in docker on apple silicon. 


## build command

`docker build --build-arg VERSION="0.5.10993" . --tag alexchesser/sorbet-linux-aarch64-binaries:0.5.10993`

or prevent yucky typos with:

`VERSION=0.5.10993;docker build --build-arg VERSION="${VERSION}" . --tag alexchesser/sorbet-linux-aarch64-binaries:${VERSION}`

## push command

`docker push alexchesser/sorbet-linux-aarch64-binaries:0.5.10902`


# build and push without typo-risk

```
VERSION=0.5.10993;\
docker build --build-arg VERSION="${VERSION}" . --tag alexchesser/sorbet-linux-aarch64-binaries:${VERSION};\
docker push alexchesser/sorbet-linux-aarch64-binaries:${VERSION}
```



## USE in a project... 

TBD!  (please halp! I think you can just copy the gem into your local project somewhere, maybe a vendor file? need to figur ethis out)