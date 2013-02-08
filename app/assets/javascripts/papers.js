// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var author_counter = 0;


function addAuthor() {

    var author = $("span.author:first");
    $("span.authors").append($("span.author:first").clone().find("input").val("").attr("id","paper_forfatter_"+author_counter).end());
    author_counter = author_counter+1;
   return false;
}

function removeAuthor(elem) {


    if ($("span.author").length > 1) {

        $(this).parent().remove();
    } else {
        $(this).parent().find("input").val("");
    }
    return false;
}



$(document).ready(function(){
    $("[rel=tooltip]").tooltip();
    $("#termsConditionsCheckBox").click(function() {
        if ($('#termsConditionsCheckBox').is(':checked')) {
            $('#createAssignmentBtn').attr("enabled");
            $('#createAssignmentBtn').removeAttr("disabled");
            $('#formCreateDiv').tooltip('destroy');
            console.log("enabled");
        } else {
            $('#createAssignmentBtn').attr("disabled", "disabled");
            $('#formCreateDiv').tooltip('show');

            console.log("disabled");
        };
    //$("#createAssignmentBtn").attr("enabled", !this.checked);
    });
 //   $("a.remove-author").click(removeAuthor);
  //  $("a.add-author").click(addAuthor);

    $("form").on("click", "a.add-author", addAuthor);
    $("form").on("click", "a.remove-author", removeAuthor);
    author_counter=$("span.author").length;

});