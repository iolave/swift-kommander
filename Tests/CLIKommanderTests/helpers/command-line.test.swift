import XCTest
@testable import CLICommand

final class CLIKommanderTests: XCTestCase {
    func test_print() {
		let res: [CLIArgument] = mapCommandLineArgs([
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
        
		XCTAssert(res.count == 12);
		
		XCTAssert(res[0].type == "cmd"); XCTAssert(res[0].name == "c1"); XCTAssert(res[0].value == nil);
		XCTAssert(res[1].type == "cmd"); XCTAssert(res[1].name == "c2"); XCTAssert(res[1].value == nil);
		XCTAssert(res[2].type == "opt"); XCTAssert(res[2].name == "--o1"); XCTAssert(res[2].value == "v1");
		XCTAssert(res[3].type == "opt"); XCTAssert(res[3].name == "--o2"); XCTAssert(res[3].value == "v2");
		XCTAssert(res[4].type == "opt"); XCTAssert(res[4].name == "--o3"); XCTAssert(res[4].value == nil);
		XCTAssert(res[5].type == "opt"); XCTAssert(res[5].name == "-x"); XCTAssert(res[5].value == "vx");
		XCTAssert(res[6].type == "opt"); XCTAssert(res[6].name == "-y"); XCTAssert(res[6].value == nil);
		XCTAssert(res[7].type == "opt"); XCTAssert(res[7].name == "--o1"); XCTAssert(res[7].value == "v1");
		XCTAssert(res[8].type == "opt"); XCTAssert(res[8].name == "--o2"); XCTAssert(res[8].value == "v2");
		XCTAssert(res[9].type == "opt"); XCTAssert(res[9].name == "--o3"); XCTAssert(res[9].value == nil);
		XCTAssert(res[10].type == "opt"); XCTAssert(res[10].name == "-x"); XCTAssert(res[10].value == nil);
		XCTAssert(res[11].type == "opt"); XCTAssert(res[11].name == "-y"); XCTAssert(res[11].value == "vx");
	}   
}