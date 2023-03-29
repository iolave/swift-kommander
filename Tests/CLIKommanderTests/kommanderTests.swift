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
        XCTAssert(false)
    }
    
    
    
    //func testExample() throws {
        //let commandName = "test";
//
        //let options: [Option] = [
        //    Option(name: "--first", requiresValue: true, required: true),
        //    Option(name: "--second", requiresValue: true, required: true),
        //    Option(name: "--third", requiresValue: true, required: true),
        //];
//
        //let method: CommandAction = {
        //    print("handle function 1")
        //};
//
        //let testCommand: Command = Command(name: commandName, action: method, helpAction: //method, options: options);
        //
        //let kommander = Kommander(commands: [testCommand]);
        //kommander.parse(args: ["test"]);
    //}
}
