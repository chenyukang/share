alias ba := build-all
alias b := build
alias ts := test-one
alias l := log

build-all:
        x b

rui:
        x test tests/ui --bless

reb N:
        git rebase -i  HEAD~{{N}}

err FILE N:
        rustc +dev {{FILE}} -Z treat-err-as-bug={{N}}

cerr FILE N:
        rustc {{FILE}} -Z treat-err-as-bug={{N}}

diag FILE:
        rustc +dev {{FILE}} -Z track-diagnostics

sugg FILE:
        RUSTC_SUGG=1 rustc +dev {{FILE}}

build:
        x b --keep-stage-std=1

test:
        x test

test-one FILE:
        x test {{FILE}} --bless

dev FILE:
        rustc +dev {{FILE}}

cur FILE:
        rustc {{FILE}}

log FILE:
        RUSTC_LOG=debug rustc +dev {{FILE}} > /tmp/r.log 2>&1; cat /tmp/r.log | grep yukang

logp FILE PATTERN:
        RUSTC_LOG=debug rustc +dev {{FILE}} > /tmp/r.log 2>&1; cat /tmp/r.log | grep {{PATTERN}}

tree FILE:
        rustc {{FILE}} -Zunpretty=hir-tree > /tmp/tree.log

old_branch := `git rev-parse --abbrev-ref HEAD`
rebm:
        git stash
        git checkout up-master
        git pull
        git submodule sync
        git submodule update
        git stash
        git checkout {{old_branch}}
        git rebase up-master

sync:
        git stash
        git checkout up-master
        git pull
        git submodule sync
        git submodule update
