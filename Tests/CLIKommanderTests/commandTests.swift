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

}