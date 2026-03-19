---
name: pr-comments
description: Fetches all unresolved comments for a given PR number and systematically addresses them with code changes, verification, and replies.
---

# PR Comments Resolution Mode

## Goal
To efficiently clear the "unresolved" queue of a Pull Request by implementing requested changes, verifying them, and closing the feedback loop.

## Workflow

### Phase 1: Context Gathering
1. **Fetch Threads**: Use `mcp_github_pull_request_read(method="get_review_comments")` to retrieve all comment threads for the specified PR.
2. **Filter Unresolved**: Identify threads where `isResolved` is `false`.
3. **Map to Source**: For each unresolved thread, identify:
    - The file path and line numbers.
    - The core request or issue described in the comments.
    - The "latest" state of the code at those lines.

### Phase 2: Implementation Planning
1. **Analyze Requirements**: Group comments by file or logical feature.
2. **Generate Strategy**: For each group of comments, decide if it's a simple fix (refactor/style) or requires a broader logic change.
3. **Draft Plan**: Create an **Implementation Summary** in the Obsidian `plans/` directory (`working/<project-name>/plans/PR-<number>-comments-resolution.md`).

### Phase 3: Execution (The "Solve" Loop)
For each comment or logical group:
1. **Act**: Apply surgical code changes to address the feedback. Use `replace` or `write_file` for precise updates.
2. **Verify**: Run relevant tests, linters, or build commands to ensure the fix is correct and hasn't introduced regressions.
3. **Reply**: Use `mcp_github_add_reply_to_pull_request_comment` to explain the fix. Mention that the issue has been addressed.

### Phase 4: Integration & Closure
1. **Final Audit**: Run a full project build/test suite.
2. **Sync**: Ensure all changes are committed (atomic commits per logical fix).
3. **Summarize**: Update the Obsidian note with a summary of which comments were resolved and how.

## Constraints & Mandates
- **PRECISION**: Only touch the code specifically mentioned in the comments or strictly necessary for the fix.
- **COMMUNICATION**: Always reply to the thread. Don't leave the reviewer guessing.
- **VERIFICATION**: Every fix MUST be verified by a test or build. No "blind" fixes.
- **OBSIDIAN**: All planning and summaries MUST be stored in the Obsidian vault.
- **NO SELF-MERGE**: Never merge the PR yourself. Your job ends when the comments are addressed and the user is notified.

## Review Dimensions for Solving
When addressing comments, prioritize:
- **Intent Alignment**: Does the fix actually satisfy what the reviewer was asking for?
- **Pattern Consistency**: Does the fix match the project's existing style and architectural patterns?
- **Blast Radius**: Does this fix impact other parts of the system? If so, have those been updated or tested?

## Success Criteria
- [ ] All `isResolved: false` threads targeted by the current session are addressed.
- [ ] Code compiles and all relevant tests pass.
- [ ] Replies are posted for every resolved thread.
- [ ] Resolution summary is saved to Obsidian.
