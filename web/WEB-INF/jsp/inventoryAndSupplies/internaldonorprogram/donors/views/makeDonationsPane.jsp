<%-- 
    Document   : makeDonationsPane
    Created on : Oct 16, 2018, 10:04:13 AM
    Author     : IICS
--%>
<%@include file="../../../../include.jsp" %>
<head>
    <script type="text/javascript" src="static/js/jquery.autocomplete.min.js"></script>
<!--    <script type="text/javascript" src="static/js/jquery-1.9.1.min.js"></script>-->
<!--    <script type="text/javascript" src="static/js/jquery.autocomplete.min.js"></script>-->
</head>
<style>
    html, body, div, span, applet, object, iframe, h1, h2, h3, h4, h5, h6, p, blockquote, pre, a, abbr, acronym, address, big, cite, code, del, dfn, em, img, ins, kbd, q, s, samp, small, strike, strong, sub, sup, tt, var, b, u, i, center, dl, dt, dd, ol, ul, li, fieldset, form, label, legend, table, caption, tbody, tfoot, thead, tr, th, td, article, aside, canvas, details, embed, figure, figcaption, footer, header, hgroup, menu, nav, output, ruby, section, summary, time, mark, audio, video {
        margin: 0;
        padding: 0;
        border: 0;
        font-size: 100%;
        font: inherit;
        vertical-align: baseline;
        outline: none;
        -webkit-font-smoothing: antialiased;
        -webkit-text-size-adjust: 100%;
        -ms-text-size-adjust: 100%;
        -webkit-box-sizing: border-box;
        -moz-box-sizing: border-box;
        box-sizing: border-box;
    }
    html { height: 101%; }
    body { 
        background: #f0f0f0 url('images/bg.gif'); 
        font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
        color: #313131;
        font-size: 62.5%; 
        line-height: 1; 
    }

    selection { background: #a4dcec; }
    -moz-selection { background: #a4dcec; }
    -webkit-selection { background: #a4dcec; }

    ::-webkit-input-placeholder { /* WebKit browsers */
        color: #ccc;
        font-style: italic;
    }
    :-moz-placeholder { /* Mozilla Firefox 4 to 18 */
        color: #ccc;
        font-style: italic;
    }
    ::-moz-placeholder { /* Mozilla Firefox 19+ */
        color: #ccc;
        font-style: italic;
    }
    :-ms-input-placeholder { /* Internet Explorer 10+ */
        color: #ccc !important;
        font-style: italic;  
    }

    br { display: block; line-height: 2.2em; } 

    article, aside, details, figcaption, figure, footer, header, hgroup, menu, nav, section { display: block; }
    ol, ul { list-style: none; }

    input, textarea { 
        -webkit-font-smoothing: antialiased;
        -webkit-text-size-adjust: 100%;
        -ms-text-size-adjust: 100%;
        -webkit-box-sizing: border-box;
        -moz-box-sizing: border-box;
        box-sizing: border-box;
        outline: none; 
    }

    blockquote, q { quotes: none; }
    blockquote:before, blockquote:after, q:before, q:after { content: ''; content: none; }
    strong { font-weight: bold; } 

    table { border-collapse: collapse; border-spacing: 0; }

    /** typography **/
    h1 {
        font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
        font-size: 2.5em;
        line-height: 1.5em;
        letter-spacing: -0.05em;
        margin-bottom: 20px;
        padding: .1em 0;
        color: #444;
        position: relative;
        overflow: hidden;
        white-space: nowrap;
        text-align: center;
    }
    h1:before,
    h1:after {
        content: "";
        position: relative;
        display: inline-block;
        width: 50%;
        height: 1px;
        vertical-align: middle;
        background: #f0f0f0;
    }
    h1:before {    
        left: -.5em;
        margin: 0 0 0 -50%;
    }
    h1:after {    
        left: .5em;
        margin: 0 -50% 0 0;
    }
    h1 > span {
        display: inline-block;
        vertical-align: middle;
        white-space: normal;
    }

    p {
        display: block;
        font-size: 1.35em;
        line-height: 1.5em;
        margin-bottom: 22px;
    }

    a { color: #5a9352; text-decoration: none; }
    a:hover { text-decoration: underline; }

    .center { display: block; text-align: center; }


    /** page structure **/
    #w {
        display: block;
        margin: 0 auto;
        padding-top: 30px;
    }
/*
    #content {
        display: block;
        width: 100%;
        background: #fff;
        padding: 25px 20px;
        padding-bottom: 35px;
        -webkit-box-shadow: rgba(0, 0, 0, 0.1) 0px 1px 2px 0px;
        -moz-box-shadow: rgba(0, 0, 0, 0.1) 0px 1px 2px 0px;
        box-shadow: rgba(0, 0, 0, 0.1) 0px 1px 2px 0px;
    }*/

    #searchfield { display: block; width: 100%; text-align: center; margin-bottom: 35px; }
/*
    #searchfield {
        display: inline-block;
        background: #eeefed;
        padding: 0;
        margin: 0;
        padding: 5px;
        border-radius: 3px;
        margin: 5px 0 0 0;
    }
    #searchfield.biginput {
        width: 600px;
        height: 40px;
        padding: 0 10px 0 10px;
        background-color: #fff;
        border: 1px solid #c8c8c8;
        border-radius: 3px;
        color: #aeaeae;
        font-weight:normal;
        font-size: 1.5em;
        -webkit-transition: all 0.2s linear;
        -moz-transition: all 0.2s linear;
        transition: all 0.2s linear;
    }*/
    #searchfield .biginput:focus {
        color: #858585;
    }



    .flatbtn {
        -webkit-box-sizing: border-box;
        -moz-box-sizing: border-box;
        box-sizing: border-box;
        display: inline-block;
        outline: 0;
        border: 0;
        color: #f3faef;
        text-decoration: none;
        background-color: #6bb642;
        border-color: rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.25);
        font-size: 1.2em;
        font-weight: bold;
        padding: 12px 22px 12px 22px;
        line-height: normal;
        text-align: center;
        vertical-align: middle;
        cursor: pointer;
        text-transform: uppercase;
        text-shadow: 0 1px 0 rgba(0,0,0,0.3);
        -webkit-border-radius: 3px;
        -moz-border-radius: 3px;
        border-radius: 3px;
        -webkit-box-shadow: 0 1px 0 rgba(15, 15, 15, 0.3);
        -moz-box-shadow: 0 1px 0 rgba(15, 15, 15, 0.3);
        box-shadow: 0 1px 0 rgba(15, 15, 15, 0.3);
    }
    .flatbtn:hover {
        color: #fff;
        background-color: #73c437;
    }
    .flatbtn:active {
        -webkit-box-shadow: inset 0 1px 5px rgba(0, 0, 0, 0.1);
        -moz-box-shadow:inset 0 1px 5px rgba(0, 0, 0, 0.1);
        box-shadow:inset 0 1px 5px rgba(0, 0, 0, 0.1);
    }



    .autocomplete-suggestions { border: 1px solid #999; background: #fff; cursor: default; overflow: auto; }
    .autocomplete-suggestion { padding: 10px 5px; font-size: 1.2em; white-space: nowrap; overflow: hidden; }
    .autocomplete-selected { background: #f0f0f0; }
    .autocomplete-suggestions strong { font-weight: normal; color: #3399ff; }
</style>
<div class="form-group" id="searchfield">
    <label class="control-label">Item Name:</label>
    <input class="form-control myform" id="otheritemid" type="hidden">
    <input class="form-control myform biginput" id="otheritemname" type="text" placeholder="Enter Item Name">
    <div id="outputbox">
        <p id="outputcontent"></p>
    </div>
</div>  
<div class="form-group">
    <label class="control-label">Enter Specification:</label>
    <input class="form-control myform" id="specification" type="text" placeholder="Enter Item Specification">
</div>
<div class="form-group row">
    <label for="itemclass" id="packsLabel">Total Quantity</label>
    <input class="form-control" id="quantity" type="number"  placeholder="Enter Item Quantity">
</div>
<script>
    $(function () {
        var jsonviewAll = ${jsonDataAdimn};
        $('#otheritemname').autocomplete({
            lookup: jsonviewAll,
            onSelect: function (suggestion) {
                alert("it has finally worked");
                // some function here
            }
        });

//        $('#autocomplete').autocomplete({
//            lookup: currencies,
//            onSelect: function (suggestion) {
//                var thehtml = '<strong>Currency Name:</strong> ' + suggestion.value + ' <br> <strong>Symbol:</strong> ' + suggestion.data;
//                $('#outputcontent').html(thehtml);
//            }
//        });

    });
//    function searchOtherDonationItem() {
//        var name = $('#otheritemname').val();
//        if (name.length >= 3)
//            $.ajax({
//                type: 'GET',
//                data: name,
//                url: 'internaldonorprogram/fetchOtherDonorItems.htm',
//                success: function (res) {
//                    console.log("--------------------res" + res);
//                    jsonviewAll = JSON.parse(res);
//                    console.log(jsonviewAll);
//                    if (JSON.parse(res).length !== 0) {
//                        $('#otheritemname').autocomplete({
//                            lookup: jsonviewAll,
//                            onSelect: function (suggestion) {
//                                alert(suggestion.value);
//                                var thehtml = '<strong>Currency Name:</strong> ' + suggestion.value;
//                                $('#outputcontent').html(thehtml);
//                            }
//                        });
//                        console.log("--------------------res222222222222222" + res);
//                    } else {
//
//                    }
//                }
//            });
//    }
</script>