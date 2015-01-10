/* DEV BUILD*/
/*! Haushaltsbuch 10-01-2015
 *  Copyright: Michel Vielmetter <programming@michelvielmetter.de>
 */

!function($){"use strict";// jshint ;_;
$(function(){var modalId="modal-form-"+parseInt(1e3*Math.random(),10),$cont=$('<div id="'+modalId+'"></div>');$("body").append($cont),$.modalForm=function(options){var $modal,field,type,fields=options.fields||[],title=options.title||options.submit,submit=options.submit||"submit",html="";for(html+='<div class="modal fade">',html+='  <form class="modal-dialog">',html+='    <div class="modal-content">',title&&(html+='      <div class="modal-header">',html+="        <h3>",html+="        "+title,html+='          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>',html+="        </h3>",html+="      </div>"),html+='      <div class="modal-body">';field=fields.shift();)type=/password/.test(field)?"password":"text",html+='        <input class="form-control" type="'+type+'" name="'+field+'" placeholder="'+field.replace(/_/g," ")+'"><br />';// make sure that only one modal is visible
return html+="      </div>",html+='      <div class="modal-footer">',html+='        <button type="submit" class="btn btn-primary">'+submit+"</button>",html+="      </div>",html+="    </div>",html+="  </form>",html+="</div>",$modal=$(html),$cont.html("").append($modal),$modal.modal(),$modal.modal("show"),$modal.on("submit","form",function(event){event.preventDefault(),event.stopPropagation();var inputs={},$form=$(event.target);$form.find("[name]").each(function(){inputs[this.name]=this.value}),$modal.trigger("submit",inputs)}),$modal.on("error",function(event,error){$modal.find(".alert").remove(),$modal.find(".modal-body").before('<div class="alert alert-error">'+error.message+"</div>")}),$modal.on("shown",function(){$modal.find("input").eq(0).focus()}),$modal}})}(window.jQuery),!function($){"use strict";// extend Hoodie with Hoodstrap module
Hoodie.extend(function(hoodie){// Constructor
function Hoodstrap(hoodie){this.hoodie=hoodie,// all about authentication and stuff
this.hoodifyAccountBar()}Hoodstrap.prototype={//
hoodifyAccountBar:function(){this.subscribeToHoodieEvents(),this.hoodie.account.authenticate().then(this.handleUserAuthenticated.bind(this),this.handleUserUnauthenticated.bind(this))},subscribeToHoodieEvents:function(){this.hoodie.account.on("signup changeusername signin reauthenticated",this.handleUserAuthenticated.bind(this)),this.hoodie.account.on("signout",this.handleUserUnauthenticated.bind(this)),this.hoodie.on("account:error:unauthenticated remote:error:unauthenticated",this.handleUserAuthenticationError.bind(this))},//
handleUserAuthenticated:function(username){$("html").attr("data-hoodie-account-status","signedin"),$(".hoodie-accountbar").find(".hoodie-username").text(username)},//
handleUserUnauthenticated:function(){return this.hoodie.account.username?this.handleUserAuthenticationError():void $("html").attr("data-hoodie-account-status","signedout")},handleUserAuthenticationError:function(){$(".hoodie-accountbar").find(".hoodie-username").text(this.hoodie.account.username),$("html").attr("data-hoodie-account-status","error")}},new Hoodstrap(hoodie)}),/* Hoodie DATA-API
  * =============== */
$(function(){// bind to click events
$("body").on("click.hoodie.data-api","[data-hoodie-action]",function(event){var $form,$element=$(event.target),action=$element.data("hoodie-action");switch(action){case"signup":$form=$.modalForm({fields:["username","password","password_confirmation"],submit:"Sign Up"});break;case"signin":$form=$.modalForm({fields:["username","password"],submit:"Sign in"});break;case"resetpassword":$form=$.modalForm({fields:["username"],submit:"Reset Password"});break;case"changepassword":$form=$.modalForm({fields:["current_password","new_password"],submit:"Change Password"});break;case"changeusername":$form=$.modalForm({fields:["current_password","new_username"],submit:"Change Username"});break;case"signout":window.hoodie.account.signOut();break;case"destroy":window.confirm("you sure?")&&window.hoodie.account.destroy()}$form&&$form.on("submit",handleSubmit(action))});var handleSubmit=function(action){return function(event,inputs){var magic,$modal=$(event.target);switch(action){case"signin":magic=window.hoodie.account.signIn(inputs.username,inputs.password);break;case"signup":magic=window.hoodie.account.signUp(inputs.username,inputs.password);break;case"changepassword":magic=window.hoodie.account.changePassword(null,inputs.new_password);break;case"changeusername":magic=window.hoodie.account.changeUsername(inputs.current_password,inputs.new_username);break;case"resetpassword":magic=window.hoodie.account.resetPassword(inputs.email).done(function(){window.alert("send new password to "+inputs.email)})}magic.done(function(){$modal.find(".alert").remove(),$modal.modal("hide")}),magic.fail(function(error){$modal.find(".alert").remove(),$modal.trigger("error",error)})}}})}(window.jQuery);
//# sourceMappingURL=vendor.js.map