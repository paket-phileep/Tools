const readline = require("readline");
const fs = require("fs");
const path = require("path");
const folderDoctor = require("./folder-doctor");

// Function to prompt user input from the terminal
function promptInput(question) {
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
  });

  return new Promise((resolve) => {
    rl.question(question, (answer) => {
      rl.close();
      resolve(answer);
    });
  });
}

// Function to get paths from command-line arguments or prompt the user
async function getPaths() {
  let srcPath, destPath, gitIgnorePath;

  const args = process.argv.slice(2); // Skip the first two arguments (node and script name)

  if (args.length >= 3) {
    // If arguments are provided, use them
    srcPath = args[0];
    destPath = args[1];
    gitIgnorePath = args[2];
  } else {
    // Prompt user for input if arguments are not provided
    srcPath = await promptInput("Enter the source path: ");
    destPath = await promptInput("Enter the destination path: ");
    gitIgnorePath = await promptInput("Enter the .gitignore path: ");
  }

  return { srcPath, destPath, gitIgnorePath };
}

// Main function to execute your logic
async function main() {
  const { srcPath, destPath, gitIgnorePath } = await getPaths();

  // Example usage of the paths
  console.log("Source Path:", srcPath);
  console.log("Destination Path:", destPath);
  console.log("Git Ignore Path:", gitIgnorePath);

  folderDoctor(srcPath, destPath, gitIgnorePath);


  // Your logic to use the paths
  // For example, copying files, etc.
}

// Execute the main function
main();
