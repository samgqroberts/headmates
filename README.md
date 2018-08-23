# Headmates
The goal of this project is to provide for the user as she writes in a textbox multiple suggestions for the next words / phrases.

Another goal is for me to learn about elm, markov chains, and later other methods of text prediction like neural nets.

# Development

## Installation
All steps should be taken from root directory of repository

### Install `npm` (using `nvm`)
Follow the instructions here: https://github.com/creationix/nvm  
You must use `npm` at a version of 5 or greater, for the `package-lock.json` to have effect

### Install `npm` dependencies
`npm install`  
You may also need to specifically say `npm install elm` in order for specific elm binaries, like elm-package, to be installed into node_modules

### Install Elm dependencies
`npm run elm-install`

## Development Environment
After installation, normal development involves the following.

### Building the webapp
#### For production assets
`npm run build` - builds the html, js, and css assets into `dist/`
#### For development
`npm run start` - runs a local build with webpack watching for source changes, recompiling, and auto-refreshing connected browser pages

### Testing
#### Single test run
`npm run test`
#### For development
`npm run start-test` - watches for source changes and re-runs the tests
