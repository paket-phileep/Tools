# FolderDoctor

FolderDoctor is a Node.js application that synchronizes the contents of one folder (source) to another folder (destination), including handling file changes, additions, deletions, and optionally respecting `.gitignore` rules.

## Features

- **Real-time Synchronization**: Automatically copies files and directories from the source to the destination folder.
- **Handles Changes**: Detects and applies changes such as additions, modifications, and deletions.
- **Optional `.gitignore` Support**: Optionally reads a `.gitignore` file to exclude specified files and directories from synchronization.
- **Directory Creation**: Creates the destination directory if it does not exist.

## Command-Line Usage

You can run the script with three command-line arguments for the paths. The order of the arguments should be:

1. Source path
2. Destination path
3. .gitignore path

For example:

```sh
node script.js /path/to/source /path/to/destination /path/to/.gitignore
```

# Interactive Usage

If you run the script without providing command-line arguments, it will prompt you to enter the paths interactively. When you run:

```sh
node script.js
```

The script will prompt you for the following:

- Source path
- Destination path
- .gitignore path

You will need to enter the paths one by one when prompted.

## Example Usage

### Using Command-Line Arguments:

```sh
node script.js /home/user/project/src /home/user/project/dest /home/user/project/.gitignore
```

### Interactive Mode:

```sh
node script.js
```

You will see prompts like:

```javascript
Enter the source path: /home/user/project/src
Enter the destination path: /home/user/project/dest
Enter the .gitignore path: /home/user/project/.gitignore
```

# Main Function

Once the paths are retrieved (either from command-line arguments or user input), the script prints them and then calls the `folderDoctor` function with these paths. This function presumably handles some operations like copying files, processing .gitignore rules, etc.

Here is the core part of the script:

```javascript
const { srcPath, destPath, gitIgnorePath } = await getPaths();

console.log("Source Path:", srcPath);
console.log("Destination Path:", destPath);
console.log("Git Ignore Path:", gitIgnorePath);

folderDoctor(srcPath, destPath, gitIgnorePath);
```

## Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/yourusername/folderdoctor.git
   cd folderdoctor
   ```

2. **Install dependencies:**

   ```bash
   npm install
   ```

## Usage

To use FolderDoctor, you need to provide the source and destination paths, and optionally the path to a `.gitignore` file.

### Javscrit 

You can use the app via javascript by creating a simple script. For example, create a `start.js` file:

```javascript
const folderDoctor = require('./path/to/folderDoctor'); or npm 

const srcPath = '/path/to/source/folder';
const destPath = '/path/to/destination/folder';
const gitIgnorePath = '/path/to/.gitignore'; // Optional

folderDoctor(srcPath, destPath, gitIgnorePath);
```

Then, run the script:

```bash
node start.js
```

### Parameters

- `srcPath`: The path to the source folder.
- `destPath`: The path to the destination folder.
- `gitIgnorePath` (optional): The path to the `.gitignore` file. If not provided, all files and directories will be synchronized.

### Logging

FolderDoctor logs its actions to the console using ANSI escape codes to highlight different types of messages:

- **Green**: File or folder copied.
- **Yellow**: Changes detected.
- **Bright Green**: Folder copied.
- **Bright Cyan**: Watching for changes.
- **Red**: Errors.

## Error Handling

FolderDoctor handles errors by logging them to the console with detailed messages. If the `.gitignore` file cannot be read, a warning is logged, and synchronization proceeds without ignoring any files.

## Contributions

Contributions are welcome! Please fork the repository and submit a pull request with your changes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact

For any questions or issues, please open an issue on GitHub or contact the repository owner.

---

Enjoy using FolderDoctor! Keep your folders in sync effortlessly.
