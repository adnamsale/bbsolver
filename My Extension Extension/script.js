//document.addEventListener("DOMContentLoaded", function(event) {
window.addEventListener("load", function(event) {
    sendPageToExtension();
});

safari.self.addEventListener("message", handleMessage);

function sendPageToExtension() {
    let document = window.document
    let message = "Solve"
    let element = document.querySelector(".sudokutable");
    if (element !== null) {
      let type = "KillerSudoku"
      let titleElement = document.querySelector(".b2heading");
      if (titleElement !== null) {
          let title = titleElement.innerHTML;
          if (title.includes("Daily Sudoku")) {
            type = "Sudoku";
          }
      }
      safari.extension.dispatchMessage(message, {"source":element.innerHTML, "type":type});
      return;
    }
    element = document.querySelector(".SlitherlinkTable");
    if (element !== null) {
          safari.extension.dispatchMessage(message, {"source":element.innerHTML, "type":"Slitherlink"})
          return;
    }
}

function handleMessage(event) {
    let error = event.message.error;
    if (error) {
        alert(error);
        return;
    }
    let solution = event.message.solution;
    let type = event.message.type;
    switch(type) {
        case "Button":
            sendPageToExtension();
            break;
        case "Sudoku":
            for (i = 0 ; i < 9 ; ++i) {
                for (j = 0 ; j < 9 ; ++j) {
                    let input = document.querySelector("#BBsudokuinputA" + (i + 1) + (j + 1));
                    if (input != null) {
                        input.value = solution.charAt(9 * i + j);
                    }
                }
            }
            break;
        case "Slitherlink":
            let hor = solution.hor;
            for (let i = 0; i < hor.length; ++i) {
                let image = document.querySelector("#squareH" + i);
                if (image != null) {
                    image.src = "/gifs_slitherlink/" + hor.charAt(i) + "h.gif"
                }
            }
            let ver = solution.ver;
            for (let i = 0 ; i < ver.length ; ++i) {
                let image = document.querySelector("#squareV" + i);
                if (image != null) {
                    image.src = "/gifs_slitherlink/" + ver.charAt(i) + "v.gif"
                }
            }
            break;
    }
}
