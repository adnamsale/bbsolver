document.addEventListener("DOMContentLoaded", function(event) {
    let element = document.querySelector(".sudokutable");
                          if (element === null) {
                          safari.extension.dispatchMessage("Null sudoku table");
                          }
                          else {
                          safari.extension.dispatchMessage(element.innerHTML);
                          }
});

safari.self.addEventListener("message", handleMessage);

function handleMessage(event) {
    let solution = event.message.solution;
    for (i = 0 ; i < 9 ; ++i) {
        for (j = 0 ; j < 9 ; ++j) {
            let input = document.querySelector("#BBsudokuinputA" + (i + 1) + (j + 1));
            if (input != null) {
                input.value = solution.charAt(9 * i + j);
            }
        }
    }
}
