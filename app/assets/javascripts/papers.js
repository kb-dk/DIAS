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


  /*
    $("#termsConditionsCheckBox").click(function() {
        if ($('#termsConditionsCheckBox').is(':checked')) {
            $('#createAssignmentBtn').attr("enabled");
            $('#createAssignmentBtn').removeAttr("disabled");
            $('#formCreateDiv').tooltip('destroy');
        } else {
            $('#createAssignmentBtn').attr("disabled", "disabled");
            $('#formCreateDiv').tooltip('show');
        };
    });
   */


 //   $("a.remove-author").click(removeAuthor);
  //  $("a.add-author").click(addAuthor);

    $("form").on("click", "a.add-author", addAuthor);
    $("form").on("click", "a.remove-author", removeAuthor);
    author_counter=$("span.author").length;


    $("#new_paper").validate(

        {
            rules: {
                'paper[title]': {required: true},
                'paper[afleveringsaar]': {required: true, minlength:4, min: 1479},
                'paper[studium]': {required: true},
                'paper[opgavesprog]': {required: true},
                'paper[opgavetype]': {required: true},
                'content': {required: true, accept: "pdf"},
                'termsConditionsCheckBox': {required: true}
            },
            messages: {
                'content': KBDIAS.file,
                'paper[title]':{
                    required: KBDIAS.title
                },
                'paper[afleveringsaar]':{
                    required: KBDIAS.afleveringsaar,
                    minlength: KBDIAS.afleveringsaarlength,
                    min: KBDIAS.afleveringsaarefter1479
                },
                'paper[studium]': KBDIAS.studium,
                'paper[opgavesprog]': KBDIAS.opgavesprog,
                'paper[opgavetype]': KBDIAS.opgavetype,
                'termsConditionsCheckBox': ""
            },
            errorClass: "help-inline",
            errorElement: "span",
            highlight:function(element, errorClass, validClass) {
                $(element).parents('.control-group').addClass('error');
            },
            unhighlight: function(element, errorClass, validClass) {
                $(element).parents('.control-group').removeClass('error');
                $(element).parents('.control-group').addClass('success');
            },
            errorPlacement: function (error, element) {
                if (element.parent().is('.input-append'))
                    error.appendTo(element.parents(".controls:first"));
                else
                    error.insertAfter(element);
            }
        });



});
