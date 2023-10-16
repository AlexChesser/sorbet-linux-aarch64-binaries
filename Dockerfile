# this is a build of the https://github.com/sorbet/sorbet-build-image.git repo.
FROM alexchesser/sorbet-build-image as BUILD

ENV SORBET_RELEASE=0.5.11073.20231013130737-0f0f4b938
RUN git clone --depth 1 https://github.com/sorbet/sorbet.git --tags ${SORBET_RELEASE} --single-branch
WORKDIR ${SORBET_RELEASE}

# When building on  an apple silicon mac we need to strip the sandybridge (intel) architecture
RUN bash -c "sed '/--copt=-march=sandybridge/d' .bazelrc > .bazelrc_2" && \
    mv .bazelrc_2 .bazelrc
RUN ./.buildkite/build-static-release.sh
RUN mv _out_/gems /gems
WORKDIR /gems

# this strips out everything but the binaries from the build container 
# so consumers don't need to download an 8+GB image :) 
FROM alpine
COPY --from=BUILD /gems /gems
WORKDIR /gems