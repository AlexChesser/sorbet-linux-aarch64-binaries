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

This docker file will successfully install sorbet 


```
ARG RUBY_VERSION=3.2
ARG SORBET_VERSION=0.5.10993
ARG BUNDLE_RUBYGEMS__PKG__GITHUB__COM
FROM alexchesser/sorbet-linux-aarch64-binaries:${SORBET_VERSION} as sorbet-binaries
FROM mcr.microsoft.com/vscode/devcontainers/ruby:${RUBY_VERSION}  as base

COPY --from=sorb './dist' '/sorbet'
WORKDIR /app
RUN chown vscode -hR /app /sorbet /usr/local/rvm /usr/local/bin/gem /usr/local/lib/ruby
RUN gem update --system
RUN gem install --source file:///sorbet/ sorbet:0.5.10993
```

Alternatively you can copy the gems into your project `vendor/cache` and run `bundle install --prefer-local` the specific gems you'll want to copy the files like this.

`COPY --from=sorbet-binaries './dist/gems' './vendor/cache'`

This is propably preferable since you won't need to tag a specific version in your dockerfile
