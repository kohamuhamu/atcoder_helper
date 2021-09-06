#!/bin/bash

set -eu
set -eo pipefail

### 引数の受け取り #######################################
CONTEST_NAME="${1}"  # コンテスト名
TASK="${2}"          # タスク名


### 基本設定 #############################################
SCRIPT_DIR="$(cd "$(dirname "${0}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
SRC_DIR="${ROOT_DIR}/../src/main/kotlin"            # 提出用のソースコードを保存しているディレクトリ
COMMON_KT="${ROOT_DIR}/src/main/kotlin/common.kt"   # 共通関数群の kotlin ファイル
TEST_DIR="${ROOT_DIR}/tmp/test"                     # 各コンテストのテストケース
BUILD_DIR="${ROOT_DIR}/tmp/build"                   # ビルドして固めた jar を保存するディレクトリ
TMP_SRC_DIR="${ROOT_DIR}/tmp/src"                   # 提出用のコードと common.kt の連結ファイルの保存ディレクトリ
                                                    # ※ 提出できるのはファイル一つのみのため


### ディレクトリ作成 #####################################
mkdir -p "${TEST_DIR}" "${BUILD_DIR}" "${TMP_SRC_DIR}"


### 提出用ファイル連結 ###################################
# Note: 連結時にそれぞれの import 文をファイルの先頭に移している.
awk 1 "${SRC_DIR}/${TASK}.kt" "${COMMON_KT}" | (grep import || true) | sort | uniq > "${TMP_SRC_DIR}/${TASK}.kt"
echo >> "${TMP_SRC_DIR}/${TASK}.kt"
awk 1 "${SRC_DIR}/${TASK}.kt" "${COMMON_KT}" | (grep -v import || true) >> "${TMP_SRC_DIR}/${TASK}.kt"


### build ################################################
echo "--- start building ---"
kotlinc -include-runtime -d "${BUILD_DIR}/${TASK}.jar" "${TMP_SRC_DIR}/${TASK}.kt"
echo "--- end building ---"


### test #################################################
oj t \
    -c "java -jar ${BUILD_DIR}/${TASK}.jar" \
    -d "${TEST_DIR}/${CONTEST_NAME}/${TASK}"
