import XCTest
@testable import CLIKommander

final class HelpersTests: XCTestCase {
    func test_mapCommandLineArgs_success() {
		let res: [CLIArgument] = try! mapCommandLineArgs([
			"c1",
			"c2",
			"--o1", "v1",
			"--o2=v2",
			"--o3",
			"-x", "vx",
			"-y",
			"--o1", "true",
			"--o2=v2",
			"--o3",
			"-x",
			"-y", "vx",
			"-z", "false"
		]);

		// for e: CLIArgument in res {
		// 	print (e.value);
		// }
        
		XCTAssert(res.count == 13);
		
		XCTAssert(res[0].type  == "cmd"); XCTAssert(res[0].name  == "c1");   XCTAssert(res[0].value  == nil);
		XCTAssert(res[1].type  == "cmd"); XCTAssert(res[1].name  == "c2");   XCTAssert(res[1].value  == nil);
		XCTAssert(res[2].type  == "opt"); XCTAssert(res[2].name  == "--o1"); XCTAssert(res[2].value as! Optional<String> == "v1");
		XCTAssert(res[3].type  == "opt"); XCTAssert(res[3].name  == "--o2"); XCTAssert(res[3].value as! Optional<String>  == "v2");
		XCTAssert(res[4].type  == "opt"); XCTAssert(res[4].name  == "--o3"); XCTAssert(res[4].value as! Optional<Bool> == true);
		XCTAssert(res[5].type  == "opt"); XCTAssert(res[5].name  == "-x");   XCTAssert(res[5].value as! Optional<String> == "vx");
		XCTAssert(res[6].type  == "opt"); XCTAssert(res[6].name  == "-y");   XCTAssert(res[6].value as! Optional<Bool> == true);
		XCTAssert(res[7].type  == "opt"); XCTAssert(res[7].name  == "--o1"); XCTAssert(res[7].value as! Optional<String> == "true");
		XCTAssert(res[8].type  == "opt"); XCTAssert(res[8].name  == "--o2"); XCTAssert(res[8].value as! Optional<String> == "v2");
		XCTAssert(res[9].type  == "opt"); XCTAssert(res[9].name  == "--o3"); XCTAssert(res[9].value as! Optional<Bool> == true);
		XCTAssert(res[10].type == "opt"); XCTAssert(res[10].name == "-x");   XCTAssert(res[10].value as! Optional<Bool> == true);
		XCTAssert(res[11].type == "opt"); XCTAssert(res[11].name == "-y");   XCTAssert(res[11].value as! Optional<String> == "vx");
		XCTAssert(res[12].type == "opt"); XCTAssert(res[12].name == "-z");   XCTAssert(res[12].value as! Optional<String> == "false");
	}

    func test_mapCommandLineArgs_error_doesNotAllowMoreCommands() {
		do {
			let args: [String] = ["c1", "c2", "-c1", "c3"];
            _ = try mapCommandLineArgs(args);
        } catch MapCommandLineArgsError.AllowCommandsAfterOptions(false) {
            return;
        } catch {
            XCTFail("Wrong error thrown");
            return;
        }
	}
}