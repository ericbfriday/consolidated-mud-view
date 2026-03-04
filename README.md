# Consolidated Mud View

A meta-analysis tool for aggregating and interpreting data about local repositories in `~/dev`.

## Purpose

This repository serves as a centralized hub for:

- **Repository Status Tracking**: Monitor the state of all local repos
- **Pattern Analysis**: Identify common patterns, architectures, and tech stacks
- **Codebase Health**: Aggregate metrics on code quality, dependencies, and activity
- **Cross-Repo Insights**: Find relationships and shared code across projects

## Monitored Repositories

Analysis targets located in `~/dev`:

| Category | Repositories |
|----------|-------------|
| MUD/Gaming | mudlet-*, medievia-scripts, tintin, duneagent, DeMuddler, dynmud, muddle, muddy-fire |
| AI/LLM | big-agi, open-webui, clippyjs, morph-via-openrouter |
| OpenCode | opencode-overlord, goose-ralph-loop, goosetown |
| Templates | react-router-hono-fullstack-template, vercel-hono-mcp-bun |
| Tools | jira-mcp-tool, mud-script-converter |
| Other | artemis-reverse-sandbox, claude-flow-nexus, discord-bot-starter-q1-2026, etc. |

## Structure

```
consolidated-mud-view/
├── analysis/       # Generated analysis reports
├── scripts/        # Analysis and aggregation scripts
├── data/           # Cached repo metadata
└── docs/           # Documentation and insights
```

## Getting Started

```bash
# Run full analysis
./scripts/analyze-all.sh

# Generate status report
./scripts/status-report.sh
```

## License

MIT
