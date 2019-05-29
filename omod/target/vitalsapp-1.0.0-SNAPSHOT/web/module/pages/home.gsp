<%
    ui.decorateWith("appui", "standardEmrPage")
%>

<script type="text/javascript">
    var breadcrumbs = [
        {icon: "icon-home", link: '/' + OPENMRS_CONTEXT_PATH + '/index.htm'},
        {
            label: "${ ui.message("vitalsapp.home.title") }",
            link: '${ ui.pageLink("appointmentschedulingui", "home") }'
        }
    ];
</script>

<div id="apps">

    <% if (context.hasPrivilege("App: appointmentschedulingui.providerSchedules")) { %>
    <a class="button app big" href="${ ui.pageLink("coreapps", "findpatient/findPatient", [app: "referenceapplication.vitals"]) }"
       id="appointmentschedulingui-scheduleProviders-app">
        <i class="icon-stethoscope"></i>
        ${ui.message("vitalsapp.patient.vital")}

    </a>
    <% } %>

    <% if (context.hasPrivilege("App: appointmentschedulingui.appointmentTypes")) { %>
    <a class="button app big" href="${ui.pageLink("vitalsapp", "patientVitals")}"
       id="appointmentschedulingui-manageAppointmentTypes-app">
        <i class="icon-list-alt"></i>
        ${ui.message("vitalsapp.patient.listing")}
    </a>
    <% } %>

</div>