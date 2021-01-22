import Bottomify
import SwiftCLI
import Files

enum CLIError: Error {
  case translationError (why: String)
}

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
      return [
        .atMostOne($bottomify, $regress),
      ]
    }

    func getText() throws -> String {
      if text != nil && input != nil || text == nil && input == nil {
        throw CLIError.translationError(why: "Either input text or the --input options must be provided.")
      }

      var _input: String

      if text != nil {
        _input = text!
      } else {
        // Key/Param does not yet support defaults...
        // So stdin/stdout feeding can't be done as easily. 
        _input = try File(path: input!).readAsString()
      }

      return _input
    }

    func write(_ text: String) throws {
      if output != nil {
          let out = try File(path: output!)
          try out.write(text)
      } else {
        stdout <<< text
      }
    }

    func execute() throws {
        if bottomify {
          try write(try getText().bottomified())
        } else if regress {
          try write(try getText().regressed())
        }
    }
}

let bottomifyCLI = CLI(singleCommand: BottomifyCLI())
bottomifyCLI.go()
