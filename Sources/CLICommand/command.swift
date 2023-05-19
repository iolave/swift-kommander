import Foundation;

enum CLICommandError: Error {
    case initWithEmptyOptions
    case duplicatedOptions
    case commandOnlyAllowsAddSubCommandMethod
}

public class CLICommand {
    private var allowSubCommands: Bool;

    var name: String;
    var action: CLIAction? = nil;
    var options: [CLIOption]? = nil;
    var subCommands: [CLICommand]? = nil;

    init(name: String, action: @escaping CLIAction) {
        self.name = name;
        self.action = action;
        self.allowSubCommands = false;
    }

    init(name: String, action: @escaping CLIAction, options: [CLIOption]) throws {
        self.name = name;
        self.action = action;
        self.allowSubCommands = false;

        if (options.count == 0) {
            print("options initializer parameter can not be empty, either remove options parameter or add options");
            throw CLICommandError.initWithEmptyOptions;
        }

        // As options lenght is not 0 we're able to check 
        // if is there another option with the same name
        // or the same shorthand
        if (optionDuplicates(options: options)) {
            print("There is an option within the options initializer parameter that have a duplicated 'name' or 'shorthand' property");
            throw CLICommandError.duplicatedOptions;
        }

        self.options = options;
    }

    /** This initializer only creates a command with a name and sets
        `subCommands`, `options` and `action` as nil. This will only
        allow the user to use the addSubCommand method.
    */
    init(name: String) {
        self.name = name;
        self.allowSubCommands = true;
    }

    /**
    Adds an option to a CLICommand instance.
    - Parameter name: Name of the given option (should begin with a `--` prefix)
    - Parameter shorthand: Shorthand for the option name (optional, should begin with a `-` prefix)
    - Parameter requiresValue: Specify if the option requires a value (i.e. `--path /root` or `--path=/root`)
    - Parameter required: Specify if the option is required or optional.
    - Throws `CLICommandError.duplicatedOptions`
    */
    public func addOption(name: String, shorthand: String?, requiresValue: Bool, required: Bool) throws -> Void {
        if (self.allowSubCommands == true && self.subCommands != nil) {
            print("CLICommand ERROR: command '", self.name, "' does not allow addOption calls cuz it's purposed to store subCommands only");
            throw CLICommandError.commandOnlyAllowsAddSubCommandMethod;
        }

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
            throw CLICommandError.duplicatedOptions;
        }

        self.allowSubCommands = false;

        return;
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
func commandDuplicates(options: [CLIOption]) -> Bool {
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

