package org.openmrs.module.vitalsapp.page.controller;

import org.openmrs.Concept;
import org.openmrs.Obs;
import org.openmrs.Patient;
import org.openmrs.Person;
import org.openmrs.api.ConceptService;
import org.openmrs.api.ObsService;
import org.openmrs.api.PatientService;
import org.openmrs.module.appointmentscheduling.AppointmentType;
import org.openmrs.module.appointmentscheduling.api.AppointmentService;
import org.openmrs.ui.framework.UiUtils;
import org.openmrs.ui.framework.annotation.SpringBean;
import org.openmrs.ui.framework.page.PageModel;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;
import java.util.Vector;
import java.util.function.Function;
import java.util.stream.Collectors;

public class PatientVitalsPageController {
	
	public void get(PageModel model, UiUtils ui,
					@RequestParam(value = "deleted", required = false) String appointmentTypeDeleted,
					@SpringBean("patientService") PatientService patientService,
					@SpringBean("conceptService") ConceptService conceptService,
					@SpringBean("obsService") ObsService obsService) throws Exception {

		String[] conceptUuidList = {
				"5088AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
				"5089AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
				"5087AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
				"5090AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
				"5085AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
				"5086AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
				"86aca82e-8129-11e9-bb4e-204747d1a908"


		};


		String resultMessage = "";
		if (appointmentTypeDeleted.equals("true")) {
			resultMessage = ui.message("appointmentschedulingui.manageappointmenttype.success");
		}
		model.addAttribute("resultMessage", resultMessage);

		List<Patient> allPatients = patientService.getAllPatients();
		Function<Patient, PatientVitalsPageController.PatientWrapper> wrapperFunction = p -> {
			List<Person> who = new Vector<>();
			who.add(p.getPerson());
			List<String> sort = new ArrayList<String>();
			sort.add("obsDatetime");
			List<Obs> obsList = new ArrayList<>();
			for (String conceptUuid : conceptUuidList) {
				Concept concept = conceptService.getConceptByUuid(conceptUuid.trim());
				if (concept == null) {
					continue;
				}

				List<Concept> questions = new Vector<Concept>();
				questions.add(concept);

				List<Obs> obs = obsService.getObservations(who, null, questions, null, null,
						null, sort, 1, null, null, null, false);
				if (obs.size() > 0) {
					obsList.add(obs.get(0));
				}
			}


			PatientVitalsPageController.PatientWrapper wrapper = new PatientVitalsPageController.PatientWrapper(p);
			wrapper.setObsList(obsList);
			return wrapper;
		};
		List<PatientVitalsPageController.PatientWrapper> wrapperList = allPatients.stream().filter(p -> p.getAge() > 15).map(wrapperFunction).collect(Collectors.toList());
		System.out.println(wrapperList);

		model.addAttribute("patientList", wrapperList);
	}
	
	private class PatientWrapper {
		
		Patient p;
		
		double weight, height, bmi, pulseRate, bp;
		
		double temperature;
		
		private List<Obs> obsList;
		
		public PatientWrapper(Patient p) {
			this.p = p;
		}
		
		public void setObsList(List<Obs> obsList) {
			this.obsList = obsList;
			obsList.forEach(//                        process temperature
//                        process weight
//                        process Pulse Rate
//                        process height
//                        process Blood Pressure Systolic or diastolic
//                        process bmi
					this::accept);
		}
		
		@Override
		public String toString() {
			return "PatientWrapper{" + "p=" + p + ", weight=" + weight + ", height=" + height + ", bmi=" + bmi
			        + ", pulseRate=" + pulseRate + ", bp=" + bp + ", temperature=" + temperature + '}';
		}
		
		private void accept(Obs obs) {
			switch (obs.getConcept().getUuid()) {
				case "5088AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA": {
					//                        process temperature
					this.temperature = obs.getValueNumeric();
					break;
				}
				case "5089AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA": {
					//                        process weight
					this.weight = obs.getValueNumeric();
					break;
				}
				case "5087AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA": {
					//                        process Pulse Rate
					this.pulseRate = obs.getValueNumeric();
					break;
				}
				case "5090AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA": {
					//                        process height
					this.height = obs.getValueNumeric();
					break;
				}
				case "5085AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA":
				case "5086AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA": {
					//                        process Blood Pressure Systolic or diastolic
					this.bp = obs.getValueNumeric();
					break;
				}
				case "86aca82e-8129-11e9-bb4e-204747d1a908": {
					//                        process bmi
					this.bmi = obs.getValueNumeric();
					break;
				}
			}
		}
	}
}
