# ESX-Advanced-Duty

What does this version / script provides you from the other one?

• The markers are displayed and used only based on the job you are, even if that job is "offduty". That means, if you are "offpolice", the system removes the "off" in order to be displayed and used as "police" for changing duty status.

• The code, client & server side does not need to be changed, the system has been created in order to use as many markers and as many jobs you want by only adding / removing them from the config.

• Older version was using pNotify for the notifications, this one does not include pNotify, it sends an ESX notification.

• Locales: {'EN, 'GR'} as default.

Tutorials:

If you are new into this system, there are some things you should know and how does this actually works before starting.

• In order a job to be changed / set as "offduty" | "onduty", you must add in the database (jobs & job_grades) the current job with the same name but with an "off" at first. That means, if you have a job called "lscustom", you must add in the database a new job and with the same grades, called "offlscustom".
