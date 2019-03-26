# Shiny-demo

Step-by-step instructions for building a Shiny app. It starts from a default app that is provided when a Shiny app is created in Rstudio.
The default app shows a histogram of waiting times from the dataset 'faithful'. This first version is at the 'master' branch.

Changes and new features are added and the code is available by selecting new branches (Update_1, Update_2 and so forth).
It is also possible to compare the changes in the code between different versions. First select a "Branch" and then click on "Compare":

![alt text](https://github.com/JoachimGoedhart/Shiny-demo/blob/master/Compare-versions.png "Output")

To run the different Updates from R/Rstudio use:

shiny::runGitHub('Shiny-demo', 'JoachimGoedhart', ref="Update_1")

shiny::runGitHub('Shiny-demo', 'JoachimGoedhart', ref="Update_2")

......and so on.....
