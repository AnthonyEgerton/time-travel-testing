# Time Travel Testing

Sample code for "Time Travel Testing" presentation: [Watch Video](https://vimeo.com/146536576)

Tips for how to handle testing code that requires the passage of time to pass.
This includes asynchronous code & code dependent on dates/times.

## Tips
1. Avoid - Factor out the code to be tested separately, from the async code.
2. Fake - Fake out the code to provide the current date so you can control the passage of time at will, within your tests.
3. Expect - Use XCTest expectations to wait for async code to be complete.
4. Count - Use the operationCount of the subject’s OperationQueue and the main OperationQueue to tell when all operations are complete.
