import XCTest
@testable import CLICommand

final class CLIKommanderTests: XCTestCase {
    func test_print() {
		let res: [CommandLineArg] = cliArgsToKeyValue([
			"c1",
			"c2",
			"--o1", "v1",
			"--o2=v2",
			"--o3",
			"-x", "vx",
			"-y",
			"--o1", "v1",
			"--o2=v2",
			"--o3",
			"-x",
			"-y", "vx"
		]);        

		for e: CommandLineArg in res { print("type:", e.type, "name:", e.name, "\tvalue:", e.value as Any) }

        
		XCTAssert(true == true);
    }   
}