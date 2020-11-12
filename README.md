## Appointment-Scheduling-and-Tele-visit

### Product Vision (Far Vision)
Practice EHR provides a convenient and secure way to conduct video consults through Tele Visit. Give patients the healthcare they want, when and where they want it. Tele Visit is fully integrated with Practice EHR saving you and your staff time.

* HIPAA compliant end-to-end Tele Visit solution for your practice.
* Patients can schedule Tele Visit appointments with ease from the patient portal and practice website.
* Access Tele Visit appointment requests directly from the Practice EHR wait list.
* Patients will be notified through the Patient Portal and via email once TeleVisitis scheduled.
* View Tele Visit appointments, verify information, and check-in patients quickly.
* Conduct secure Tele Visit sessions with patients and write chart notes instantaneously from Practice EHR.
* Consultation summary automatically shared to patients at the end of Tele Visit session.

## Team Roster
* Thomas Thompson: Frontend Developer
* Ricky Rodriguez: Frontend Developer
* Akul Anant: Backend Developer
* Vishnu Divakar: Backend Developer


## Stakeholders
1. Medical Staff
2. Patients

## Detailed User Personas
1. Medical Staff(ER Doctor)
    * Name: Diego
    * Narrative: Diego has been in medicine for years and has treated all types of patients and has worked in various hospitals. He is pretty comfortable with technology and the current technological systems in place. He is comfortable with changes but is concerned a new system would just disrupt the flow and be counter intuitive. He believes a better system is needed but that what is needed  will be harder to achieve.
    * Age:58
    * Field of Study: Medicine
    * Computer Expertise: intermediate
    * Frustrations & Pain Points: Slow system, navigation of UI, other staff not filling out information correctly.
2. Patients:
    * Name: Janice
    * Narrative: Janice has been retired for the past 15 years; she used to be a real estate agent. After her husband passed away from cancer, she has been more proactive about monitoring her health. While she is more comfortable with in-person consultations, she is willing to try tele-health services because her mobility is limited.
    * Age: 80
    * Field of Study: High School Diploma
    * Computer Expertise: Novice
    * Frustrations & Pain Points: Complex GUIs, has an inexpensive computer with limited processing power, has difficulty reading small fonts
3. Insurance Agents:
    * Name: Jack Ryan
    * Narrative: Jack is a finance graduate from Wharton College. He is very passionate about helping people with their financial situations. He now focuses on medical insurance and wants to help people to tackle the difficulties in claiming medical insurance.He is looking for a software solution to meet with his clients as well as doctors online so that he can conduct his business in a better way. COVID is one of the motives for him to look for online solutions.
    * Age: 35
    * Field of Study: Finance
    * Computer Expertise: Fair, Proficient in Microsoft Office
    * Frustrations & Pain Points: complex workflow, missing appointments, missing client’s feedback, data leakages, unable to bill clients properly.

## Iterations (Near Visions)

### Iteration 1

By the end of iteration 1, our team expects to deliver a platform where patients, medical staff and insurance agents can schedule appointments and view the allotted windows in their respective calendar.
* Patient Portal/Website: Patient
* Practice Portal / Website: medical Staff-doctors, nurses, PAs
* View Patient appointment: Patient
* View appointments: insurance holder (may not have active appointments)
* View appointments: medical Staff-doctors, nurses, PAs

### Iteration 2
TBD

## Pivotal Tracker URL:
https://www.pivotaltracker.com/n/projects/2467271

## Order of Product Backlog:
* Patients can schedule TeleVisit appointments with ease from the patient portal and practice website. (Iteration 1)
* View Tele Visit appointments, verify information, and check-in patients quickly. (Iteration 1)
* Patients will be notified through Patient Portal and via email once TeleVisit is scheduled.
* Access TeleVisit appointment requests directly from the Practice EHR waitlist
* HIPAA compliant end-to-end Tele Visit solution for your practice
* Conduct secure Tele Visit sessions with patients and write chart notes instantaneously from Practice EHR.
* Consultation summary automatically shared to the patient at the end of the Tele Session.

In this order, our team can build various micro-services from bottom to up, starting by developing a platform for stakeholders to schedule appointments and view those appointments. Once it is done, our team will focus on notifications then proceed with HIPAA compliant video conferencing feature. When these user stories are stable, then our team will focus on adding more features to Tele-Visit like write notes, drawing charts and provide a summary of consultation at the end of each tele-visit. This order allows other teams to develop their parts and our dependencies with them comes after the second iteration.

## Backlog Grooming
* Ricky :
    * Patient Portal/Website : Patient (2 SP)
    * Practice Portal/Website: medical Staff-doctors, nurses,PAs (3 SP)


* Indira :
    * View Patient appointment: just patient (3 SP
    * View appointments: insurance holder (may not have active appointments) (3SP)
    * View appointments: medical Staff-doctors, nurses, PAs (2 SP)

* Vishnu Divakar :
    * Tele-Visit: Patient (3 SP)
    * Tele-Visit: Doctor/Medical Staff(3 SP)
    * Tele-Visit: Medical Agents (3 SP)
    * Tele-Visit: HIPAA Compliance - Patient (3SP)
    * Tele-Visit: HIPAA Compliance – Doctor/Medical Staff (3SP)
    * Tele-Visit: HIPAA Compliance – Medical Agents (3 SP)
    * Tele-Visit: Bill Building - Doctors/Medical Staff/Medical Agents (3 SP)

* Thomas Thompson
    * Tele-Visit: Sharing Chart Notes (2 SP)
    * Tele-Visit: Automatically Sharing Charts & Consultation Notes (1 SP)

* Akul Prabhudesai
    * Patient portal website / Practice EHR: Waitlist requests (3SP)
