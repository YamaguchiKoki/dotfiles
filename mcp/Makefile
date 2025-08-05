all: build

build: clean
	jsonnet mcp-claude-code.jsonnet > .mcp-claude-code.json
	jq 'del(.mcpServers) + $$mcp[0]' ~/.claude.json --slurpfile mcp .mcp-claude-code.json > ~/.claude.json.tmp && mv ~/.claude.json.tmp ~/.claude.json

clean:
	rm -f .mcp-claude-code.json

.PHONY: all build clean