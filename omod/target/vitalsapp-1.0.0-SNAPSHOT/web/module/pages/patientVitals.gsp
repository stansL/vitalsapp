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
        if (resultMessage != "") {
            emr.successMessage(resultMessage);
        }
    });

</script>


<div class="container">
    <div>
        <div id="manageAppointmentsTypeTitle" class="appointment-type-label">
            <h1>
                ${ui.message("vitalsapp.collectBMI.new.title")}
            </h1>
        </div>

    </div>

    <div id="appointmentTypes-list">

        <% if (appointmentTypeList) { %>

        <table id="appointmentTypesTable" empty-value-message='${ui.message("uicommons.dataTable.emptyTable")}'>
            <thead>
            <tr>
                <th style="width: 40%">${ui.message("vitalsapp.listing.name")}</th>
                <th style="width: 10%">${ui.message("vitalsapp.listing.gender")}</th>
                <th style="width: 30%">${ui.message("vitalsapp.listing.weight")}</th>
                <th style="width: 10%">${ui.message("vitalsapp.listing.height")}</th>
                <th style="width: 10%">${ui.message("vitalsapp.listing.bmi")}</th>
                <th style="width: 10%">${ui.message("vitalsapp.listing.pulseRate")}</th>
                <th style="width: 10%">${ui.message("vitalsapp.listing.temperature")}</th>
                <th style="width: 10%">${ui.message("vitalsapp.listing.bp")}</th>
            </tr>
            </thead>
            <tbody>
            <% appointmentTypeList.each { appointmentType -> %>

            <tr>
                <td>${ui.encodeHtmlContent(ui.format(appointmentType.name))}</td>
                <td>${ui.format(appointmentType.duration)}</td>
                <td>${ui.encodeHtmlContent(ui.format(appointmentType.description))}</td>
                <td class="align-center">
                    <span>
                        <i id="appointmentschedulingui-edit-${ui.encodeHtml(ui.format(appointmentType.name))}"
                           class="editAppointmentType delete-item icon-pencil"
                           data-appointment-type-id="${appointmentType.id}"
                           data-edit-url='${ui.pageLink("appointmentschedulingui", "appointmentType")}'
                           title="${ui.message("coreapps.edit")}"></i>
                        <i id="appointmentschedulingui-delete-${ui.encodeHtml(ui.format(appointmentType.name))}"
                           class="deleteAppointmentType delete-item icon-remove"
                           data-appointment-type-id="${appointmentType.id}"
                           title="${ui.message("coreapps.delete")}"></i>
                    </span>
                </td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>

            <div id="delete-appointment-type-dialog" class="dialog" style="display: none">
                <div class="dialog-header">
                    <h3>${ui.message("appointmentschedulingui.manageappointmenttype.deleteAppointmentTypeTitleDialog")}</h3>
                </div>

                <div class="dialog-content">
                    <input type="hidden" id="encounterId" value="">
                    <ul>
                        <li class="info">
                            <span>${ui.message("appointmentschedulingui.manageappointmenttype.deleteAppointmentTypeMessageDialog")}</span>
                        </li>
                    </ul>

                    <button class="confirm right">${ui.message("emr.yes")}
                        <i class="icon-spinner icon-spin icon-2x" style="display: none; margin-left: 10px;"></i>
                    </button>
                    <button class="cancel">${ui.message("emr.no")}</button>
                </div>
            </div>

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

<% if (appointmentTypeList) { %>

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
