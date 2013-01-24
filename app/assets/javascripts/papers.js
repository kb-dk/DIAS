// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

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



});