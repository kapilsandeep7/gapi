$(function () {
	  setTimeout(function() {
        $('.alert').fadeOut("slow");
        $('.flash-message').removeClass("in");
    }, 2000);
    
 jQuery(function() {
	jQuery.validator.addMethod("loginRegex", function(value, element) {
		return this.optional(element) || /^[a-zA-Z]+$/i.test(value);
	}, 'Please enter valid name');
}); 
    jQuery(function() {
        jQuery.validator.addMethod("emailRegex", function(value, element) {
            value = $.trim(value);
            jQuery('#UserEmail').val(value);
            return this.optional(element) || /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i.test(value);
        }, 'Please enter valid email');
    });	
 
 $("#new_user, .edit_user").validate({
        rules: {
            'first_name': {
                required: true,
                loginRegex:true,
                minlength:3,
                maxlength:20        
            },
            'last_name': {
                required: true,
                loginRegex:true,
                minlength:3,
                maxlength:20
            },
            'email': {
                required: true,
                emailRegex:true,
                email: true
            },
           'role':{
               required:true
              
            }
        },
        messages: {
            'first_name': {
                required: 'Please enter first name'
            },
            'last_name': {
                required: 'Please enter last name'
            },
            'email': {
                required: 'Please enter email',
                email: 'Please enter valid email'
            },
            'role': {
                required: 'Please select role'
            }
        },
		highlight: function(element) {
            $(element).removeClass("error");
        }
    });
    });
