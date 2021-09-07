#!/bin/bash

set -eu
set -eo pipefail

### 基本設定 #############################################
SCRIPT_DIR="$(cd "$(dirname "${0}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
TEST_DIR="${ROOT_DIR}/tmp/test"                     # 各コンテストのテストケース
BUILD_DIR="${ROOT_DIR}/tmp/build"                   # ビルドして固めた jar を保存するディレクトリ
TMP_SRC_DIR="${ROOT_DIR}/tmp/src"                   # 提出用のコードと common.kt の連結ファイルの保存ディレクトリ
                                                    # ※ 提出できるのはファイル一つのみのため


### 一時ファイルを削除 ###################################
rm -rf "${TEST_DIR}" "${BUILD_DIR}" "${TMP_SRC_DIR}"
