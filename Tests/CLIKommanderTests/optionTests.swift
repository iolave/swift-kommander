import XCTest
@testable import CLICommand

final class CLIOptionTests: XCTestCase {
    func test_init_error_throw_invalidNamePrefix() {
        let name: String = "test-opt";

        do {
            _ = try CLIOption(name: name, requiresValue: true, required: true);
        } catch CLIOptionError.invalidNamePrefix {
            return;
        } catch {
            XCTFail("Wrong error thrown");
            return;
        }
            
        XCTFail("No error thown");
    }

    func test_init_error_throw_invalidShorthandPrefix() {
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

    func test_init_success() {
        let name: String = "--test-opt";
        let shorthand: String = "-t";

        XCTAssertNoThrow(try CLIOption(name: name, shorthand: shorthand, requiresValue: true, required: true))
    }
}

final class optionDuplicatesTests: XCTestCase {
    func test_duplicates_true() throws {
        let name: String = "--test-opt";

        let opts: [CLIOption] = [
            try CLIOption(name: name, requiresValue: true, required: true),
            try CLIOption(name: name, requiresValue: true, required: true),
        ];

        XCTAssert(optionDuplicates(options: opts) == true);
    }

    func test_duplicates_false() throws {
        let name: String = "--test-opt";

        let opts: [CLIOption] = [
            try CLIOption(name: name, requiresValue: true, required: true),
        ];

        XCTAssert(optionDuplicates(options: opts) == false);
    }
}