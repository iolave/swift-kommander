import Foundation

enum MapCommandLineArgsError: Error {
	case AllowCommandsAfterOptions(_ value: Bool)
}

/** Reads an array of strings containing (sub)commands,
options (i.e. `--option`), option's shorthands (i.e. `-o`)
and it's corresponding values to map them in a readable way.
- Returns: An array of `CLIArgument` values, where `CLIArgument`
stores a type (`"cmd" || "opt"`), name and it's value when
`CLIArgument.type == "opt"`.
- Throws: An error of type `MapCommandLineArgsError`
*/
internal func mapCommandLineArgs(_ args: [String]) throws -> [CLIArgument] {
	/** Mutable version of args parameter */
	var mutArgs: [String] = args;
	/** Variable to store this function return value */
	var parsedArgs: [CLIArgument] = [];

	/** Flag that help us determine wether we have seen
	an option and thus no more subcommands will be allowed */
	var allowMoreCommands: Bool = true;

	/* Running a loop that will store in `parsedArgs` the key,
	value and type (`"cmd","opt"`) of what has been seen. 
	The amount of items on `mutArgs` will be reduced in each 
	iteration as it's always removing the first item of it */
	while(mutArgs.count != 0) {
		let e: String = mutArgs.removeFirst();


		/* Having in mind that subcommands does not have a `-`
		prefix we can append a command kv pair only and only
		if we're accepting more subcommmands */
		if (!e.starts(with: "-")) {
			if (!allowMoreCommands) { 
				throw MapCommandLineArgsError.AllowCommandsAfterOptions(allowMoreCommands)
			}
			parsedArgs.append(CLIArgument("cmd", e));
			continue;
		}

		/* At this point, we know for sure that whatever the element
		content is, it is indeed an option's shorthand or the option
		name itself, and thus we will not be accepting more commands */
		allowMoreCommands = false;

		/* Handling options (those that begins with a `--` prefix).
		There are three scenarios that has to be handled:
			1. `--option=value`
			2. `--option value`
			3. `--option`
		*/
		if (e.starts(with: "--")) {
			// Handles scenario "1"
			if (e.contains("=")) {
				let kv: [String] = e.components(separatedBy: "=");
				let value: Any = detectAndParseArgumentValue(kv[1]);
				parsedArgs.append(CLIArgument("opt", kv[0], value));
				continue;
			}
			
			// Handles scenario 2
			if (!(mutArgs.first?.starts(with: "-") == true)) {
				let value: Any = detectAndParseArgumentValue(mutArgs.removeFirst());
				parsedArgs.append(CLIArgument("opt", e, value));
				continue;
			}
			
			// Handles scenario 3
			parsedArgs.append(CLIArgument("opt", e, true));
			continue;
		}

		/* Handling option's shorthand (those that begins with a `-` prefix).
		There are two scenarios that has to be handled:
			1. `-o value`
			2. `-o`
		*/
		// Handles scenario 1
		if (mutArgs.first != nil && !mutArgs.first!.starts(with: "-")) {
			let value: Any = detectAndParseArgumentValue(mutArgs.removeFirst());
			parsedArgs.append(CLIArgument("opt", e, value));
			continue;
		}

		// Handles scenario 2
		parsedArgs.append(CLIArgument("opt", e, true));
		continue;
	}

	return parsedArgs;
}

// TODO: specify that only allowed values are int, string and bool
internal struct CLIArgument {
	let type: String;
	let name: String;
	let value: Any?;

	init(_ type: String, _ name: String) {
		self.name = name;
		self.type = type;
		self.value = nil;
	}

	init<T>(_ type: String, _ name: String, _ value: T) {
		self.name = name;
		self.type = type;
		switch value {
			case is String, is Int, is Bool:
				self.value = value;
			default:
				// TODO: add an error for unsopported types
				self.value = nil;
		}
	}
}

private func detectAndParseArgumentValue(_ str: String) -> Any {
	var isNumber: Bool = true;

	for character: Character in str {
        if !character.isNumber {
            isNumber = false;
			break;
        }
    }

	if isNumber { 
		return Int(str) ?? str
	}
	if (str == "true" || str == "false") { 
		return Bool(str) ?? str
	}
	print("is string:", str)
	return str;
}
