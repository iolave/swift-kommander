import Foundation;

enum CLICommandBaseError: Error {
    case initWithEmptyOptions
    case duplicatedOptions
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
            throw CLICommandBaseError.initWithEmptyOptions;
        }

        // As options lenght is not 0 we're able to check 
        // if is there another option with the same name
        // or the same shorthand
        if (optionDuplicates(options: options)) {
            print("There is an option within the options initializer parameter that have a duplicated 'name' or 'shorthand' property");
            throw CLICommandBaseError.duplicatedOptions;
        }

        self.options = options;
    }

    /**
    Adds an option to a CLICommandBase instance.
    - Parameter name: Name of the given option (should begin with a `--` prefix)
    - Parameter shorthand: Shorthand for the option name (optional, should begin with a `-` prefix)
    - Parameter requiresValue: Specify if the option requires a value (i.e. `--path /root` or `--path=/root`)
    - Parameter required: Specify if the option is required or optional.
    - Throws `CLICommandBaseError.duplicatedOptions`
    */
    public func addOption(name: String, shorthand: String?, requiresValue: Bool, required: Bool) throws -> Void {
        var option: CLIOption;

        if (self.options == nil) { self.options = [] }

        if (shorthand == nil) {
            option = try CLIOption(name: name, requiresValue: requiresValue, required: required);
        } else {
            option = try CLIOption(name: name, shorthand: shorthand!, requiresValue: requiresValue, required: required);
        }

        self.options!.append(option);

        if (optionDuplicates(options: self.options!)) {
            print("There is an option within the options initializer parameter that have a duplicated 'name' or 'shorthand' property");
            throw CLICommandBaseError.duplicatedOptions;
        }
        return;
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

/**
 * Check if a CLIOptions array have a duplicated
 * `name` and/or `shorthand` property.
 * - Parameters:
 * - Returns:
 * `true` when a duplicate is found and `false` otherwise.
 */
private func optionDuplicates(options: [CLIOption]) -> Bool {
    var mutableOptions: [CLIOption] = options;

    while(mutableOptions.count > 0) {
        let opt: CLIOption? = mutableOptions.popLast();

        if (opt == nil) { return true }

        for optToCheck: CLIOption in mutableOptions {
            if (optToCheck.name == opt!.name) { return true }
            if (optToCheck.shorthand == opt!.shorthand) { return true }
        }
    }

    return false;
}
