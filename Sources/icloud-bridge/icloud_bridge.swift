@main
public struct icloud_bridge {
    public static func main() {
        // TODO: add commander config folder?
        let commander: Commander = Commander();
        
        commander.addCommand(name: "testCmd", cmd: testCommand);
        
        commander.commands["testCmd"]?.action();
        print(commander.commands["testCmd"]?.options?[0].name)
    }
}
