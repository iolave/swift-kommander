import Foundation;

enum CLICommandBaseError: Error {
    case initWithEmptyOptions
}

public class CLICommandBase {
    let name: String;
    var action: CLIAction? = nil;
    var options: [CLIOption]? = nil;

    init(name: String, action: @escaping CommandAction) {
        self.name = name;
        self.action = action;
    }

    init(name: String, action: @escaping CommandAction, options: [CLIOption]) throws {
        self.name = name;
        self.action = action;

        if (options.count == 0) {
            print("options initializer parameter can not be empty, either remove options parameter or add options");
            throw CLICommandBaseError.initWithEmptyOptions
        }

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