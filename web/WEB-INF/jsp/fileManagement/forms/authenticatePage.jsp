<%-- 
    Document   : authenticatePage
    Created on : Jun 7, 2018, 3:11:11 PM
    Author     : IICS
--%>
<div class="tile">
<div class="tile-body">
<form >
<div class="row">
    <div class=" col-md-3"></div>
    <div class=" col-md-6">
        <div id="horizontalwithwords">
                <span class="pat-form-heading">Confirm File Assignment</span></div>
        <div class="form-group">
                    <label class="control-label">USERNAME:</label>
                   <input class="form-control"  id="borrowerusername" type="text" placeholder="username" required style="margin-bottom: 2.5em" size="15">
           </div>
                     <div class="form-group">
                    <label class="control-label">PASSWORD:</label>
               <input class="form-control" id='borrowerpassword' type="password" placeholder="Password" required size="15">
            </div>
    <br>
       <div class="form-group">
                <button class="btn btn-primary btn-block" onclick="authenticateUser()"><i class="fa fa-sign-in fa-lg fa-fw"></i>Login
                </button>
      </div>
    </div>
            
          
 </div>
        
</form>

 </div>
  </div>
 <script src="static/res/js/sec/md5.min.js"></script>
 <script>
       function authenticateUser() {
       var password = $('#borrowerpassword').val();
        var username = $('#borrowerusername').val();
         var pass;
       if(username=== ''&&password ===''){
            alert('Enter Your Credentials');
        }else{
           pass= md5(password);
        }
         $.ajax({
                type: "GET",
                cache: false,
                url: "fileassignment/confirmassignment.htm",
                data: {username:username,password:pass},
                success: function (response) {
               alert(response);
               var obj = JSON.parse(response);
              if(obj.status!=='success'){
                  
                }else{
                alert(obj.message);  
               }
                }
            });
        }
    </script>