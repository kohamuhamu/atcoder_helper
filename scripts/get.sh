#!/bin/bash

### 引数の受け取り #######################################
ARGS=( "${@}" )
## 最初の引数はコンテスト名
CONTEST_NAME="${ARGS[0]}"
## 残りの引数はタスク名
unset ARGS[0]
TASK_NAMES=( "${ARGS[@]}" )


### 基本設定 #############################################
SCRIPT_DIR="$(cd "$(dirname "${0}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
TEST_DIR="${ROOT_DIR}/tmp/test"
MainKT="fun main() {
    func()
    pw.flush()
}

private fun func() {
}"


### kotlin ファイルの作成と問題のダウンロード ############
for TASK in "${TASK_NAMES[@]}"; do
    ## テストファイルのダウンロード
    URL="https://atcoder.jp/contests/${CONTEST_NAME}/tasks/${TASK}"
    DL_CHECK="TRUE"
    if [ ! -d "${TEST_DIR}/${CONTEST_NAME}/${TASK}" ]; then
        if ! oj dl "${URL}" -d "${TEST_DIR}/${CONTEST_NAME}/${TASK}"; then
            DL_CHECK="FALSE"
        fi
    fi

    ## kotlin ファイルの touch
    if [ "${DL_CHECK}" == "TRUE" ] && [ ! -f "${ROOT_DIR}/../src/main/kotlin/${TASK}.kt" ]; then
        mkdir -p "${ROOT_DIR}/../src/main/kotlin/"
        echo "${MainKT}" > "${ROOT_DIR}/../src/main/kotlin/${TASK}.kt"
    fi
done
