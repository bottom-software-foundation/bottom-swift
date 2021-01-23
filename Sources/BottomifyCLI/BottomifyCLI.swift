import Bottomify
import SwiftCLI
import Files
import Foundation

class BottomifyCLI: Command {
    let name = "bottomify"
    let description = "Fantastic (maybe) CLI for translating between bottom and human-readable text"
    
    @Flag("-b", "--bottomify", description: "Translate text to bottom")
    var bottomify: Bool
    
    @Flag("-r", "--regress", description: "Translate bottom to human-readable text (futile)")
    var regress: Bool
    
    @Key("-i", "--input", description: "Input file [Default: stdin]")
    var input: String?
    
    @Key("-o", "--output", description: "Output file [Default: stdout]")
    var output: String?
    
    @Param var text: String?
    
    var optionGroups: [OptionGroup] {
        [
            .atMostOne($bottomify, $regress)
        ]
    }
    
    func getText() -> BottomifyCLIResult<String> {
        guard text != nil && input == nil || text == nil && input != nil else {
            return .failure(.translationError)
        }
        
        if let text = text {
            return .success(text)
        } else if let input = input, let result = try? File(path: input).readAsString() {
            return .success(result)
        } else if let input = input {
            return .failure(.fileIOError(filename: input))
        } else {
            return .failure(.translationError)
        }
    }
    
    func write(_ text: String) -> BottomifyCLIResult<Void> {
        guard let output = output else {
            stdout <<< text
            return .success(())
        }
        
        if (try? File(path: output).write(text)) != nil {
            return .success(())
        } else {
            return .failure(.fileIOError(filename: output))
        }
    }
    
    func execute() throws {
        if bottomify {
            try write(getText().get().bottomified()).get()
        } else if regress {
            try write(try getText().get().regressed()).get()
        }
    }
}
