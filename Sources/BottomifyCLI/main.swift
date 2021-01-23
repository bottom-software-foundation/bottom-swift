import Bottomify
import SwiftCLI
import Files
import Foundation

enum CLIError: LocalizedError {
    case translationError
    case fileIOError(filename: String)

    var errorDescription: String? {
      switch self {
          case .translationError:
              return NSLocalizedString("Either input text or the --input options must be provided.", comment: "")
          case .fileIOError(let filename):
              return NSLocalizedString("Could not operate on file \(filename).", comment: "")
      }
    }
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
        [
            .atMostOne($bottomify, $regress),
        ]
    }

    func getText() -> Result<String, Error> {
      guard !(text != nil && input != nil || text == nil && input == nil) else {
          return .failure(CLIError.translationError)
      }

      if let text = text {
          return .success(text)
      } else {
        // Key/Param does not yet support defaults...
        // So stdin/stdout feeding can't be done as easily.
        return input.flatMap {
            try? File(path: $0).readAsString()
        }.map { .success($0) } ?? .failure(CLIError.fileIOError(filename: input!))
      }
    }

    func write(_ text: String) -> Result<Void, Error> {
      if output != nil {
          return output.flatMap {
              try? File(path: $0).write(text)
          }.map { .success(()) } ?? .failure(CLIError.fileIOError(filename: output!))
      } else {
          stdout <<< text
          return .success(())
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

let bottomifyCLI = CLI(singleCommand: BottomifyCLI())
bottomifyCLI.go()
