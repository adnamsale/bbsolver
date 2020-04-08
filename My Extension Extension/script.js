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
    element = document.querySelector(".futoshikitable");
    if (element !== null) {
        safari.extension.dispatchMessage(message, {"source":element.innerHTML, "type":"ABCPath"})
        return;
    }
    element = document.querySelector(".BridgesTable");
    if (element !== null) {
        safari.extension.dispatchMessage(message, {"source":element.innerHTML, "type":"Bridges"})
        return;
    }
    element = document.querySelector("#puzzlediv > .fillingtable");
    if (element !== null) {
        safari.extension.dispatchMessage(message, {"source":element.innerHTML, "type":"Fillomino"})
        return;
    }
    element = document.querySelector(".lightuptable");
    if (element !== null) {
        safari.extension.dispatchMessage(message, {"source":element.innerHTML, "type":"LightUp"})
        return;
    }
    element = document.querySelector(".NonoTable");
    if (element !== null) {
        safari.extension.dispatchMessage(message, {"source":element.innerHTML, "type":"Nonogrids"});
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
        case "ABCPath":
            for (i = 0 ; i < 5 ; ++i) {
                for (j = 0 ; j < 5 ; ++j) {
                    let input = document.querySelector("#BBabcpathinput" + (i + 1) + (j + 1));
                    if (input != null) {
                        input.value = solution.charAt(5 * i + j);
                    }
                }
            }
            break;
        case "Bridges":
            for (i = 0 ; i < solution.length ; ++i) {
                let image = document.querySelector("#square" + i);
                if (image != null && solution.charAt(i) !== ' ') {
                    image.src = "/gifs_bridges_new/" + solution.charAt(i) + ".gif";
                }
            }
            break;
        case "Fillomino":
            let dim = Math.sqrt(solution.length)
            for (i = 0 ; i < solution.length ; ++i) {
                let row = Math.floor(i / dim);
                let col = i % dim;
                let id = "#square" + row.toString().padStart(3, "_") + col.toString().padStart(3, "_");
                let td = document.querySelector(id);
                if (td != null) {
                    td.innerHTML = solution.charAt(i)
                }
            }
            break;
        case "LightUp":
            for (i = 0 ; i < solution.length ; ++i) {
                let image = document.querySelector("#square" + i);
                if (image != null && solution.charAt(i) !== ' ') {
                    if (solution.charAt(i) === 'B') {
                        image.src = "gifs_lightup/bulb.gif";
                    }
                    else if (solution.charAt(i) === 'X') {
                        image.src = "gifs_lightup/crsy.gif";
                    }
                    else {
                        image.src = "gifs_lightup/yell.gif"
                    }
                }
            }
            break;
        case "Nonogrids":
            for (i = 0 ; i < solution.length ; ++i) {
                let image = document.querySelector("#square" + i);
                if (image != null) {
                    if (solution.charAt(i) === 'B') {
                        image.src = "/gifs_nonogrids/y.gif";
                    }
                    else if (solution.charAt(i) === 'W') {
                        image.src = "/gifs_nonogrids/x.gif";
                    }
                    else {
                        image.src = "/gifs_nonogrids/n.gif";
                    }
                }
            }
            break;
    }
}
