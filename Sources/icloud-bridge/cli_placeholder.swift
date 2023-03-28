//
//  cli_placeholder.swift
//  
//
//  Created by Ignacio Olave on 27-03-23.
//

import Foundation

// TODO: change name
class Commander {
    var commands: [String: Command];
    
    init(){
        self.commands = [:];
    }
    
    func addCommand(name: String, cmd: Command) {
        self.commands[name] = cmd;
    }
}

class Command {
    let action: CommandAction;
    
    init(action: @escaping CommandAction) {
        self.action = action
    }
}

typealias CommandAction = () -> Void;
