---
when: 2026-04-10T15:52:45Z
why: unbound variable error when BUILD_ARGS array was empty under set -u
what: fix unbound variable for empty BUILD_ARGS array in container build
model: opencode/glm-5.1
tags: [bugfix, bash, set-u]
---

Fixed "unbound variable" error on line 224 where `"${BUILD_ARGS[@]}"` failed under `set -u` when the array was empty. Changed to `${BUILD_ARGS[@]+"${BUILD_ARGS[@]}"}` pattern, consistent with how PODMAN_OPTS and CMD_OPTS are already handled. Touched `run-container.sh`. Version bumped to 1.1.2.