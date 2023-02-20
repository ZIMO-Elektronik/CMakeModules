# Minify HTML
minify_html(comment.html ${CMAKE_BINARY_DIR}/comment_minified.html)
minify_html(sample1.html ${CMAKE_BINARY_DIR}/sample1_minified.html)

# Read minified HTML back
file(READ ${CMAKE_BINARY_DIR}/comment_minified.html COMMENT_MINIFIED)
file(READ ${CMAKE_BINARY_DIR}/sample1_minified.html SAMPLE1_MINIFIED)

# Compare minified HTML
set(COMMENT_STR
    [=[<div>Text after first single line comment.</div><div>Text after second single line comment.</div><div>Text after multi-line comment.</div>]=]
)
if(NOT COMMENT_MINIFIED STREQUAL COMMENT_STR)
  message(FATAL_ERROR "reason")
endif()

set(SAMPLE1_STR
    [=[<!DOCTYPE html><html><body> <div id="pageID1"> <strong style="margin: 0px; padding: 0px"> GeeksforGeeks </strong> is a computer science portal that contains articles on mordern technologies as well as programming.It also helps us to prepare for various competitive programming competitions as well. So,that's why, GeeksforGeeks is recommended for every student out there who is eager to learn about new things related to mordern technology. </div> <br /><br /> <div id="pageID2"> <div class="different markup"></div> <i style="margin: 0px; padding: 0px">GeeksforGeeks</i> <b>is a computer science portal that contains articles on mordern technologies as well as programming.It also helps us to prepare for various competitive programming competitions as well. So,that's why, <em style="color: green">GeeksforGeeks</em> is recommended for every student out there who is eager to learn about new things related to mordern technology.</b> </div> <br /> <h3 id="compareResultID" style="color: green"></h3> <script> Object.defineProperty(String.prototype, "hashCode", { value: function () { var hashValue = 0; var i, code; for (i = 0; i < this.length; i++) { code = this.charCodeAt(i); hashValue = hashValue * 32 - hashValue + code; hashValue |= 0; } return hashValue; }, }); var hashValue1 = document.getElementById("pageID1").innerText.hashCode(); var hashValue2 = document.getElementById("pageID2").innerText.hashCode(); if (hashValue1 !== hashValue2) { document.getElementById("compareResultID").innerHTML = "They are different Pages"; } else { document.getElementById("compareResultID").innerHTML = "Same Pages"; } </script></body></html>]=]
)
if(NOT SAMPLE1_MINIFIED STREQUAL SAMPLE1_STR)
  message(FATAL_ERROR "reason")
endif()
