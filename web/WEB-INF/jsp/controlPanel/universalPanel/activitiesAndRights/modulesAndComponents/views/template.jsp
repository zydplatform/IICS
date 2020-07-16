<%-- 
    Document   : activitiesandaccessrightstabs
    Created on : Mar 21, 2018, 10:20:40 AM
    Author     : RESEARCH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="row">
    <div class="col-md-12">
        <div class="bs-component">
            <ul class="nav nav-tabs">
                <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#home">Home</a></li>
                <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#profile">Profile</a></li>

            </ul>
            <div class="tab-content" id="myTabContent"><br>
                <div class="tab-pane fade active show" id="home">
                    <div class="row user">
                        <div class="col-md-9">
                            <div class="tab-content">
                                <div class="tab-pane active" id="user-timeline">
                                    <div class="timeline-post">
                                        <div class="post-media"><a href="#"><img src="https://s3.amazonaws.com/uifaces/faces/twitter/jsa/48.jpg"></a>
                                            <div class="content">
                                                <h5><a href="#">John Doe</a></h5>
                                                <p class="text-muted"><small>2 January at 9:30</small></p>
                                            </div>
                                        </div>
                                        <div class="post-content">
                                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,	quis tion ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non	proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
                                        </div>
                                        <ul class="post-utility">
                                            <li class="likes"><a href="#"><i class="fa fa-fw fa-lg fa-thumbs-o-up"></i>Like</a></li>
                                            <li class="shares"><a href="#"><i class="fa fa-fw fa-lg fa-share"></i>Share</a></li>
                                            <li class="comments"><i class="fa fa-fw fa-lg fa-comment-o"></i> 5 Comments</li>
                                        </ul>
                                    </div>
                                    <div class="timeline-post">
                                        <div class="post-media"><a href="#"><img src="https://s3.amazonaws.com/uifaces/faces/twitter/jsa/48.jpg"></a>
                                            <div class="content">
                                                <h5><a href="#">John Doe</a></h5>
                                                <p class="text-muted"><small>2 January at 9:30</small></p>
                                            </div>
                                        </div>
                                        <div class="post-content">
                                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,	quis tion ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non	proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
                                        </div>
                                        <ul class="post-utility">
                                            <li class="likes"><a href="#"><i class="fa fa-fw fa-lg fa-thumbs-o-up"></i>Like</a></li>
                                            <li class="shares"><a href="#"><i class="fa fa-fw fa-lg fa-share"></i>Share</a></li>
                                            <li class="comments"><i class="fa fa-fw fa-lg fa-comment-o"></i> 5 Comments</li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="user-settings">
                                    <div class="tile user-settings">
                                        <h4 class="line-head">Settings</h4>
                                        <form>
                                            <div class="row mb-4">
                                                <div class="col-md-4">
                                                    <label>First Name</label>
                                                    <input class="form-control" type="text">
                                                </div>
                                                <div class="col-md-4">
                                                    <label>Last Name</label>
                                                    <input class="form-control" type="text">
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-8 mb-4">
                                                    <label>Email</label>
                                                    <input class="form-control" type="text">
                                                </div>
                                                <div class="clearfix"></div>
                                                <div class="col-md-8 mb-4">
                                                    <label>Mobile No</label>
                                                    <input class="form-control" type="text">
                                                </div>
                                                <div class="clearfix"></div>
                                                <div class="col-md-8 mb-4">
                                                    <label>Office Phone</label>
                                                    <input class="form-control" type="text">
                                                </div>
                                                <div class="clearfix"></div>
                                                <div class="col-md-8 mb-4">
                                                    <label>Home Phone</label>
                                                    <input class="form-control" type="text">
                                                </div>
                                            </div>
                                            <div class="row mb-10">
                                                <div class="col-md-12">
                                                    <button class="btn btn-primary" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i> Save</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <a class="mb-2 btn btn-primary btn-block" href="#">Compose Mail</a>
                            <div class="tile p-0">
                                <h4 class="tile-title folder-head">Folders</h4>
                                <ul class="nav flex-column nav-tabs user-tabs">
                                    <li class="nav-item"><a class="nav-link active" href="#user-timeline" data-toggle="tab">Timeline</a></li>
                                    <li class="nav-item"><a class="nav-link" href="#user-settings" data-toggle="tab">Settings</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="tab-pane fade" id="profile">

                    <div style="margin: 10px;">
                        <fieldset style="min-height:100px;">
                            <h2>Tabs</h2>
<div class="bd-example bd-example-tabs">
  <nav class="nav nav-tabs" id="nav-tab" role="tablist">
    <a class="nav-item nav-link active" id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab" aria-controls="home" aria-expanded="true">Home</a>
    <a class="nav-item nav-link" id="nav-profile-tab" data-toggle="tab" href="#nav-profile" role="tab" aria-controls="profile" aria-expanded="false">Profile</a>
    <div class="dropdown">
      <a class="nav-item nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
        Dropdown
      </a>
      <div class="dropdown-menu" x-placement="bottom-start" style="position: absolute; transform: translate3d(0px, 42px, 0px); top: 0px; left: 0px; will-change: transform;">
        <a class="dropdown-item" id="nav-dropdown1-tab" href="#nav-dropdown1" role="tab" data-toggle="tab" aria-controls="dropdown1">@fat</a>
        <a class="dropdown-item" id="nav-dropdown2-tab" href="#nav-dropdown2" role="tab" data-toggle="tab" aria-controls="dropdown2">@mdo</a>
      </div>
    </div>
  </nav>
  <div class="tab-content" id="nav-tabContent">
    <div class="tab-pane fade active show" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab" aria-expanded="true">
      <p>Et et consectetur ipsum labore excepteur est proident excepteur ad velit occaecat qui minim occaecat veniam. Fugiat veniam incididunt anim aliqua enim pariatur veniam sunt est aute sit dolor anim. Velit non irure adipisicing aliqua ullamco irure incididunt irure non esse consectetur nostrud minim non minim occaecat. Amet duis do nisi duis veniam non est eiusmod tempor incididunt tempor dolor ipsum in qui sit. Exercitation mollit sit culpa nisi culpa non adipisicing reprehenderit do dolore. Duis reprehenderit occaecat anim ullamco ad duis occaecat ex.</p>
    </div>
    <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab" aria-expanded="false">
      <p>Nulla est ullamco ut irure incididunt nulla Lorem Lorem minim irure officia enim reprehenderit. Magna duis labore cillum sint adipisicing exercitation ipsum. Nostrud ut anim non exercitation velit laboris fugiat cupidatat. Commodo esse dolore fugiat sint velit ullamco magna consequat voluptate minim amet aliquip ipsum aute laboris nisi. Labore labore veniam irure irure ipsum pariatur mollit magna in cupidatat dolore magna irure esse tempor ad mollit. Dolore commodo nulla minim amet ipsum officia consectetur amet ullamco voluptate nisi commodo ea sit eu.</p>
    </div>
    <div class="tab-pane fade" id="nav-dropdown1" role="tabpanel" aria-labelledby="nav-dropdown1-tab">
      <p>Sint sit mollit irure quis est nostrud cillum consequat Lorem esse do quis dolor esse fugiat sunt do. Eu ex commodo veniam Lorem aliquip laborum occaecat qui Lorem esse mollit dolore anim cupidatat. Deserunt officia id Lorem nostrud aute id commodo elit eiusmod enim irure amet eiusmod qui reprehenderit nostrud tempor. Fugiat ipsum excepteur in aliqua non et quis aliquip ad irure in labore cillum elit enim. Consequat aliquip incididunt ipsum et minim laborum laborum laborum et cillum labore. Deserunt adipisicing cillum id nulla minim nostrud labore eiusmod et amet. Laboris consequat consequat commodo non ut non aliquip reprehenderit nulla anim occaecat. Sunt sit ullamco reprehenderit irure ea ullamco Lorem aute nostrud magna.</p>
    </div>
    <div class="tab-pane fade" id="nav-dropdown2" role="tabpanel" aria-labelledby="nav-dropdown2-tab">
      <p>Proident incididunt esse qui ea nisi ullamco aliquip nostrud velit sint duis. Aute culpa aute cillum sit consectetur mollit minim non reprehenderit tempor. Occaecat amet consectetur aute esse ad ullamco ad commodo mollit reprehenderit esse in consequat. Mollit minim do consectetur pariatur irure non id ea dolore occaecat adipisicing consectetur est aute magna non.</p>
    </div>
  </div>
</div>

<br>

<h2>Pills</h2>
<div class="bd-example bd-example-tabs">
  <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
    <li class="nav-item">
      <a class="nav-link active" id="pills-home-tab" data-toggle="pill" href="#pills-home" role="tab" aria-controls="pills-home" aria-expanded="true">Home</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" id="pills-profile-tab" data-toggle="pill" href="#pills-profile" role="tab" aria-controls="pills-profile" aria-expanded="true">Profile</a>
    </li>
    <li class="nav-item dropdown">
      <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">Dropdown</a>
      <div class="dropdown-menu">
        <a class="dropdown-item" id="pills-dropdown1-tab" href="#pills-dropdown1" role="tab" data-toggle="pill" aria-controls="pills-dropdown1">@fat</a>
        <a class="dropdown-item" id="pills-dropdown2-tab" href="#pills-dropdown2" role="tab" data-toggle="pill" aria-controls="pills-dropdown2">@mdo</a>
      </div>
    </li>
  </ul>
  <div class="tab-content" id="pills-tabContent">
    <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
      <p>Consequat occaecat ullamco amet non eiusmod nostrud dolore irure incididunt est duis anim sunt officia. Fugiat velit proident aliquip nisi incididunt nostrud exercitation proident est nisi. Irure magna elit commodo anim ex veniam culpa eiusmod id nostrud sit cupidatat in veniam ad. Eiusmod consequat eu adipisicing minim anim aliquip cupidatat culpa excepteur quis. Occaecat sit eu exercitation irure Lorem incididunt nostrud.</p>
    </div>
    <div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
      <p>Ad pariatur nostrud pariatur exercitation ipsum ipsum culpa mollit commodo mollit ex. Aute sunt incididunt amet commodo est sint nisi deserunt pariatur do. Aliquip ex eiusmod voluptate exercitation cillum id incididunt elit sunt. Qui minim sit magna Lorem id et dolore velit Lorem amet exercitation duis deserunt. Anim id labore elit adipisicing ut in id occaecat pariatur ut ullamco ea tempor duis.</p>
    </div>
    <div class="tab-pane fade" id="pills-dropdown1" role="tabpanel" aria-labelledby="pills-dropdown1-tab">
      <p>Est quis nulla laborum officia ad nisi ex nostrud culpa Lorem excepteur aliquip dolor aliqua irure ex. Nulla ut duis ipsum nisi elit fugiat commodo sunt reprehenderit laborum veniam eu veniam. Eiusmod minim exercitation fugiat irure ex labore incididunt do fugiat commodo aliquip sit id deserunt reprehenderit aliquip nostrud. Amet ex cupidatat excepteur aute veniam incididunt mollit cupidatat esse irure officia elit do ipsum ullamco Lorem. Ullamco ut ad minim do mollit labore ipsum laboris ipsum commodo sunt tempor enim incididunt. Commodo quis sunt dolore aliquip aute tempor irure magna enim minim reprehenderit. Ullamco consectetur culpa veniam sint cillum aliqua incididunt velit ullamco sunt ullamco quis quis commodo voluptate. Mollit nulla nostrud adipisicing aliqua cupidatat aliqua pariatur mollit voluptate voluptate consequat non.</p>
    </div>
    <div class="tab-pane fade" id="pills-dropdown2" role="tabpanel" aria-labelledby="nav-dropdown2-tab">
      <p>Tempor anim aliquip qui nisi sit minim ex in cupidatat ipsum adipisicing. Ad non magna anim id ullamco do dolor sit adipisicing nulla exercitation. Qui Lorem eiusmod sint in laboris pariatur est adipisicing non sunt occaecat in mollit culpa sit. Aliquip id duis do do quis mollit ut duis. Non dolor reprehenderit do esse nostrud deserunt non eiusmod minim anim sit voluptate ipsum. Nulla elit aliqua do sunt labore velit anim nisi dolor nostrud consectetur fugiat ex qui velit ex tempor. Do cillum qui anim aliquip id cillum duis ex laboris tempor incididunt sint dolor ullamco tempor. Fugiat laboris enim anim veniam aliquip cillum irure.</p>
    </div>
  </div>
</div>

                        </fieldset>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>