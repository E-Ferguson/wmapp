William & Mary Maintenance Request App
======================================

This is the github repository for our Software Engineering class project.

To get this working, just clone the repo and run bundle install --without production 
Then rails s will load the site 

To get the database populated with buildings (in case it gets wiped or anything like that), there is a script in /scripts called addBuildings script. Load the console with "rails c" and then run the command "load("scripts/addBuildingScript.rb")"

Initial admin has credentials:
admin@example.com
password

=================== Implementing state Branch Changes ====================
1. Changes to admin  on Buildings.rb
2. Included "Creat Work Order" in the navbar that directs user to new work order page
3. Defined the "new" action in the work_orders controller
4. Created some changes to the validations for work orders in the workorder model--e.g. fields can't be blank
5. Made the default value for a new work order state pending--a user should only be able to see a worker if the state isn't pending
6. Made it so that users don't have to re-enter the information for building and room number
7. Made it so that an admin can sort work orders based on "Pending", "In Progress", and "Completed"
8. Defined a new batch action--"Assign Selected".  Hopefully we can assign workorders en masse
9. Removed some of the contents of the workorder view so that a user can't input the state and worker

