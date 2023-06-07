import Foundation

internal func cliArgsToKeyValue(_ args: [String]) -> Void {
	var allowMoreCommands: Bool = true;
	var mutArgs: [String] = args;
	var parsedArgs: [CommandLineArg] = [];

	while(mutArgs.count != 0) {
		let e: String = mutArgs.removeFirst();

		// si encuentro una opcion y luego un comando
		// entonces debo salir
		if (!e.starts(with: "-")) {
			if (!allowMoreCommands) { exit(1) }
			let newArg: CommandLineArg = CommandLineArg("cmd", e);
			parsedArgs.append(newArg);
		} else {
			allowMoreCommands = false;
			if (e.starts(with: "--")) {
				if(e.contains("=")) {
					let kv: [String] = e.components(separatedBy: "=");
					let newArg: CommandLineArg = CommandLineArg("opt", kv[0], kv[1]);
					parsedArgs.append(newArg);
				} 
				else {
					if(!(mutArgs.first?.starts(with: "-") == true)) {
						let newArg: CommandLineArg = CommandLineArg("opt", e, mutArgs.removeFirst());
						parsedArgs.append(newArg);
					}
					else {
						let newArg: CommandLineArg = CommandLineArg("opt", e);
						parsedArgs.append(newArg);
					}
				}
			}
			else if (e.starts(with: "-")) {
				if(mutArgs.first != nil && !mutArgs.first!.starts(with: "-")) {
					let newArg: CommandLineArg = CommandLineArg("opt", e, mutArgs.removeFirst());
					parsedArgs.append(newArg);
				}
				else {
					let newArg: CommandLineArg = CommandLineArg("opt", e);
					parsedArgs.append(newArg);
				}
			}
		}
	}

	for e in parsedArgs { print(e) }
}

private struct CommandLineArg {
	let type: String;
	let name: String;
	let value: String?;

	init(_ type: String, _ name: String) {
		self.name = name;
		self.type = type;
		self.value = nil;
	}

	init(_ type: String, _ name: String, _ value: String) {
		self.name = name;
		self.type = type;
		self.value = value;
	}
}