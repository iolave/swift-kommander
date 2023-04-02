import XCTest
@testable import CLIKommander

final class KommanderTests: XCTestCase {
 
    func testInitWithNoArgs() {
        let kommander: Kommander = Kommander();
        XCTAssertTrue(kommander.commands.isEmpty);
    }
    
    func testInitWithCommandsArg() {
        let action: CommandAction = {}
        let cmdName: String = "test";
        let cmd: Command = Command(name: cmdName, action: action);
        
        let kommander: Kommander = Kommander(commands: [cmd]);
        
        XCTAssert(kommander.commands[cmdName] != nil);
    }
    
    func testMethodAddCommand() {
        let action: CommandAction = {}
        let cmdName: String = "test";
        let cmd: Command = Command(name: cmdName, action: action);

        let kommander: Kommander = Kommander();
        kommander.addCommand(cmd: cmd);
        
        XCTAssert(kommander.commands[cmdName] != nil);
    }
    
    func testMethodParse() {
        CommandLine.arguments.append("test")
        let kommander: Kommander = Kommander();
        kommander.parse();
        //XCTAssert(false)
    }
    
}
