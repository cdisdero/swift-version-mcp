import Foundation
import MCP

let server = Server(
    name: "Swift Version MCP",
    version: "0.1.0",
     capabilities: .init(
        prompts: .init(listChanged: true),
        resources: .init(subscribe: true, listChanged: true),
        tools: .init(listChanged: true)
    )
)

let transport = StdioTransport()
try await server.start(transport: transport)

let tool = Tool(name: "swift_version",
                description: "Returns the current Swift version",
                inputSchema: .object([
                    "type": .string("object")
                ]))
 
await server.withMethodHandler(ListTools.self) { params in
    .init(tools: [tool])
}

await server.withMethodHandler(CallTool.self) { params in
    switch params.name {
        case "swift_version":
            return .init(content: [.text(swiftVersion() ?? "No version")], isError: false)
        default:
            return .init(content: [.text("Unknown tool")], isError: true)
    }
}
 
func swiftVersion() -> String? {
    let process = Process()
    process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
    process.arguments = ["swift", "--version"]
 
    let outputPipe = Pipe()
    process.standardOutput = outputPipe
 
    do {
        try process.run()
        process.waitUntilExit()
 
        let data = outputPipe.fileHandleForReading.readDataToEndOfFile()
        return String(data: data, encoding: .utf8)
    } catch {
        return "Error running swift-version: \(error)"
    }
}

await server.waitUntilCompleted()
