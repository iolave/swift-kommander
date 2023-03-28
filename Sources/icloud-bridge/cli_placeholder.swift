//
//  cli_placeholder.swift
//  
//
//  Created by Ignacio Olave on 27-03-23.
//

import Foundation

// TODO: change name
public class Commander {
    var commands: [String: Command];
    
    init(){
        self.commands = [:];
    }
    
    func addCommand(cmd: Command) {
        self.commands[cmd.name] = cmd;
    }
}

public class Command {
    let name: String;
    let action: CommandAction;
    let helpAction: CommandAction?;
    let options: [Option]?;
    // TODO: add subcommands support
    
    init(name: String, action: @escaping CommandAction) {
        self.name = name;
        self.action = action;
        self.helpAction = nil;
        self.options = nil;
    }
    
    init(name: String, action: @escaping CommandAction, helpAction: @escaping CommandAction) {
        self.name = name;
        self.action = action;
        self.helpAction = helpAction;
        self.options = nil;
    }
    
    init(name:String, action: @escaping CommandAction, options: [Option]) {
        self.name = name;
        self.action = action;
        self.helpAction = nil;
        self.options = options;
    }
    
    init(name:String, action: @escaping CommandAction, helpAction: @escaping CommandAction, options: [Option]) {
        self.name = name;
        self.action = action;
        self.helpAction = helpAction;
        self.options = options;
    }
}


public struct Option {
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
public typealias CommandAction = () -> Void;


