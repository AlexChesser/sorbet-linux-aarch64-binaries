# this is a build of the https://github.com/sorbet/sorbet-build-image.git repo.
FROM alexchesser/sorbet-build-image as BUILD
ARG VERSION=0.5.10993
ENV ENV_VERSION=$VERSION
RUN git clone https://github.com/sorbet/sorbet.git
WORKDIR /sorbet
RUN export GIT_BRANCH=$(eval "git tag|grep ${ENV_VERSION}") && \
    git checkout tags/${GIT_BRANCH}

# When building on  an apple silicon mac we need to strip the sandybridge (intel) architecture
RUN bash -c "sed '/--copt=-march=sandybridge/d' .bazelrc > .bazelrc_2" && \
    mv .bazelrc_2 .bazelrc
RUN ./.buildkite/build-static-release.sh
RUN cp -r _out_ /
RUN ./.buildkite/build-sorbet-static-and-runtime.sh
RUN cp -r _out_ /
RUN ./.buildkite/build-sorbet-runtime.sh
RUN cp -r _out_ /
WORKDIR /_out_
RUN gem install builder && gem generate_index

# this strips out everything but the binaries from the build container 
# so consumers don't need to download an 8+GB image :) 
FROM alpine
COPY --from=BUILD /_out_ /dist
WORKDIR /dist