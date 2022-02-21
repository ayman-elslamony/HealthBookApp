# Health Book App  (Graduation Project)

It's a flutter application responsible for helping the patient to keep all personal health records in one place and contact the doctors using video chats or schedule an appointment to see the patient's PHR to give him the best diagnosis and treatment.

### Technologies:
* provider as state management.
* restful API as backend.
* agora for video call.
* firebase.
* google map.

### For using apps:
 [download android apks](https://drive.google.com/drive/folders/1B65P-KCbJdbctn49kWLFQ7eFXTWMQy9B?usp=sharing)

## Features for patients

* View appointments with the possibility:
  * View the doctor's profile and call or send a message.
* Search for nearby doctors and filter doctors by specialty, governorate, and classification.
* View the doctor's profile with the ability to view the doctor's clinic information.
* Allow reservations with the doctor at the time available.
* View the list of medicines for each disease, which contains all the doctors who wrote a treatment for this disease
* View the raidology and analysis for each disease, which contains all the doctors who ordered x-rays and analyzes for this disease.
* update profile data.

## Features for doctors

* View patient's appointments with ability to:
  * View Health Record for each patient.
  * Make video call with patient.
  * Add prescription for patient depend on your Health Record, each prescription contain diagnose, medicine , raidology and analysis result.
  * View patient porfile.
* View clinic data and all booking time.
* View profile data and update it.
* Update clinic data.


#### Code Quality

* Write readable and reusable code.
* Use single responsibility for the classes and functions.
* Reduce unnecessary requests for the restful api.
* Work with models.
* Easy to modify user interface.

## Screenshots for patient

## Screenshots for doctor



#### Dependencies:
- provider
- google_maps_flutter
- flutter_google_places
- animated_text_kit
- cloud_firestore
- firebase_auth
- firebase_storage
- shared_preferences
- fluttertoast
- 


# What's Next?
 - [ ] Add complex protection.
 - [ ] Add an alert during the time of each dose.
