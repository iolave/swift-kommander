//
//  cli_placeholder.swift
//  
//
//  Created by Ignacio Olave on 27-03-23.
//

import Foundation

class Command {
    let action: CommandAction;
    
    init(action: @escaping CommandAction) {
        self.action = action
    }
}

typealias CommandAction = () -> Void;
