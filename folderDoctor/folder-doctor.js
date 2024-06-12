const fs = require("fs");
const path = require("path");
const ignore = require("ignore");

function folderDoctor(srcPath, destPath, gitIgnorePath = null) {
  // ANSI escape code for colors
  const colors = {
    reset: "\x1b[0m",
    red: "\x1b[31m",
    green: "\x1b[32m",
    yellow: "\x1b[33m",
    brightGreen: "\x1b[32;1m",
    brightCyan: "\x1b[36;1m",
  };

  function copyFileSync(source, target) {
    try {
      const targetFile = target;
      const isDir = fs.lstatSync(source).isDirectory();

      if (isDir && !fs.existsSync(targetFile)) {
        fs.mkdirSync(targetFile);
      }

      fs.writeFileSync(targetFile, fs.readFileSync(source));
      console.log(`${colors.green}Copied: ${source} -> ${target}${colors.reset}`);
    } catch (err) {
      console.error(`${colors.red}Error copying file ${source}: ${err.message}${colors.reset}`);
    }
  }

  function copyFolderSync(source, target, ignoreFilter) {
    try {
      if (!fs.existsSync(target)) {
        fs.mkdirSync(target, { recursive: true });
      }

      fs.readdirSync(source).forEach((file) => {
        const sourcePath = path.join(source, file);
        const targetPath = path.join(target, file);

        if (!ignoreFilter || !ignoreFilter.ignores(path.relative(source, sourcePath))) {
          if (fs.lstatSync(sourcePath).isDirectory()) {
            copyFolderSync(sourcePath, targetPath, ignoreFilter);
          } else {
            copyFileSync(sourcePath, targetPath);
          }
        }
      });

      console.log(`${colors.brightGreen}Folder copied: ${source} -> ${target}${colors.reset}`);
    } catch (err) {
      console.error(`${colors.red}Error copying folder ${source}: ${err.message}${colors.reset}`);
    }
  }

  function deleteRemovedFiles(srcPath, destPath, ignoreFilter) {
    try {
      if (fs.existsSync(destPath)) {
        fs.readdirSync(destPath).forEach((file) => {
          const srcFilePath = path.join(srcPath, file);
          const destFilePath = path.join(destPath, file);

          if (!fs.existsSync(srcFilePath)) {
            if (fs.lstatSync(destFilePath).isDirectory()) {
              fs.rmdirSync(destFilePath, { recursive: true });
              console.log(`${colors.yellow}Deleted directory: ${destFilePath}${colors.reset}`);
            } else {
              fs.unlinkSync(destFilePath);
              console.log(`${colors.yellow}Deleted file: ${destFilePath}${colors.reset}`);
            }
          } else if (fs.lstatSync(destFilePath).isDirectory()) {
            deleteRemovedFiles(srcFilePath, destFilePath, ignoreFilter);
          }
        });
      }
    } catch (err) {
      console.error(`${colors.red}Error deleting files: ${err.message}${colors.reset}`);
    }
  }

  function watchFolder(srcPath, destPath, ignoreFilter) {
    try {
      copyFolderSync(srcPath, destPath, ignoreFilter);

      fs.watch(srcPath, { recursive: true }, (eventType, filename) => {
        if (eventType === "change" || eventType === "rename") {
          console.log(`${colors.yellow}Detected change: ${filename}${colors.reset}`);

          deleteRemovedFiles(srcPath, destPath, ignoreFilter);
          copyFolderSync(srcPath, destPath, ignoreFilter);
        }
      });

      console.log(`${colors.brightCyan}Watching for changes in: ${srcPath}${colors.reset}`);
    } catch (err) {
      console.error(`${colors.red}Error watching folder: ${err.message}${colors.reset}`);
    }
  }

  // Read and parse .gitignore file
  function readGitIgnore(filePath) {
    try {
      const content = fs.readFileSync(filePath, "utf-8");
      const ignoreFilter = ignore().add(content);
      return ignoreFilter;
    } catch (err) {
      console.log(`${colors.red}Error reading .gitignore file: ${err.message}${colors.reset}`);
      return null;
    }
  }

  const ignoreFilter = gitIgnorePath ? readGitIgnore(gitIgnorePath) : null;

  if (!fs.existsSync(destPath)) {
    fs.mkdirSync(destPath, { recursive: true });
  }

  watchFolder(srcPath, destPath, ignoreFilter);

  // Keep the application running
  process.stdin.resume();
}

module.exports = folderDoctor;
