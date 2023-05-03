import Foundation

public class Kommander {
    public var commands: [String: Command] = [:];
    public var defaultAction: CommandAction? = nil;
    public var usage: CommandAction? = nil;
    
    init(commands: [Command]){
        for cmd: Command in commands {
            self.commands[cmd.name] = cmd;
        }
    }

    init(commands: [Command], usage: @escaping CommandAction){
        for cmd: Command in commands {
            self.commands[cmd.name] = cmd;
        }

        self.usage = usage;
    }

    init(action: @escaping CommandAction){
        self.defaultAction = action;
    }
    
    init(action: @escaping CommandAction, usage: @escaping CommandAction){
        self.defaultAction = action;
        self.defaultAction = action;
    }

    public func addCommand(cmd: Command) {
        self.commands[cmd.name] = cmd;
    }
    
    public func defaultUsage() -> Void {
        if (self.commands.count == 0) {
            if (self.defaultAction == nil) {
                print("KOMMANDER_DEFAULTUSAGE_METHOD: no default command defined, exiting with code 1");
                exit(1);
            }
            
            print("Usage:")
                
            print("AppName [OPTIONS]")
            print("")
            print("[OPTIONS]")
            // TODO: break command into a basic one and a extended one to allow options in the default command
        }
    }
    
    
    // TODO: add logic
    public func parse() -> Void {
        let args: ArraySlice<String> = CommandLine.arguments[2...];
        
        if (self.commands.count == 0) {
            if (args.count != 0) {
                if (self.usage == nil) {
                    print("KOMMANDER_PARSE_METHOD: no commands defined but arguments were given, printing custom usage");
                    usage?();
                }
                
                print("KOMMANDER_PARSE_METHOD: no commands defined but arguments were given, printing default usage");
                defaultUsage();
            }
            
            if (self.defaultAction == nil) {
                print("KOMMANDER_PARSE_METHOD: no commands defined and no arguments were given and no default command defined, exiting with code 1");
                exit(1);
            }
            
            print("KOMMANDER_PARSE_METHOD: no commands defined and no arguments were given, running default command");
            defaultAction?();

            return;
        }

        for arg: String in args {
            if (self.commands[arg] == nil) {
                print("argument:", arg, "is not valid");
                exit(1);
            }
        }

        print("WIP");
    }
}

private func defaultUsage(kommanderInstance: Kommander) -> Void {
    
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
