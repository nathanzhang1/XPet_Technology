import Foundation

func loadEnvFile(path: String = ".env") {
    guard let contents = try? String(contentsOfFile: path) else {
        print("⚠️  .env file not found at path: \(path)")
        return
    }

    contents.split(separator: "\n").forEach { line in
        guard !line.starts(with: "#") else { return } // allow comments
        let parts = line.split(separator: "=", maxSplits: 1)
        if parts.count == 2 {
            let key = parts[0].trimmingCharacters(in: .whitespacesAndNewlines)
            let value = parts[1].trimmingCharacters(in: .whitespacesAndNewlines)
            setenv(key, value, 1)
        }
    }
}
