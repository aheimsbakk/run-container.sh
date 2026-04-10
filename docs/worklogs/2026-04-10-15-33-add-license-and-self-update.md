---
when: 2026-04-10T15:33:52Z
why: embed license, link source repo, and add self-update capability
what: add --license, --update options and embed MIT license text and repo URL
model: opencode/glm-5.1
tags: [feature, script, license, self-update]
---

Added embedded MIT license text (from LICENSE) displayed via --license flag, source repository URL (https://github.com/aheimsbakk/run-container.sh.git) shown in help, and --update option that downloads the latest script from GitHub and replaces itself in-place. Bumped version to 1.1.0. Updated BLUEPRINT.md, CONTEXT.md, and README.md.