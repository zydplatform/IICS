/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function breadCrumb(){
    $('.breadcrumbs li a').each(function () {

        var breadWidth = $(this).width();

        if ($(this).parent('li').hasClass('active') || $(this).parent('li').hasClass('first')) {

        } else {

            $(this).css('width', 75 + 'px');

            $(this).mouseover(function () {
                $(this).css('width', breadWidth + 'px');
            });

            $(this).mouseout(function () {
                $(this).css('width', 75 + 'px');
            });
        }
    });
}

