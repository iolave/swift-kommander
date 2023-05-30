import XCTest
@testable import CLICommand

final class CLICommandTests: XCTestCase {
    func test_init_error_throw_initWithEmptyOptions() {
        let name: String = "test-cmd";
        let action: CLIAction = CLIAction({ args in });

        do {
            _ = try CLICommand(name: name, action: action, options: []);
        } catch CLICommandError.initWithEmptyOptions {
            return;
        } catch {
            XCTFail("Wrong error thrown");
            return;
        }
            
        XCTFail("No error thown");
    }

    func test_init_error_throw_duplicatedOptions_name() {
        let name: String = "test-cmd";
        let action: CLIAction = CLIAction({ args in });

        let optName: String = "--test-opt";
        let options: [CLIOption] = [
            try! CLIOption(name: optName, requiresValue: true, required: true),
            try! CLIOption(name: optName, requiresValue: true, required: true)
        ]

        do {
            _ = try CLICommand(name: name, action: action, options: options);
        } catch CLICommandError.duplicatedOptions {
            return;
        } catch {
            XCTFail("Wrong error thrown");
            return;
        }
            
        XCTFail("No error thown");
    }

    func test_init_error_throw_duplicatedOptions_shorthand() {
        let name: String = "test-cmd";
        let action: CLIAction = CLIAction({ args in });

        let shorthand: String = "--test-opt";
        let options: [CLIOption] = [
            try! CLIOption(name: "--test-opt-1", shorthand: shorthand, requiresValue: true, required: true),
            try! CLIOption(name: "--test-opt-2", shorthand: shorthand, requiresValue: true, required: true),
        ]

        do {
            _ = try CLICommand(name: name, action: action, options: options);
        } catch CLICommandError.duplicatedOptions {
            return;
        } catch {
            XCTFail("Wrong error thrown");
            return;
        }
            
        XCTFail("No error thown");
    }

    func test_init_success() {
        let name: String = "test-cmd";
        let action: CLIAction = CLIAction({ args in });

        let options: [CLIOption] = [
            try! CLIOption(name: "--test-opt-1", shorthand: "-a", requiresValue: true, required: true),
            try! CLIOption(name: "--test-opt-2", shorthand: "-b", requiresValue: true, required: true),
        ]

        XCTAssertNoThrow(try CLICommand(name: name, action: action, options: options))
    }

    func test_addOption_error_throw_commandOnlyAllowsAddSubCommandMethod() {
        let name: String = "test-cmd";

        let cmd: CLICommand = CLICommand(name: name);
        cmd.subCommands = [];

        do {
            try cmd.addOption(name: "--test-option", shorthand: nil, requiresValue: true, required: true);
        } catch CLICommandError.commandOnlyAllowsAddCommandMethod { return }
        catch {
            XCTFail("Wrong error thrown");
            return;
        }
            
        XCTFail("No error thown");
    }

    func test_addOption_error_throw_duplicatedOptions_name() {
        let name: String = "test-cmd";
        let action: CLIAction = CLIAction({ args in });

        let cmd: CLICommand = CLICommand(name: name, action: action);

        do {
            try cmd.addOption(name: "--test-option", shorthand: nil, requiresValue: true, required: true);
            try cmd.addOption(name: "--test-option", shorthand: nil, requiresValue: true, required: true);
        } catch CLICommandError.duplicatedOptions { return }
        catch {
            XCTFail("Wrong error thrown");
            return;
        }
            
        XCTFail("No error thown");
    }
    
    func test_addOption_error_throw_duplicatedOptions_shorthand() {
        let name: String = "test-cmd";
        let action: CLIAction = CLIAction({ args in });

        let cmd: CLICommand = CLICommand(name: name, action: action);

        do {
            try cmd.addOption(name: "--test-option-a", shorthand: "-t", requiresValue: true, required: true);
            try cmd.addOption(name: "--test-option-b", shorthand: "-t", requiresValue: true, required: true);
        } catch CLICommandError.duplicatedOptions { return }
        catch {
            XCTFail("Wrong error thrown");
            return;
        }
            
        XCTFail("No error thown");
    }

    func test_addOption_error_throw_invalidNamePrefix() {
        let name: String = "test-cmd";
        let action: CLIAction = CLIAction({ args in });

        let cmd: CLICommand = CLICommand(name: name, action: action);

        do {
            try cmd.addOption(name: "test-option", shorthand: nil, requiresValue: true, required: true);
        } catch CLIOptionError.invalidNamePrefix { return }
        catch {
            XCTFail("Wrong error thrown");
            return;
        }
            
        XCTFail("No error thown");
    }

    func test_addOption_error_throw_invalidShorthandPrefix() {
        let name: String = "test-cmd";
        let action: CLIAction = CLIAction({ args in });

        let cmd: CLICommand = CLICommand(name: name, action: action);

        do {
            try cmd.addOption(name: "--test-option", shorthand: "t", requiresValue: true, required: true);
        } catch CLIOptionError.invalidShorthandPrefix { return }
        catch {
            XCTFail("Wrong error thrown");
            return;
        }
            
        XCTFail("No error thown");
    }

    func test_addOption_success() {
        let name: String = "test-cmd";
        let action: CLIAction = CLIAction({ args in });

        let cmd: CLICommand = CLICommand(name: name, action: action);
        XCTAssertNoThrow(try cmd.addOption(name: "--test-option", shorthand: "-t", requiresValue: false, required: false));
    }

    func test_addCommand_success() {
        let name: String = "test-cmd";

        let cmd: CLICommand = CLICommand(name: name);
        let subCmd: CLICommand = CLICommand(name: name);
        XCTAssertNoThrow(try cmd.addCommand(command: subCmd));
    }

    func test_addCommand_error_throw_duplicatedCommand() {
        let name: String = "test-cmd";

        let cmd: CLICommand = CLICommand(name: name);
        let subCmd: CLICommand = CLICommand(name: name);

        do {
            try cmd.addCommand(command: subCmd);
            try cmd.addCommand(command: subCmd);
        } catch CLICommandError.duplicatedCommand { return }
        catch {
            XCTFail("Wrong error thrown");
            return;
        }

        XCTFail("No error thown");
    }

    func test_addCommand_error_throw_commandDoesNotAllowsAddCommandMethod() {
        let name: String = "test-cmd";

        let action: CLIAction = CLIAction({ args in });
        let cmd: CLICommand = CLICommand(name: name, action: action);
        let subCmd: CLICommand = CLICommand(name: name);

        do {
            try cmd.addCommand(command: subCmd);
        } catch CLICommandError.commandDoesNotAllowsAddCommandMethod { return }
        catch {
            XCTFail("Wrong error thrown");
            return;
        }

        XCTFail("No error thown");
    }
}
