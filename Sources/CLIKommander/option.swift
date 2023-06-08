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

enum CLIOptionError: Error {
    case invalidNamePrefix
    case invalidShorthandPrefix
}

/**
 * Check if a CLIOptions array have a duplicated
 * `name` and/or `shorthand` property.
 * - Parameters:
 * - Returns:
 * `true` when a duplicate is found and `false` otherwise.
 */
func optionDuplicates(options: [CLIOption]) -> Bool {
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