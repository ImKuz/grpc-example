import GRPC
import NIO
import Logging

LoggingSystem.bootstrap {
    var handler = StreamLogHandler.standardOutput(label: $0)
    handler.logLevel = .debug

    return handler
}

func main(args: [String]) throws {
    let group = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)

    defer {
        try! group.syncShutdownGracefully()
    }

    let provider = GroceryListProvider()

    let server = Server.insecure(group: group)
        .withServiceProviders([provider])
        .bind(host: "localhost", port: 8000)

    server
        .map {$0.channel.localAddress}
        .whenSuccess { address in
            if let address = address,
                let port = address.port {
                print("Server started on port \(port)")
            }
    }

    _ = try server.flatMap { $0.onClose }.wait()
}

try main(args: CommandLine.arguments)
