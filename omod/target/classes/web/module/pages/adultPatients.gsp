<%
    ui.decorateWith("appui", "standardEmrPage")
    ui.includeCss("appointmentschedulingui", "appointmentType.css")
    ui.includeJavascript("appointmentschedulingui", "manageAppointmentType.js")
%>


<script type="text/javascript">

    // TODO redo usnig angular?

    var breadcrumbs = [
        {icon: "icon-home", link: '/' + OPENMRS_CONTEXT_PATH + '/index.htm'},
        {
            label: "${ ui.message("vitalsapp.home.title") }",
            link: '${ ui.pageLink("vitalsapp", "home") }'
        },
        {label: "${ ui.message("vitalsapp.patient.listing")}"}
    ];

    jq(function () {
        var resultMessage = "${resultMessage}";
        var patientList = "${patientList}";
        console.log(patientList);
        if (resultMessage != "") {
            emr.successMessage(resultMessage);
        }
    });

</script>


<div class="container">
    <div>
        <div id="manageAppointmentsTypeTitle" class="appointment-type-label">
            <h1>
                ${ui.message("vitalsapp.listing.adult.title")}
            </h1>
        </div>

    </div>

    <div id="appointmentTypes-list">

        <% if (patientList) { %>

        <table id="appointmentTypesTable" empty-value-message='${ui.message("uicommons.dataTable.emptyTable")}'>
            <thead>
            <tr>
                <th style="width: 40%">${ui.message("vitalsapp.listing.name")}</th>
                <th style="width: 10%">${ui.message("vitalsapp.listing.gender")}</th>
                <th style="width: 10%">${ui.message("vitalsapp.listing.weight")}</th>
                <th style="width: 10%">${ui.message("vitalsapp.listing.height")}</th>
                <th style="width: 10%">${ui.message("vitalsapp.listing.bmi")}</th>
                <th style="width: 10%">${ui.message("vitalsapp.listing.pulseRate")}</th>
                <th style="width: 10%">${ui.message("vitalsapp.listing.temperature")}</th>
                <th style="width: 10%">${ui.message("vitalsapp.listing.bp")}</th>
            </tr>
            </thead>
            <tbody>
            <% patientList.each { patient -> %>

            <tr>
                <td>${ui.encodeHtmlContent(ui.format(patient.p.personName))}</td>
                <td>${ui.encodeHtmlContent(ui.format(patient.p.gender))}</td>
                <td>${ui.encodeHtmlContent(ui.format(patient.weight))}</td>
                <td>${ui.encodeHtmlContent(ui.format(patient.height))}</td>
                <td>${ui.encodeHtmlContent(ui.format(patient.bmi))}</td>
                <td>${ui.encodeHtmlContent(ui.format(patient.pulseRate))}</td>
                <td>${ui.encodeHtmlContent(ui.format(patient.temperature))}</td>
                <td>${ui.encodeHtmlContent(ui.format(patient.bp))}</td>
            </tr>
            <% } %>
            </tbody>
        </table>

        <% } else { %>
        <p>
            ${ui.message("uicommons.dataTable.emptyTable")}
        </p>
        <% } %>
    </div>
</div>

<% if (patientList) { %>

${ui.includeFragment("uicommons", "widget/dataTable", [object : "#appointmentTypesTable",
                                                       options: [
                                                               bFilter        : false,
                                                               bJQueryUI      : true,
                                                               bLengthChange  : false,
                                                               iDisplayLength : 10,
                                                               sPaginationType: '\"full_numbers\"',
                                                               bSort          : false,
                                                               sDom           : '\'ft<\"fg-toolbar ui-toolbar ui-corner-bl ui-corner-br ui-helper-clearfix datatables-info-and-pg \"ip>\''
                                                       ]
])}

<% } %>
