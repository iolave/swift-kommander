import Foundation

public class Kommander {
    public var commands: [String: Command] = [:];
    
    init(){ }
    
    init(commands: [Command]){
        for cmd in commands {
            self.commands[cmd.name] = cmd;
        }
    }
    
    public func addCommand(cmd: Command) {
        // TODO: add error handling for duplicated command name
        self.commands[cmd.name] = cmd;
    }
    
    // TODO: add logic
    public func parse(args: [String]) -> Void {
        print("WIP");
    }
}

public class Command {
    let name: String;
    let action: CommandAction;
    let helpAction: CommandAction?;
    let options: [Option]?;
    // TODO: add subcommands support
    
    init(name: String, action: @escaping CommandAction) {
        self.name = name;
        self.action = action;
        self.helpAction = nil;
        self.options = nil;
    }
    
    init(name: String, action: @escaping CommandAction, helpAction: @escaping CommandAction) {
        self.name = name;
        self.action = action;
        self.helpAction = helpAction;
        self.options = nil;
    }
    
    init(name:String, action: @escaping CommandAction, options: [Option]) {
        self.name = name;
        self.action = action;
        self.helpAction = nil;
        self.options = options;
    }
    
    init(name:String, action: @escaping CommandAction, helpAction: @escaping CommandAction, options: [Option]) {
        self.name = name;
        self.action = action;
        self.helpAction = helpAction;
        self.options = options;
    }
}


public struct Option {
    let name: String;
    let requiresValue: Bool;
    let required: Bool;
    
    init(name: String, requiresValue: Bool, required: Bool) {
        if (!name.hasPrefix("--")) {
            print("Command Options are required to have '--' prefix");
            exit(1);
        }
        self.name = name
        self.requiresValue = requiresValue
        self.required = required
    }
}

// TODO: add support for custom functions using, maybe, typed parameters(?)
public typealias CommandAction = () -> Void;




// public struct kommander {
//     public static func main() {
//         // TODO: add commander config folder?
//         let cliParser = CliParser();
//
//         cliParser.addCommand(cmd: testCommand);
//
//         // commander.commands["test"]?.action();
//         // print(commander.commands["test"]?.options?[0].name)
//
//         cliParser.parse(args: ["test"]);
//     }
// }