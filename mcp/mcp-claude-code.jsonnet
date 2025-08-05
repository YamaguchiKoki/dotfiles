{
  mcpServers: {
    filesystem: {
      command: 'npx',
      args: ['-y', '@modelcontextprotocol/server-filesystem'],
      settings: {
        rootPath: std.extVar('HOME') + '/projects',
      },
    },
    github: {
      command: 'npx',
      args: ['-y', '@modelcontextprotocol/server-github'],
      env: {
        GITHUB_TOKEN: std.extVar('GITHUB_TOKEN'),
      },
    },
    // 他のMCPサーバーをここに追加
  },
}