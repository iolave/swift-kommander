import Foundation;

public class CLICommandBase {
    let name: String;
    var action: CLIAction;
    var options: [CLIOption]? = nil;

    init(name: String, action: @escaping CommandAction) {
        self.name = name;
        self.action = action;
    }

    init(name:String, action: @escaping CommandAction, options: [CLIOption]) {
        self.name = name;
        self.action = action;
        self.options = options;
    }
}

public struct CLIOption {
    let name: String;
    let requiresValue: Bool;
    let required: Bool;
    
    init(name: String, requiresValue: Bool, required: Bool) {
        if (!name.hasPrefix("--")) {
            print("CLIOptions 'name' property is required to have a '--' prefix");
            exit(1);
        }

        self.name = name;
        self.requiresValue = requiresValue;
        self.required = required;
    }
}

public typealias CLIAction = () -> Void;