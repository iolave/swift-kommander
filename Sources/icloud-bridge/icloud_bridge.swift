@main
public struct icloud_bridge {
    public private(set) var text = "Hello, World!"

    public static func main() {
        
        print(CommandLine.arguments)
        print(CommandLine.argc)
    }
}

private func cli_handler (args: Array<String>) -> String {
    return "";
}
