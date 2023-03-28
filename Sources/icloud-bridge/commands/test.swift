//
//  File.swift
//  
//
//  Created by Ignacio Olave on 28-03-23.
//

import Foundation

private let options: [Option] = [
    Option(name: "--first", requiresValue: true, required: true),
    Option(name: "--second", requiresValue: true, required: true),
    Option(name: "--third", requiresValue: true, required: true),
];

private let method: CommandAction = {
    print("handle function 1")
};

public let testCommand: Command = Command(action: method, helpAction: method, options: options);
