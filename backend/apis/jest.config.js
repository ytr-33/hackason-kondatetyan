/** @type {import('ts-jest').JestConfigWithTsJest} */
module.exports ={
    preset:'ts-jest',
    testEnvironment:'node',
    setupFileAfterEnv:["./jest.setup.ts"]
}