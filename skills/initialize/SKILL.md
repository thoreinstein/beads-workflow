---
name: initialize
description: Generate a GEMINI.md file for any codebase by scanning project structure, detecting tech stack, and documenting conventions. Use when onboarding a new project.
---

# Initialize Project Context

## When to Use

- Setting up Gemini CLI for a new project
- Onboarding to an unfamiliar codebase
- Creating a GEMINI.md from scratch
- Bootstrapping project context after cloning a repo

## Workflow

### Phase 1: Project Discovery

Scan the project to identify:

1. **Languages**: Check file extensions, count by type
2. **Frameworks**: Look for config files:
   - JavaScript/TypeScript: package.json, tsconfig.json, vite.config.*, next.config.*
   - Python: pyproject.toml, setup.py, requirements.txt, Pipfile
   - Go: go.mod, go.sum
   - Rust: Cargo.toml, Cargo.lock
   - Nix: flake.nix, shell.nix, default.nix
   - Lua: .luacheckrc, .luarocks
3. **Build tools**: Makefile, Justfile, Taskfile.yml, npm scripts, cargo, go build
4. **Test runners**: pytest, go test, cargo test, vitest, jest, bats, busted
5. **Linters/formatters**: eslint, prettier, ruff, golangci-lint, clippy, shellcheck, nixfmt, stylua
6. **CI/CD**: .github/workflows/, .gitlab-ci.yml, Jenkinsfile
7. **Package managers**: npm/yarn/pnpm/bun, pip/poetry/uv, cargo, go modules

### Phase 2: Convention Detection

Analyze existing code for:

1. **Naming conventions**: camelCase, snake_case, kebab-case
2. **Directory structure**: src/, lib/, internal/, cmd/, pkg/, app/
3. **Import patterns**: absolute vs relative, barrel files
4. **Error handling patterns**: Result types, try/catch, error codes
5. **Test organization**: co-located, separate test dir, naming patterns

### Phase 3: Generate GEMINI.md

Template:

```markdown
# Project: <name>

<1-2 sentence description>

## Tech Stack

- **Language(s):** <detected>
- **Framework(s):** <detected>
- **Package Manager:** <detected>
- **Test Framework:** <detected>

## Commands

- **Build:** `<command>`
- **Test:** `<command>`
- **Lint:** `<command>`
- **Format:** `<command>`
- **Run:** `<command>`

## Directory Structure

- `src/` — <purpose>
- `tests/` — <purpose>

## Conventions

- <naming convention>
- <error handling pattern>
- <import pattern>
- <test organization>
```

### Phase 4: Review

1. Present the generated GEMINI.md to the user
2. Ask for corrections or additions
3. Only write the file after user approval

## Constraints

- **Read-only scanning** — do not modify any project files during discovery
- **GEMINI.md only** — the only file written is GEMINI.md in the project root
- **No speculation** — only document what is actually detected
- **Concise** — GEMINI.md should be under 100 lines
- **Present for review** — show the generated content to the user before writing
- **Existing GEMINI.md** — if one exists, read it first and offer to update
