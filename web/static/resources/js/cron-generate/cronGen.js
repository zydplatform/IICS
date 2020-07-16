

(function ($) {
    
    var resultsName = "";
    var inputElement;
//    var displayElement;
    
    $.fn.extend({
        cronGen: function () {
            var that = $(this);
            var resultsDef = "0 0/" + 1 + " * 1/1 * ?";
            $('#cron').val(resultsDef);
//            // Hide the original input
//            that.hide();

//            // Add an input
//            var $i = $("<input>", { type: 'text', placeholder: 'Cron trigger', readonly: 'readonly' }).addClass("form-control").val($(that).val());

            inputElement = that;
//            displayElement = $i;
                $('#CronGenTabs a').click(function (e) {
                    e.preventDefault();
                    $(this).tab('show');
                    generate();
                });
//                $('#CronGenTabs a').keyup(function (e) {
//                    e.preventDefault();
//                    $(this).addClass('active');
//                    generate();
//                });
                $("#CronGenMainDiv select,input").change(function (e) {
                    generate();
                });
                   $("#CronGenMainDiv select,input").click(function (e) {
                    generate();
                }); 
                $("#CronGenMainDiv select,input").keyup(function (e) {
                    generate();
                });
                $("#CronGenMainDiv input").focus(function (e) {
                    generate();
                });
                $("#CronGenMainDiv input").keyup(function (e) {
                    generate();
                });
                //generate();
            return;
        }
    });
    
    var generate = function () {
        var activeTab = $("ul#CronGenTabs li.active a").prop("id");
        var results = "";
        switch (activeTab) {
            case "MinutesTab":
                results = "0 0/" + $("#MinutesInput").val() + " * 1/1 * ?";
                break;
            case "HourlyTab":
                switch ($("input:radio[name=HourlyRadio]:checked").val()) {
                    case "1":
                        results = "0 0 0/" + $("#HoursInput").val() + " 1/1 * ?";
                        break;
                    case "2":
                        results = "0 " + Number($("#AtMinutes").val()) + " " + Number($("#AtHours").val()) + " 1/1 * ?";
                        break;
                }
                break;
            case "DailyTab":
                switch ($("input:radio[name=DailyRadio]:checked").val()) {
                    case "1":
                        results = "0 " + Number($("#DailyMinutes").val()) + " " + Number($("#DailyHours").val()) + " 1/" + $("#DaysInput").val() + " * ?";
                        break;
                    case "2":
                        results = "0 " + Number($("#DailyMinutes").val()) + " " + Number($("#DailyHours").val()) + " ? * MON-FRI";
                        break;
                }
                break;
            case "WeeklyTab":
                var selectedDays = "";
                $("#weekly input:checkbox:checked").each(function () { selectedDays += $(this).val() + ","; });
                if (selectedDays.length > 0)
                    selectedDays = selectedDays.substr(0, selectedDays.length - 1);
                results = "0 " + Number($("#WeeklyMinutes").val()) + " " + Number($("#WeeklyHours").val()) + " ? * " + selectedDays + "";
                break;
            case "MonthlyTab":
                switch ($("input:radio[name=MonthlyRadio]:checked").val()) {
                    case "1":
                        results = "0 " + Number($("#MonthlyMinutes").val()) + " " + Number($("#MonthlyHours").val()) + " " + $("#DayOfMOnthInput").val() + " 1/" + $("#MonthInput").val() + " ? ";
                        break;
                    case "2":
                        results = "0 " + Number($("#MonthlyMinutes").val()) + " " + Number($("#MonthlyHours").val()) + " ? 1/" + Number($("#EveryMonthInput").val()) + " " + $("#DayInWeekOrder").val() + "/" + $("#WeekDay").val() + "";
                        break;
                }
                break;
            case "YearlyTab":
                switch ($("input:radio[name=YearlyRadio]:checked").val()) {
                    case "1":
                        results = "0 " + Number($("#YearlyMinutes").val()) + " " + Number($("#YearlyHours").val()) + " " + $("#YearInput").val() + " " + $("#MonthsOfYear").val() + " ?";
                        break;
                    case "2":
                        results = "0 " + Number($("#YearlyMinutes").val()) + " " + Number($("#YearlyHours").val()) + " ? " + $("#MonthsOfYear2").val() + " " + $("#DayWeekForYear").val() + "/" + $("#DayOrderInYear").val() + "";
                        break;
                }
                break;
        }

        // Update original control
        inputElement.val(results).change();
        // Update display
        $('#cron').val(results);
    };
})(jQuery);

