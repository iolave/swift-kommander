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
    let helpAction: CommandAction?;
    let options: [Option]?;
    // TODO: add subcommands support
    
    init(action: @escaping CommandAction) {
        self.action = action;
        self.helpAction = nil;
        self.options = nil;
    }
    
    init(action: @escaping CommandAction, helpAction: @escaping CommandAction) {
        self.action = action;
        self.helpAction = helpAction;
        self.options = nil;
    }
    
    init(action: @escaping CommandAction, options: [Option]) {
        self.action = action;
        self.helpAction = nil;
        self.options = options;
    }
    
    init(action: @escaping CommandAction, helpAction: @escaping CommandAction, options: [Option]) {
        self.action = action;
        self.helpAction = helpAction;
        self.options = options;
    }
}


struct Option {
    let name: String;
    let requiresValue: Bool;
    let required: Bool;
    
    init(name: String, requiresValue: Bool, required: Bool) {
        if (!name.hasPrefix("--")) {
            print("Command Options are required to have '--' prefix");
            exit(1);
        }
        self.name = name
        self.requiresValue = requiresValue
        self.required = required
    }
}

// TODO: add support for custom functions using, maybe, typed parameters(?)
typealias CommandAction = () -> Void;


