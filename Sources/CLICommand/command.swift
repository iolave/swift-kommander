import Foundation;

enum CLICommandError: Error {
    case initWithEmptyOptions
    case duplicatedOptions
    case duplicatedCommand
    case commandOnlyAllowsAddCommandMethod
    case commandDoesNotAllowsAddCommandMethod
}

public class CLICommand {
    private var allowSubCommands: Bool;
    private var action: CLIAction? = nil;
    private var actionOptionNamesOrder: [String]? = nil;

    var name: String;
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
        allow the user to use the addCommand method.
    */
    public init(name: String) {
        self.name = name;
        self.allowSubCommands = true;
    }

    /**
    Adds an option to the CLICommand instance.
    - Parameter name: Name of the given option (should begin with a `--` prefix).
    - Parameter shorthand: Shorthand for the option name (optional, should begin with a `-` prefix).
    - Parameter requiresValue: Specify if the option requires a value (i.e. `--path /root` or `--path=/root`).
    - Parameter required: Specify if the option is required or optional.
    - Throws `CLICommandError.duplicatedOptions`
    */
    public func addOption(name: String, shorthand: String?, requiresValue: Bool, required: Bool) throws -> Void {
        if (self.allowSubCommands == true && self.subCommands != nil) {
            print("CLICommand ERROR: command '", self.name, "' does not allow addOption calls cuz it's purposed to store subCommands only");
            throw CLICommandError.commandOnlyAllowsAddCommandMethod;
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

    public func addCommand(command: CLICommand) throws {
        if (self.allowSubCommands == false) {
            print("CLICommand ERROR: command '", self.name, "' does not allow addCommand calls cuz it already have either 'options' or 'action' defined");
            throw CLICommandError.commandDoesNotAllowsAddCommandMethod;
        }

        var tmpSubCommands: [CLICommand]? = nil;

        if (self.subCommands == nil) {
            tmpSubCommands = [];
        } else {
            tmpSubCommands = subCommands;
        }

        tmpSubCommands?.append(command);

        if (commandDuplicates(commands: tmpSubCommands!)) {
            print("CLICommand ERROR: command '", self.name, "' already exists");
            throw CLICommandError.duplicatedCommand;
        }

        self.subCommands = tmpSubCommands;
        return;
    }
    
    /**
        Sets a function that can be invoked through the `CLICommand` instance.
        - Parameter method: Function to be setted.
        - Parameter optionsOrder: `CLICommand.options[].name` array that represents 
        the order of the options values that will be passed to method when executed.
        - Parameter requiresValue: Specify if the option requires a value (i.e. `--path /root` or `--path=/root`)
        - Parameter required: Specify if the option is required or optional.
    */
    public func setAction(_ method: @escaping CLIAction, _ optionsOrder: [String]) {
        self.action = method;
        self.actionOptionNamesOrder = optionsOrder;
        self.allowSubCommands = false;
    }
}

public typealias CLIAction = (_ args: Any...) -> Void;

/**
 * Check if a CLICommand array have a duplicated
 * `name` property.
 * - Parameter commands: Array of `CLICommand`
 * - Returns:
 * `true` when a duplicate is found and `false` otherwise.
 */
public func commandDuplicates(commands: [CLICommand]) -> Bool {
    var mutableCommands: [CLICommand] = commands;

    while(mutableCommands.count > 0) {
        let cmd: CLICommand? = mutableCommands.popLast();

        if (cmd == nil) { return true }

        for cmdToCheck: CLICommand in mutableCommands {
            if (cmdToCheck.name == cmd!.name) { return true }
        }
    }

    return false;
}

