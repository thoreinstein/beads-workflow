---
name: release
description: Author release notes, changelog, and signed release tag
---

# Release Authoring

## Agent Delegation
You MUST delegate the coordination of release artifacts and stakeholder communication strategy to the `agile-delivery-lead` sub-agent. For technical verification of the release state, consult the `sre-engineer` if necessary.

## Workflow

### 1. Pre-flight Checks
- Ensure a clean working tree (`git status --porcelain`).
- Identify the last tag and review changes since then.

### 2. Semver Selection
Analyze commits since the last tag to determine the version bump (Major, Minor, or Patch) based on the highest-impact change.

### 3. Artifact Creation
- **RELEASE_NOTES.md**: Prepend summary, breaking changes, new features, bug fixes, and operational notes.
- **CHANGELOG.md**: Prepend version header and bulleted list of commits.

### 4. Execution Sequence
1.  **Draft** content.
2.  **Write** to files.
3.  **Stage** changes.
4.  **Commit** with GPG signature (`git commit -S`).
5.  **Tag** with GPG signature (`git tag -s`).

## Constraints

- **GPG Signing Required**: All commits and tags MUST be signed.
- **NO PUSH**: Never push to the remote. The user pushes manually after review.
- **No CI-skip**: Do not use CI-skip directives in commit messages.
- **Clean Tree**: Abort if the working tree is dirty.
