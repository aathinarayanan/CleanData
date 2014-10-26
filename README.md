README.md

1. Source the "run_analysis.R" file.

2. Execute the function "run_analysis".

3. Set the working folder by passing the folder path where data present. 

4. The function uses "reshape" package which is pre-request to execute the function. 

5. The function uses various local variables to clean the data.

6. The variable "subjectActivityDs" is the data frame containing tidy data created by the function by combining activities, subject and measurements data.

7. Using the tidy data "subjectActivityDs" data frame and Reshape package step two activity is performed as follows:

8. Reshape package - "melt" function is used to melt the clean data by fixing columns "activityId",  "activity",	"subject".

9. The variable "meltDs" has the melted data.

10. ReShape package - "cast" function is used to find the average of each subjects' each activity by using melted data.

11. The variable "averageBySubjectActivityDS" has the average of each subjects' each activity measurements.

12. The function generates text file of the "averageBySubjectActivityDS" data and save it in the working folder.

13. The function Prints the dataset "averageBySubjectActivityDS".