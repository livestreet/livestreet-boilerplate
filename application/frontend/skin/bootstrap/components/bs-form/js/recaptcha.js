var onloadCallback = function() {
    var x = document.getElementsByClassName("g-recaptcha");
    
    var i;
    for (i = 0; i < x.length; i++) {
        grecaptcha.render(
            x[i],
            {
                sitekey: ls.registry.get('recaptcha.site_key'),
                theme: "light",
                callback: function(response){
                    let field = document.getElementById(this.dataset.fieldId);
                    field.value = response;
                    $(field).bsFieldValidate('validate');
                }.bind(x[i])
            }
        );
    }
    
};
