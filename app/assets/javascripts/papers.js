// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var author_counter = 0;


function addAuthor() {
    $("span.authors").append($("span.author:first").clone()
			.find("input.gn").val("").attr("id","paper_forfatter_"+author_counter+"_gn").attr("name","paper[forfatter]["+author_counter+"][gn]").end()
			.find("input.sn").val("").attr("id","paper_forfatter_"+author_counter+"_sn").attr("name","paper[forfatter]["+author_counter+"][sn]").end());
    author_counter = author_counter+1;
   return false;
}

function removeAuthor(elem) {


    if ($("span.author").length > 1) {

        $(this).parent().parent().remove();
    } else {
        $(this).parent().parent().find("input").val("");
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
        } else {
            $('#createAssignmentBtn').attr("disabled", "disabled");
            $('#formCreateDiv').tooltip('show');
        };
    //$("#createAssignmentBtn").attr("enabled", !this.checked);
    });
 //   $("a.remove-author").click(removeAuthor);
  //  $("a.add-author").click(addAuthor);

    $("form").on("click", "a.add-author", addAuthor);
    $("form").on("click", "a.remove-author", removeAuthor);
    author_counter = $("span.author").length;

    $("#new_paper").validate(

        {
        rules: {
            'paper[title]': {required: true},
            'paper[afleveringsaar]': {required: true},
            'paper[studium]': {required: true},
            'paper[opgavesprog]': {required: true},
            'paper[opgavetype]': {required: true},

            'content': {required: true, accept: "pdf"}
        },
        messages: {
            'content': KBDIAS.file,
            'paper[title]':{
                required: KBDIAS.title
            },
            'paper[afleveringsaar]':{
                required: KBDIAS.afleveringsaar,
                minlength: KBDIAS.afleveringsaarlength
            },
            'paper[studium]': KBDIAS.studium,
            'paper[opgavesprog]': KBDIAS.opgavesprog,
            'paper[opgavetype]': KBDIAS.opgavetype
        }
    });


});
