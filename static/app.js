/*
This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.  See the GNU General Public License for more details.

https://www.gnu.org/licenses/
*/

/* Link event binding code. */
// Given a node, finds all <a> tags and mocks them
mockNode = function (node) {
    links = node.getElementsByTagName("a");
    mockCollection(links);
}

// Given an HTMLCollection, mocks the localized links
mockCollection = function (collection) {
    links = [];
    // Turn collection into an array for easy filter/map
    for (var ii = 0; ii < collection.length; ii++) {
        links[ii] = collection[ii];
    }
    links.filter(referencesRemote).map(mockLink);
}

// Given an <a>, binds navigateTo and preventDefault, marks link as mocked
mockLink = function (a) {
    a.addEventListener("click", function (e) {
        if (e.ctrlKey === true) return;
        e.preventDefault();
        navigateTo(a.href);
    });
    a.setAttribute("data-mocked", "true");
}

// Check if an <a> node references a local path and hasn't been mocked
// mocking is the act by which we take a link and suppress it with JS
referencesRemote = function (a) {
    // Use a.getAttribute instead of a.href since a.href coerces to full url
    url = a.getAttribute("href");
    
    // If the link has no href, ignore it
    if (url == undefined) return false;

    // If the link has mocking disabled, ignore it
    if (a.getAttribute("data-disable-mocking") == "true") return false;

    // If the link has already been mocked
    if (a.getAttribute("data-mocked") == "true") return false;

    // If the link is only a fragment, consider it local
    if ((/^#/).test(url)) return false;

    // If the link has a URI scheme, consider it non-local
    hasScheme = (/^\w+:\/\//).test(url)
    return !hasScheme;
}

/* History state changers and handlers */
navigateTo = function (url) {
    url = sanitizeUrl(url);
    history.pushState({}, "", url);
    onNavigate();
} 
onNavigate = function () {
    showCurrentPage();
}
window.onpopstate = onNavigate;

// Main entry point for a url change (popstate) event
// mediates between all associated content getting and embedding
showCurrentPage = function () {
    var path = window.location.pathname;

    // If we are navigating to root, simply close the current page and stop.
    if (path === "/") {
        var profile = document.getElementById("profile");
        profile.style.backgroundImage = "url(/<%=./utils/static/path.sh static/profile.jpg=%>)";
        // Add small delay to allow profile to be ready to flex before content
        // closes and blurb fades in
        setTimeout(function () {
            document.body.classList.remove("open");
            setTitleFromSection();
            selectSection(path);
        }, 20);
        return;
    }

    var section = findSection(path);
    if (section == undefined) {
        console.log("section does not exist", path)
        clearSelection();
        document.body.classList.add("open");
        getContent(path, function (content) {
            var section = createSection(path, content);
            setTitleFromSection(section);
            setTimeout(selectSection.bind(window, path), 100);
        }, function (response) {
            errorSection("Error " + response.status + " has occurred.<br/>" + response.response);
        });
    } else {
        var section = selectSection(path);
        setTitleFromSection(section);
        document.body.classList.add("open");
    }
}

setTitleFromSection = function (section) {
    if (section == undefined) return document.title = "Dylan Thinnes";

    var newTitle = section.getElementsByTagName("title")[0];
    if (newTitle == undefined) return document.title = "Dylan Thinnes";
    
    return document.title = newTitle.innerHTML;
}

/* URL getting and replacement */
// gets the content at the endpoint without the layout
getContent = function (url, callback, error) {
    var req = new XMLHttpRequest();
    req.onreadystatechange = function () {
        if (req.readyState == 4) {
            if (req.status == 200) callback(req.response);
            else                   error(req);
        }
    }
    if (url[0] != "/") throw "Url is not absolute."
    if      (/\/\w+$/.test(url)) url += "/index.html"
    else if (/\/\w+\/$/.test(url)) url += "index.html"
    req.open("GET", "/nolayout" + url);
    req.send();
}

/* Section Management */
// Sections contain the content for a given endpoint and have a data-url attr
// The page may be initialized with any number of sections

var sanitizeUrl = function (url) {
    if (url.slice(-1) === '/') {
        return url.slice(0,-1);
    } else if (url.slice(-11) === '/index.html') {
        return url.slice(0,-11);
    } else {
        return url;
    }
}

// Finds the section corresponding to a given url
findSection = function (url) {
    url = sanitizeUrl(url);
    if (url === "ERROR") return document.querySelector(".section#error");
    var sections = document.getElementsByClassName("section");
    for (var ii = 0; ii < sections.length; ii++) {
        var section = sections[ii];
        var sectionUrl = section.getAttribute("data-url");
        if (sectionUrl == undefined) continue;
        sectionUrl = sanitizeUrl(sectionUrl);
        if (sectionUrl == url) return section;
    }
}

// create a section container for content retrieved from an endpoint
// append it to the page container
createSection = function (url, content) {
    url = sanitizeUrl(url);
    var section = document.createElement("div");
    section.classList.add("section");
    section.setAttribute("data-url", url);

    var sectionContainer = document.createElement("div");
    sectionContainer.classList.add("section-container")
    sectionContainer.innerHTML = content;

    section.appendChild(sectionContainer);

    var content = document.getElementById("content");
    var loading = content.querySelector("#loading");

    content.insertBefore(section, loading);
    mockNode(section);
    initSection(section);

    return section;
}

// Initializes a new section by building a toc & running all scripts.
initSection = function (section) {
    // This runs after all scripts are fetched.
    var rest = function () {
        var toc = section.getElementsByClassName("toc")[0];
        if (toc != null) {
            var toggler = document.createElement("a");
            toggler.className = "toggler button";
            toggler.addEventListener("click", function () {
                toc.classList.toggle("hidden")
            })

            var title = toc.getElementsByTagName("h3")[0];
            title.appendChild(toggler);
        }

        if (window.Prism != undefined) {
            var codeBlocks = section.querySelectorAll("pre > code");
            for (var ii = 0; ii < codeBlocks.length; ii++) {
                var codeBlock = codeBlocks[ii];
                var classes = codeBlock.parentNode.classList;
                for (var jj = 0; jj < classes.length; jj++) {
                    var currClass = classes[jj];
                    if (Prism.languages[currClass] != undefined) {
                        codeBlock.classList.add("language-" + currClass);
                        Prism.highlightElement(codeBlock);
                        break;
                    }
                }
            }
        }
    }

    // Explicitly execute scripts
    var scripts = section.getElementsByTagName("script");
    var ii = 0;
    var runScript = function () {
        // Get current script, then progress counter to next script.
        var origScript = scripts[ii];
        ii++;

        // If the original script is null, just run the rest
        if (origScript == null) {
            rest();
        } else {
            var newScript = document.createElement("script");
            newScript.type = 'text/javascript'
            if (origScript.src) {
                // If remote, run as remote and run rest of scripts once this
                // one is done / errors out
                newScript.onload = runScript
                newScript.onerror = runScript
                newScript.src = origScript.src
                document.head.appendChild(newScript);
            } else {
                // If inline, just run that code
                try {
                    newScript.textContent = origScript.innerText
                    document.head.appendChild(newScript);
                } catch (e) {
                    console.log("Error occurred with script: ", origScript);
                }
                runScript();
            }
        }
    }
    runScript();
}

// select a section
selectSection = function (url) {
    clearSelection();
    section = findSection(url);
    section.classList.add("selected");
    return section;
}

getSelectedSections = function () {
    return document.querySelectorAll(".section.selected");
}

// unselect all sections
clearSelection = function (url) {
    var sections = document.getElementsByClassName("section");
    for (var ii = 0; ii < sections.length; ii++) {
        sections[ii].classList.remove("selected");
    }
}

// select the error section
errorSection = function (newError) {
    console.log("SETTING ERROR: ", newError);
    var errorText = findSection("ERROR").getElementsByClassName("text")[0];
    if (errorText != null) errorText.innerHTML = newError;
    selectSection("ERROR");
}

// Initialize mocking of links in page.
mockNode(document);
console.log("Nodes mocked.")

var ss = getSelectedSections();
for (var ii = 0; ii < ss.length; ii++) {
    initSection(ss[ii]);
}
