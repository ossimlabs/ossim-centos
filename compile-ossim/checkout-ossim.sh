#!/bin/bash

set -e

export REPOS_DIR="${PWD}/ossim-repos"
export OSSIM_DIR="${REPOS_DIR}/ossim"
export OSSIM_PLUGINS_DIR="${REPOS_DIR}/ossim-plugins"
export OSSIM_OMS_DIR="${REPOS_DIR}/ossim-oms"
export OSSIM_VIDEO_DIR="${REPOS_DIR}/ossim-video"

mkdir -p "${REPOS_DIR}"

if [[ ! -d "${OSSIM_DIR}" ]]; then
    git clone https://github.com/ossimlabs/ossim.git "${OSSIM_DIR}" --single-branch --branch "${OSSIM_BRANCH:=dev}"
fi

if [[ ! -d "${OSSIM_PLUGINS_DIR}" ]]; then
    git clone https://github.com/ossimlabs/ossim-plugins.git "${OSSIM_PLUGINS_DIR}" --single-branch --branch "${OSSIM_PLUGINS_BRANCH:=dev}"
fi

if [[ ! -d "${OSSIM_OMS_DIR}" ]]; then
    git clone https://github.com/ossimlabs/ossim-oms.git "${OSSIM_OMS_DIR}" --single-branch --branch "${OSSIM_OMS_BRANCH:=dev}"
fi

if [[ ! -d "${OSSIM_VIDEO_DIR}" ]]; then
    git clone https://github.com/ossimlabs/ossim-video.git "${OSSIM_VIDEO_DIR}" --single-branch --branch "${OSSIM_VIDEO_BRANCH:=dev}"
fi

