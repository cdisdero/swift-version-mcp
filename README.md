# swift-version-mcp
My first MCP server written in a Swift Package

Depends on:
https://github.com/modelcontextprotocol/swift-sdk

This was my implementation from this tutorial:
https://www.artemnovichkov.com/blog/creating-mcp-servers-in-swift

In order to use the server in:

### VSCode Github Copilot

1. Edit ~/Library/Application\ Support/Code/User/settings.json in VSCode.
2. Add this section for the server in the configuration:
```
    "mcp": {
        "servers": {
            "swift-version-mcp": {
                "type": "stdio",
                "command": "/Volumes/Shared/Code/swift-version-mcp/.build/debug/swift-version-mcp",
                "args": []
            }
        }
    },
```
3. VSCode will display a small caption bar above the 'swift-version-mcp' server block you just added.  Press the Start button to start the server.
4. When you open a conversation with copilot, click on the 'Add Context...' button above the prompt line and choose Tools from the menu, then select the 'swift-version' server from the list presented.

### Claude Desktop

1. Edit ~/Library/Application\ Support/Claude/claude_desktop_config.json in VSCode.
2. Add this section for the server in the configuration:
```
{
  "mcpServers": {
    "swift-version-server": {
      "type": "stdio",
      "command": "/Volumes/Shared/Code/swift-version-mcp/.build/debug/swift-version-mcp"
    }
  }
}
```
3. Restart Claude Desktop.
