# Headmates
The goal of this project is to provide for the user as she writes in a textbox multiple suggestions for the next words / phrases.

# Development

## Installation
All steps should be taken from root directory of repository

### Install `npm`
Follow the instructions here: https://github.com/creationix/nvm
Any modern version of node and npm ought to work.

### Install Elm (importantly, `elm-package`)
`npm install -g elm`

### Install `elm-test`
`npm install -g elm-test`

### Install Elm dependencies
`elm-package install`

### Install `yarn`
`npm install -g yarn`

### Install `npm` dependencies
`yarn install`

## Development Environment
After installation, normal development involves the following.

### Running a local build, with webpack watching, recompilation, and auto-refresh of browser page
`yarn start`

### Running the tests
NOTE: `elm-test` (or `elm test`, they are the same) alone does not work! This is because we want collocated tests (no separate `tests/` directory). You must include a file matcher.
`elm-test src/**/*Test.elm` - run the tests
`elm-test src/**/*Test.elm --watch` - run the tests in watch mode
