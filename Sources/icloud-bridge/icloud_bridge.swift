@main
public struct icloud_bridge {
    public static func main() {
        // TODO: add commander config folder?
        let cliParser = CliParser();
        
        cliParser.addCommand(cmd: testCommand);
        
        // commander.commands["test"]?.action();
        // print(commander.commands["test"]?.options?[0].name)
        
        cliParser.parse(args: ["test"]);
    }
}
