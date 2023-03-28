@main
public struct icloud_bridge {
    public static func main() {
        // TODO: add commander config folder?
        var options: [Option];
        var method: CommandAction;
        var cmd: Command;
        
        method = { print("handle function 1") }
        options = [ Option(name: "--test", requiresValue: true, required: true) ];
        cmd = Command(action: method, options: options);
        
        let commander: Commander = Commander();
        
        commander.addCommand(name: "testCmd", cmd: cmd);
        
        commander.commands["testCmd"]?.action();
        print(commander.commands["testCmd"]?.options?[0].name)
    }
}
