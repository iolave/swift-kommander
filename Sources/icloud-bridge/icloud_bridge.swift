@main
public struct icloud_bridge {
    public static func main() {
        // TODO: add commander config folder?
        let commander: Commander = Commander();
        
        commander.addCommand(cmd: testCommand);
        
        commander.commands["test"]?.action();
        print(commander.commands["test"]?.options?[0].name)
    }
}
