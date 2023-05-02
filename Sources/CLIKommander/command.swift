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

enum CLIOptionError: Error {
    case invalidNamePrefix
    case invalidShorthandPrefix
}

public struct CLIOption {
    let name: String;
    let shorthand: String?;
    let requiresValue: Bool;
    let required: Bool;
    
    init(name: String, requiresValue: Bool, required: Bool) throws {
        if (!name.hasPrefix("--")) {
            print("CLIOptions 'name' property is required to have a '--' prefix");
            throw CLIOptionError.invalidNamePrefix;
        }

        self.name = name;
        self.requiresValue = requiresValue;
        self.required = required;
        self.shorthand = nil;
    }

    init(name: String, shorthand: String ,requiresValue: Bool, required: Bool) throws {
        if (!name.hasPrefix("--")) {
            print("CLIOptions 'name' property is required to have a '--' prefix");
            throw CLIOptionError.invalidNamePrefix;
        }

        if(!shorthand.hasPrefix("-")) {
            print("CLIOptions 'shorthand' property is required to have a '-' prefix");
            throw CLIOptionError.invalidShorthandPrefix;
        }

        self.name = name;
        self.requiresValue = requiresValue;
        self.required = required;
        self.shorthand = shorthand;
    }
}

public typealias CLIAction = () -> Void;