# Shiny_step-by-step

Step-by-step instructions for building a Shiny app. It starts from a default app that is provided when a Shiny app is created in Rstudio.
The default app shows a histogram of waiting times from the dataset 'faithful'. This first version is at the 'master' branch.

Changes and new features are added and the code is available by selecting new branches (Update_1, Update_2 and so forth).
It is possible to compare the changes in the code between different versions. Click on "Contribute" and then on ""Compare". This will open a new window where you can compare the code between different branches.

![alt text](https://github.com/JoachimGoedhart/Shiny_step-by-step/blob/master/Compare-versions.png "Output")

To run the different Updates from R/Rstudio use:

shiny::runGitHub('Shiny_step-by-step', 'JoachimGoedhart', ref="Update_1")

shiny::runGitHub('Shiny_step-by-step', 'JoachimGoedhart', ref="Update_2")

......and so on.....
