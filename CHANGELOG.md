## [1.8.0] - 2026-03-19
 - ced3738 feat: Restrict PM agent behavior and mandate LLM-driven refinement artifacts
 - a3fb932 Add pr-comments skill
 - 0b06ed7 Remove commands that now conflict with skills
 - 82395e8 feat(skills): update workflows for multi-agent delegation
 - e893de9 feat(agents): introduce specialized pro and reviewer agents
 - 380ba81 refactor(agents): evolve SDET to Test Strategy Architect
 - 8cf76d6 fix(hooks): resolve path traversal, JSON injection, and latency issues
# Changelog

## v1.7.2 (2026-03-08)

### Documentation
- ef39ec5 docs(skills): migrate ticket completion to bd close and closed status
- ed76d1d docs: update core workflow to use bd close

## v1.7.1 (2026-03-07)

### Refactorings
- 8d4a13e refactor(hooks): migrate to structured configuration and extensionPath resolution

## v1.7.0 (2026-03-04)

### Features
- 7b902fc feat(skills): add plan-review skill for cross-platform plan refinement
- 9840b9c docs: enhance workflow documentation and define guardrail hooks
- 4e80cf0 feat(skills): rename code-review to review and fix compound typo
- d693c4b refactor(agents): standardize task tracking and research methodologies

## v1.6.0 (2026-02-14)

### Features
- f16e89a feat(commands): consolidate refinement commands and rename review command
- 01fd82f feat(compound): add multi-stage retrospective and clarify local write exception
- 8aa75e4 feat(workflow): enforce obsidian-only artifacts and PR/closure guardrails
- fd3d028 feat: enhance compound retrospective with multi-stage review
- 24df4e8 feat: add adr-writer skill and /adr command
- 795aa88 feat: allow agents to write and edit files

## v1.5.0 (2026-02-09)

### Features
- 14b401a feat: standardize artifact storage paths across core skills

## v1.4.0 (2026-02-08)

### Features
- 6e81597 feat(release): automate version bumping in project files
- 6d2e975 feat(commit): require interactive staging for mixed changes

### Documentation
- 4f6b215 docs: implement 'merge before close' guardrail
- b27dcf8 docs: add trunk branch guardrail to smart branching logic
- 78d2576 docs: standardize Obsidian vault directory structure
- 1c63d3e docs: require YAML frontmatter for knowledge artifacts
- 854b2fd docs: Resolve skill instruction inconsistencies
- 79a7657 docs: fix numbering gaps and add missing merge-before-close constraint
- f4e437e docs: fix cross-file inconsistencies found in project review

## v1.3.0 (2026-02-07)

### Features
- 07aa4d0 feat: implement smart branching strategy

### Refactors
- 91262a2 refactor: remove mandatory release branch constraint from release skill
