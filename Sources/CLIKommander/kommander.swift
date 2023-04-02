import Foundation

public class Kommander {
    public var commands: [String: Command] = [:];
    
    init(){ }
    
    init(commands: [Command]){
        for cmd: Command in commands {
            self.commands[cmd.name] = cmd;
        }
    }
    
    public func addCommand(cmd: Command) {
        // TODO: add error handling for duplicated command name
        self.commands[cmd.name] = cmd;
    }
    
    // TODO: add logic
    public func parse() -> Void {
        let args: ArraySlice<String> = CommandLine.arguments[2...];

        for arg: String in args {
            if (self.commands[arg] == nil) {
                print("argument: ", arg, "is not valid");
                exit(1);
            }
        }

        print("WIP");
    }
}

// TODO: test command
public class Command {
    let name: String;
    var action: CommandAction? = nil;
    var usage: CommandAction? = nil;
    var options: [Option]? = nil;
    var subCommands: [String: Command] = [:];

    // Simple command with an action
    init(name: String, action: @escaping CommandAction) {
        self.name = name;
        self.action = action;
    }

    // Simple command with an action and a custom usage method
    init(name: String, action: @escaping CommandAction, usage: @escaping CommandAction) {
        self.name = name;
        self.action = action;
        self.usage = usage;
    }

    // Command with options
    init(name:String, action: @escaping CommandAction, options: [Option]) {
        self.name = name;
        self.action = action;
        self.options = options;
    }

    // Command with options and a custom usage method
    init(name:String, action: @escaping CommandAction, options: [Option], usage: @escaping CommandAction) {
        self.name = name;
        self.action = action;
        self.usage = usage;
        self.options = options;
    }

    // Command with subcommands and a custom usage method
    init(name: String, subCommands: [Command]) {
        self.name = name;
        for cmd in subCommands {
            self.subCommands[cmd.name] = cmd;
        }
    }
    
    // Command with subcommands and a custom usage method
    init(name: String, subCommands: [Command], usage: @escaping CommandAction) {
        self.name = name;
        self.usage = usage;
        for cmd in subCommands {
            self.subCommands[cmd.name] = cmd;
        }
    }
}

// TODO: test option
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
