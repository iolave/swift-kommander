@main
public struct icloud_bridge {
    public static func main() {
        let method: () -> Void = {
            print("handle function 1");
        }
        
        let testCmd = Command(action: method);
        
        testCmd.action();
    }
}


