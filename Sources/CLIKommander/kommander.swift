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
    var action: CommandAction? = nil;
    var helpAction: CommandAction? = nil;
    var options: [Option]? = nil;
    var subCommands: [String: Command] = [:];

    // Simple command with an action
    init(name: String, action: @escaping CommandAction) {
        self.name = name;
        self.action = action;
    }

    // Simple command with an action and a custom usage method
    init(name: String, action: @escaping CommandAction, helpAction: @escaping CommandAction) {
        self.name = name;
        self.action = action;
        self.helpAction = helpAction;
    }

    // Command with options
    init(name:String, action: @escaping CommandAction, options: [Option]) {
        self.name = name;
        self.action = action;
        self.options = options;
    }

    // Command with options and a custom usage method
    init(name:String, action: @escaping CommandAction, options: [Option], helpAction: @escaping CommandAction) {
        self.name = name;
        self.action = action;
        self.helpAction = helpAction;
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
    init(name: String, subCommands: [Command], helpAction: @escaping CommandAction) {
        self.name = name;
        self.helpAction = helpAction;
        for cmd in subCommands {
            self.subCommands[cmd.name] = cmd;
        }
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
