#!/bin/bash

### 引数の受け取り #######################################
CONTEST_NAME="${1}"  # コンテスト名
TASK="${2}"          # タスク名

### 基本設定
SCRIPT_DIR="$(cd "$(dirname "${0}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
SRC_DIR="${ROOT_DIR}/../src/main/kotlin"            # 提出用のソースコードを保存しているディレクトリ
COMMON_KT="${ROOT_DIR}/src/main/kotlin/common.kt"   # 共通関数群の kotlin ファイル
TMP_SRC_DIR="${ROOT_DIR}/tmp/src"                   # 提出用のコードと common.kt の連結ファイルの保存ディレクトリ


### ディレクトリ作成 #####################################
mkdir -p "${TMP_SRC_DIR}"


### 提出用ファイル連結 ###################################
awk 1 "${SRC_DIR}/${TASK}.kt" "${COMMON_KT}" > "${TMP_SRC_DIR}/${TASK}.kt"


### submit ###############################################
URL="https://atcoder.jp/contests/${CONTEST_NAME}/tasks/${TASK}"
oj s "${URL}" "${TMP_SRC_DIR}/${TASK}.kt" -l kotlin -y
