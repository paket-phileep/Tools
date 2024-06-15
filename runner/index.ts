const assert = require('node:assert');
const fs = require('node:fs');
const { spawn } = require('node:child_process');

type time = {
    started  : time 
    ended : time
}


type session = {
    id : number
    time : time
}



type terminalInput = {
    input : string
}


class instance {

    terminate() {

   } 


    constructor(initialCommand) {
        this.uuid = Math.rand()

    }
    session : session
    logs : 
    command :
    
}



function pipeInputToInstance ({input}):  terminalInput {
    
    return "hi"

}

const subprocess = spawn('pwd', {
  stdio: [
    0, // Use parent's stdin for child.
    'pipe', // Pipe child's stdout to parent.
    fs.openSync('err.out', 'w'), // Direct child's stderr to a file.
  ],
});


const subprocess = spawn('ls');

subprocess.stdout.on('data', (data) => {
  console.log(`Received chunk ${data}`);
});

