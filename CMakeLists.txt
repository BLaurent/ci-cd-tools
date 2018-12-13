cmake_minimum_required(VERSION 2.8)
SET(IMAGE_PATH ${CMAKE_CURRENT_SOURCE_DIR})
SET(IMAGE_TAG "blaurent/ci-cd-tools")
SET(no_proxy predix.io,192.*,127.*,localhost,0.0.0.*)
SET(build_args --build-arg "http_proxy=$ENV{http_proxy}" --build-arg "https_proxy=$ENV{https_proxy}" --build-arg "no_proxy=$ENV{no_proxy}" )

add_custom_target(build
  COMMAND docker build ${build_args} --tag=${IMAGE_TAG} .
  WORKING_DIRECTORY ${IMAGE_PATH})

add_custom_target(build-noproxy
  COMMAND docker build --tag=${IMAGE_TAG} .
  WORKING_DIRECTORY ${IMAGE_PATH})
