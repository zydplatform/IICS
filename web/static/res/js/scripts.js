/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function initDialog(dialogClass) {
    var div = $('.' + dialogClass + ' > div').height();
    var divHead = $('.' + dialogClass + ' > div > #head').height();
    $('.' + dialogClass + ' > div > #content').height(parseInt(parseInt(div) - parseInt(divHead)) - parseInt(div * 0.06));

    $(window).resize(function () {
        div = $('.' + dialogClass + ' > div').height();
        divHead = $('.' + dialogClass + ' > div > #head').height();
        $('.' + dialogClass + ' > div > #content').height(parseInt(parseInt(div) - parseInt(divHead)) - parseInt(div * 0.06));
    });
}