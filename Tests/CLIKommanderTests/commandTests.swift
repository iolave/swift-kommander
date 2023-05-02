import XCTest
@testable import CLIKommander

final class CLICommandBaseTests: XCTestCase {

    func testInit_ThrowEmptyOptionsError() {
        let name: String = "test-cmd";
        let action: CommandAction = {};

        do {
            try CLICommandBase(name: name, action: action, options: []);
        } catch CLICommandBaseError.initWithEmptyOptions {
            return;
        } catch {
            XCTFail("Wrong error thrown");
            return;
        }
            
        XCTFail("No error thown");
    }

    func testInit_ThrowDuplicatedOptionsError_name() {
        let name: String = "test-cmd";
        let action: CommandAction = {};

        let optName: String = "--test-opt";
        let options: [CLIOption] = [
            try! CLIOption(name: optName, requiresValue: true, required: true),
            try! CLIOption(name: optName, requiresValue: true, required: true)
        ]

        do {
            try CLICommandBase(name: name, action: action, options: options);
        } catch CLICommandBaseError.duplicatedOptions {
            return;
        } catch {
            XCTFail("Wrong error thrown");
            return;
        }
            
        XCTFail("No error thown");
    }

    func testInit_ThrowDuplicatedOptionsError_shorthand() {
        let name: String = "test-cmd";
        let action: CommandAction = {};

        let shorthand: String = "--test-opt";
        let options: [CLIOption] = [
            try! CLIOption(name: "--test-opt-1", shorthand: shorthand, requiresValue: true, required: true),
            try! CLIOption(name: "--test-opt-2", shorthand: shorthand, requiresValue: true, required: true),
        ]

        do {
            try CLICommandBase(name: name, action: action, options: options);
        } catch CLICommandBaseError.duplicatedOptions {
            return;
        } catch {
            XCTFail("Wrong error thrown");
            return;
        }
            
        XCTFail("No error thown");
    }

    func testInit_DontThrowError() {
        let name: String = "test-cmd";
        let action: CommandAction = {};

        let options: [CLIOption] = [
            try! CLIOption(name: "--test-opt-1", shorthand: "-a", requiresValue: true, required: true),
            try! CLIOption(name: "--test-opt-2", shorthand: "-b", requiresValue: true, required: true),
        ]

        XCTAssertNoThrow(try CLICommandBase(name: name, action: action, options: options))
    }
}

final class CLIOptionTests: XCTestCase {

    func testInit_ThrowInvalidNamePrefixError() {
        let name: String = "test-opt";

        do {
            try CLIOption(name: name, requiresValue: true, required: true);
        } catch CLIOptionError.invalidNamePrefix {
            return;
        } catch {
            XCTFail("Wrong error thrown");
            return;
        }
            
        XCTFail("No error thown");
    }

    func testInit_ThrowInvalidShorthandPrefixError() {
        let name: String = "--test-opt";
        let shorthand: String = "test";

        do {
            _ = try CLIOption(name: name, shorthand: shorthand, requiresValue: true, required: true);
        } catch CLIOptionError.invalidShorthandPrefix {
            return;
        } catch {
            XCTFail("Wrong error thrown");
            return;
        }
            
        XCTFail("No error thown");
    }

    func testInit_DontThrowError() {
        let name: String = "--test-opt";
        let shorthand: String = "-t";

        XCTAssertNoThrow(try CLIOption(name: name, shorthand: shorthand, requiresValue: true, required: true))
    }

}