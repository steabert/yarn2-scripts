#!/usr/bin/env bash

declare GOOD_MESSAGES=( \
'feat: great new thing' \
'fix: great new thing' \
'chore(docs): great new thing' \
'docs(tests): explain new testing in `fake.md` file' \
'feat!: breaking stuff now' \
)

for msg in "${GOOD_MESSAGES[@]}"; do
        if ! bash commitlint "$msg"; then
                echo "Test commitlint: FAILURE"
                exit 1
        fi
done

declare BAD_MESSAGES=( \
'feat (thing): great new thing' \
'fix:  great new thing' \
'chore(docs): update documentation...' \
'docs([]/9): explain new testing in `fake.md` file' \
)

for msg in "${BAD_MESSAGES[@]}"; do
        if bash commitlint "$msg"; then
                echo "Test commitlint: FAILURE"
                exit 1
        fi
done

echo "Test commitlint: SUCCESS"
