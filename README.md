# sorbet-linux-aarch64-binaries
A docker container for compiling sorbet for use in docker on apple silicon. 


## build command

`docker build --build-arg SORBET_RELEASE_ARG="0.5.10902.20230703175300-14469345b" . --tag alexchesser/sorbet-linux-aarch64-binaries:0.5.10902`

## push command

`docker push alexchesser/sorbet-linux-aarch64-binaries:0.5.10902`

## USE in a project... 

TBD!  (please halp! I think you can just copy the gem into your local project somewhere, maybe a vendor file? need to figur ethis out)