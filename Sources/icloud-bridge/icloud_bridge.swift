@main
public struct icloud_bridge {
    public static func main() {
        let method: () -> Void = {
            print("handle function 1");
        }
        
        let testCmd: Command = Command(action: method);
        
        let commander: Commander = Commander();
        commander.addCommand(name: "testCmd", cmd: testCmd)
        
        commander.commands["testCmd"]?.action();
    }
}


